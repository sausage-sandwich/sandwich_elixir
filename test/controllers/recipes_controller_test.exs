defmodule Sandwich.RecipesControllerTest do
  use Sandwich.ConnCase

  test "GET :index", %{conn: conn} do
    conn = get conn, recipes_path(conn, :index)
    assert html_response(conn, 200)
  end
end
