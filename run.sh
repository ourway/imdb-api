#!/usr/bin/env bash
mix deps.get
mix do deps.compile, compile
cp .env.example .env
source .env
bash data/download.sh
mix run -e OpenMovieApi.DbSetup.run
mix phx.server
