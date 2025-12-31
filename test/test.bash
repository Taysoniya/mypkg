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

cd $dir/ros2_ws
colcon build --packages-select mypkg
source $dir/ros2_ws/install/setup.bash

export PYTHONUNBUFFERED=1

colcon test --packages-select mypkg || true

rm -f /tmp/mypkg.log

ros2 run mypkg robot_sim > /tmp/mypkg.log 2>&1 &
SIM_PID=$!
sleep 5

timeout 5 ros2 topic pub --once /countup std_msgs/msg/Int16 "data: 1"
sleep 2

kill $SIM_PID

cat /tmp/mypkg.log

if grep -q "rob: forward" /tmp/mypkg.log; then
    echo "Test Passed"
    exit 0
elif grep -q "ロボット: 前進中" /tmp/mypkg.log; then
    echo "Test Passed"
    exit 0
else
    echo "Test Failed"
    exit 1
fi
