template="$1"
output_base="$(bazel info output_base)"

bazel fetch @foo//...

sed "s,OUTPUT_BASE,$output_base,g" $1 > compile_commands.json
