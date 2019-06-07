#!/usr/bin/env bash
# Author: Stefan Crawford

# set default coin
COIN="VOT"
# Prompt to choose coin to send
read -e -i "VOT" -p "Coin to send: [VOT, ZCASH, HUSH, VERUS] " COIN

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

# declare array & initialize array
declare -a array
array=( )

# append t_address to array
T_ADDRESS="t1XkGxHatyhuY1mZ2c87noqv9AyzyBNuazm t1XkGxHatyhuY1mZ2c87noqv9AyzyBNuazm"
read -e -i "$T_ADDRESS" -p "t_address to send payment to, space demlimit multiple addresses: " T_ADDRESS
array+=($T_ADDRESS)

# Choose a recepient, default to first entry
RECEPIENT="${array[0]}"
read -e -i "$RECEPIENT" -p "Recepient Name: " RECEPIENT

# Choose a return address for compliance
read -e -i "$RETURN_ADDRESS" -p "Return t_address or z_address: " RETURN_ADDRESS

# Append memo to transaction memo
read -e -i "$MEMO" -p "Append memo: " MEMO

# amount to send
if [ -z "$AMOUNT" ]; then
    AMOUNT=125
    read -e -i "$AMOUNT" -p "Amount to send? " AMOUNT
else
    read -e -i "$AMOUNT" -p "Amount to send? " AMOUNT
fi

# Prompt to choose coin to send
INTERVALS=2
read -e -i "$INTERVALS" -p "# of payments? " INTERVALS

# how many times to interval payments
if [ "$INTERVALS" -gt "1" ]; then
    SLEEP_INTERVAL=10
    read -e -i "$SLEEP_INTERVAL" -p "Time between payments? " SLEEP_INTERVAL
else
    SLEEP_INTERVAL=0
fi

# loop x number of times 
for ((n=0;n<"$INTERVALS";n++))
do
    for ((j=0;j<"${#array[@]}";j++))
    do
    let "ARRAY_ITERATION = $j + 1"
        # loop through t_addresses
        for i in "${array[$j]}"
        do
            :
            # send VOT to array list
#            let "ITERATION = $n + 1"
#            printf "\nSending $AMOUNT $COIN to $i... Transaction ID: " && "$PROGRAM" #sendtoaddress "$i" "$AMOUNT" "Sending $AMOUNT $COIN to $RECEPIENT $INTERVALS times with #$SLEEP_INTERVAL seconds between payments and executed from a bash script, payment #$ITERATION of $INTERVALS - Return Payment Address: $RETURN_ADDRESS - MEMO: $MEMO" #"$RECEPIENT" false
            let "ITERATION = $n + 1"
            printf "\nSending $AMOUNT $COIN to $i... Transaction ID: " && "$PROGRAM" sendtoaddress "$i" "$AMOUNT" '"$MEMO","Amount:$AMOUNT","Coin":$COIN,"To":"$RECEPIENT","Payments":"$INTERVALS","PaymentIntervals":"$SLEEP_INTERVAL","$ITERATION","Intervals":"$INTERVALS","ReturnPaymentAddress":"$RETURN_ADDRESS" "$RECEPIENT"' false

        done

        # check for last iteration to negate sleep after last transaction
        if [ "$ITERATION" = "$INTERVALS" ] && [ "$ARRAY_ITERATION" = "${#array[@]}" ]; then
        SLEEP_INTERVAL="0"
        sleep "$SLEEP_INTERVAL"
    else
        sleep "$SLEEP_INTERVAL"
    fi
    done
done
