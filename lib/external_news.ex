defmodule MyApp.ExternalNews do
  @url "https://newsapi.org/v2/top-headlines?"

  defp build_url(params \\ %{country: "us"}) do
    params = Plug.Conn.Query.encode(params)
    @url <> "#{params}" <> "&apiKey=cc6b1881ad6c4df08676325f0c42cd49"
  end

  def fetch_json() do
    build_url()

    case HTTPoison.get(build_url()) do
      {:ok, %HTTPoison.Response{body: body, status_code: 200}} ->
        %{"articles" => articles} = Poison.decode!(body)

        articles |> IO.inspect()

      {:error, %HTTPoison.Error{reason: reason}} ->
        {:error, reason}
    end
  end
end
