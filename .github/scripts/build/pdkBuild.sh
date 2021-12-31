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


# By default skip timing since we don't need the libs in any of the CI tests
export SKIP_TIMING=${1:-1}
export IMAGE_NAME=efabless/openlane:$OPENLANE_TAG
docker pull $IMAGE_NAME

cd $RUN_ROOT/..
echo $PWD
export PDK_ROOT=$(pwd)/pdks
mkdir -p $PDK_ROOT

cd $RUN_ROOT
echo $PWD
export CARAVEL_ROOT=$(pwd)/caravel
make skywater-pdk
make skywater-library
make open_pdks

docker run -v $RUN_ROOT:/openLANE_flow -v $PDK_ROOT:$PDK_ROOT -e PDK_ROOT=$PDK_ROOT -e OPENLANE_IMAGE_NAME=$IMAGE_NAME -u $(id -u $USER):$(id -g $USER) $IMAGE_NAME  bash -c "make build-pdk"

rm -rf $PDK_ROOT/open_pdks
rm -rf $PDK_ROOT/skywater-pdk

echo "done installing"
cd $RUN_ROOT
exit 0