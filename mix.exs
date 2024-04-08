defmodule Teiserver.MixProject do
  use Mix.Project

  @source_url "https://github.com/Teifion/teiserver"
  @version "0.0.5"

  def project do
    [
      app: :teiserver,
      version: @version,
      elixir: "~> 1.14",
      elixirc_paths: elixirc_paths(Mix.env()),
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      aliases: aliases(),
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [
        coveralls: :test,
        "coveralls.detail": :test,
        "coveralls.post": :test,
        "coveralls.html": :test,
        bench: :test,
        "test.ci": :test,
        "test.reset": :test,
        "test.setup": :test
      ],

      # Hex
      description: "Game middleware server",
      package: package(),

      # Docs
      name: "Teiserver",
      docs: [
        main: "Teiserver",
        api_reference: false,
        # logo: "assets/teiserver-logo.svg",
        source_ref: "v#{@version}",
        source_url: @source_url,
        extra_section: "GUIDES",
        formatters: ["html"],
        extras: extras(),
        groups_for_extras: groups_for_extras(),
        groups_for_modules: groups_for_modules(),
        groups_for_docs: groups_for_docs(),
        skip_undefined_reference_warnings_on: ["CHANGELOG.md"],
        before_closing_head_tag: &before_closing_head_tag/1,
        before_closing_body_tag: &before_closing_body_tag/1
      ]
    ]
  end

  defp extras do
    [
      # Guides
      "documentation/guides/installation.md",
      "documentation/guides/config.md",
      "documentation/guides/hello_world.md",
      "documentation/guides/program_structure.md",
      "documentation/guides/snippets.md",
      "documentation/guides/match_lifecycle.md",
      "documentation/guides/telemetry.md",
      "documentation/guides/testing.md",

      # Development
      "documentation/development/features.md",
      "documentation/development/roadmap.md",

      # PubSubs
      "documentation/pubsubs/client.md",
      "documentation/pubsubs/match.md",
      "documentation/pubsubs/user.md",
      "documentation/pubsubs/communication.md",

      # KW maps
      "CHANGELOG.md": [title: "Changelog"]
    ]
  end

  defp groups_for_extras do
    [
      Guides: ~r{documentation/guides/[^\/]+\.md},
      Development: ~r{documentation/development/[^\/]+\.md},
      PubSubs: ~r{documentation/pubsubs/[^\/]+\.md}
    ]
  end

  defp groups_for_modules do
    [
      Contexts: [
        Teiserver.Account,
        Teiserver.Communication,
        Teiserver.Community,
        Teiserver.Connections,
        Teiserver.Game,
        Teiserver.Lobby,
        Teiserver.Logging,
        Teiserver.Matchmaking,
        Teiserver.Moderation,
        Teiserver.Settings
      ],
      Account: [
        ~r"Teiserver.Account.*"
      ],
      Communication: [
        ~r"Teiserver.Communication.*"
      ],
      Community: [
        ~r"Teiserver.Community.*"
      ],
      Connections: [
        ~r"Teiserver.Connections.*"
      ],
      Game: [
        ~r"Teiserver.Game.*"
      ],
      Lobby: [
        ~r"Teiserver.Lobby.*"
      ],
      Logging: [
        ~r"Teiserver.Logging.*"
      ],
      Matchmaking: [
        ~r"Teiserver.Matchmaking.*"
      ],
      Moderation: [
        ~r"Teiserver.Moderation.*"
      ],
      Settings: [
        ~r"Teiserver.Settings.*"
      ],
      Helpers: [
        ~r"Teiserver.Helpers.*"
      ],
      Internals: [
        Teiserver.Config,
        Teiserver.Migration,
        # Teiserver.Registry,
        Teiserver.Repo,
        TeiserverMacros
      ]
    ]
  end

  def groups_for_docs do
    [
      # Accounts
      Users: &(&1[:section] == :user),
      "Extra user data": &(&1[:section] == :extra_user_data),

      # Connections
      Clients: &(&1[:section] == :client),

      # Communication
      "Room messages": &(&1[:section] == :room_message),
      "Party messages": &(&1[:section] == :party_message),
      "Match messages": &(&1[:section] == :match_message),
      "Direct messages": &(&1[:section] == :direct_message),

      # Game
      Lobby: &(&1[:section] == :lobby),
      Match: &(&1[:section] == :match),
      "Match Type": &(&1[:section] == :match_type),
      "Match Setting": &(&1[:section] == :match_setting),
      "Match Setting Type": &(&1[:section] == :match_setting_type),

      # Settings
      "Site settings": &(&1[:section] == :server_setting),
      "User settings": &(&1[:section] == :user_setting),

      # Logging
      "Audit logs": &(&1[:section] == :audit_log),
      "Match minute logs": &(&1[:section] == :match_minute_log),
      "Match day logs": &(&1[:section] == :match_day_log),
      "Match week logs": &(&1[:section] == :match_week_log),
      "Match month logs": &(&1[:section] == :match_month_log),
      "Match quarter logs": &(&1[:section] == :match_quarter_log),
      "Match year logs": &(&1[:section] == :match_year_log),
      "Server minute logs": &(&1[:section] == :server_minute_log),
      "Server day logs": &(&1[:section] == :server_day_log),
      "Server week logs": &(&1[:section] == :server_week_log),
      "Server month logs": &(&1[:section] == :server_month_log),
      "Server quarter logs": &(&1[:section] == :server_quarter_log),
      "Server year logs": &(&1[:section] == :server_year_log)
    ]
  end

  defp before_closing_head_tag(:html) do
    """
    <script src="https://cdn.jsdelivr.net/npm/mermaid@10.2.3/dist/mermaid.min.js"></script>
    <script>
      document.addEventListener("DOMContentLoaded", function () {
        mermaid.initialize({
          startOnLoad: false,
          theme: document.body.className.includes("dark") ? "dark" : "default"
        });
        let id = 0;
        for (const codeEl of document.querySelectorAll("pre code.mermaid")) {
          const preEl = codeEl.parentElement;
          const graphDefinition = codeEl.textContent;
          const graphEl = document.createElement("div");
          const graphId = "mermaid-graph-" + id++;
          mermaid.render(graphId, graphDefinition).then(({svg, bindFunctions}) => {
            graphEl.innerHTML = svg;
            bindFunctions?.(graphEl);
            preEl.insertAdjacentElement("afterend", graphEl);
            preEl.remove();
          });
        }
      });
    </script>
    """
  end

  defp before_closing_head_tag(_), do: ""

  defp before_closing_body_tag(:html) do
    """
    <!-- HTML injected at the end of the <body> element -->
    """
  end

  defp before_closing_body_tag(_), do: ""

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {Teiserver.Application, []}
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_env), do: ["lib"]

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ecto_sql, "~> 3.10"},
      {:postgrex, ">= 0.0.0"},
      {:phoenix_pubsub, "~> 2.1"},
      {:telemetry, "~> 1.2.1"},
      {:gettext, "~> 0.20"},
      {:jason, "~> 1.2"},
      {:argon2_elixir, "~> 3.0"},
      {:timex, "~> 3.7.5"},
      {:typedstruct, "~> 0.5.2", runtime: false},
      {:horde, "~> 0.9"},
      {:uuid, "~> 1.1"},
      {:cachex, "~> 3.6"},

      # Dev and Test stuff
      {:ex_doc, "~> 0.31", only: :dev, runtime: false},
      {:excoveralls, "~> 0.15.3", only: :test, runtime: false},
      {:credo, "~> 1.6", only: [:dev, :test], runtime: false},
      {:floki, ">= 0.34.0", only: :test},
      {:dialyxir, "~> 1.1", only: [:dev], runtime: false}
    ]
  end

  defp package do
    [
      maintainers: ["Teifion Jordan"],
      licenses: ["Apache-2.0"],
      files: ~w(lib .formatter.exs mix.exs README* CHANGELOG* LICENSE*),
      links: %{
        "Changelog" => "#{@source_url}/blob/master/CHANGELOG.md",
        "GitHub" => @source_url,
        "Discord" => "https://discord.gg/NmrSt9zw2p"
      }
    ]
  end

  defp aliases do
    [
      test: ["ecto.create --quiet", "ecto.migrate --quiet", "test"],
      # Oban has these and seems to do a really nice job so we're going to use them too
      # bench: "run bench/bench_helper.exs",
      release: [
        "cmd git tag v#{@version}",
        "cmd git push",
        "cmd git push --tags",
        "hex.publish --yes"
      ],
      "test.reset": ["ecto.drop --quiet", "test.setup"],
      "test.setup": ["ecto.create --quiet", "ecto.migrate --quiet"],
      "test.ci": [
        "format --check-formatted",
        "deps.unlock --check-unused",
        "credo --strict",
        "test --raise",
        "dialyzer"
      ]
    ]
  end
end
