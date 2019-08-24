defmodule Sandwich.PageController do
  use Sandwich.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
