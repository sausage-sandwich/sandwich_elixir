defmodule Sandwich.Commands.Recipes.UpdateTest do
  import Assertions

  use ExUnit.Case
  use Sandwich.ModelCase

  alias Sandwich.Repo
  alias Sandwich.Recipe
  alias Sandwich.Ingredient
  alias Sandwich.RecipeIngredient

  test "updates recipe with provided params" do
    recipe = Repo.insert!(%Recipe{title: "title", body: "body"})
    new_ingredient_title = "new_ingredient_title"
    existing_ingredient_title = "existing_ingredient_title"
    existing_ingredient = Repo.insert!(%Ingredient{title: existing_ingredient_title})
    Repo.insert!(%RecipeIngredient{
      recipe_id: recipe.id,
      ingredient_id: existing_ingredient.id,
      quantity: 10.0,
      unit: "ml"
    })

    recipe_params = %{
      "title" => "new_title",
      "body" => "new_body",
      "recipe_ingredients" => [
        %{
          "ingredient_title" => new_ingredient_title,
          "quantity" => 100.0,
          "unit" => "ml"
        },
        %{
          "ingredient_title" => existing_ingredient_title,
          "quantity" => 100.0,
          "unit" => "ml"
        }
      ]
    }

    Sandwich.Commands.Recipes.Update.call(recipe.id, recipe_params)
    recipe = Repo.preload(Repo.get_by(Recipe, title: recipe_params["title"]), recipe_ingredients: :ingredient)
    recipe_ingredients = Enum.map(recipe.recipe_ingredients, &({&1.ingredient.id, &1.ingredient.title}))
    new_ingredient = Repo.get_by(Ingredient, title: new_ingredient_title)

    assert(recipe)
    assert_lists_equal(recipe_ingredients, [
      {new_ingredient.id, new_ingredient_title},
      {existing_ingredient.id, existing_ingredient_title}
    ])
  end
end
