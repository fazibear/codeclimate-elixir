defmodule CodeclimateElixir.Mixfile do
  use Mix.Project

  def project do
    [app: :codeclimate_elixir,
     version: "0.0.1",
     elixir: "~> 1.1",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps]
  end

  def application do
    [applications: []]
  end

  defp deps do
    [
      {:credo, "~> 0.1.9"},
      {:dogma, "~> 0.0"}
    ]
  end
end
