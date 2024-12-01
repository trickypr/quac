ghdl_opts := "--workdir=out/ -fsynopsys"
entry := "adder"

source_files := `( find ./src/ -regex '^.*[^_tb].vhdl$' | tr '\n' ' ' )`

test_files := `( find ./src/ -regex '^.*_tb.vhdl$' | tr '\n' ' ' )`
test_cases := "('alu' 'reg_16' 'register_file')"

setup:
  mkdir -p out/

analyze: setup
  ghdl -a {{ghdl_opts}} {{source_files}}

elaboration: analyze
  ghdl -e {{ghdl_opts}} {{entry}}

run: elaboration
  rm -f out/wave.ghw
  ghdl -r {{ghdl_opts}} {{entry}} --wave=out/wave.ghw

wave:
  gtkwave out/wave.ghw

case entry *FLAGS: elaboration
  ghdl analyze {{ghdl_opts}} {{test_files}} 
  ghdl -e {{ghdl_opts}} {{entry}}_tb 
  ghdl run {{ghdl_opts}} {{entry}}_tb --wave=out/wave_tb_{{entry}}.ghw
  {{ if FLAGS == "-i" {"gtkwave out/wave_tb_" + entry + ".ghw"} else {""} }}

test: elaboration 
  #!/bin/sh
  test_cases={{test_cases}}
  for case in "${test_cases[@]}"; do
    echo "trying case $case"
    # We run the cases earlier, we can skip running them here
    just --no-deps case $case
  done

clean:
  rm out/*



