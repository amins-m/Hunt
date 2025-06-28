#!/bin/bash

get_asn_details() {
    input=""
    while read line
    do
        curl -s https://api.bgpview.io/asn/$line | jq -r ".data | {asn: .asn, name: .name, des: .description_short, email: .email_contacts}"
    done < "${1:-/dev/stdin}"
}
get_asn_details