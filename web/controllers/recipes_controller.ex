defmodule Sandwich.RecipesController do
  use Sandwich.Web, :controller

  def index(conn, _params) do
    alias Sandwich.Repo
    alias Sandwich.Recipe
    recipes = Repo.all(Recipe)

    render conn, "index.html", recipes: recipes
  end

  def new(conn, _params) do
    alias Sandwich.Recipe
    changeset = Recipe.changeset(%Recipe{}, %{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"recipe" => recipe_params}) do
    alias Sandwich.Recipe
    alias Sandwich.Repo
    %Recipe{}
    |> Recipe.changeset(recipe_params)
    |> Repo.insert()
    |> case do
      {:ok, recipe} ->
        conn
        |> put_flash(:info, "Recipe saved")
        |> redirect(to: recipes_path(conn, :index))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end
end

