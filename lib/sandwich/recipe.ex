defmodule Sandwich.Recipe do
  use Ecto.Schema
  use Waffle.Ecto.Schema
  import Ecto.Changeset

  schema "recipes" do
    field :body, :string
    field :title, :string
    field :cover, Sandwich.Recipe.CoverUploader.Type

    many_to_many(
      :ingredients,
      Sandwich.Ingredient,
      join_through: "recipe_ingredients",
      on_replace: :delete
    )

    timestamps()
  end

  @doc false
  def changeset(recipe, attrs) do
    recipe
    |> cast(attrs, [:title, :body])
    |> cast_attachments(attrs, [:cover])
    |> put_assoc(:ingredients, attrs["ingredients"])
    |> validate_required([:title, :body])
  end
end
