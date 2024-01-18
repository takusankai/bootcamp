# reference.txtは「探すファイル名に含まれる文字列,移動先フォルダ名」という記述形式が保証されているとする
REFERENCE_PATH="./reference.txt"

if [[ $1 == "write" ]]
then

  # writeが引数の場合、references.txtへの書き込みを行う

  read -p "移動したいファイルに含まれる文字列: " search_pattern
  read -p "そのファイルの移動先フォルダ名: " move_directory

  # 「1つ目,2つ目」の形でreference.txtに出力
  echo "$search_pattern,$move_directory" >> $REFERENCE_PATH

  echo "references.txtに書き込みました"

elif [[ $1 == "move" ]]
then

  # 通常時、reference.txtの内容を元にファイルを移動する

  # references.txtの内容を行区切りで配列に保存
  mapfile -t input_lines < $REFERENCE_PATH

  for line in ${input_lines[@]}
  do

    # ','で「探す文字列」と「移動先名」に分割
    IFS=',' read -a parts <<< "$line"
    search_pattern=${parts[0]}
    move_directory=${parts[1]}

    # カレントディレクトリからsearch_patternをファイル名に含むファイルを探し、配列に保存
    mapfile -t move_file < <(find . -type f -name "*$search_pattern*")
    
    # 見つけたファイルをmove_directoryに移動し、移動結果を表示
    for file in "${move_file[@]}"
    do

      mv "$file" "./$move_directory/"
      echo "$file >> $move_directory"
      
    done

  done

else

  # 引数が指定されていない場合、動作説明を表示
  echo
  echo "--------------------------------------------------------------------------------------"
  echo -e "\033[31m第一引数に「write」か「move」を指定してください\033[m"
  echo "--------------------------------------------------------------------------------------"
  echo -e "\033[31m第一引数が正しく指定されていないので、動作説明を表示します\033[m"
  echo "これは多数の講義ファイルを各講義フォルダに振り分け、整理することを想定して作られたスクリプトです。"
  echo "予め「"CV"と名の付くファイルは"コンピュータビジョン"フォルダに入れる」などと登録し、一括で整理することができます"
  echo "--------------------------------------------------------------------------------------"
  echo "このスクリプトは、カレントディレクトリ内に登録の為のreferences.txtを必要とします"
  echo "references.txtには「移動したいファイルに含まれる文字列」と「そのファイルの移動先フォルダ名」がセットで登録されます"
  echo "これを参照してカレントディレクトリ内のファイルを移動し、整理します"
  echo "--------------------------------------------------------------------------------------"
  echo -e "\033[31m第一引数に「write」を指定 : \033[m"
  echo "references.txtに書き込みを行います"
  echo "入力プロンプトに従って、移動したいファイルに含まれる文字列と、そのファイルの移動先フォルダ名を入力してください"
  echo "書き込みが完了したら、「references.txtに書き込みました」と表示します"
  echo "--------------------------------------------------------------------------------------"
  echo -e "\033[31m第一引数に「move」を指定 : \033[m"
  echo "references.txtの内容を元にファイルを移動を行います"
  echo "references.txtの「検索する文字列」と「移動先フォルダ名」を参照し、これに従ってファイルを移動します"
  echo "移動が完了したら、移動したファイル名と移動先フォルダ名の一覧を表示します"
  echo "--------------------------------------------------------------------------------------"
  echo

fi
