defmodule OpenMovieApi.Helpers do
  @moduledoc """
  Provides helper tools to deal with files, math, ...

  """

  def read_tsv(path) do

    File.stream!(path) |> Flow.from_enumerable |> Flow.flat_map(&String.split(&1, "\t")) |> Flow.partition |> Flow.map( fn x -> x end) 
    |> Enum.to_list

  end
end
