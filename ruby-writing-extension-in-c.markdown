% Ruby の拡張を C 言語で書くための薄い本
% 佐藤 文優 著
% Copyright: (c) 2012 SATOH Fumiyasu @ OSS Technology Corp., Japan
% License: Attribution-NonCommercial 3.0 Unported

## この本について

### 目的

Ruby の拡張を C 言語で書くための情報をざっくりまとめています。
Ruby 1.9.3 を元に書いていますが、Ruby 1.8 系でも参考になるかもしれません。
まだ書き始めたばかりです。いまのところ永遠に未完成の予定です。
主に「Pure Ruby のあのコードを C でどうやって書けばいいのか」といった観点から書くつもりです。

最新のソース:
<https://github.com/fumiyas/ruby-writing-extension-in-c>

### ライセンス

この本は Attribution-NonCommercial 3.0 Unported に基づいてライセンスされています。
*あなたはこの本を読む為にお金を支払う必要はありません。*

この本を複製、改変、展示することは基本的に自由です。
しかし、この本は常に私 (佐藤 文優) に帰属するように求めます。
そして私はこれを商用目的で使用する事はありません。
以下にライセンスの全文があります:

<http://creativecommons.org/licenses/by-nc/3.0/legalcode>

### 謝辞

「MongoDB の薄い本」を参考にさせてもらっています。ありがとう!

翻訳版の最新のソース:
<http://github.com/hamano/the-little-mongodb-book>

原書の最新のソース:
<http://github.com/karlseguin/the-little-mongodb-book>

## ソースツリー環境の構築

Ruby Bundler を利用して雛形を作る手順。

### Bundler のインストール

gem コマンドでインストールする場合:

	# gem install bundler

Debian で標準パッケージをインストールする場合:

	# apt-get install bundler

Ubuntu で標準パッケージ (universe) をインストールする場合:

	# apt-get install ruby-bundler

### Bundler によるソースツリー雛形の作成

	$ bundle gem example
	      create  example/Gemfile
	      create  example/Rakefile
	      create  example/LICENSE
	      create  example/README.md
	      create  example/.gitignore
	      create  example/example.gemspec
	      create  example/lib/example.rb
	      create  example/lib/example/version.rb
	Initializating git repo in /home/fumiyas/git/example


## 基本

Ruby のデータやコードはすべてオブジェクトが保持している。
Ruby のオブジェクトは、C では VALUE という型を介して参照する。
Ruby の C API と C の VALUE 型を利用して、C から Ruby オブジェクトを生成したり、
呼びだしたり、C の値と相互変換したり、値を保持させることが可能。

## モジュールとクラスの生成

## C 変数と Ruby オブジェクトの変換

### C 整数から Ruby 整数オブジェクトの生成

`*2NUM()` マクロを利用する。

C の `int`, `long` から Ruby の `Integer` オブジェクトを生成する。

	/* 整数から整数オブジェクト Integer を生成 */
	VALUE int_obj1 = INT2NUM(int 型);
	VALUE int_obj2 = LONG2NUM(long 型);

C の `off_t` 等の整数に対応する整数オブジェクト生成マクロも用意されている。

	/* そのほかの整数型から整数オブジェクト Integer を生成 */
	VALUE off_t_value = OFFT2NUM(off_t 型);
	VALUE size_t_value = SIZET2NUM(size_t 型);
	VALUE ssize_t_value = SSIZET2NUM(ssize_t 型);
	VALUE pid_t = PIDT2NUM(pid_t 型);
	VALUE uid_t_value = UIDT2NUM(uid_t 型);
	VALUE gid_t = GIDT2NUM(gid_t 型);
	VALUE mode_t = MODET2NUM(mode_t 型);

Linux の AMD64/Intel64 環境など、C で `sizeof(int) < sizeof(long)` と
なる環境で、かつ整数値が `int` の範囲であれば、`*2FIX()` を利用したほうが
効率がよい。__注意: 桁溢れしても例外は上がらず、壊れた値になる__。

	/* 整数から整数オブジェクト Fixnum を生成 */
	VALUE fixnum_obj1 = INT2FIX(123);
	VALUE fixnum_obj2 = LONG2FIX(45678910L);

### C 文字列から Ruby `String` オブジェクトの生成

	char *str = "foo";
	/* 文字列と長さから String オブジェクトを生成 */
	VALUE str_obj1 = rb_str_new(str, strlen(str));
	/* 長さ不明の NULL 終端文字列から String オブジェクトを生成 */
	VALUE str_obj2 = rb_str_new2(str);

FIXME: 文字エンコーディング関連の説明

### 既存の Ruby のオブジェクトを得る

	/* nil, true, false の VALUE を得る */
	VALUE nil_obj = Qnil;
	VALUE true_obj = Qtrue;
	VALUE false_obj = Qfalse;

	/* Ruby の Symbol :name の VALUE を得る */
	VALUE sym_name = ID2SYM(rb_intern("name"));

	/* クラス名からクラスの VALUE を得る */
	VALUE enc_class = rb_path2class("Encoding");
	/* クラス名を持つ String オブジェクトからクラスの VALUE を得る */
	VALUE enc_classname_obj = rb_new_str2("Encoding");
	VALUE enc_class = rb_path_to_class(enc_classname_obj);

## クラスのオブジェクトの生成とメソッド呼び出し

