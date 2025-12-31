import launch
import launch.actions
import launch.substitutions
import launch_ros.actions


def generate_launch_description():
    return launch.LaunchDescription([
        # 1台目のロボット
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
