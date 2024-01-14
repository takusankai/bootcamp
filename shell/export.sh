# 「環境変数」は現在実行しているシェル上だけでなく、そのシェルから他のシェルに移動したり、シェルスクリプトを使っても利用することができる変数
export HOGE=hogehoge
echo $HOGE

# 以下で環境変数PATHを出力できる
export | grep PATH