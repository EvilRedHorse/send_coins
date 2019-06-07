#!/usr/bin/env bash
# Author: Stefan Crawford

# set default coin
COIN="VOT"
# Prompt to choose coin to send
read -e -i "VOT" -p "Coin to send? [VOT, ZCASH, HUSH, VERUS] " COIN

# choose appropriate program to send coin
if [ "$COIN" == "VOT" ]; then
    PROGRAM="votecoin-cli"
    printf "using $PROGRAM to send..."
#if [ "$COIN" == "ZCASH" ]; then
#    PROGRAM="zcash-cli"
#    printf "using $PROGRAM to send..."
#if [ "$COIN" == "HUSH" ]; then
#    PROGRAM="hush-cli"
#    printf "using $PROGRAM to send..."
#if [ "$COIN" == "VERUS" ]; then
#    PROGRAM="verus"
#    printf "using $PROGRAM to send..."
else
    printf "no valid program to use..."
fi

# amount to send

if [ -z "$AMOUNT" ]; then
    AMOUNT=125
    read -e -i "$AMOUNT" -p "Amount to send? " AMOUNT
else
    read -e -i "$AMOUNT" -p "Amount to send? " AMOUNT
fi

INTERVALS=2
# Prompt to choose coin to send
read -e -i "$INTERVALS" -p "# of payments? " INTERVALS

# how many times to interval payments
if [ "$INTERVALS" -gt "1" ]; then
    SLEEP_INTERVAL=10
    read -e -i "$SLEEP_INTERVAL" -p "Time between payments? " SLEEP_INTERVAL
else
    SLEEP_INTERVAL=0
fi

# declare array
declare -a array

# initialize array
array=( )

# append t_address to array
T_ADDRESS="t1XkGxHatyhuY1mZ2c87noqv9AyzyBNuazm"
read -e -i "$T_ADDRESS" -p "t_address to send payment to? " T_ADDRESS
array+=("$T_ADDRESS")

# loop x number of times 
for ((n=0;n<"$INTERVALS";n++))
do
    # loop through t_addresses
    for i in "${array[@]}"
    do
        :
        # send VOT to array list
        let "ITERATION = $n + 1"
        printf "\nSending $AMOUNT $COIN to $i... Transaction ID: " && "$PROGRAM" sendtoaddress "$i" "$AMOUNT" "Sending $AMOUNT $COIN to myself $INTERVALS times with $SLEEP_INTERVAL seconds between payments and executed from a bash script, payment $ITERATION of $INTERVALS" "myself" false
        # check for last iteration to negate sleep after last transaction
        if [ "$ITERATION" = "$INTERVALS" ]; then
        SLEEP_INTERVAL="0"
        sleep "$SLEEP_INTERVAL"
    else
        sleep "$SLEEP_INTERVAL"
    fi
    done
done
