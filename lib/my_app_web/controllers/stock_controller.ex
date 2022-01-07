defmodule MyAppWeb.StockController do
  use MyAppWeb, :controller
  alias MyApp.ExternalNews

  def index(conn, _params) do
    news = ExternalNews.fetch_json()

    render(conn, "index.json", news: news)
  end
end
