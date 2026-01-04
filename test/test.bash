#!/bin/bash
# SPDX-FileCopyrightText: 2025 Obata Yuuto
# SPDX-License-Identifier: BSD-3-Clause

source /opt/ros/humble/setup.bash

dir=~
[ "$1" != "" ] && dir="$1"

cd $dir/ros2_ws

colcon build --packages-select mypkg
source install/setup.bash

colcon test --packages-select mypkg
if [ $? -ne 0 ]; then
    echo "colcon test failed"
    exit 1
fi

rm -f /tmp/mypkg.log

ros2 run mypkg robot_sim > /tmp/mypkg.log 2>&1 &
NODE_PID=$!

sleep 2

ros2 topic pub --once /cmd_topic std_msgs/msg/String "data: 'w'"

sleep 2

kill $NODE_PID

cat /tmp/mypkg.log

if grep -q "前進" /tmp/mypkg.log; then
    echo "Test passed: Correct log found"
    exit 0
else
    echo "Test failed: Log not found"
    exit 1
fi
