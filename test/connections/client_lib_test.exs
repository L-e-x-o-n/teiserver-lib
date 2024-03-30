defmodule Connections.ClientLibTest do
  @moduledoc false
  use Teiserver.Case, async: true

  alias Teiserver.Connections
  alias Teiserver.ConnectionFixtures

  describe "ClientLib" do
    test "server lifecycle" do
      {_conn, user} = ConnectionFixtures.client_fixture()

      Connections.get_client_pid(user.id)

      # These are used elsewhere in general but we want to ensure they are delegated
      Connections.cast_client(user.id, {:update_client, %{}, "test"})
      Connections.call_client(user.id, :get_client_state)
      Connections.stop_client_server(user.id)
    end

    test "update client" do
      uuid = Teiserver.uuid()

      {conn, user} = ConnectionFixtures.client_fixture()
      TestConn.subscribe(conn, Connections.client_topic(user.id))

      msgs = TestConn.get(conn)
      assert msgs == []

      # Check the client is as we expect
      client = Connections.get_client(user.id)
      refute client.afk?

      # Now update it, the `total_number` key isn't a valid key
      Connections.update_client(user.id, %{afk?: true, total_number: 123}, uuid)

      # Check the client has updated
      client = Connections.get_client(user.id)
      assert client.afk?
      assert client.team_number == nil

      # Should have gotten a new message too
      msgs = TestConn.get(conn)

      assert msgs == [
               %{
                 topic: Connections.client_topic(user.id),
                 event: :client_updated,
                 changes: %{
                   afk?: true,
                   update_id: 1
                 },
                 reason: uuid,
                 user_id: user.id
               }
             ]

      # Now try to update with the same details, should result in no change
      Connections.update_client(user.id, %{afk?: true}, "test")

      client = Connections.get_client(user.id)
      assert client.afk?
      assert client.team_number == nil

      msgs = TestConn.get(conn)
      assert msgs == []

      # Now swap the value around to ensure we get a new update
      Connections.update_client(user.id, %{afk?: false}, "test2")

      client = Connections.get_client(user.id)
      refute client.afk?
      assert client.team_number == nil

      msgs = TestConn.get(conn)
      assert Enum.count(msgs) == 1
      [update_msg] = msgs

      refute update_msg.changes.afk?
      assert client.team_number == nil
      assert update_msg.reason == "test2"
    end
    test "get_client_list" do
      {_conn1, user1} = ConnectionFixtures.client_fixture()
      {_conn1, user2} = ConnectionFixtures.client_fixture()
      {_conn1, user3} = ConnectionFixtures.client_fixture()

      user_ids = [user1.id, user2.id, user3.id]
      client_list = Connections.get_client_list(user_ids)

      client_ids = client_list |> Enum.map(fn c -> c.id end)
      assert Enum.sort(user_ids) == Enum.sort(client_ids)

      [c1, c2, c3] = client_list
      assert %Connections.Client{} = c1
      assert %Connections.Client{} = c2
      assert %Connections.Client{} = c3
    end

    test "updating with a bad key" do
      {conn, user} = ConnectionFixtures.client_fixture()
      TestConn.subscribe(conn, Connections.client_topic(user.id))

      msgs = TestConn.get(conn)
      assert msgs == []

      # Now update it
      Connections.update_client(user.id, %{not_a_key: "abc"}, "test")

      # Check the client has updated
      client = Connections.get_client(user.id)
      refute Map.has_key?(client, :not_a_key)

      # No messages either, client should be the same
      msgs = TestConn.get(conn)
      assert msgs == []
    end
  end
end
