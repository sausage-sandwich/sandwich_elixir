defmodule Sandwich.Ingredient do
  use Ecto.Schema
  import Ecto.Changeset

  schema "ingredients" do
    field :title, :string

    many_to_many(
      :recipes,
      Sandwich.Recipe,
      join_through: "recipe_ingredients",
      on_replace: :delete
    )

    timestamps()
  end

  @doc false
  def changeset(ingredient, attrs) do
    ingredient
    |> cast(attrs, [:title])
    |> validate_required([:title])
  end
end
