defmodule Teiserver.MatchDayLogQueriesTest do
  @moduledoc false
  use Teiserver.Case, async: true

  alias Teiserver.Logging.MatchDayLogQueries

  describe "queries" do
    @empty_query MatchDayLogQueries.match_day_log_query([])

    test "clauses" do
      # Null values, shouldn't error but shouldn't generate a query
      null_values =
        MatchDayLogQueries.match_day_log_query(
          where: [
            key1: "",
            key2: nil
          ]
        )

      assert null_values == @empty_query
      Repo.all(null_values)

      # If a key is not present in the query library it should error
      assert_raise(FunctionClauseError, fn ->
        MatchDayLogQueries.match_day_log_query(where: [not_a_key: 1])
      end)

      # we expect the query to run though it won't produce meaningful results
      all_values =
        MatchDayLogQueries.match_day_log_query(
          where: [
            date: Timex.today(),
            after: Timex.today(),
            before: Timex.today()
          ],
          order_by: [
            "Newest first",
            "Oldest first"
          ],
          preload: []
        )

      assert all_values != @empty_query
      Repo.all(all_values)
    end
  end
end
