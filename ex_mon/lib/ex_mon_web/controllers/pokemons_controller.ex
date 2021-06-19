defmodule ExMonWeb.PokemonsController do
  @moduledoc false
  use ExMonWeb, :controller
  alias ExMon

  action_fallback ExMonWeb.FallbackController

  def show(conn, %{"name" => name}) do
    name
    |> ExMon.fetch_pokemon()
    |> handle_response(conn)
  end

  defp handle_response({:ok, pokemon}, conn) do
    conn
    |> put_status(:ok)
    |> json(pokemon)
  end

  defp handle_response({:error, "Pokemon not found!"} = error, _conn),
    do: Tuple.append(error, :not_found)

  defp handle_response({:error, _reason} = error, _conn), do: error
end
