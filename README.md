# nvidia-sdkmanager-gui

nvidia-sdkmanager-guiは、NVIDIA SDK Manager の GUI 版を Docker 上で動作させ、Jetson の OSインストール を行うためのスクリプトです。  
Jetson などのデバイスの OSインストール に必要な NVIDIA SDK Manager は、Ubuntu LTS などの限られたOSしかサポートしていません。  
また他のLinux環境上でも動作する公式Dockerイメージも配布されていますが、CLIでしか動作しません。  
本スクリプトは、公式Dockerイメージを拡張し、より多くのLinux環境上でSDK Manager GUIを起動させるためのものです。  

## 動作環境

* x64 Linux 環境
	* DBus, NetworkManager, udev が動作している必要があります。（近年の Linux ディストリビューションであれば大抵の場合動作しています。）
* X サーバ (Wayland 環境の場合、XWayland など)
* Docker
* Docker Compose v2
* GNU Make

### 事前確認

事前に以下の動作確認が必要です。  

* SDK Manager GUI 起動
* Jetson USB 接続の認識・再認識
* Jetson AGX Xavier への各種インストール
* Jetson AGX Xavier の NVMe SSD へのインストール (JetPack 4.6 以降)

## NVIDIA SDK Managerについて

NVIDIA SDK Managerは、NVIDIA Jetsonプラットフォーム、NVIDIA DRIVEプラットフォームの開発環境をセットアップするツールです。  
NVIDIA SDK Managerは、NVIDIA のドライブ、Jetson、Clara Holoscan、Rivermax、DOCA、そしてEthernet Switch SDKでホストとUSB接続した開発ボードに対して利用可能です。

## 事前準備


### 公式 Docker イメージのダウンロード

* [NVIDIA DEVELOPER サイト](https://developer.nvidia.com/nvidia-sdk-manager) から、公式 Docker イメージの .tar.gz ファイルをダウンロードしてください。(NVIDIA アカウントが必要です)

* ダウンロードが終わりましたら、このディレクトリに配置してください。


### Docker イメージの作成

次のコマンドを利用します。バージョンは、ダウンロードした Docker イメージのファイル名に含まれています。

```sh
make docker-build version=x.x.x.xxxx
```


### ホスト側に必要なディレクトリを作成

次のコマンドを実行します。

```sh
make setup
```


## 実行

次のコマンドを実行します。

```sh
make launch
```

SDK Manager を終了すると、自動で Docker コンテナが破棄されます。


## 制約
* ログインの際ブラウザが開きませんので、QR コード画面の下部にあるログイン用リンクをコピーし、ブラウザに貼り付けてログイン画面を表示させてください。
* ホスト側 SDK 等の Host Components はサポートしていません。
