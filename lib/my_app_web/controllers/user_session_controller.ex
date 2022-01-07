defmodule MyAppWeb.UserSessionController do
  use MyAppWeb, :controller

  alias MyApp.Accounts

  def new(conn, %{"email" => email, "password" => password}) do
    with {:ok, user} <- Accounts.authenticate_user(email, password)

    {:ok, token} <-
      MyApp.Token.create_new_token %{user_id: user.id} do
        send_resp(conn, 200, token)
      else
        _ -> {:error, gettext("email or password is incorrect")}
      end
  end
end
