defmodule Sandwich.RecipesController do
  use Sandwich.Web, :controller

  alias Sandwich.Repo
  alias Sandwich.Recipe
  alias Sandwich.Ingredient
  alias Sandwich.RecipeIngredient

  def index(conn, _params) do
    recipes = Repo.all(Recipe)

    render conn, "index.html", recipes: recipes
  end

  def show(conn, params) do
    recipe = Repo.preload(Repo.get_by(Recipe, id: params["id"]), [recipe_ingredients: :ingredient])

    render conn, "show.html", recipe: recipe
  end

  def new(conn, _params) do
    changeset = Recipe.changeset(%Recipe{recipe_ingredients: [%RecipeIngredient{ingredient: %Ingredient{}}]}, %{})
    ingredients = Repo.all(Ingredient)

    render(conn, "new.html", changeset: changeset, ingredients: ingredients)
  end

  def create(conn, %{"recipe" => recipe_params}) do
    normalized_params = Map.replace!(
      recipe_params,
      "recipe_ingredients",
      Map.values(recipe_params["recipe_ingredients"])
    )

    %Recipe{}
    |> Recipe.changeset(normalized_params)
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
    recipe = Repo.preload(Repo.get_by(Recipe, id: params["id"]), :recipe_ingredients)
    ingredients = Repo.all(Ingredient)
    changeset = Recipe.changeset(recipe, %{})

    render(conn, "edit.html", recipe: recipe, ingredients: ingredients, changeset: changeset)
  end

  def update(conn, %{"recipe" => recipe_params, "id" => id}) do
    recipe = Repo.preload(Repo.get_by(Recipe, id: id), :ingredients)

    recipe
    |> Recipe.changeset(recipe_params)
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

