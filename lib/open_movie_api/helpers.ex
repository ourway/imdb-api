defmodule OpenMovieApi.Helpers do
  @moduledoc """
  Provides helper tools to deal with files, math, ...

  """
  require Logger

  @doc """
  returns integer part of tconst
  """
  def get_id(tconst) do
    tconst
    |> binary_part(2, 7)
    |> String.to_integer()
  end

  @doc """
  finds out what is last line and extract a number
  """
  defp get_last_id(path) do
    {line, 0} = System.cmd("tail", ["-n", "1", path])

    line
    |> String.trim()
    |> String.split("\t", trim: true)
    |> List.first()
    |> get_id
  end

  @doc """
  extract line into clean list
  """
  defp extract_line(line) do
    line |> String.trim() |> String.split("\t", trim: true)
  end

  @doc """
    reads downloaded files from https://datasets.imdbws.com/
  """
  def read_tsv(path, module, func) do
    total = path |> get_last_id()

    File.stream!(path)
    |> Stream.drop(1)
    |> Flow.from_enumerable(max_demand: 1024)
    |> Flow.map(&extract_line(&1))
    |> Enum.chunk_every(8192)
    |> Enum.map(&apply(module, func, [&1, total]))
  end
end
