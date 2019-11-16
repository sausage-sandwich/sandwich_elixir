defmodule Sandwich.RecipesController do
  use Sandwich.Web, :controller

  alias Sandwich.Repo
  alias Sandwich.Recipe
  alias Sandwich.Ingredient

  def index(conn, _params) do
    recipes = Repo.all(Recipe)

    render conn, "index.html", recipes: recipes
  end

  def show(conn, params) do
    recipe = Repo.preload(Repo.get_by(Recipe, id: params["id"]), :ingredients)

    render conn, "show.html", recipe: recipe
  end

  def new(conn, _params) do
    changeset = Recipe.changeset(%Recipe{ingredients: [%Ingredient{}]}, %{})
    ingredients = Repo.all(Ingredient)

    render(conn, "new.html", changeset: changeset, ingredients: ingredients)
  end

  def create(conn, %{"recipe" => recipe_params}) do
    ingredients = from(i in Ingredient, where: i.id in ^recipe_params["ingredients"]) |> Repo.all
    params_with_ingredients = Map.replace!(recipe_params, "ingredients", ingredients)

    %Recipe{}
    |> Recipe.changeset(params_with_ingredients)
    |> Repo.insert()
    |> case do
      {:ok, _recipe} ->
        conn
        |> put_flash(:info, "Recipe saved")
        |> redirect(to: recipes_path(conn, :index))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def edit(conn, params) do
    recipe = Repo.preload(Repo.get_by(Recipe, id: params["id"]), :ingredients)
    ingredients = Repo.all(Ingredient)
    changeset = Recipe.changeset(recipe, %{})

    render(conn, "edit.html", recipe: recipe, ingredients: ingredients, changeset: changeset)
  end

  def update(conn, %{"recipe" => recipe_params, "id" => id}) do
    recipe = Repo.preload(Repo.get_by(Recipe, id: id), :ingredients)
    ingredients = from(i in Ingredient, where: i.id in ^recipe_params["ingredients"]) |> Repo.all
    params_with_ingredients = Map.replace!(recipe_params, "ingredients", ingredients)


    recipe
    |> Recipe.changeset(params_with_ingredients)
    |> Repo.update()
    |> case do
    {:ok, recipe} ->
      conn
      |> put_flash(:info, "Recipe updated")
      |> redirect(to: recipes_path(conn, :show, recipe.id))
    {:error, %Ecto.Changeset{} = changeset} ->
      render(conn, "edit.html", changeset: changeset, recipe: recipe)
    end
  end
end

