defmodule Sandwich.IngredientsController do
  use Sandwich.Web, :controller

  def index(conn, _params) do
    alias Sandwich.Repo
    alias Sandwich.Ingredient
    ingredients = Repo.all(Ingredient)

    render conn, "index.html", ingredients: ingredients
  end

  def new(conn, _params) do
    alias Sandwich.Ingredient
    changeset = Ingredient.changeset(%Ingredient{}, %{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"ingredient" => ingredient_params}) do
    alias Sandwich.Ingredient
    alias Sandwich.Repo
    %Ingredient{}
    |> Ingredient.changeset(ingredient_params)
    |> Repo.insert()
    |> case do
      {:ok, _ingredient} ->
        conn
        |> put_flash(:info, "Ingredient saved")
        |> redirect(to: ingredients_path(conn, :index))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end
end

