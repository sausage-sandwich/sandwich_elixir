defmodule Sandwich.Repo.Migrations.CreateIngredients do
  use Ecto.Migration

  def change do
    create table(:ingredients) do
      add :title, :string

      timestamps()
    end

  end
end
