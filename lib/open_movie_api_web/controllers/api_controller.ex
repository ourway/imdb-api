defmodule OpenMovieApiWeb.APIs do
  @moduledoc """
    This module fetches data from mnesia database.

  """

  use OpenMovieApiWeb, :controller

  def ping(conn, _params) do
    conn |> json(%{message: :pong})
  end
end
