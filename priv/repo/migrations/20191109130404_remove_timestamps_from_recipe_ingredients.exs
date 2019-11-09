defmodule Sandwich.Repo.Migrations.RemoveTimestampsFromRecipeIngredients do
  use Ecto.Migration

  def change do
    alter table("recipe_ingredients") do
      remove :inserted_at
      remove :updated_at
    end
  end
end
