defmodule Sandwich.Recipe do
  use Ecto.Schema
  import Ecto.Changeset

  schema "recipes" do
    field :body, :string
    field :title, :string

    timestamps()
  end

  @doc false
  def changeset(recipe, attrs) do
    recipe
    |> cast(attrs, [:title, :body])
    |> validate_required([:title, :body])
  end
end
