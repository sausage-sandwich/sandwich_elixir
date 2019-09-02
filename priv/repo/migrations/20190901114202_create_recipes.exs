defmodule Sandwich.Repo.Migrations.CreateRecipes do
  use Ecto.Migration

  def change do
    create table(:recipes) do
      add :title, :string
      add :body, :text

      timestamps()
    end

  end
end
