ghdl_opts := "--workdir=out/"
entry := "adder"

testbenches := ("adder")

setup:
  mkdir -p out/

analyze: setup
  #!/usr/bin/env bash
  shopt -s extglob
  ghdl analyze {{ghdl_opts}} src/*!(_tb).vhdl 
  shopt -u extglob

elaboration: analyze
  ghdl -e {{entry}} {{ghdl_opts}}

run: elaboration
  rm out/wave.ghw
  ghdl run {{entry}} {{ghdl_opts}} --wave=out/wave.ghw

case entry: elaboration
  ghdl analyze {{ghdl_opts}} src/{{entry}}_tb.vhdl 
  ghdl -e {{entry}}_tb {{ghdl_opts}}
  ghdl run {{entry}}_tb {{ghdl_opts}} --wave=out/wave_tb_{{entry}}.ghw

# test: 
#   for i in "${testbenches[@]}"; do
#     just case '$i'
#   done


clean:
  rm out/*

wave:
  gtkwave out/wave.ghw


