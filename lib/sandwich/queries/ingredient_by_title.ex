defmodule Sandwich.Queries.IngredientByTitle do
  import Ecto.Query, only: [from: 2]

  alias Sandwich.Ingredient
  alias Sandwich.Repo

  def call(query) do
    like_term = "%#{query}%"
    results = Repo.all(
      from ingredient in Ingredient,
      where: ilike(ingredient.title, ^like_term),
      limit: 1
    )
    List.first(results)
  end
end
