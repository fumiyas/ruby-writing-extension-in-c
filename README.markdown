# Ruby の拡張を C 言語で書くための薄い本

Ruby の拡張を C 言語で書くための情報をざっくりまとめています。
Ruby 1.9.3 を元に書いていますが、Ruby 1.8 系でも参考になるかもしれません。
まだ書き始めたばかりです。いまのところ永遠に未完成の予定です。
主に「Pure Ruby のあのコードを C でどうやって書けばいいのか」といった観点から書くつもりです。

## ライセンス

この本は無料であり、
[Attribution-NonCommercial 3.0 Unported ライセンス](<http://creativecommons.org/licenses/by-nc/3.0/legalcode>)
に基づいて配布されています。

## フォーマット

この本は
[Markdown](http://daringfireball.net/projects/markdown/)
記法で書かれています。

UNIX 環境で `make` コマンドと
[Pandoc](http://johnmacfarlane.net/pandoc/)
の `pandoc` コマンドが利用可能であれば、
HTML ファイルを生成することもできます。
PDF などそのほかのフォーマットは準備中です。

	$ make
	Building ruby-writing-extension-in-c.html ...

