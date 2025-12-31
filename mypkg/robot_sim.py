# SPDX-FileCopyrightText: 2025 Obata Yuuto
# SPDX-License-Identifier: BSD-3-Clause

import rclpy
from rclpy.node import Node
from std_msgs.msg import String

class MinimalSubscriber(Node):

    def __init__(self):
        super().__init__('robot_sim_node')
        self.subscription = self.create_subscription(
            String,
            'cmd_topic',
            self.listener_callback,
            10)
        self.subscription

    def listener_callback(self, msg):
        command = msg.data
        
        if command == 'w':
            self.get_logger().info('【ロボット動作】前進します')
        elif command == 's':
            self.get_logger().info('【ロボット動作】停止しました')
        elif command == 'a':
            self.get_logger().info('【ロボット動作】左に曲がります')
        elif command == 'd':
            self.get_logger().info('【ロボット動作】右に曲がります')
        else:
            self.get_logger().info(f'謎の指令を受信: "{command}"')

def main(args=None):
    rclpy.init(args=args)
    minimal_subscriber = MinimalSubscriber()
    rclpy.spin(minimal_subscriber)
    minimal_subscriber.destroy_node()
    rclpy.shutdown()

if __name__ == '__main__':
    main()
