defmodule Metallum.Mixfile do
  use Mix.Project

  def project do
    [app: :metallum,
     version: "0.1.0",
     elixir: "~> 1.4",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     escript: escript(),
     deps: deps()]
  end

  def application do
    # Specify extra applications you'll use from Erlang/Elixir
    [extra_applications: [:logger]]
  end

  def escript do
    [main_module: Metallum]
  end

  defp deps do
    [{:httpoison, "~> 0.12"},
     {:floki, "~> 0.17.0"}]
  end
end
