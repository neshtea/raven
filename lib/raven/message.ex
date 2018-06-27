defmodule Raven.Message do
  @moduledoc """
  Message represents a message with a user (String.t) and a message (String.t).
  """

  alias UUID

  @type t :: %Raven.Message{
    id: UUID.t,
    user: String.t,
    message: String.t
  }
  @enforce_keys [:id, :user, :message]
  defstruct [:id, :user, :message]

end
