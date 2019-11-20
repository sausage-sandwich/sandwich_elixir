defmodule Sandwich.Recipe do
  use Ecto.Schema
  use Waffle.Ecto.Schema
  import Ecto.Changeset

  schema "recipes" do
    field :body, :string
    field :title, :string
    field :cover, Sandwich.Recipe.CoverUploader.Type

    has_many(:recipe_ingredients, Sandwich.RecipeIngredient, on_replace: :delete)

    timestamps()
  end

  @doc false
  def changeset(recipe, attrs) do
    recipe
    |> cast(attrs, [:title, :body])
    |> cast_attachments(attrs, [:cover])
    |> cast_assoc(:recipe_ingredients)
    |> validate_required([:title, :body])
  end
end
