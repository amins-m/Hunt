wlist_maker() {
    seq 1 100 > list.tmp
    echo $1 >> list.tmp
    seq 101 300 >> list.tmp
    echo $1 >> list.tmp
    seq 301 600 >> list.tmp
}
