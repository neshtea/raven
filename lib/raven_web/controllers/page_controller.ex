defmodule RavenWeb.PageController do
  use RavenWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
