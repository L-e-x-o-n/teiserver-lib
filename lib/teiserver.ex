defmodule Teiserver do
  alias Teiserver.Helpers.PubSubHelper

  @moduledoc """
  Teiserver is a middleware server library; designed for usage with games. It handles game-agnostic issues (chat, searching for games, match history) and allows you to implement the game-specific items you care about.

  In a peer-to-peer setting each client will communicate to each other client as and when they need to. With a middleware server every client communicates via the middleware server and the server acts as a single source of truth.

  ```mermaid
  graph TD;
    srv{{Middleware Server}};
    srv <--> User1;
    srv <--> User2;
    srv <--> User3;
    srv <--> User4;
    Host1 <--> srv;
    Host2 <--> srv;
    Bot1 <--> srv;
    Bot2 <--> srv;
  ```

  To use Teiserver you write an endpoint which your game connects to over a network. The endpoint handles the messages from client apps and makes calls to Teiserver; acting as wrapper around the Teiserver API.

  ## Main guides:
  - [Installation](guides/installation.md)
  - [Hello world](guides/hello_world.md)
  - [Program structure](guides/program_structure.md)
  - [Snippets](guides/snippets.md)

  ## Contexts
  These are the main modules you will be interacting with in Teiserver. They typically delegate all their functions to something more specific but the context module will be the preferred point of contact with the Teiserver library.

  Teiserver has some other publicly accessible functions for those who want to write more advanced or complex functionality but in theory everything you need should be accessible from the relevant context.

  ### Context overview
  - **Accounts**: Users
  - **Communication**: Chat
  - **Community**: Social interactions between players
  - **Connections**: User activity
  - **Game**: Game/playing functionality
  - **Logging**: Logging of events and numbers
  - **Moderation**: Handling disruptive users
  - **Settings**: Key-Value pairs for users and the system
  - **Telemetry**: Moment to moment events
  """

  # Aliased types
  @type user_id :: Teiserver.Account.User.id()
  @type lobby_id :: Teiserver.Game.Lobby.id()
  @type match_id :: Teiserver.Game.Match.id()
  @type queue_id :: non_neg_integer()
  @type party_id :: Ecto.UUID.t()

  # Teiserver types
  @type team_number :: non_neg_integer()
  @type seconds :: integer()

  @type query_args ::
          keyword(
            id: non_neg_integer() | nil,
            where: list(),
            preload: list(),
            order_by: list(),
            offset: non_neg_integer() | nil,
            limit: non_neg_integer() | nil
          )

  # UUIDs
  @spec uuid() :: String.t()
  def uuid() do
    f = Application.get_env(:teiserver, :fn_uuid_generator, &Ecto.UUID.generate/0)
    f.()
  end

  @spec deterministic_uuid(String.t()) :: String.t()
  def deterministic_uuid(base) do
    UUID.uuid5(:nil, base)
  end

  # PubSub delegation
  @doc false
  @spec broadcast(String.t(), map()) :: :ok
  defdelegate broadcast(topic, message), to: PubSubHelper

  @doc false
  @spec subscribe(String.t()) :: :ok
  defdelegate subscribe(topic), to: PubSubHelper

  @doc false
  @spec unsubscribe(String.t()) :: :ok
  defdelegate unsubscribe(topic), to: PubSubHelper

  # Cluster cache delegation
  @spec invalidate_cache(atom, any) :: :ok
  defdelegate invalidate_cache(table, key_or_keys), to: Teiserver.System.CacheClusterServer

end
