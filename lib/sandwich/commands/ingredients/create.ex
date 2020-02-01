defmodule Sandwich.Commands.Ingredients.Create do
  alias Sandwich.Repo
  alias Sandwich.Ingredient

  def call(title) do
    %Ingredient{}
    |> Ingredient.changeset(%{"title" => title})
    |> Repo.insert()
    |> case do
      {:ok, ingredient} ->
        ingredient
      {:error, _} ->
        raise ArgumentError
    end
  end
end
