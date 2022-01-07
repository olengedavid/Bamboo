defmodule MyApp.Accounts.Token do
  alias MyApp.Accounts.User

  @signing_salt "news_api"
  # token for 12 hrs
  @token_age_secs 43_200

  # create token for a given user
  def create_new_token(%User{id: user_id}) do
    Phoenix.Token.sign MyAppWeb.Endpoint, @signing_salt, user_id do
    end
  end

  def verify_new_token(token) do
    case Phoenix.Token.verify(MyAppWeb.Endpoint, @signing_salt, token, max_age: @token_age_secs) do
      {:ok, data} -> {:ok, data}
      _error -> {:error, :unauthenticated}
    end
  end
end
