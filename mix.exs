defmodule EctoJsonDemo.MixProject do
  use Mix.Project

  def project do
    [
      app: :ecto_json_demo,
      version: "0.1.0",
      elixir: "~> 1.14",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:ecto, "~> 3.8"}
    ]
  end
end
