#!/bin/bash
#@ job_name = test_ompi
#@ initialdir = .
#@ output = mongo_%j.out
#@ error = mongo_%j.err
#@ total_tasks = 16
#@ nodes = 1
#@ wall_clock_limit = 24:00:00

## remember to load mongodb before launch job
# module load MONGODB
# module load MACHANGUITOS/0.7.0
# module load MACHANGUITOS/0.7.1 without mongo
set -u

######################################################################
wait_mongo (){
    TRIES=180
    CHECK=$(mongo -eval "1+1" 2>&1)
    COND=$?
    if [ $COND -eq 1 ]; then
        echo -n "waiting mongo"
        while [ $COND -eq 1 ] && [ $TRIES -gt 0 ]; do
            echo -n "."
            sleep 0.5
            CHECK=$(mongo -eval "1+1")
            COND=$?
            TRIES=$((TRIES - 1))
        done
        if [ $TRIES -eq 0 ]; then
            echo " fail"
        else
            echo " done"
        fi
    fi
}


# prepare data path for mongodb database
MONGODATA=/gpfs/res_projects/ucXX/mongodb/${SLURM_JOB_ID}
if [ -d ${MONGODATA} ]; then 
    rm -rf ${MONGODATA}
fi

mkdir -p ${MONGODATA}/data

# start mongodb database
mongod --dbpath ${MONGODATA}/data --logpath ${MONGODATA}/mongod.log --pidfilepath ${MONGODATA}/mongod.pid --fork
MONGOPID=$(cat ${MONGODATA}/mongod.pid)
wait_mongo

# run programs that user mongodb database
mongo -eval "1+2"
mongo -eval "3+2"

sleep 30

date
#srun machen cdp/cdpsimulation.lua
mkdir -p cdp/out_${SLURM_JOB_ID}/export
pushd cdp/out_${SLURM_JOB_ID}
srun machen ../cdpsimulation.lua
popd


date

sleep 30

# end mongodb database
echo ending mongo $MONGOPID
kill $MONGOPID
sleep 10
