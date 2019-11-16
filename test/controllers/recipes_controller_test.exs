defmodule Sandwich.RecipesControllerTest do
  use Sandwich.ConnCase

  alias Sandwich.Repo
  alias Sandwich.Recipe
  alias Sandwich.Ingredient

  test "GET :index", %{conn: conn} do
    conn = get conn, recipes_path(conn, :index)
    assert html_response(conn, 200)
  end

  test "GET :show", %{conn: conn} do
    recipe = Repo.insert!(%Recipe{title: "title", body: "body"})

    conn = get conn, recipes_path(conn, :show, recipe.id)

    assert html_response(conn, 200)
  end

  test "GET :new", %{conn: conn} do
    conn = get conn, recipes_path(conn, :new)

    assert html_response(conn, 200)
  end

  test "POST :create", %{conn: conn} do
    recipe_title = "title"
    ingredient = Repo.insert!(%Ingredient{title: "Carrot"})

    conn = post conn, recipes_path(conn, :create),
      [recipe: [body: "body", title: recipe_title, ingredients: [ingredient.id]]]

    created_recipe = Repo.preload(Repo.get_by(Recipe, title: recipe_title), :ingredients)

    assert html_response(conn, 302)
    assert created_recipe
    assert Enum.member?(created_recipe.ingredients, ingredient)
  end

  test "GET :edit", %{conn: conn} do
    recipe = Repo.insert!(%Recipe{title: "title", body: "body"})

    conn = get conn, recipes_path(conn, :edit, recipe.id)

    assert html_response(conn, 200)
  end

  test "PUT :update", %{conn: conn} do
    recipe = Repo.insert!(%Recipe{title: "title", body: "body"})
    new_title = "new title"
    params = [recipe: [title: new_title, ingredients: [1]]]

    conn = put conn, recipes_path(conn, :update, recipe.id, params)

    assert html_response(conn, 302)
    assert Repo.get_by(Recipe, title: new_title)
  end
end
