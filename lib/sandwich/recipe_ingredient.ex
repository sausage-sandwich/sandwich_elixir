defmodule Sandwich.RecipeIngredient do
  use Ecto.Schema
  import Ecto.Changeset

  schema "recipe_ingredients" do
    field :quantity, :float
    field :unit, :string
    belongs_to(:recipe, Sandwich.Recipe, primary_key: true)
    belongs_to(:ingredient, Sandwich.Ingredient, primary_key: true)
  end

  @doc false
  def changeset(recipe_ingredient, attrs) do
    recipe_ingredient
    |> cast(attrs, [:quantity, :unit, :ingredient_id, :recipe_id])
    |> validate_required([:quantity, :unit])
    |> foreign_key_constraint(:recipe_id)
    |> foreign_key_constraint(:ingredient_id)
    |> unique_constraint(:unique_recipe_ingredient,
      name: :recipe_id_ingredient_id_unique_index,
      message: @already_exists)
  end
end
