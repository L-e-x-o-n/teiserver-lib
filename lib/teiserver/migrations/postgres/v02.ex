defmodule Teiserver.Migrations.Postgres.V02 do
  @moduledoc false
  # Copied and tweaked from Oban

  use Ecto.Migration

  @spec up(map) :: any
  def up(%{prefix: prefix}) do
    # Logging
    create_if_not_exists table(:audit_logs, prefix: prefix) do
      add(:action, :string)
      add(:details, :jsonb)
      add(:ip, :string)
      add(:user_id, references(:account_users, on_delete: :nothing, type: :uuid), type: :uuid)

      timestamps()
    end

    # Logging - Server activity
    create_if_not_exists table(:logging_server_minute_logs, primary_key: false) do
      add(:timestamp, :utc_datetime, primary_key: true)
      add(:data, :jsonb)
    end

    create_if_not_exists table(:logging_server_day_logs, primary_key: false) do
      add(:date, :date, primary_key: true)
      add(:data, :jsonb)
    end

    create_if_not_exists table(:logging_server_week_logs, primary_key: false, prefix: prefix) do
      add(:year, :integer, primary_key: true)
      add(:week, :integer, primary_key: true)
      add(:date, :date)
      add(:data, :jsonb)
    end

    create_if_not_exists table(:logging_server_month_logs, primary_key: false, prefix: prefix) do
      add(:year, :integer, primary_key: true)
      add(:month, :integer, primary_key: true)
      add(:date, :date)
      add(:data, :jsonb)
    end

    create_if_not_exists table(:logging_server_quarter_logs, primary_key: false, prefix: prefix) do
      add(:year, :integer, primary_key: true)
      add(:quarter, :integer, primary_key: true)
      add(:date, :date)
      add(:data, :jsonb)
    end

    create_if_not_exists table(:logging_server_year_logs, primary_key: false, prefix: prefix) do
      add(:year, :integer, primary_key: true)
      add(:date, :date)
      add(:data, :jsonb)
    end

    # Logging - Match logs
    create_if_not_exists table(:logging_match_minute_logs, primary_key: false) do
      add(:timestamp, :utc_datetime, primary_key: true)
      add(:data, :jsonb)
    end

    create_if_not_exists table(:logging_match_day_logs, primary_key: false) do
      add(:date, :date, primary_key: true)
      add(:data, :jsonb)
    end

    create_if_not_exists table(:logging_match_week_logs, primary_key: false, prefix: prefix) do
      add(:year, :integer, primary_key: true)
      add(:week, :integer, primary_key: true)
      add(:date, :date)
      add(:data, :jsonb)
    end

    create_if_not_exists table(:logging_match_month_logs, primary_key: false, prefix: prefix) do
      add(:year, :integer, primary_key: true)
      add(:month, :integer, primary_key: true)
      add(:date, :date)
      add(:data, :jsonb)
    end

    create_if_not_exists table(:logging_match_quarter_logs, primary_key: false, prefix: prefix) do
      add(:year, :integer, primary_key: true)
      add(:quarter, :integer, primary_key: true)
      add(:date, :date)
      add(:data, :jsonb)
    end

    create_if_not_exists table(:logging_match_year_logs, primary_key: false, prefix: prefix) do
      add(:year, :integer, primary_key: true)
      add(:date, :date)
      add(:data, :jsonb)
    end

    # Telemetry tables
    create_if_not_exists table(:telemetry_event_types, prefix: prefix) do
      add(:category, :string)
      add(:name, :string)
    end

    create_if_not_exists(unique_index(:telemetry_event_types, [:category, :name], prefix: prefix))
  end

  @spec down(map) :: any
  def down(%{prefix: prefix, quoted_prefix: _quoted}) do
    # Telemetry
    drop_if_exists(table(:telemetry_event_types, prefix: prefix))

    # Logging
    drop_if_exists(table(:audit_logs, prefix: prefix))
  end
end
