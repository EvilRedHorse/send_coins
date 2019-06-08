# file to run: send-coins.sh
# Script to send equihash coins:
# Intended for a simple transaction or to spread out payments over multiple addresses and have them gradually sent over 

                                                              VARIABLE
choice for type of coin, script to pick appropriate program - COIN & PROGRAM,
choice for one or more addresses -                            T_ADDRESS         space delimited,
choice for payment amount per interval -                      AMOUNT,
choice for number of intervals -                              INTERVALS,
choice for time in seconds between intervals -                SLEEP_INTERVAL,   interval in seconds
choice for return adddress -                                  RETURN_ADDRESS    for compliance purposes,
choice for memorandum -                                       MEMO,
choice for recepient address -                                RECEPIENT

Long-term:  I would like to add a bit of internationalization with a choice of language 
            Load defaults from json or similar compact notation, allow user to set defaults with a cli-based script and perhaps a simple GUI
            add z_address send
            add choice for interval time randomization
            use the memo section to extend json expansion out of the container - experimental 
