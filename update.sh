#!/usr/bin/env bash

echo Lets download data
bash data/download.sh
echo Processing the data. Will take few hours. Please wait ...
mix run -e OpenMovieApi.Commands.process_all
echo done.
