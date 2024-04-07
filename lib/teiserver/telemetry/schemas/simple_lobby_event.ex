defmodule Teiserver.Telemetry.SimpleLobbyEvent do
  @moduledoc """
  # SimpleLobbyEvent
  A simple event taking place inside a lobby

  ### Attributes

  * `:user_id` - The `Teiserver.Account.User` this event took place for
  * `:match_id` - The match_id of the lobby this took place in
  * `:event_type_id` - The `Teiserver.Telemetry.EventType` this event belongs to
  * `:inserted_at` - The timestamp the event took place
  """
  use TeiserverMacros, :schema

  schema "telemetry_simple_lobby_events" do
    belongs_to(:user_id, Teiserver.Account.User)
    belongs_to(:match_id, Teiserver.Game.Match)
    belongs_to(:event_type, Teiserver.Telemetry.EventType)
    field(:inserted_at, :utc_datetime)
  end

  @type id :: non_neg_integer()

  @type t :: %__MODULE__{
          user_id: Teiserver.user_id(),
          match_id: Teiserver.match_id(),
          event_type_id: Teiserver.Telemetry.EventType.id(),
          inserted_at: DateTime.t()
        }

  @doc false
  @spec changeset(map()) :: Ecto.Changeset.t()
  @spec changeset(map(), map()) :: Ecto.Changeset.t()
  def changeset(struct, attrs \\ %{}) do
    struct
    |> cast(attrs, ~w(user_id match_id event_type_id inserted_at)a)
    |> validate_required(~w(user_id match_id event_type_id inserted_at)a)
  end
end