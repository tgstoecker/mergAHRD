#!/bin/bash

#safer programming env: some bugs recognized -> errors
#set -o errexit -o pipefail -o noclobber -o nounset
set -o pipefail -o noclobber -o nounset


CLEAR='\033[0m'
RED='\033[0;31m'

function usage() {
  if [ -n "$1" ]; then
    echo -e "${RED}<F0><9F><91><89> $1${CLEAR}\n";
  fi
  echo "Usage: $0 [-n number-of-people] [-s section-id] [-c cache-file]"
  echo "  -g, --GO_TABLE   AHRD output that INCL. GO term predictions"
  echo "  -h, --HRD_TABLE   AHRD output WITHOUT GO term predictions"
  echo "  The output is a .csv file in the current working directory called mergAHRD.csv"
  echo ""
  echo "Example: $0 --GO_TABLE AHRD_go_prediction.csv --HRD_TABLE AHRD_human_readable_descriptions.csv "
  exit 1
}


while [[ "$#" -gt 0 ]]; do
    case $1 in
        -g|--GO_TABLE) GO_TABLE="$2"; shift; shift ;;
#        -h|--HRD_TABLE) HRD_TABLE="3" ;;
        *) echo "Unknown parameter passed: $1"; exit 1 ;;
    esac
    shift
done

# verify params
if [ -z "$GO_TABLE" ]; then usage "AHRD output table with GO terms is not provided!"; fi;
#if [ -z "$SECTION_ID" ]; then usage "Section id is not set."; fi;



#remove .transcript endings, etc. from first column
#reduce all names to gene level

    awk -F "\t" '{sub(/\..*$/,"",$1)}; OFS="\t" ' ahrd_wheat48_go_prediction.csv |
`#also only keep gene name and GO terms` \
    awk -F "\t" '{print $1, $6}' OFS="\t" |
`#sort based on gene names; next step: merge GO term values per gene; keep all here; redundancy removed later` \
    sort -k1,1 |
`#next line: Initializes while loop, precrementing i since $0 = full line in awk; starts at $1 (first field).` \
`#Loops through the line until the end. + change of field seperator.` \
`#So, if input is not in the array !a[$i]++, then it prints $i, if it is, it prints just the field seperator.` \
    awk  -F"\t" ' BEGIN{num_old="";num_new=""}
    {
        if (num_old==""){num_old=$1;num_new=$1}
        else {num_new=$1}
        if (num_old==num_new){printf ", " $2}
        if (num_old != num_new) {printf"\n";num_old=num_new;printf $1"\t"$2 }
    } END {printf "\n"} ' |
`#Normally = null split. Here, it resets i for the next line; shorthand to delete array;` \
    awk -F "," '{ while(++i<=NF) printf (!a[$i]++) ? $i FS : ""; i=split("", a); print ""}; ' |
`#remove last comma in every line which is superfluous` \
    sed 's/,$//' |
`#delete first line, where AHRD info used to be` \
    sed '1d' > test_output
