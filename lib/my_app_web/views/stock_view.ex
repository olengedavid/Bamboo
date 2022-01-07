defmodule MyAppWeb.StockView do
  use MyAppWeb, :view

  def render("index.json", %{news: news}) do
    news
  end
end
