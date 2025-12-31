# mypkg
![test](https://github.com/Taysoniya/mypkg/actions/workflows/test.yml/badge.svg)

ロボットを擬似的に操作するためのROS 2パッケージです。
キーボード入力を行うCommanderノードと、動作を表示するRobotSimノードで構成されています。

## 実行環境
- ROS 2 Humble Hawksbill
- Ubuntu 22.04 LTS

## インストール方法
```bash
$cd ~/ros2_ws/src$ git clone [https://github.com/Taysoniya/mypkg.git](https://github.com/Taysoniya/mypkg.git)
$cd ~/ros2_ws$ colcon build --packages-select mypkg
$ source install/setup.bash
