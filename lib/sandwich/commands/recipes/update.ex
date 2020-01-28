defmodule Sandwich.Commands.Recipes.Update do
  alias Sandwich.Repo
  alias Sandwich.Recipe
  alias Sandwich.Ingredient
  alias Sandwich.Queries.IngredientByTitle

  def call(recipe_id, recipe_params) do
    recipe = Repo.preload(Repo.get_by(Recipe, id: recipe_id), recipe_ingredients: :ingredient)

    recipe_ingredients = Enum.map(
      Map.get(recipe_params, "recipe_ingredients", []),
      &(
        %{
            ingredient_id: find_or_create_ingredient(&1["ingredient_title"]).id,
            quantity: &1["quantity"],
            unit: &1["unit"]
        }
      )
    )
    params = Map.merge(recipe_params, %{"recipe_ingredients" => recipe_ingredients})

    recipe
    |> Recipe.changeset(params)
    |> Repo.update()
  end

  def find_or_create_ingredient(title) do
    IngredientByTitle.call(title) || Sandwich.Commands.Ingredients.Create.call(title)
  end
end
