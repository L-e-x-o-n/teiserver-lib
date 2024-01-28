defmodule Teiserver.Settings.ServerSettingQueries do
  @moduledoc false
  use TeiserverMacros, :queries
  alias Teiserver.Settings.ServerSetting
  require Logger

  @spec server_setting_query() :: Ecto.Query.t()
  @spec server_setting_query(Teiserver.query_args()) :: Ecto.Query.t()
  def server_setting_query(args \\ []) do
    query = from(server_settings in ServerSetting)

    query
    |> do_where(id: args[:id])
    |> do_where(args[:where])
    |> do_preload(args[:preload])
    |> do_order_by(args[:order_by])
    |> QueryHelper.query_select(args[:select])
    |> QueryHelper.limit_query(args[:limit] || 50)
  end

  @spec do_where(Ecto.Query.t(), list | map | nil) :: Ecto.Query.t()
  defp do_where(query, nil), do: query

  defp do_where(query, params) do
    params
    |> Enum.reduce(query, fn {key, value}, query_acc ->
      _where(query_acc, key, value)
    end)
  end

  @spec _where(Ecto.Query.t(), atom, any()) :: Ecto.Query.t()
  def _where(query, _, ""), do: query
  def _where(query, _, nil), do: query

  def _where(query, :id, id) do
    from(server_settings in query,
      where: server_settings.id == ^id
    )
  end

  def _where(query, :id_in, id_list) do
    from(server_settings in query,
      where: server_settings.id in ^id_list
    )
  end

  def _where(query, :name, name) do
    from(server_settings in query,
      where: server_settings.name == ^name
    )
  end

  def _where(query, :inserted_after, timestamp) do
    from(server_settings in query,
      where: server_settings.inserted_at >= ^timestamp
    )
  end

  def _where(query, :inserted_before, timestamp) do
    from(server_settings in query,
      where: server_settings.inserted_at < ^timestamp
    )
  end

  @spec do_order_by(Ecto.Query.t(), list | nil) :: Ecto.Query.t()
  defp do_order_by(query, nil), do: query

  defp do_order_by(query, params) when is_list(params) do
    params
    |> List.wrap()
    |> Enum.reduce(query, fn key, query_acc ->
      _order_by(query_acc, key)
    end)
  end

  @spec _order_by(Ecto.Query.t(), any()) :: Ecto.Query.t()
  def _order_by(query, "Name (A-Z)") do
    from(server_settings in query,
      order_by: [asc: server_settings.name]
    )
  end

  def _order_by(query, "Name (Z-A)") do
    from(server_settings in query,
      order_by: [desc: server_settings.name]
    )
  end

  def _order_by(query, "Newest first") do
    from(server_settings in query,
      order_by: [desc: server_settings.inserted_at]
    )
  end

  def _order_by(query, "Oldest first") do
    from(server_settings in query,
      order_by: [asc: server_settings.inserted_at]
    )
  end

  @spec do_preload(Ecto.Query.t(), list | nil) :: Ecto.Query.t()
  defp do_preload(query, nil), do: query

  defp do_preload(query, _), do: query
  # defp do_preload(query, preloads) do
  #   preloads
  #   |> List.wrap
  #   |> Enum.reduce(query, fn key, query_acc ->
  #     _preload(query_acc, key)
  #   end)
  # end

  # def _preload(query, :relation) do
  #   from server_setting in query,
  #     left_join: relations in assoc(server_setting, :relation),
  #     preload: [relation: relations]
  # end
end
