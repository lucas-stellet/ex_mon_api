defmodule ExMon do
  @moduledoc false

  alias ExMon.{Pokemon, Trainer}

  defdelegate create_trainer(params), to: Trainer.Create, as: :call
  defdelegate delete_trainer(params), to: Trainer.Delete, as: :call
  defdelegate get_trainer(params), to: Trainer.Get, as: :call
  defdelegate update_trainer(params), to: Trainer.Update, as: :call

  defdelegate fetch_pokemon(params), to: Pokemon.Get, as: :call
  defdelegate create_pokemon(params), to: Trainer.Pokemon.Create, as: :call
end
