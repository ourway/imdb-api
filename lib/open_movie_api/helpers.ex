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
  def get_last_id(path) do
    {line, 0} = System.cmd("tail", ["-n", "1", path])

    line
    |> String.trim()
    |> String.split("\t", trim: true)
    |> List.first()
    |> get_id
  end

  @doc """
    reads downloaded files from https://datasets.imdbws.com/
  """
  def read_tsv(path, module, callback) do
    total = path |> get_last_id

    File.stream!(path)
    |> Stream.drop(1)
    |> Flow.from_enumerable(max_demand: 8192)
    |> Flow.map(&apply(module, callback, [&1]))
    |> Flow.map(
      &Logger.debug(fn ->
        "#{((&1 |> List.first() |> get_id) * 100 / total) |> round}% complete - #{
          &1 |> List.first()
        }"
      end)
    )
    |> Enum.to_list()
  end
end
