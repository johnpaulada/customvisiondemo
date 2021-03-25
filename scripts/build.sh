#!/bin/bash

cat << EOF

################################
#                              #
#  Cleaning Environment...     #
#                              #
################################

EOF

bsb -clean-world

cat << EOF

################################
#                              #
#  Compiling ReScript Code...  #
#                              #
################################

EOF

bsb -make-world

cat << EOF

################################
#                              #
#  Packaging with Snowpack...  #
#                              #
################################

EOF

snowpack build

cat << EOF

################################
#                              #
#  App Build Complete!         #
#                              #
################################

EOF