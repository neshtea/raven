defmodule Raven.Database do

  use GenServer
  alias UUID
  alias Raven.Message

  # GenServer implementation.
  def init(_) do
    {:ok, Map.new()}
  end

  def start_link() do
    GenServer.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  ## Casts
  def handle_cast({:create, user, message}, state) do
    uuid = UUID.uuid1()
    message = %Message{id: uuid, user: user, message: message}
    {:noreply, Map.put(state, uuid, message)}
  end

  def handle_cast({:update, {id, model}}, state) do
    {:noreply, Map.put(state, id, model)}
  end

  def handle_cast({:delete, id}, state) do
    {:noreply, Map.delete(state, id)}
  end

  ## Calls
  def handle_call({:read, id}, _from, state) do
    {:reply, Map.get(state, id), state}
  end

  def handle_call(:readall, _from, state) do
    {:reply, state, state}
  end

  # Convenience functions
  def create(user, message) do
    GenServer.cast(__MODULE__, {:create, user, message})
  end

  def read(id) do
    GenServer.call(__MODULE__, {:read, id})
  end

  def read_all() do
    GenServer.call(__MODULE__, :readall)
  end

  def update({id, model}) do
    GenServer.cast(__MODULE__, {:update, {id, model}})
  end

  def delete(id) do
    GenServer.cast(__MODULE__, {:delete, id})
  end
end
