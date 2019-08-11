defmodule Caipirinha.MixProject do
  use Mix.Project

  def project do
    [
      app: :caipirinha,
      version: "0.1.0",
      elixir: "~> 1.8",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {Caipirinha.Application, []}
    ]
  end

  defp deps do
    [
      {:plug_cowboy, "~> 2.1"},
      {:poison, "~> 3.1"},
      {:httpoison, "~> 1.4"},
      {:ecto, "~> 3.1"},
      {:ecto_sql, "~> 3.1"},
      {:postgrex, ">= 0.0.0"},
      {:myxql, "~> 0.2.0"},
    ]
  end
end
