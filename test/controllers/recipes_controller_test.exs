defmodule Sandwich.RecipesControllerTest do
  use Sandwich.ConnCase

  test "GET :index", %{conn: conn} do
    conn = get conn, recipes_path(conn, :index)
    assert html_response(conn, 200)
  end

  test "GET :show", %{conn: conn} do
    recipe = Sandwich.Repo.insert!(%Sandwich.Recipe{title: "title", body: "body"})

    conn = get conn, recipes_path(conn, :show, recipe.id)

    assert html_response(conn, 200)
  end

  test "GET :new", %{conn: conn} do
    conn = get conn, recipes_path(conn, :new)

    assert html_response(conn, 200)
  end

  test "POST :create", %{conn: conn} do
    recipe_title = "title"

    conn = post conn, recipes_path(conn, :create), [recipe: [body: "body", title: recipe_title]]

    assert html_response(conn, 302)
    assert Sandwich.Repo.get_by(Sandwich.Recipe, title: recipe_title)
  end

  test "GET :edit", %{conn: conn} do
    recipe = Sandwich.Repo.insert!(%Sandwich.Recipe{title: "title", body: "body"})

    conn = get conn, recipes_path(conn, :edit, recipe.id)

    assert html_response(conn, 200)
  end

  test "PUT :update", %{conn: conn} do
    recipe = Sandwich.Repo.insert!(%Sandwich.Recipe{title: "title", body: "body"})
    new_title = "new title"

    conn = put conn, recipes_path(conn, :update, recipe.id, [recipe: [title: new_title]])

    assert html_response(conn, 302)
    assert Sandwich.Repo.get_by(Sandwich.Recipe, title: new_title)
  end
end
