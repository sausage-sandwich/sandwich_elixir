defmodule Sandwich.Queries.IngredientByTitle do
  import Ecto.Query, only: [from: 2]

  alias Sandwich.Ingredient
  alias Sandwich.Repo

  def call(query) do
    results = Repo.all(
      from ingredient in Ingredient,
      where: ingredient.title == ^query,
      limit: 1
    )
    List.first(results)
  end
end
