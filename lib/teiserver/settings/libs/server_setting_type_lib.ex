defmodule Teiserver.Settings.ServerSettingTypeLib do
  @moduledoc """
  A library of functions for working with `Teiserver.Settings.ServerSettingType`
  """

  @cache_table :ts_server_setting_type_store

  alias Teiserver.Settings.ServerSettingType

  @spec list_server_setting_types([String.t()]) :: [ServerSettingType.t()]
  def list_server_setting_types(keys) do
    keys
    |> Enum.map(&get_server_setting_type/1)
  end

  @spec list_server_setting_type_keys() :: [String.t()]
  def list_server_setting_type_keys() do
    {:ok, v} = Cachex.get(@cache_table, "_all")
    (v || [])
  end

  @spec get_server_setting_type(String.t()) :: ServerSettingType.t() | nil
  def get_server_setting_type(key) do
    {:ok, v} = Cachex.get(@cache_table, key)
    v
  end

  @spec add_server_setting_type(map()) :: {:ok, ServerSettingType.t()} | {:error, String.t()}
  def add_server_setting_type(args) do
    if not Enum.member?(~w(string integer boolean), args.type) do
      raise "Invalid type, must be one of `string`, `integer` or `boolean`"
    end

    existing_keys = list_server_setting_type_keys()
    if Enum.member?(existing_keys, args.key) do
      raise "Key #{args.key} already exists"
    end

    type = %ServerSettingType{
      key: args.key,
      label: args.label,
      section: args.section,
      type: args.type,

      permissions: Map.get(args, :permissions),
      choices: Map.get(args, :choices),
      default: Map.get(args, :default),
      description: Map.get(args, :description)
    }

    # Update our list of all keys
    new_all = [type.key | existing_keys]
    Cachex.put(@cache_table, "_all", new_all)

    Cachex.put(@cache_table, type.key, type)
    {:ok, type}
  end
end
