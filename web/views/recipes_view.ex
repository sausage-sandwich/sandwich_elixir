defmodule Sandwich.RecipesView do
  use Sandwich.Web, :view

  def units do
    [
      "кг",
      "г",
      "шт"
    ]
  end
end
