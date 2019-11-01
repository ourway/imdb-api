defmodule OpenMovieApi.Models.Basic do
  @moduledoc false
  defstruct tconst: nil,
            type: nil,
            title: nil,
            isAdult: false,
            startYear: 0,
            endYear: 0,
            runtime: 0,
            genres: []
end

defmodule OpenMovieApi.Models.Rating do
  @moduledoc false

  defstruct tconst: nil,
            rate: 0,
            votes: 0
end

defmodule OpenMovieApi.Models.Aka do
  @moduledoc false
  defstruct tconst: nil,
            region: nil,
            lang: nil
end

defmodule OpenMovieApi.Models.Episode do
  @moduledoc false
  defstruct tconst: nil,
            parent: nil,
            season: 0,
            episode: 0
end

defmodule OpenMovieApi.Models.Crew do
  @moduledoc false

  defstruct tconst: nil,
            directors: [],
            writers: []
end

defmodule OpenMovieApi.Model.Principal do
  @moduledoc false

  defstruct nconst: nil,
            category: nil,
            job: nil,
            characters: []
end
