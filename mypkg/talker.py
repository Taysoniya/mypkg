#!/usr/bin/python3
# SPDX-FileCopyrightText: 2025 Obata Yuuto
# SPDX-License-Identifier: BSD-3-Clause

import rclpy
from rclpy.node import Node
from std_msgs.msg import String

class MinimalPublisher(Node):

    def __init__(self):
        super().__init__('commander_node')
        self.publisher_ = self.create_publisher(String, 'cmd_topic', 10)
        
        timer_period = 0.5
        self.timer = self.create_timer(timer_period, self.timer_callback)
        self.i = 0
        print("w:前進, s:停止, a:左, d:右 を入力してエンター")

    def timer_callback(self):
        msg = String()
        try:
            command = input("Command > ") 
            msg.data = command
            self.publisher_.publish(msg)
            self.get_logger().info(f'送信: "{msg.data}"')
        except EOFError:
            pass

def main(args=None):
    rclpy.init(args=args)
    minimal_publisher = MinimalPublisher()
    rclpy.spin(minimal_publisher)
    minimal_publisher.destroy_node()
    rclpy.shutdown()

if __name__ == '__main__':
    main()
