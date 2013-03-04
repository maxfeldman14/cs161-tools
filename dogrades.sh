#!/bin/bash
# cs161 mod

# Start in ~/grading directory
cd ~/grading
cp grades.csv hws

# Grade all hws
echo "Grading HW"
cd hws
cp grades.csv hw1
cd hw1
# now in grading/hws/hw1
ruby generic_grader.rb "hw1" "hw1.csv"
enter-grades -f hw1
cd
