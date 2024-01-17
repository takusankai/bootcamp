# reference.txtは「探すファイル名に含まれる文字列,移動先フォルダ名」という記述形式が保証されているとする
reference_path="./reference.txt"

if [[ $1 == "write" ]]
then

  #writeが引数の場合、reference.txtへの書き込みを行う

  read -p "移動したいファイルに含まれる文字列: " first_value
  read -p "そのファイルの移動先フォルダ名: " second_value

  # 「1つ目,2つ目」の形でreference.txtに出力
  echo "$first_value,$second_value" >> $reference_path

  echo "reference.txtに書き込みました"

else

  #通常時、reference.txtの内容を元にファイルを移動する

  # reference.txtの内容を行区切りで配列に保存
  mapfile -t input_lines < $reference_path

  for line in ${input_lines[@]}
  do

    # ','で「探す文字列」と「移動先名」に分割
    IFS=',' read -a parts <<< "$line"
    search_phrase=${parts[0]}
    move_directory=${parts[1]}

    # カレントディレクトリからsearch_phraseをファイル名に含むファイルを探し、配列に保存
    mapfile -t move_file < <(find . -type f -name "*$search_phrase*")
    
    # 見つけたファイルをmove_directoryに移動し、移動結果を表示
    for file in "${move_file[@]}"
    do

      mv "$file" "./$move_directory/"
      echo "$file >> $move_directory"
      
    done

  done

fi
