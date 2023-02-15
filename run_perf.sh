#!/bin/bash

repo_dirs=/global/home/users/prhegde/microbench/
output_dir=/global/home/users/prhegde/microbench/results

for repo_dir in "$repo_dirs"/*; do
    exec_name=$(basename "$repo_dir")
    perf stat -o "$output_dir"/"$exec_name" -e cycles,instructions "$repo_dir"/bench.ARM
done

