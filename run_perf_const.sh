#!/bin/bash
repo_dirs=/global/home/users/prhegde/microbench/
output_dir=/global/home/users/prhegde/microbench/results

# mkdir -p "$output_dir"
for repo_dir in "$repo_dirs"/*; do

    if [ -d "$repo_dir" ] && [ -n "$(ls -A $repo)" ] 
    then 
        exec_name=$(basename "$repo_dir")
        cycles=()
        instructions=()
        branch_misses=()
        #perf stat -o "$output_dir"/"$exec_name" -e cycles,instructions,branch-misses "$repo_dir"/bench.ARM
        for i in {1..100}
        do
            perf_output=$(perf stat -e cycles,instructions,branch-misses "$repo_dir"/bench.X86 2>&1)
    

            cycles+=($(echo "$perf_output" | grep "cycles" | awk '{print $1}'))
            instructions+=($(echo "$perf_output" | grep "instructions" | awk '{print $1}'))
            branch_misses+=($(echo "$perf_output" | grep "branch-misses" | awk '{print $1}'))
            sleep 2
        done

        echo "$exec_name""_Cycles: ${cycles[@]}"
        echo "$exec_name""_Instructions: ${instructions[@]}"
        echo "$exec_name""_Branch_Misses: ${branch_misses[@]}"
    fi 
done