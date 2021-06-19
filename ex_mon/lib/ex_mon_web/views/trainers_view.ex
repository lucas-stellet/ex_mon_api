defmodule ExMonWeb.TrainersView do
  use ExMonWeb, :view

  def render("create.json", %{trainer: %{id: id, name: name, inserted_at: inserted_at}}) do
    %{
      message: "Trainer created!",
      trainer: %{
        id: id,
        name: name,
        inserted_at: inserted_at
      }
    }
  end

  def render("get.json", %{trainer: %{id: id, name: name, inserted_at: inserted_at}}) do
    %{
      trainer: %{
        id: id,
        name: name,
        inserted_at: inserted_at
      }
    }
  end

  def render("update.json", %{trainer: %{id: id, name: name, updated_at: updated_at}}) do
    %{
      message: "Trainer updated successfully!",
      trainer: %{
        id: id,
        name: name,
        updated_at: updated_at
      }
    }
  end
end
