#!/bin/bash
# SPDX-FileCopyrightText: 2020 Efabless Corporation
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# SPDX-License-Identifier: Apache-2.0

export RUN_ROOT=$(pwd)
export CARAVEL_ROOT=$(pwd)/caravel
CMD=$1
BUILD=$2

cd $RUN_ROOT/..
echo $PWD
export OPENLANE_ROOT=$(pwd)/openlane
export PDK_ROOT=$(pwd)/pdks

cd $RUN_ROOT
echo $PWD

if [[ $BUILD -ne 0 ]]; then 
  cd openlane ;
  echo $PWD ;
fi

make $CMD
RES=$?
echo "$CMD: $RES"
if [[ $RES -ne 0 ]]; then 
    exit $RES ; 
fi

cd $RUN_ROOT
echo $PWD

exit 0
