#!/usr/bin/env bash
mix deps.get
mix do deps.compile, compile
cp .env.example .env
source .env
bash data/download.sh
MIX_ENV=prod mix run -e OpenMovieApi.DbSetup.run
MIX_ENV=prod mix phx.server
