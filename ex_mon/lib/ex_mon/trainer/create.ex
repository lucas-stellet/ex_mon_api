defmodule ExMon.Trainer.Create do
  @moduledoc false
  alias ExMon.{Repo, Trainer}

  def call(params) do
    params
    |> Trainer.build()
    |> create_trainer()
  end

  defp create_trainer({:ok, changeset}), do: Repo.insert(changeset)
  defp create_trainer({:error, _changeset} = error), do: error
end
