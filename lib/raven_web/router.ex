defmodule RavenWeb.Router do
  use RavenWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers

  end

  scope "/", RavenWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    get "/new", PageController, :new
    get "/:id/edit", PageController, :edit
    get "/:id/show", PageController, :show
    post "/create", PageController, :create
    post "/change", PageController, :change
    delete "/:id/delete", PageController, :delete
  end
end
