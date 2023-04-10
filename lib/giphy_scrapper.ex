defmodule GiphyScrapper do
  defstruct id: nil, url: nil, title: nil, username: nil

  @api_url "https://api.giphy.com/v1/gifs/search?"

  def search(query) do
    setup_giphy_search_api_request(query)
    |> get_response_data()
    |> deserialize_from_json_to_data()
  end

  defp get_response_data({:ok, response}) do
    response.body
  end

  defp deserialize_from_json_to_data(json) do
    search_result =
      json
      |> Jason.decode!()

    search_result["data"]
    |> Enum.map(fn item ->
      %GiphyScrapper{
        id: item["id"],
        url: item["url"],
        title: item["title"],
        username: item["username"]
      }
    end)
  end

  defp setup_giphy_search_api_request(query) do
    Finch.build(:get, build_encoded_url(query))
    |> Finch.request(HttpClient)
  end

  defp build_encoded_url(query) do
    query_params =
      %{"api_key" => "rXmAwFW36JPkDBIEyrRXkb8eUjrFvYnF", "q" => query, "limit" => "25"}
      |> URI.encode_query()

    @api_url <> query_params
  end
end
