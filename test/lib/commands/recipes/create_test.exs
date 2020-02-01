defmodule Sandwich.Commands.Recipes.CreateTest do
  import Assertions

  use ExUnit.Case
  use Sandwich.ModelCase

  alias Sandwich.Repo
  alias Sandwich.Recipe
  alias Sandwich.Ingredient

  test "creates a new recipe with existing and new ingredients" do
    existing_ingredient = Repo.insert!(%Ingredient{title: "milk"})
    new_ingredient_title = "water"
    recipe_params = %{
      "title" => "title",
      "body" => "body",
      "recipe_ingredients" => [
        %{
          "ingredient_title" => existing_ingredient.title,
          "unit" => "ml",
          "quantity" => 150.0
        },
        %{
          "ingredient_title" => new_ingredient_title,
          "unit" => "ml",
          "quantity" => 100.0
        }
      ]
    }
    Sandwich.Commands.Recipes.Create.call(recipe_params)
    recipe = Repo.preload(Repo.get_by(Recipe, title: recipe_params["title"]), recipe_ingredients: :ingredient)
    recipe_ingredients = Enum.map(recipe.recipe_ingredients, &({&1.ingredient.id, &1.ingredient.title}))
    new_ingredient = Repo.get_by(Ingredient, title: new_ingredient_title)

    assert(recipe)
    assert_lists_equal(recipe_ingredients, [
      {existing_ingredient.id, existing_ingredient.title},
      {new_ingredient.id, new_ingredient_title}
    ])
  end
end
