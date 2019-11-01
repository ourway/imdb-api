# OpenMovieApi

Basic APIs for getting movie information based on imdb id.
Data is getting updates every day.

API docs are available on: https://imdb.appido.ir/docs

## Install

Run the following
```bash
#!/usr/bin/env bash
mix deps.get
mix do deps.compile, compile
cp .env.example .env
source .env
bash data/download.sh
mix run -e OpenMovieApi.DbSetup.run
mix phx.server
```

or simply run `./run.sh`
API will be served on port `8014`.
