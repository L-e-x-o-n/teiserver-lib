defmodule Teiserver.Logging do
  @moduledoc """
  The contextual module for:
  - `Teiserver.Logging.AuditLog`
  - `Teiserver.Logging.CrashLog`
  - `Teiserver.Logging.MatchMinuteLog`
  - `Teiserver.Logging.MatchDayLog`
  - `Teiserver.Logging.MatchWeekLog`
  - `Teiserver.Logging.MatchQuarterLog`
  - `Teiserver.Logging.MatchYearLog`
  - `Teiserver.Logging.ServerMinuteLog`
  - `Teiserver.Logging.ServerDayLog`
  - `Teiserver.Logging.ServerWeekLog`
  - `Teiserver.Logging.ServerQuarterLog`
  - `Teiserver.Logging.ServerYearLog`

  ## Minutes through to years
  The system is designed to take a snapshot of activity every minute and roll these up into day logs at the end of each day. The system then later creates week, month, quarter and year snapshots from the day logs. While we could just roll up the day logs each time we need to make a query the space taken by the extra snapshots is very small and makes querying so much easier I decided to add the extra files/tables.

  Minute to minute logs are deleted periodically to save space but Day logs and beyond are designed to be kept.
  """

  # AuditLogs
  alias Teiserver.Logging.{AuditLog, AuditLogLib, AuditLogQueries}

  @doc false
  @spec audit_log_query(Teiserver.query_args()) :: Ecto.Query.t()
  defdelegate audit_log_query(args), to: AuditLogQueries

  @doc section: :audit_log
  @spec list_audit_logs(Teiserver.query_args()) :: [AuditLog.t()]
  defdelegate list_audit_logs(args), to: AuditLogLib

  @doc section: :audit_log
  @spec get_audit_log!(AuditLog.id()) :: AuditLog.t()
  @spec get_audit_log!(AuditLog.id(), Teiserver.query_args()) :: AuditLog.t()
  defdelegate get_audit_log!(audit_log_id, query_args \\ []), to: AuditLogLib

  @doc section: :audit_log
  @spec get_audit_log(AuditLog.id()) :: AuditLog.t() | nil
  @spec get_audit_log(AuditLog.id(), Teiserver.query_args()) :: AuditLog.t() | nil
  defdelegate get_audit_log(audit_log_id, query_args \\ []), to: AuditLogLib

  @doc section: :audit_log
  @spec create_audit_log(map) :: {:ok, AuditLog.t()} | {:error, Ecto.Changeset.t()}
  defdelegate create_audit_log(attrs), to: AuditLogLib

  @doc section: :audit_log
  @spec create_audit_log(Teiserver.user_id(), String.t(), String.t(), map()) ::
          {:ok, AuditLog.t()} | {:error, Ecto.Changeset.t()}
  defdelegate create_audit_log(user_id, ip, action, details), to: AuditLogLib

  @doc section: :audit_log
  @spec create_anonymous_audit_log(String.t(), String.t(), map()) ::
          {:ok, AuditLog.t()} | {:error, Ecto.Changeset.t()}
  defdelegate create_anonymous_audit_log(ip, action, details), to: AuditLogLib

  @doc section: :audit_log
  @spec update_audit_log(AuditLog, map) :: {:ok, AuditLog.t()} | {:error, Ecto.Changeset.t()}
  defdelegate update_audit_log(audit_log, attrs), to: AuditLogLib

  @doc section: :audit_log
  @spec delete_audit_log(AuditLog.t()) :: {:ok, AuditLog.t()} | {:error, Ecto.Changeset.t()}
  defdelegate delete_audit_log(audit_log), to: AuditLogLib

  @doc section: :audit_log
  @spec change_audit_log(AuditLog.t()) :: Ecto.Changeset.t()
  @spec change_audit_log(AuditLog.t(), map) :: Ecto.Changeset.t()
  defdelegate change_audit_log(audit_log, attrs \\ %{}), to: AuditLogLib

  # Crash logs



  # MatchMinuteLogs
  alias Teiserver.Logging.{MatchMinuteLog, MatchMinuteLogLib, MatchMinuteLogQueries}

  @doc false
  @spec match_minute_log_query(Teiserver.query_args()) :: Ecto.Query.t()
  defdelegate match_minute_log_query(args), to: MatchMinuteLogQueries

  @doc section: :match_minute_log
  @spec list_match_minute_logs(Teiserver.query_args()) :: [MatchMinuteLog.t]
  defdelegate list_match_minute_logs(args), to: MatchMinuteLogLib

  @doc section: :match_minute_log
  @spec get_match_minute_log!(DateTime.t()) :: MatchMinuteLog.t
  @spec get_match_minute_log!(DateTime.t(), Teiserver.query_args()) :: MatchMinuteLog.t
  defdelegate get_match_minute_log!(timestamp, query_args \\ []), to: MatchMinuteLogLib

  @doc section: :match_minute_log
  @spec get_match_minute_log(DateTime.t()) :: MatchMinuteLog.t | nil
  @spec get_match_minute_log(DateTime.t(), Teiserver.query_args()) :: MatchMinuteLog.t | nil
  defdelegate get_match_minute_log(timestamp, query_args \\ []), to: MatchMinuteLogLib

  @doc section: :match_minute_log
  @spec create_match_minute_log(map) :: {:ok, MatchMinuteLog.t} | {:error, Ecto.Changeset.t()}
  defdelegate create_match_minute_log(attrs), to: MatchMinuteLogLib

  @doc section: :match_minute_log
  @spec update_match_minute_log(MatchMinuteLog, map) :: {:ok, MatchMinuteLog.t} | {:error, Ecto.Changeset.t()}
  defdelegate update_match_minute_log(match_minute_log, attrs), to: MatchMinuteLogLib

  @doc section: :match_minute_log
  @spec delete_match_minute_log(MatchMinuteLog.t) :: {:ok, MatchMinuteLog.t} | {:error, Ecto.Changeset.t()}
  defdelegate delete_match_minute_log(match_minute_log), to: MatchMinuteLogLib

  @doc section: :match_minute_log
  @spec change_match_minute_log(MatchMinuteLog.t) :: Ecto.Changeset.t()
  @spec change_match_minute_log(MatchMinuteLog.t, map) :: Ecto.Changeset.t()
  defdelegate change_match_minute_log(match_minute_log, attrs \\ %{}), to: MatchMinuteLogLib

  # MatchDayLogs
  alias Teiserver.Logging.{MatchDayLog, MatchDayLogLib, MatchDayLogQueries}

  @doc false
  @spec match_day_log_query(Teiserver.query_args()) :: Ecto.Query.t()
  defdelegate match_day_log_query(args), to: MatchDayLogQueries

  @doc section: :match_day_log
  @spec list_match_day_logs(Teiserver.query_args()) :: [MatchDayLog.t]
  defdelegate list_match_day_logs(args), to: MatchDayLogLib

  @doc section: :match_day_log
  @spec get_match_day_log!(Date.t()) :: MatchDayLog.t
  @spec get_match_day_log!(Date.t(), Teiserver.query_args()) :: MatchDayLog.t
  defdelegate get_match_day_log!(date, query_args \\ []), to: MatchDayLogLib

  @doc section: :match_day_log
  @spec get_match_day_log(Date.t()) :: MatchDayLog.t | nil
  @spec get_match_day_log(Date.t(), Teiserver.query_args()) :: MatchDayLog.t | nil
  defdelegate get_match_day_log(date, query_args \\ []), to: MatchDayLogLib

  @doc section: :match_day_log
  @spec create_match_day_log(map) :: {:ok, MatchDayLog.t} | {:error, Ecto.Changeset.t()}
  defdelegate create_match_day_log(attrs), to: MatchDayLogLib

  @doc section: :match_day_log
  @spec update_match_day_log(MatchDayLog, map) :: {:ok, MatchDayLog.t} | {:error, Ecto.Changeset.t()}
  defdelegate update_match_day_log(match_day_log, attrs), to: MatchDayLogLib

  @doc section: :match_day_log
  @spec delete_match_day_log(MatchDayLog.t) :: {:ok, MatchDayLog.t} | {:error, Ecto.Changeset.t()}
  defdelegate delete_match_day_log(match_day_log), to: MatchDayLogLib

  @doc section: :match_day_log
  @spec change_match_day_log(MatchDayLog.t) :: Ecto.Changeset.t()
  @spec change_match_day_log(MatchDayLog.t, map) :: Ecto.Changeset.t()
  defdelegate change_match_day_log(match_day_log, attrs \\ %{}), to: MatchDayLogLib

  # MatchWeekLogs
  alias Teiserver.Logging.{MatchWeekLog, MatchWeekLogLib, MatchWeekLogQueries}

  @doc false
  @spec match_week_log_query(Teiserver.query_args()) :: Ecto.Query.t()
  defdelegate match_week_log_query(args), to: MatchWeekLogQueries

  @doc section: :match_week_log
  @spec list_match_week_logs(Teiserver.query_args()) :: [MatchWeekLog.t]
  defdelegate list_match_week_logs(args), to: MatchWeekLogLib

  @doc section: :match_week_log
  @spec get_match_week_log!(Date.t()) :: MatchWeekLog.t
  @spec get_match_week_log!(Date.t(), Teiserver.query_args()) :: MatchWeekLog.t
  defdelegate get_match_week_log!(date, query_args \\ []), to: MatchWeekLogLib

  @doc section: :match_week_log
  @spec get_match_week_log(Date.t()) :: MatchWeekLog.t | nil
  @spec get_match_week_log(Date.t(), Teiserver.query_args()) :: MatchWeekLog.t | nil
  defdelegate get_match_week_log(date, query_args \\ []), to: MatchWeekLogLib

  @doc section: :match_week_log
  @spec create_match_week_log(map) :: {:ok, MatchWeekLog.t} | {:error, Ecto.Changeset.t()}
  defdelegate create_match_week_log(attrs), to: MatchWeekLogLib

  @doc section: :match_week_log
  @spec update_match_week_log(MatchWeekLog, map) :: {:ok, MatchWeekLog.t} | {:error, Ecto.Changeset.t()}
  defdelegate update_match_week_log(match_week_log, attrs), to: MatchWeekLogLib

  @doc section: :match_week_log
  @spec delete_match_week_log(MatchWeekLog.t) :: {:ok, MatchWeekLog.t} | {:error, Ecto.Changeset.t()}
  defdelegate delete_match_week_log(match_week_log), to: MatchWeekLogLib

  @doc section: :match_week_log
  @spec change_match_week_log(MatchWeekLog.t) :: Ecto.Changeset.t()
  @spec change_match_week_log(MatchWeekLog.t, map) :: Ecto.Changeset.t()
  defdelegate change_match_week_log(match_week_log, attrs \\ %{}), to: MatchWeekLogLib

  # MatchMonthLogs
  alias Teiserver.Logging.{MatchMonthLog, MatchMonthLogLib, MatchMonthLogQueries}

  @doc false
  @spec match_month_log_query(Teiserver.query_args()) :: Ecto.Query.t()
  defdelegate match_month_log_query(args), to: MatchMonthLogQueries

  @doc section: :match_month_log
  @spec list_match_month_logs(Teiserver.query_args()) :: [MatchMonthLog.t]
  defdelegate list_match_month_logs(args), to: MatchMonthLogLib

  @doc section: :match_month_log
  @spec get_match_month_log!(Date.t()) :: MatchMonthLog.t
  @spec get_match_month_log!(Date.t(), Teiserver.query_args()) :: MatchMonthLog.t
  defdelegate get_match_month_log!(date, query_args \\ []), to: MatchMonthLogLib

  @doc section: :match_month_log
  @spec get_match_month_log(Date.t()) :: MatchMonthLog.t | nil
  @spec get_match_month_log(Date.t(), Teiserver.query_args()) :: MatchMonthLog.t | nil
  defdelegate get_match_month_log(date, query_args \\ []), to: MatchMonthLogLib

  @doc section: :match_month_log
  @spec create_match_month_log(map) :: {:ok, MatchMonthLog.t} | {:error, Ecto.Changeset.t()}
  defdelegate create_match_month_log(attrs), to: MatchMonthLogLib

  @doc section: :match_month_log
  @spec update_match_month_log(MatchMonthLog, map) :: {:ok, MatchMonthLog.t} | {:error, Ecto.Changeset.t()}
  defdelegate update_match_month_log(match_month_log, attrs), to: MatchMonthLogLib

  @doc section: :match_month_log
  @spec delete_match_month_log(MatchMonthLog.t) :: {:ok, MatchMonthLog.t} | {:error, Ecto.Changeset.t()}
  defdelegate delete_match_month_log(match_month_log), to: MatchMonthLogLib

  @doc section: :match_month_log
  @spec change_match_month_log(MatchMonthLog.t) :: Ecto.Changeset.t()
  @spec change_match_month_log(MatchMonthLog.t, map) :: Ecto.Changeset.t()
  defdelegate change_match_month_log(match_month_log, attrs \\ %{}), to: MatchMonthLogLib

  # MatchQuarterLogs
  alias Teiserver.Logging.{MatchQuarterLog, MatchQuarterLogLib, MatchQuarterLogQueries}

  @doc false
  @spec match_quarter_log_query(Teiserver.query_args()) :: Ecto.Query.t()
  defdelegate match_quarter_log_query(args), to: MatchQuarterLogQueries

  @doc section: :match_quarter_log
  @spec list_match_quarter_logs(Teiserver.query_args()) :: [MatchQuarterLog.t]
  defdelegate list_match_quarter_logs(args), to: MatchQuarterLogLib

  @doc section: :match_quarter_log
  @spec get_match_quarter_log!(Date.t()) :: MatchQuarterLog.t
  @spec get_match_quarter_log!(Date.t(), Teiserver.query_args()) :: MatchQuarterLog.t
  defdelegate get_match_quarter_log!(date, query_args \\ []), to: MatchQuarterLogLib

  @doc section: :match_quarter_log
  @spec get_match_quarter_log(Date.t()) :: MatchQuarterLog.t | nil
  @spec get_match_quarter_log(Date.t(), Teiserver.query_args()) :: MatchQuarterLog.t | nil
  defdelegate get_match_quarter_log(date, query_args \\ []), to: MatchQuarterLogLib

  @doc section: :match_quarter_log
  @spec create_match_quarter_log(map) :: {:ok, MatchQuarterLog.t} | {:error, Ecto.Changeset.t()}
  defdelegate create_match_quarter_log(attrs), to: MatchQuarterLogLib

  @doc section: :match_quarter_log
  @spec update_match_quarter_log(MatchQuarterLog, map) :: {:ok, MatchQuarterLog.t} | {:error, Ecto.Changeset.t()}
  defdelegate update_match_quarter_log(match_quarter_log, attrs), to: MatchQuarterLogLib

  @doc section: :match_quarter_log
  @spec delete_match_quarter_log(MatchQuarterLog.t) :: {:ok, MatchQuarterLog.t} | {:error, Ecto.Changeset.t()}
  defdelegate delete_match_quarter_log(match_quarter_log), to: MatchQuarterLogLib

  @doc section: :match_quarter_log
  @spec change_match_quarter_log(MatchQuarterLog.t) :: Ecto.Changeset.t()
  @spec change_match_quarter_log(MatchQuarterLog.t, map) :: Ecto.Changeset.t()
  defdelegate change_match_quarter_log(match_quarter_log, attrs \\ %{}), to: MatchQuarterLogLib

  # MatchYearLogs
  alias Teiserver.Logging.{MatchYearLog, MatchYearLogLib, MatchYearLogQueries}

  @doc false
  @spec match_year_log_query(Teiserver.query_args()) :: Ecto.Query.t()
  defdelegate match_year_log_query(args), to: MatchYearLogQueries

  @doc section: :match_year_log
  @spec list_match_year_logs(Teiserver.query_args()) :: [MatchYearLog.t]
  defdelegate list_match_year_logs(args), to: MatchYearLogLib

  @doc section: :match_year_log
  @spec get_match_year_log!(Date.t()) :: MatchYearLog.t
  @spec get_match_year_log!(Date.t(), Teiserver.query_args()) :: MatchYearLog.t
  defdelegate get_match_year_log!(date, query_args \\ []), to: MatchYearLogLib

  @doc section: :match_year_log
  @spec get_match_year_log(Date.t()) :: MatchYearLog.t | nil
  @spec get_match_year_log(Date.t(), Teiserver.query_args()) :: MatchYearLog.t | nil
  defdelegate get_match_year_log(date, query_args \\ []), to: MatchYearLogLib

  @doc section: :match_year_log
  @spec create_match_year_log(map) :: {:ok, MatchYearLog.t} | {:error, Ecto.Changeset.t()}
  defdelegate create_match_year_log(attrs), to: MatchYearLogLib

  @doc section: :match_year_log
  @spec update_match_year_log(MatchYearLog, map) :: {:ok, MatchYearLog.t} | {:error, Ecto.Changeset.t()}
  defdelegate update_match_year_log(match_year_log, attrs), to: MatchYearLogLib

  @doc section: :match_year_log
  @spec delete_match_year_log(MatchYearLog.t) :: {:ok, MatchYearLog.t} | {:error, Ecto.Changeset.t()}
  defdelegate delete_match_year_log(match_year_log), to: MatchYearLogLib

  @doc section: :match_year_log
  @spec change_match_year_log(MatchYearLog.t) :: Ecto.Changeset.t()
  @spec change_match_year_log(MatchYearLog.t, map) :: Ecto.Changeset.t()
  defdelegate change_match_year_log(match_year_log, attrs \\ %{}), to: MatchYearLogLib


  # ServerMinuteLogs
  alias Teiserver.Logging.{ServerMinuteLog, ServerMinuteLogLib, ServerMinuteLogQueries}

  @doc false
  @spec server_minute_log_query(Teiserver.query_args()) :: Ecto.Query.t()
  defdelegate server_minute_log_query(args), to: ServerMinuteLogQueries

  @doc section: :server_minute_log
  @spec list_server_minute_logs(Teiserver.query_args()) :: [ServerMinuteLog.t]
  defdelegate list_server_minute_logs(args), to: ServerMinuteLogLib

  @doc section: :server_minute_log
  @spec get_server_minute_log!(DateTime.t()) :: ServerMinuteLog.t
  @spec get_server_minute_log!(DateTime.t(), Teiserver.query_args()) :: ServerMinuteLog.t
  defdelegate get_server_minute_log!(timestamp, query_args \\ []), to: ServerMinuteLogLib

  @doc section: :server_minute_log
  @spec get_server_minute_log(DateTime.t()) :: ServerMinuteLog.t | nil
  @spec get_server_minute_log(DateTime.t(), Teiserver.query_args()) :: ServerMinuteLog.t | nil
  defdelegate get_server_minute_log(timestamp, query_args \\ []), to: ServerMinuteLogLib

  @doc section: :server_minute_log
  @spec create_server_minute_log(map) :: {:ok, ServerMinuteLog.t} | {:error, Ecto.Changeset.t()}
  defdelegate create_server_minute_log(attrs), to: ServerMinuteLogLib

  @doc section: :server_minute_log
  @spec update_server_minute_log(ServerMinuteLog, map) :: {:ok, ServerMinuteLog.t} | {:error, Ecto.Changeset.t()}
  defdelegate update_server_minute_log(server_minute_log, attrs), to: ServerMinuteLogLib

  @doc section: :server_minute_log
  @spec delete_server_minute_log(ServerMinuteLog.t) :: {:ok, ServerMinuteLog.t} | {:error, Ecto.Changeset.t()}
  defdelegate delete_server_minute_log(server_minute_log), to: ServerMinuteLogLib

  @doc section: :server_minute_log
  @spec change_server_minute_log(ServerMinuteLog.t) :: Ecto.Changeset.t()
  @spec change_server_minute_log(ServerMinuteLog.t, map) :: Ecto.Changeset.t()
  defdelegate change_server_minute_log(server_minute_log, attrs \\ %{}), to: ServerMinuteLogLib

  # ServerDayLogs
  alias Teiserver.Logging.{ServerDayLog, ServerDayLogLib, ServerDayLogQueries}

  @doc false
  @spec server_day_log_query(Teiserver.query_args()) :: Ecto.Query.t()
  defdelegate server_day_log_query(args), to: ServerDayLogQueries

  @doc section: :server_day_log
  @spec list_server_day_logs(Teiserver.query_args()) :: [ServerDayLog.t]
  defdelegate list_server_day_logs(args), to: ServerDayLogLib

  @doc section: :server_day_log
  @spec get_server_day_log!(Date.t()) :: ServerDayLog.t
  @spec get_server_day_log!(Date.t(), Teiserver.query_args()) :: ServerDayLog.t
  defdelegate get_server_day_log!(date, query_args \\ []), to: ServerDayLogLib

  @doc section: :server_day_log
  @spec get_server_day_log(Date.t()) :: ServerDayLog.t | nil
  @spec get_server_day_log(Date.t(), Teiserver.query_args()) :: ServerDayLog.t | nil
  defdelegate get_server_day_log(date, query_args \\ []), to: ServerDayLogLib

  @doc section: :server_day_log
  @spec create_server_day_log(map) :: {:ok, ServerDayLog.t} | {:error, Ecto.Changeset.t()}
  defdelegate create_server_day_log(attrs), to: ServerDayLogLib

  @doc section: :server_day_log
  @spec update_server_day_log(ServerDayLog, map) :: {:ok, ServerDayLog.t} | {:error, Ecto.Changeset.t()}
  defdelegate update_server_day_log(server_day_log, attrs), to: ServerDayLogLib

  @doc section: :server_day_log
  @spec delete_server_day_log(ServerDayLog.t) :: {:ok, ServerDayLog.t} | {:error, Ecto.Changeset.t()}
  defdelegate delete_server_day_log(server_day_log), to: ServerDayLogLib

  @doc section: :server_day_log
  @spec change_server_day_log(ServerDayLog.t) :: Ecto.Changeset.t()
  @spec change_server_day_log(ServerDayLog.t, map) :: Ecto.Changeset.t()
  defdelegate change_server_day_log(server_day_log, attrs \\ %{}), to: ServerDayLogLib

  # ServerWeekLogs
  alias Teiserver.Logging.{ServerWeekLog, ServerWeekLogLib, ServerWeekLogQueries}

  @doc false
  @spec server_week_log_query(Teiserver.query_args()) :: Ecto.Query.t()
  defdelegate server_week_log_query(args), to: ServerWeekLogQueries

  @doc section: :server_week_log
  @spec list_server_week_logs(Teiserver.query_args()) :: [ServerWeekLog.t]
  defdelegate list_server_week_logs(args), to: ServerWeekLogLib

  @doc section: :server_week_log
  @spec get_server_week_log!(Date.t()) :: ServerWeekLog.t
  @spec get_server_week_log!(Date.t(), Teiserver.query_args()) :: ServerWeekLog.t
  defdelegate get_server_week_log!(date, query_args \\ []), to: ServerWeekLogLib

  @doc section: :server_week_log
  @spec get_server_week_log(Date.t()) :: ServerWeekLog.t | nil
  @spec get_server_week_log(Date.t(), Teiserver.query_args()) :: ServerWeekLog.t | nil
  defdelegate get_server_week_log(date, query_args \\ []), to: ServerWeekLogLib

  @doc section: :server_week_log
  @spec create_server_week_log(map) :: {:ok, ServerWeekLog.t} | {:error, Ecto.Changeset.t()}
  defdelegate create_server_week_log(attrs), to: ServerWeekLogLib

  @doc section: :server_week_log
  @spec update_server_week_log(ServerWeekLog, map) :: {:ok, ServerWeekLog.t} | {:error, Ecto.Changeset.t()}
  defdelegate update_server_week_log(server_week_log, attrs), to: ServerWeekLogLib

  @doc section: :server_week_log
  @spec delete_server_week_log(ServerWeekLog.t) :: {:ok, ServerWeekLog.t} | {:error, Ecto.Changeset.t()}
  defdelegate delete_server_week_log(server_week_log), to: ServerWeekLogLib

  @doc section: :server_week_log
  @spec change_server_week_log(ServerWeekLog.t) :: Ecto.Changeset.t()
  @spec change_server_week_log(ServerWeekLog.t, map) :: Ecto.Changeset.t()
  defdelegate change_server_week_log(server_week_log, attrs \\ %{}), to: ServerWeekLogLib

  # ServerMonthLogs
  alias Teiserver.Logging.{ServerMonthLog, ServerMonthLogLib, ServerMonthLogQueries}

  @doc false
  @spec server_month_log_query(Teiserver.query_args()) :: Ecto.Query.t()
  defdelegate server_month_log_query(args), to: ServerMonthLogQueries

  @doc section: :server_month_log
  @spec list_server_month_logs(Teiserver.query_args()) :: [ServerMonthLog.t]
  defdelegate list_server_month_logs(args), to: ServerMonthLogLib

  @doc section: :server_month_log
  @spec get_server_month_log!(Date.t()) :: ServerMonthLog.t
  @spec get_server_month_log!(Date.t(), Teiserver.query_args()) :: ServerMonthLog.t
  defdelegate get_server_month_log!(date, query_args \\ []), to: ServerMonthLogLib

  @doc section: :server_month_log
  @spec get_server_month_log(Date.t()) :: ServerMonthLog.t | nil
  @spec get_server_month_log(Date.t(), Teiserver.query_args()) :: ServerMonthLog.t | nil
  defdelegate get_server_month_log(date, query_args \\ []), to: ServerMonthLogLib

  @doc section: :server_month_log
  @spec create_server_month_log(map) :: {:ok, ServerMonthLog.t} | {:error, Ecto.Changeset.t()}
  defdelegate create_server_month_log(attrs), to: ServerMonthLogLib

  @doc section: :server_month_log
  @spec update_server_month_log(ServerMonthLog, map) :: {:ok, ServerMonthLog.t} | {:error, Ecto.Changeset.t()}
  defdelegate update_server_month_log(server_month_log, attrs), to: ServerMonthLogLib

  @doc section: :server_month_log
  @spec delete_server_month_log(ServerMonthLog.t) :: {:ok, ServerMonthLog.t} | {:error, Ecto.Changeset.t()}
  defdelegate delete_server_month_log(server_month_log), to: ServerMonthLogLib

  @doc section: :server_month_log
  @spec change_server_month_log(ServerMonthLog.t) :: Ecto.Changeset.t()
  @spec change_server_month_log(ServerMonthLog.t, map) :: Ecto.Changeset.t()
  defdelegate change_server_month_log(server_month_log, attrs \\ %{}), to: ServerMonthLogLib

  # ServerQuarterLogs
  alias Teiserver.Logging.{ServerQuarterLog, ServerQuarterLogLib, ServerQuarterLogQueries}

  @doc false
  @spec server_quarter_log_query(Teiserver.query_args()) :: Ecto.Query.t()
  defdelegate server_quarter_log_query(args), to: ServerQuarterLogQueries

  @doc section: :server_quarter_log
  @spec list_server_quarter_logs(Teiserver.query_args()) :: [ServerQuarterLog.t]
  defdelegate list_server_quarter_logs(args), to: ServerQuarterLogLib

  @doc section: :server_quarter_log
  @spec get_server_quarter_log!(Date.t()) :: ServerQuarterLog.t
  @spec get_server_quarter_log!(Date.t(), Teiserver.query_args()) :: ServerQuarterLog.t
  defdelegate get_server_quarter_log!(date, query_args \\ []), to: ServerQuarterLogLib

  @doc section: :server_quarter_log
  @spec get_server_quarter_log(Date.t()) :: ServerQuarterLog.t | nil
  @spec get_server_quarter_log(Date.t(), Teiserver.query_args()) :: ServerQuarterLog.t | nil
  defdelegate get_server_quarter_log(date, query_args \\ []), to: ServerQuarterLogLib

  @doc section: :server_quarter_log
  @spec create_server_quarter_log(map) :: {:ok, ServerQuarterLog.t} | {:error, Ecto.Changeset.t()}
  defdelegate create_server_quarter_log(attrs), to: ServerQuarterLogLib

  @doc section: :server_quarter_log
  @spec update_server_quarter_log(ServerQuarterLog, map) :: {:ok, ServerQuarterLog.t} | {:error, Ecto.Changeset.t()}
  defdelegate update_server_quarter_log(server_quarter_log, attrs), to: ServerQuarterLogLib

  @doc section: :server_quarter_log
  @spec delete_server_quarter_log(ServerQuarterLog.t) :: {:ok, ServerQuarterLog.t} | {:error, Ecto.Changeset.t()}
  defdelegate delete_server_quarter_log(server_quarter_log), to: ServerQuarterLogLib

  @doc section: :server_quarter_log
  @spec change_server_quarter_log(ServerQuarterLog.t) :: Ecto.Changeset.t()
  @spec change_server_quarter_log(ServerQuarterLog.t, map) :: Ecto.Changeset.t()
  defdelegate change_server_quarter_log(server_quarter_log, attrs \\ %{}), to: ServerQuarterLogLib

  # ServerYearLogs
  alias Teiserver.Logging.{ServerYearLog, ServerYearLogLib, ServerYearLogQueries}

  @doc false
  @spec server_year_log_query(Teiserver.query_args()) :: Ecto.Query.t()
  defdelegate server_year_log_query(args), to: ServerYearLogQueries

  @doc section: :server_year_log
  @spec list_server_year_logs(Teiserver.query_args()) :: [ServerYearLog.t]
  defdelegate list_server_year_logs(args), to: ServerYearLogLib

  @doc section: :server_year_log
  @spec get_server_year_log!(Date.t()) :: ServerYearLog.t
  @spec get_server_year_log!(Date.t(), Teiserver.query_args()) :: ServerYearLog.t
  defdelegate get_server_year_log!(date, query_args \\ []), to: ServerYearLogLib

  @doc section: :server_year_log
  @spec get_server_year_log(Date.t()) :: ServerYearLog.t | nil
  @spec get_server_year_log(Date.t(), Teiserver.query_args()) :: ServerYearLog.t | nil
  defdelegate get_server_year_log(date, query_args \\ []), to: ServerYearLogLib

  @doc section: :server_year_log
  @spec create_server_year_log(map) :: {:ok, ServerYearLog.t} | {:error, Ecto.Changeset.t()}
  defdelegate create_server_year_log(attrs), to: ServerYearLogLib

  @doc section: :server_year_log
  @spec update_server_year_log(ServerYearLog, map) :: {:ok, ServerYearLog.t} | {:error, Ecto.Changeset.t()}
  defdelegate update_server_year_log(server_year_log, attrs), to: ServerYearLogLib

  @doc section: :server_year_log
  @spec delete_server_year_log(ServerYearLog.t) :: {:ok, ServerYearLog.t} | {:error, Ecto.Changeset.t()}
  defdelegate delete_server_year_log(server_year_log), to: ServerYearLogLib

  @doc section: :server_year_log
  @spec change_server_year_log(ServerYearLog.t) :: Ecto.Changeset.t()
  @spec change_server_year_log(ServerYearLog.t, map) :: Ecto.Changeset.t()
  defdelegate change_server_year_log(server_year_log, attrs \\ %{}), to: ServerYearLogLib
end
