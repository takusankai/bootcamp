# references.txtは「探すファイル名に含まれる文字列,移動先フォルダ名」という記述形式が保証されているとする
REFERENCE_PATH="./references.txt"

if [[ $1 == "write" ]]
then

  # writeが引数の場合、references.txtへの書き込みを行う

  read -p "移動したいファイルに含まれる文字列: " search_pattern
  read -p "そのファイルの移動先フォルダ名: " destination_directory

  # 「1つ目,2つ目」の形でreferences.txtに出力
  echo "$search_pattern,$destination_directory" >> $REFERENCE_PATH

  echo "references.txtに書き込みました"

elif [[ $1 == "move" ]]
then

  # 通常時、references.txtの内容を元にファイルを移動する

  # references.txtの内容を行区切りで配列に保存
  mapfile -t input_lines < $REFERENCE_PATH

  for line in ${input_lines[@]}
  do

    # ','で「探す文字列」と「移動先名」に分割
    search_pattern=$(echo "$line" | cut -d',' -f1)
    destination_directory=$(echo "$line" | cut -d',' -f2)

    # カレントディレクトリからsearch_patternをファイル名に含むファイルを探し、配列に保存
    mapfile -t file_to_move < <(find . -type f -name "*$search_pattern*")
    
    # 見つけたファイルをdestination_directoryに移動し、移動結果を表示
    for file in "${file_to_move[@]}"
    do

      mv "$file" "./$destination_directory/"
      echo "$file >> $destination_directory"
      
    done

  done

else

  # 引数が指定されていない場合、動作説明を表示
  echo "第一引数に「write」か「move」を指定してください"
  echo "まず、references.txtには「移動したいファイルに含まれる文字列」と「そのファイルの移動先フォルダ名」がセットで登録します"
  echo "そして、これを参照してカレントディレクトリ内のファイルを移動し整理します"
  echo
  echo "第一引数に「write」を指定 : 入力プロンプトに従って、references.txtに書き込みを行います"
  echo "第一引数に「move」を指定 : references.txtの「検索する文字列」と「移動先フォルダ名」を参照し、これに従ってファイルを移動します"

fi
