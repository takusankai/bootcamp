# ディレクトリを作る
mkdir child-directory-a
mkdir child-directory-b

# 1.カレントディレクトリで child-directory-a に test.txt を生成
touch child-directory-a/test.txt

# 2.child-directory-a へ移動
cd child-directory-a

# 3.child-directory-a から child-directory-b へ test.txt を移動
mv test.txt ../child-directory-b/

# 4.child-directory-b へ移動
cd ../child-directory-b

# 5.カレントディレクトリの test.txt を親ディレクトリへ移動
mv test.txt ../