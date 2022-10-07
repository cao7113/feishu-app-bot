defmodule FeishuAppBot.Contract do
  alias FeishuAppBot.Client

  # @user_id_types ~w[open_id union_id user_id]a

  # 通过手机号或邮箱获取用户 ID
  # https://open.feishu.cn/document/uAjLw4CM/ukTMukTMukTM/reference/contact-v3/user/batch_get_id

  @doc """
  ## Options:
  * user_id_type: one of [open_id, union_id, user_id], default: open_id
  * debug: default false
  ## Example

  iex> Bot.Contract.user_ids ["13700012345"], user_id_type: :user_id, debug: true
  """
  def user_ids(mobiles, opts \\ []) when is_list(mobiles) do
    path = "/open-apis/contact/v3/users/batch_get_id"

    body = %{
      mobiles: mobiles
    }

    get_authed_client(opts)
    |> Tesla.post(path, body)
  end

  def user_ids_from_emails(emails, opts \\ []) when is_list(emails) do
    path = "/open-apis/contact/v3/users/batch_get_id"

    body = %{
      emails: emails
    }

    get_authed_client(opts)
    |> Tesla.post(path, body)
  end

  def get_authed_client(opts \\ []) do
    token = opts[:auth_token] || FeishuAppBot.TokenServer.tenant_access_token()
    qs = Keyword.take(opts, [:user_id_type])

    [
      {Tesla.Middleware.BearerAuth, token: token},
      {Tesla.Middleware.Query, qs}
    ]
    |> Client.append_middlewares(opts)
    |> Client.build(opts)
  end
end
