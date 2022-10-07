defmodule FeishuAppBot.App do
  @moduledoc """
  Feishu App https://open.feishu.cn/document/ukTMukTMukTM/uYTM5UjL2ETO14iNxkTN/terminology
  """

  defstruct app_id: nil, app_secret: nil, client: nil

  # https://open.feishu.cn/document/ukTMukTMukTM/ukDNz4SO0MjL5QzM/auth-v3/auth/tenant_access_token_internal
  def tenant_access_token(opts \\ []) do
    path = "/open-apis/auth/v3/tenant_access_token/internal"
    do_get_access_token(path, opts)
  end

  # https://open.feishu.cn/document/ukTMukTMukTM/ukDNz4SO0MjL5QzM/auth-v3/auth/app_access_token_internal
  def app_access_token(opts \\ []) do
    path = "/open-apis/auth/v3/app_access_token/internal"
    do_get_access_token(path, opts)
  end

  def do_get_access_token(path, opts \\ []) do
    app = default_app(opts)
    body = Map.take(app, [:app_id, :app_secret])

    app.client
    |> Tesla.post(path, body)
  end

  def default_app(opts \\ []) do
    %__MODULE__{
      app_id: System.fetch_env!("FEISHU_DEFAULT_APP_ID"),
      app_secret: System.fetch_env!("FEISHU_DEFAULT_APP_SECRET"),
      client: opts[:client] || FeishuAppBot.Client.new(opts)
    }
  end
end
