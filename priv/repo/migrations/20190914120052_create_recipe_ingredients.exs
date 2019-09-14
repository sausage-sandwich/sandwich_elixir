defmodule Sandwich.Repo.Migrations.CreateRecipeIngredients do
  use Ecto.Migration

  def change do
    create table(:recipe_ingredients) do
      add :quantity, :float
      add :unit, :string
      add :recipe_id, references(:recipes, on_delete: :nothing)
      add :ingredient_id, references(:ingredients, on_delete: :nothing)

      timestamps()
    end

    create(
      unique_index(
        :recipe_ingredients,
        [:recipe_id, :ingredient_id],
        name: :recipe_id_ingredient_id_unique_index
      )
    )
  end
end
