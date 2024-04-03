defmodule Teiserver.Telemetry do
  @moduledoc """
  This page is a reference for the Telemetry data functions. For a guide on how to use the Telemetry features please refer to the [telemetry guide](guides/telemetry_events.md).

  The contextual module for:
  - `Teiserver.Telemetry.EventType`

  - `Teiserver.Telemetry.SimpleGameEvent`
  - `Teiserver.Telemetry.SimpleServerEvent`
  - `Teiserver.Telemetry.SimpleLobbyEvent`
  - `Teiserver.Telemetry.SimpleUserEvent`
  - `Teiserver.Telemetry.SimpleClientEvent`
  - `Teiserver.Telemetry.SimpleAnonEvent`

  - `Teiserver.Telemetry.ComplexGameEvent`
  - `Teiserver.Telemetry.ComplexServerEvent`
  - `Teiserver.Telemetry.ComplexLobbyEvent`
  - `Teiserver.Telemetry.ComplexUserEvent`
  - `Teiserver.Telemetry.ComplexClientEvent`
  - `Teiserver.Telemetry.ComplexAnonEvent`
  """

  # EventTypes
  alias Teiserver.Telemetry.{EventType, EventTypeLib, EventTypeQueries}

  @doc false
  @spec event_type_query(Teiserver.query_args()) :: Ecto.Query.t()
  defdelegate event_type_query(args), to: EventTypeQueries

  @doc section: :event_type
  @spec list_event_types(Teiserver.query_args()) :: [EventType.t()]
  defdelegate list_event_types(args), to: EventTypeLib

  @doc section: :event_type
  @spec get_event_type!(EventType.id()) :: EventType.t()
  @spec get_event_type!(EventType.id(), Teiserver.query_args()) :: EventType.t()
  defdelegate get_event_type!(event_type_id, query_args \\ []), to: EventTypeLib

  @doc section: :event_type
  @spec get_event_type(EventType.id()) :: EventType.t() | nil
  @spec get_event_type(EventType.id(), Teiserver.query_args()) :: EventType.t() | nil
  defdelegate get_event_type(event_type_id, query_args \\ []), to: EventTypeLib

  @doc section: :event_type
  @spec create_event_type(map) :: {:ok, EventType.t()} | {:error, Ecto.Changeset.t()}
  defdelegate create_event_type(attrs), to: EventTypeLib

  @doc section: :event_type
  @spec update_event_type(EventType, map) :: {:ok, EventType.t()} | {:error, Ecto.Changeset.t()}
  defdelegate update_event_type(event_type, attrs), to: EventTypeLib

  @doc section: :event_type
  @spec delete_event_type(EventType.t()) :: {:ok, EventType.t()} | {:error, Ecto.Changeset.t()}
  defdelegate delete_event_type(event_type), to: EventTypeLib

  @doc section: :event_type
  @spec change_event_type(EventType.t()) :: Ecto.Changeset.t()
  @spec change_event_type(EventType.t(), map) :: Ecto.Changeset.t()
  defdelegate change_event_type(event_type, attrs \\ %{}), to: EventTypeLib
end
