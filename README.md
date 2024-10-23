# tauri-react-sample

Tauri 2.0 & Reactでデスクトップアプリを作るアプリの素体

## Requirements

ローカル環境での開発を推奨します。

### 依存ツール

---

#### **Node.js v20.18.0**

PATHを通して、コマンドラインから`node`, `npm`, `npx` などが使えるようになっていればOKです。

```bash
node -v
# v20.18.0
```

---

#### Rustの開発環境

rustup 1.27.1, rustc 1.82.0 or above

PATHを通して、コマンドラインから`rustup`, `rustc`, `cargo`が使えるようになっていればOKです。

---

#### Tauri 2.0が要求する依存パッケージなど

公式の参考ページ: https://v2.tauri.app/start/prerequisites/

- OSによって異なるので注意してください。
- 特にLinuxの場合、使用しているディストリビューションやバージョンによってさらに必要になるパッケージがあるかもしれません。
  - 依存パッケージが不足していると、開発サーバーを立てる時やビルドのタイミングで`lib〇〇`系のエラーに遭遇することが多いです。


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

ここまででRust側のビルドをやっていなければ（＝上のコマンドを順にやっただけなら）、
初回の`npm run tauri dev`はRust側のDebugビルドも走ります。

`npm run tauri dev`が起動している間は、tauriで作ったアプリのウィンドウが現れるので、ここからデスクトップアプリの実行確認ができます。
ウィンドウを閉じると`npm run tauri dev`のプロセスは終了します。

---

- フロントエンドのエントリポイントは`main.tsx`です。
  - アプリを起動したときに出てくる画面の実装部分は`tauri-app/src/App.tsx`です。
  - `App.tsx`を書き換えるところからスタートするとわかりやすいと思います。

---

- バックエンド側は`tauri-app/src-tauri/src/main.rs`です。
  - `Greet`ボタンの挙動などは`lib.rs`に書いてあります。

- Rust側で`cargo`で何かをしたい場合は、`cd tauri-app/src-tauri/`に行けば`cargo <コマンド>`が使えます。

---

- ホットリロード対応です。
  - フロントエンドの変更はすぐに反映されます。
  - バックエンド(Rust)の変更もホットリロードに対応していますが、コンパイル中はウィンドウが勝手に閉じます。

---

### Reactの開発サーバーについて

`npm run tauri dev`の実行中は、ブラウザで`localhost:3000`にアクセスすることでReactの開発用ローカルサーバーを使えます。
フロントエンドの開発に便利です。

フロントエンドのコードにエラーがある場合、ウィンドウ側は真っ白になってしまいますが、
Reactサーバーはエラーコードを表示してくれます。

一方で、Reactサーバーの方はバックエンド(Rust)とのやりとりは正しく動作しないことに注意してください。
たとえば`Greet`ボタンは押しても正しいレスポンスが得られず、見かけ無反応になります。
正しい挙動の確認はウィンドウ側で行ってください。

ちなみに、ウィンドウは不要でReactの開発用ローカルサーバーだけを使いたい場合は、`npm run dev`で可能です。

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
