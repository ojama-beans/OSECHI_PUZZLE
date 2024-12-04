# Godot

## インストール方法

[Godot v4.3](https://godotengine.org/)

## vscode との連携

- Godot

1. [`Editor`]タブの[`Editor Setting`]を開く
2. [`external`]と検索して、[`TextEditor`]項目内の[`External`]を選択
3. - [`Use External Editor`]を On にする
   - [`Exec Path`]を使用するテキストエディタのパスを入力する(例:`C:/Users/xxx/AppData/Local/Programs/Microsoft VS Code/Code.exe`)
   - [`Exec Flags`]に`{project} --goto {file}:{line}:{col}`と入力する

- VScode

1. 拡張機能をインストールする
   [godot-tools](https://marketplace.visualstudio.com/items?itemName=geequlim.godot-tools)
2. Godot-Tools を選択して、歯車をクリックして、[`拡張機能の設定`]を選択
3. [`Editor_Path : Godot4`] (Godot3 ではない)に Godot の exe ファイルのパスをコピペする(例:`C:\Users\xxx\Documents\godot\Godot_v4.3-stable_win64.exe`)

これで準備は終了
実際に使用するには、

- VScode

1. ツールバーの[ファイル]の[フォルダーを開く]を選択
2. 目的のプロジェクトのフォルダを選択
3. 追加できたら、.gd ファイルを選択して開いてみる
   - 画面左側のファイルアイコンから、エクスプローラーを開ける
   - そこにある.gd ファイルをクリックして開いてみる(無ければ Godot 側で作成する)
4. コードに色がついていたら成功
