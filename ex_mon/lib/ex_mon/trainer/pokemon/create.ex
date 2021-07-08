defmodule ExMon.Trainer.Pokemon.Create do
  @moduledoc false
  alias ExMon.PokeApi.Client
  alias ExMon.Pokemon
  alias ExMon.Repo
  alias ExMon.Trainer.Pokemon, as: TrainerPokemon
  alias ExMon.Trainer

  def call(%{"name" => name} = params) do
    name
    |> Client.get_pokemon()
    |> handle_response(params)
  end

  defp handle_response({:ok, body}, params) do
    body
    |> Pokemon.build()
    |> create_pokemon(params)
  end

  defp handle_response({:error, _msg} = error, _params), do: error

  defp create_pokemon(%Pokemon{name: name, weight: weight, types: types}, %{
         "nickname" => nickname,
         "trainer_id" => trainer_id
       }) do
    params = %{
      name: name,
      weight: weight,
      types: types,
      nickname: nickname,
      trainer_id: trainer_id
    }

    params
    |> TrainerPokemon.build()
    |> handle_build
  end

  defp handle_build({:ok, %{trainer_id: trainer_id} = pokemon}) do
    case fetch_trainer(trainer_id) do
      nil -> {:error, "Trainer not found!"}
      _trainer -> Repo.insert!(pokemon)
    end
  end

  defp handle_build({:error, _changeset} = error), do: error

  defp fetch_trainer(id), do: Repo.get(Trainer, id)
end
