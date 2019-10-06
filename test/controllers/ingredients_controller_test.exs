defmodule Sandwich.IngredientsControllerTest do
  use Sandwich.ConnCase

  test "GET :index", %{conn: conn} do
    conn = get conn, ingredients_path(conn, :index)
    assert html_response(conn, 200)
  end

  test "GET :new", %{conn: conn} do
    conn = get conn, ingredients_path(conn, :new)

    assert html_response(conn, 200)
  end

  test "POST :create", %{conn: conn} do
    ingredient_title = "carrot"
    conn = post conn, ingredients_path(conn, :create, %{"ingredient" => %{"title" => ingredient_title}})

    assert html_response(conn, 302)
    assert Sandwich.Repo.get_by(Sandwich.Ingredient, title: ingredient_title)
  end
end
