#!/usr/bin/env sh
curl https://datasets.imdbws.com/title.basics.tsv.gz | gzip -d > data/title.basics.tsv
curl https://datasets.imdbws.com/title.ratings.tsv.gz | gzip -d > data/title.ratings.tsv
#curl https://datasets.imdbws.com/title.akas.tsv.gz | gzip -d > data/title.akas.tsv
#curl https://datasets.imdbws.com/title.crew.tsv.gz | gzip -d > data/title.crew.tsv
#curl https://datasets.imdbws.com/title.episode.tsv.gz | gzip -d > data/title.episode.tsv
#curl https://datasets.imdbws.com/title.principals.tsv.gz | gzip -d > data/title.principals.tsv
