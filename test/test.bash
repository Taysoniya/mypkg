#!/bin/bash
# SPDX-FileCopyrightText: 2025 Obata Yuuto
# SPDX-License-Identifier: BSD-3-Clause

dir=~
[ "$1" != "" ] && dir="$1"

cd $dir/ros2_ws
colcon build
source $dir/ros2_ws/install/setup.bash

echo "Test 1: Code check (colcon test)"
colcon test --packages-select mypkg
colcon test-result --verbose
if [ $? -ne 0 ]; then
  echo "ERROR: Code check failed"
  exit 1
fi

echo "Test 2: Operation check (Robot Simulator)"
rm -f /tmp/mypkg.log
ros2 run mypkg robot_sim > /tmp/mypkg.log 2>&1 &
SIM_PID=$!
sleep 3

echo "Sending command: Forward(1)"
ros2 topic pub --once /countup std_msgs/msg/Int16 "data: 1"
sleep 2

kill $SIM_PID

if grep -q "rob: forward" /tmp/mypkg.log; then
    echo "Test Passed: Log matched"
    exit 0
else
    if grep -q "ロボット: 前進中" /tmp/mypkg.log; then
        echo "Test Passed: Log matched"
        exit 0
    else
        echo "Test Failed: Log not matched"
        cat /tmp/mypkg.log
        exit 1
    fi
fi
