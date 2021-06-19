defmodule ExMon.Trainer.Update do
  @moduledoc false
  alias Ecto.UUID
  alias ExMon.Repo
  alias ExMon.Trainer

  def call(%{"id" => id} = params) do
    case UUID.cast(id) do
      :error -> {:error, "Invalid ID format!"}
      {:ok, _uuid} -> update(params)
    end
  end

  defp update(%{"id" => uuid} = params) do
    case fetch_trainer(uuid) do
      nil -> {:error, "Trainer not found!"}
      trainer -> update_trainer(create_changeset(trainer, params))
    end
  end

  defp fetch_trainer(uuid), do: Repo.get(Trainer, uuid)

  defp create_changeset(trainer, params) do
    trainer
    |> Trainer.changeset(params)
  end

  defp update_trainer(changeset) do
    case Repo.update(changeset) do
      {:ok, trainer} -> {:ok, trainer}
      {:error, changeset} -> {:error, changeset}
    end
  end
end
