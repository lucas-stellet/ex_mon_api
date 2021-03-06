defmodule ExMon.Trainer do
  @moduledoc false

  use Ecto.Schema
  import Ecto.Changeset

  alias ExMon.Trainer.Pokemon

  @primary_key {:id, Ecto.UUID, autogenerate: true}

  schema "trainers" do
    field :name, :string
    field :password_hash, :string
    field :password, :string, virtual: true
    has_one(:pokemon, Pokemon)
    timestamps()
  end

  @required_params [:name, :password]

  def build(params) do
    params
    |> changeset()
    |> apply_action(:insert)
  end

  def changeset(params), do: create_changeset(%__MODULE__{}, params)

  def changeset(trainer, params), do: create_changeset(trainer, params)

  defp create_changeset(trainer, params) do
    trainer
    |> cast(params, @required_params)
    |> validate_required(@required_params)
    |> validate_length(:password, min: 6)
    |> put_password_hash()
  end

  defp put_password_hash(
         %Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset
       ) do
    change(changeset, Argon2.add_hash(password))
  end

  defp put_password_hash(changeset), do: changeset
end
