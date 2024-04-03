defmodule Teiserver.Settings.ServerSetting do
  @moduledoc """
  # Site setting
  A key/value storage of settings used as part of the server.

  ### Attributes

  * `:key` - The key of the setting
  * `:email` - The value of the setting
  """
  use TeiserverMacros, :schema

  @primary_key false
  schema "settings_server_settings" do
    field(:key, :string, primary_key: true)
    field(:value, :string)

    timestamps()
  end

  @type key :: String.t()

  @type t :: %__MODULE__{
          key: String.t(),
          value: String.t(),
          inserted_at: DateTime.t(),
          updated_at: DateTime.t()
        }

  @doc false
  @spec changeset(map()) :: Ecto.Changeset.t()
  @spec changeset(map(), map()) :: Ecto.Changeset.t()
  def changeset(server_setting, attrs \\ %{}) do
    server_setting
    |> cast(attrs, ~w(key value)a)
    |> validate_required(~w(key)a)
  end
end
