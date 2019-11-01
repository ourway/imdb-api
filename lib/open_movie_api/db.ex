defmodule OpenMovieApi.Db do
  @moduledoc """
  database operations

  """

  def add_basic(model) do
    {:atomic, :ok} =
      :mnesia.transaction(fn ->
        :ok =
          :mnesia.write(
            {Basics, model.tconst, model.type, model.title, model.isAdult, model.startYear,
             model.endYear, model.runtime, model.genres}
          )
      end)
  end

  def process_basic_tsv_line(lineList) do
    [tconst, type, title, _, isAdult, startYear, endYear, runtime, genres] = lineList

    %OpenMovieApi.Models.Basic{
      tconst: tconst,
      type: type,
      title: title,
      isAdult:
        case isAdult |> String.to_integer() do
          0 -> false
          1 -> true
        end,
      startYear:
        case startYear do
          "N" -> -1
          n -> n |> String.to_integer()
        end,
      endYear:
        case endYear do
          "N" -> -1
          n -> n |> String.to_integer()
        end,
      runtime:
        case runtime do
          "N" -> -1
          "" -> -1
          n -> n |> String.to_integer()
        end,
      genres: genres |> String.split(",", trim: true)
    }
  end
end
