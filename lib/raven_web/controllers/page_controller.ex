defmodule RavenWeb.PageController do
  use RavenWeb, :controller

  alias Raven.Database
  alias Raven.Message



  def index(conn, _params) do
    case Database.read_all() do
      %{} = ms -> render(conn, "index.html", messages: ms)
    end

  end

  def new(conn, _params) do
    render conn, "new.html"
  end

  def create(conn, %{"user" => user, "message" => message}) do
    case Database.create(user, message) do
      :ok -> redirect(conn, to: page_path(conn, :index))
      {:error, err} -> put_flash(conn, :error, err)
                        |> render("new.html")
    end
  end

  def show(conn, %{"id" => id}) do
    case Database.read(id) do
      nil ->
        put_flash(conn, :error, "Message #{id} not found.")
        |> redirect(to: page_path(conn, :index))
      message -> render(conn, "show.html", message: message)
    end
  end

  def edit(conn, %{"id" => id}) do
    case Database.read(id) do
      nil ->
        put_flash(conn, :error, "Message #{id} not found.")
        |> redirect(to: page_path(conn, :index))
      message -> render(conn, "edit.html", message: message)
    end
  end

  def change(conn, %{"id" => id, "user" => user, "message" => message}) do
    message = %Message{id: id, user: user, message: message}
    case Database.update({id, message}) do
      nil ->
        put_flash(conn, :error, "Message #{id} not found.")
        |> redirect(to: page_path(conn, :index))
      _ ->
        put_flash(conn, :success, "Message #{id} successfully changed.")
        |> redirect(to: page_path(conn, :index))
    end
    redirect(conn, to: page_path(conn, :index))
  end

  def delete(conn, %{"id" => id}) do
    case Database.read(id) do
      nil ->
        put_flash(conn, :error, "Message #{id} not found.")
        |> redirect(to: page_path(conn, :index))
      _ ->
        Database.delete(id)
        put_flash(conn, :success, "Message #{id} successfully deleted.")
        |> redirect(to: page_path(conn, :index))
      end
  end
end
