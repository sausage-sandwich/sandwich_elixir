defmodule Sandwich.Commands.Recipes.Create do
  alias Sandwich.Repo
  alias Sandwich.Recipe
  alias Sandwich.Ingredient
  alias Sandwich.Queries.IngredientByTitle

  def call(recipe_params) do
    recipe_ingredients = Enum.map(
      recipe_params["recipe_ingredients"],
      &(
        %{
            "ingredient_id" => find_or_create_ingredient(&1["ingredient_title"]).id,
            "quantity" => &1["quantity"],
            "unit" => &1["unit"]
        }
      )
    )
    params = Map.replace!(recipe_params, "recipe_ingredients", recipe_ingredients)

    %Recipe{}
    |> Recipe.changeset(params)
    |> Repo.insert()
  end

  def find_or_create_ingredient(title) do
    IngredientByTitle.call(title) || create_ingredient(title)
  end

  # FIXME: it does not belong to this module
  def create_ingredient(title) do
    %Ingredient{}
    |> Ingredient.changeset(%{"title" => title})
    |> Repo.insert()
    |> case do
      {:ok, ingredient} ->
        ingredient
      {:error, _} ->
        raise ArgumentError
    end
  end
end
