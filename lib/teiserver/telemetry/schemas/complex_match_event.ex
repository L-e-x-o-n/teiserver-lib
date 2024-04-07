defmodule Teiserver.Telemetry.ComplexMatchEvent do
  @moduledoc """
  # ComplexMatchEvent
  A complex event taking place inside of a match

  ### Attributes

  * `:user_id` - The `Teiserver.Account.User` this event took place for
  * `:match_id` - The `Teiserver.Game.Match` this took place in
  * `:event_type_id` - The `Teiserver.Telemetry.EventType` this event belongs to
  * `:inserted_at` - The timestamp the event took place
  * `:game_time_seconds` - The number of seconds elapsed in the game before the event took place
  * `:details` - A key-value map of the details of the event
  """
  use TeiserverMacros, :schema

  schema "telemetry_complex_anon_events" do
    belongs_to(:user_id, Teiserver.Account.User)
    belongs_to(:match_id, Teiserver.Game.Match)
    belongs_to(:event_type, Teiserver.Telemetry.EventType)
    field(:inserted_at, :utc_datetime)

    field(:game_time_seconds, :integer)
    field(:details, :map)
  end

  @type id :: non_neg_integer()

  @type t :: %__MODULE__{
          user_id: Teiserver.user_id(),
          match_id: Teiserver.match_id(),
          event_type_id: Teiserver.Telemetry.EventType.id(),
          inserted_at: DateTime.t(),
          game_time_seconds: non_neg_integer(),
          details: map()
        }

  @doc false
  @spec changeset(map()) :: Ecto.Changeset.t()
  @spec changeset(map(), map()) :: Ecto.Changeset.t()
  def changeset(struct, attrs \\ %{}) do
    struct
    |> cast(attrs, ~w(user_id match_id event_type_id inserted_at game_time_seconds details)a)
    |> validate_required(
      ~w(user_id match_id event_type_id inserted_at game_time_seconds details)a
    )
  end
end