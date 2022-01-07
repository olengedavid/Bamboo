defmodule MyApp.Plug.Authenticate do
  import Plug.Conn
  require Logger

  def init(opts) do
    opts
  end

  def call(conn, _opts) do
    with ["Bearer" <> token] <- get_req_header(conn, "authorization"),
         {:ok, data} <- MyApp.Token.verify(token) do
      conn
      |> assign(:current_user, MyApp.Accounts.get_user(data.user_id))
    else
      _error ->
        conn
        |> put_status(:unathorized)
        |> Phoenix.Controller.put_view(MyAppWeb.ErrorView)
        |> Phoenix.Controler.render(:"401")
        |> halt()
    end
  end
end
