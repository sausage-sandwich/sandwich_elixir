defmodule Sandwich.Repo.Migrations.AddCoverToRecipes do
  use Ecto.Migration

  def change do
    alter table(:recipes) do
      add :cover, :string
    end
  end
end
