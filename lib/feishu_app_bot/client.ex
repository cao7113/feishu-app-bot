defmodule FeishuAppBot.Client do
  def new(opts \\ []) do
    mw = opts[:middlewares] || default_middlewares(opts)
    adapter = opts[:adapter] || Tesla.Adapter.Hackney
    Tesla.client(mw, adapter)
  end

  def build(mws, opts \\ []) do
    new(
      opts
      |> Keyword.merge(middlewares: mws)
    )
  end

  def default_middlewares(opts \\ []) do
    headers = opts[:headers] || []
    base_url = opts[:base_url] || "https://open.feishu.cn"

    [
      {Tesla.Middleware.BaseUrl, base_url},
      {Tesla.Middleware.Headers, headers},
      {Tesla.Middleware.JSON, [engine_opts: [keys: :atoms]]},
      {Tesla.Middleware.Logger, [debug: opts[:debug] || false]}
    ]
  end

  def append_middlewares(mws, opts \\ []) when is_list(mws) do
    default_middlewares(opts) ++ mws
  end

  def append_middleware(mw, opts \\ []) do
    default_middlewares(opts) ++ [mw]
  end
end
