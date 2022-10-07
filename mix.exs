defmodule FeishuAppBot.MixProject do
  use Mix.Project

  def project do
    [
      app: :feishu_app_bot,
      version: "0.1.0",
      elixir: "~> 1.14",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {FeishuAppBot.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:tesla, "~> 1.4"},
      {:hackney, "~> 1.17"},
      {:jason, ">= 1.0.0"}
      # {:feishu_bot, github: "cao7113/feishu-bot"}
    ]
  end
end
