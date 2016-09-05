#!/bin/bash
set -eux -o pipefail

TMPDIR=$(mktemp -d)

cat ci/2-envs.yml  | gsed -e 's/\(^ *\)\(resource: repo-.*\)/\1\2\n\1params: { submodules: all }/' > $TMPDIR/pipeline.yml

fly -t lite sp -p test-2-envs -c $TMPDIR/pipeline.yml -l params.yml -l credentials.yml

rm -rf $TMPDIR
