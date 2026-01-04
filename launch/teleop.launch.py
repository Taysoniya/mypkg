# SPDX-FileCopyrightText: 2025 Obata Yuuto
# SPDX-License-Identifier: BSD-3-Clause

import launch
import launch.actions
import launch.substitutions
import launch_ros.actions


def generate_launch_description():
    return launch.LaunchDescription([
        launch_ros.actions.Node(
            package='mypkg',
            executable='robot_sim',
            name='robot1',
            output='screen',
        ),
        launch_ros.actions.Node(
            package='mypkg',
            executable='robot_sim',
            name='robot2',
            output='screen',
        ),
    ])
