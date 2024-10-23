# tauri-test

Tauri 2.0 & Reactでデスクトップアプリを作るアプリの素体

## Requirements

**`Docker/`以下にDocker環境の設定がありますが、現状、デスクトップアプリ開発目的でのDocker開発環境は使えません。**
- コンテナ内で開発することもできますが、devの確認はコンテナ内に過不足なくGUIライブラリが入っており、かつホスト側とX Window Systemのプロトコルの設定を行う必要があります。色々設定すれば不可能ではないですが、現状あまりメリットはありません。

したがって、ローカル環境での開発を推奨します。

### 依存ツール

#### **Node.js v20.18.0**

PATHを通して、コマンドラインから`node`, `npm`, `npx` などが使えるようになっていればOKです。

```bash
node -v
# v20.18.0
```

#### Rustの開発環境

rustup 1.27.1, rustc 1.82.0 or above

PATHを通して、コマンドラインから`rustup`, `rustc`, `cargo`が使えるようになっていればOKです。

#### Tauri 2.0が要求する依存パッケージなど

公式の参考ページ: https://v2.tauri.app/start/prerequisites/

## 開発

macOS/Linuxのコマンドライン(bash/zsh)を前提にしています。

Windowsの場合はPowerShellやGit Bashなどを使うことになりますが、ほとんど同じ操作でできるはずです。

Tauri 2.0 & React の組み合わせですが、このリポジトリで操作するのは`npm`だけです。
`cargo`は`npm run コマンド`上で勝手に呼び出されます。
`cargo`を直接使うことはありません。

npmでインストール

```bash
# install dependencies
cd tauri-app
npm install
```

dev環境の起動

```bash
# launch dev
cd tauri-app
npm run tauri dev
```

初回の`npm run tauri dev`はビルドも走ります。

`npm run tauri dev`が起動している間は、tauriで作ったアプリのウィンドウが現れるので、ここからデスクトップアプリの実行確認ができます。
また、`localhost:3000`にアクセスすることでwebページ版も見れます。

どちらもホットリロード対応です。

エントリポイントは`main.tsx`です。
アプリを起動したときに出てくる画面の実装部分は`tauri-app/src/App.tsx`です。
`App.tsx`を書き換えるところからスタートするとわかりやすいと思います。

## ビルド

作ったアプリをコンパイルしてパッケージ化します。
いわゆるリリースビルドです。

ビルド結果は`tauri-app/src-tauri/target/release`以下に出力されます。

```bash
# build
cd tauri-app
npm run tauri build
```

出力されるものはビルドを実行した環境によって異なります。

- 直接実行可能な形式のアプリは`tauri-app/src-tauri/target/release/`直下に配置されます。

- 配布可能な形式はたいてい`tauri-app/src-tauri/target/release/bundle/`以下に格納されます。
  - Windows: インストーラ(msi)
  - macOS: dmg
  - Linux: AppImage, debパッケージなど
