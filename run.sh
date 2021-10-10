#!/bin/bash
# Bash Menu Script

PS3='Type the number here: '
echo 'Welcome to Big Data Processing Application.'
echo 'Please type the number that corresponds to which application you would like to run:'
echo ' '
options=("Apache Hadoop" "Apache Spark" "Jupyter Notebook" "SonarQube and SonarScanner" "Quit")
select opt in "${options[@]}"
do
    case $opt in
        "Apache Hadoop")
            echo "you chose $opt"
            echo "Run $opt on the cluster"
            ;;
        "Apache Spark")
            echo "you chose $opt"
            echo "Run $opt on the cluster"
            ;;
        "Jupyter Notebook")
            echo "you chose $opt"
            echo "Run $opt on the cluster"
            ;;
        "SonarQube and SonarScanner")
            echo "you chose $opt"
            echo "Run $opt on the cluster"
            ;;
        "Quit")
            break
            ;;
        *) echo "invalid option $REPLY";;
    esac
done
