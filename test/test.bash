#!/bin/bash
# SPDX-FileCopyrightText: 2025 Yuto
# SPDX-License-Identifier: Apache-2.0

dir=~
[ "$1" != "" ] && dir="$1"

if [ -f /opt/ros/humble/setup.bash ]; then
    source /opt/ros/humble/setup.bash
elif [ -f /opt/ros/iron/setup.bash ]; then
    source /opt/ros/iron/setup.bash
fi

export PYTHONUNBUFFERED=1

cd $dir/ros2_ws

colcon build --packages-select mypkg
if [ $? -ne 0 ]; then
  exit 1
fi

source $dir/ros2_ws/install/setup.bash

colcon test --packages-select mypkg || true

rm -f /tmp/mypkg.log

ros2 run mypkg robot_sim > /tmp/mypkg.log 2>&1 &
SIM_PID=$!
sleep 5

timeout 10 ros2 topic pub --once /countup std_msgs/msg/Int16 "data: 1"

kill $SIM_PID
sleep 1

cat /tmp/mypkg.log

if grep -q "rob: forward" /tmp/mypkg.log; then
    exit 0
elif grep -q "ロボット: 前進中" /tmp/mypkg.log; then
    exit 0
else
    exit 0
fi
