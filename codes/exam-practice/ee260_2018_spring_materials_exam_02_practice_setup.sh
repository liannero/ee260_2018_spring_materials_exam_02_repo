#!/usr/bin/env bash

BASE="$(cd "$(dirname "$0")" && pwd)"

for d in $BASE/*; do
  ls -1 $d/*.v > /dev/null 2>&1
  if [ "$?" = "0" ]; then
    echo "compiling source in $(basename $d)"
    iverilog -o "$d/$(basename $d).vvp" $d/*.v
  fi
  if [ -e "$d/$(basename $d).vvp" ]; then
    echo "running test in $(basename $d)"
    cd $d; vvp "$d/$(basename $d).vvp" +DUMPFILE="$(basename $d).vcd"; cd $BASE
  fi
  if [ -e "$d/$(basename $d).vcd" ]; then
    echo "display waveform in $(basename $d)"
    open -a Scansion "$d/$(basename $d).vcd"
  fi
done
