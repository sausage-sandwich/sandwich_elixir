defmodule Sandwich.RecipesView do
  use Sandwich.Web, :view

  def units do
    [
      "kg",
      "g",
      "pieces",
      "ml",
      "l",
      "pound",
      "ounce",
      "imperial_gallon",
      "imperial_quart",
      "imperial_pint",
      "imperial_cup",
      "imperial_fluid_ounce",
      "imperial_tablespoon",
      "imperial_teaspoon",
      "glass",
      "handful",
      "pinch"
    ]
  end

  def quantity_in_metric(unit, quantity) do
    in_metric = Map.get(any_to_metric(), unit)

    case in_metric do
      nil -> [Kernel.trunc(quantity), unit]
      _ -> [Kernel.trunc(quantity * Map.get(in_metric, "quantity")), Map.get(in_metric, "unit")]
    end
  end

  def any_to_metric do
    %{
      "us_cup" => %{"quantity" => 236.588, "unit" => "ml"},
      "us_liquid_gallon" => %{"quantity" => 3785.41, "unit" => "ml"},
      "us_liquid_quart" => %{"quantity" => 946.353, "unit" => "ml"},
      "us_liquid_pint" => %{"quantity" => 473.176, "unit" => "ml"},
      "us_legal_cup" => %{"quantity" => 240, "unit" => "ml"},
      "us_liquid_ounce" => %{"quantity" => 29.5735, "unit" => "ml"},
      "imperial_gallon" => %{"quantity" => 4546.09, "unit" => "ml"},
      "imperial_quart" => %{"quantity" => 1136.52, "unit" => "ml"},
      "imperial_pint" => %{"quantity" => 568.261, "unit" => "ml"},
      "imperial_cup" => %{"quantity" => 284.131, "unit" => "ml"},
      "imperial_fluid_ounce" => %{"quantity" => 28.4131, "unit" => "ml"},
      "pound" => %{"quantity" => 453.592, "unit" => "g"},
      "ounce" => %{"quantity" => 28.3495, "unit" => "g"}
    }
  end
end
