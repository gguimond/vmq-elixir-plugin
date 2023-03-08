defmodule VMQPlugin.MixProject do
  use Mix.Project

  def project do
    [
      app: :vmq_elixir_plugin,
      version: "0.1.0",
      elixir: "~> 1.13",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger, :httpoison, :exjsx],
      env: [
        vmq_plugin_hooks: [
          {:on_client_wakeup, VMQPlugin, :on_client_wakeup, 1, []},
          {:auth_on_register_m5, VMQPlugin, :auth_on_register_m5, 6, []}
        ],
        endpoint_on_client_wakeup: "http://10.193.203.242:1234"
      ]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
      {:httpoison, "~> 2.0.0"},
      {:exjsx, "~> 4.0.0"},
      {:mock, "~> 0.3.0" , only: [:test]}
    ]
  end
end
