#!/usr/bin/env bash

mix deps.get --only prod
MIX_ENV=prod mix compile