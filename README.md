# mypkg
![test](https://github.com/Taysoniya/mypkg/actions/workflows/test.yml/badge.svg)

本パッケージは、キーボード入力によって移動するロボットのシミュレータと、その操作コマンドを提供する ROS 2 パッケージです。
ROS 2 のトピック通信を用いて、操作ノードからシミュレータへ指令を送信します。

## 実行・操作方法
本パッケージは、シミュレータ群の起動と操作で **2つの端末** を使用します。

### 1. シミュレーション環境の立ち上げ
1つ目の端末で、以下のランチファイルを実行します。
これにより、2台のロボットシミュレータ（`robot1`, `robot2`）が起動し、待機状態になります。
```
$ ros2 launch mypkg teleop.launch.py
[INFO] [launch]: All log files can be found below /home/yuto/.ros/log/2025-12-31-22-22-40-990524-MSI-98219
[INFO] [launch]: Default logging verbosity is set to INFO
[INFO] [robot_sim-1]: process started with pid [98221]
[INFO] [robot_sim-2]: process started with pid [98223]
```
### 2. ロボットの操作
２つ目の端末で、以下のコマンドを実行します。
```
& ros2 run mypkg commander
```
この端末でキーボードの`w`, `a`, `s`, `d`を入力してエンターキーを押すと、立ち上げているすべてのロボットが同期して動作します。
* `w`:前進
* `a`:左回転
* `s`:停止
* `d`:右回転

## 実行例
ターミナル１
```
$ ros2 run mypkg commander
w:前進, s:停止, a:左, d:右 を入力してエンター
Command > d
[INFO] [1767187460.340413107] [commander_node]: 送信: "d"
```
ターミナル２
```
$ ros2 launch mypkg teleop.launch.py
[INFO] [launch]: All log files can be found below /home/yuto/.ros/log/2025-12-31-22-22-40-990524-MSI-98219
[INFO] [launch]: Default logging verbosity is set to INFO
[INFO] [robot_sim-1]: process started with pid [98221]
[INFO] [robot_sim-2]: process started with pid [98223]
[robot_sim-2] [INFO] [1767187422.901878051] [robot2]: 【ロボット動作】右に曲がります
[robot_sim-1] [INFO] [1767187422.903023909] [robot1]: 【ロボット動作】右に曲がります
```

## ノードの説明
### commander
* 役割:ユーザーからの標準入力（キーボード）を受けて、ロボットへの指令としてトピック配信します。
* パブリッシュするトピック:`/cmd_topic`

### robot_sim
* 役割:指令トピックを受信し、ロボットの現在の状態（動作ログ）を標準出力に表示します。
* サブスクライブするトピック:`/cmd_topic`
* 備考: Launchファイルを使用することで、名前を変えて複数同時に起動することが可能です。

## 実行環境
* ROS 2 Humble Hawksbill
* Ubuntu 24.04 LTS
* Python 3.10

## ライセンス
- このソフトウェアパッケージは、3条項BSDライセンスの下、再頒布および使用が許可されます。
- なお、このパッケージの一部は、下記のスライド（CC-BY-SA 4.0 by Ryuichi Ueda）のものを、参考にしたものです。
    - [ryuichiueda/slides_marp/ robosys_2025](https://github.com/ryuichiueda/slides_marp/tree/master/robosys2025)
- © 2025 Obata Yuuto
