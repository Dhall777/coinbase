defmodule Coinbase.MixProject do
  use Mix.Project

  def project do
    [
      app: :coinbase,
      version: "0.1.0",
      elixir: "~> 1.10",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {Coinbase.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
      {:websockex, "~> 0.4.2"},
      {:poison, "~> 5.0"},
      {:httpoison, "~> 1.8"},
      {:aurum, "~> 0.2.0"}
    ]
  end
end
