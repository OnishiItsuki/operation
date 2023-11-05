#!/bin/bash

set -e
echo "> デプロイを開始します..."

ENV=$1
DEPLOY_DESCRIPTION=$2
ORIGIN_SCRIPT_ID='"scriptId":""'
CLASP_JSON_PATH=".clasp.json"

# 引数チェック
if [ -z "$ENV" ]; then
  echo '> エラー: stgもしくはprodを指定してください。'
  exit 1
fi

if [ ! $ENV = prod ] && [ ! $ENV = stg ]; then
  echo '> エラー: stgもしくはprodを指定してください。'
  exit 1
fi

# if [ $ENV = prod ] && [ -z "$DEPLOY_DESCRIPTION" ]; then
#   echo '> エラー: prodを指定した場合はデプロイの説明を指定してください。'
#   exit 1
# fi

# ファイル存在チェック
if [ ! -e $CLASP_JSON_PATH ]; then
  echo '> エラー: .clasp.jsonが見つかりませんでした。'
  exit 1
fi

if [ $ENV = prod ]; then
  SCRIPT_ID='"scriptId":"1eu4IN9GpsvKHOOxTv456euFPh48EXmP6RU_Bs2v1St1ZiFsOvjUYjIPm"'
  ENV_STR="本番環境"
  JOB_STR="デプロイ・プッシュ"
elif [ $ENV = stg ]; then
  SCRIPT_ID='"scriptId":"1eu4IN9GpsvKHOOxTv456euFPh48EXmP6RU_Bs2v1St1ZiFsOvjUYjIPm"'
  ENV_STR="ステージング環境"
  JOB_STR="プッシュ"
fi

echo "> 以下の内容で $JOB_STR しようとしています。"
printf '\n'
echo "> 環境: $ENV_STR"
if [ $ENV = prod ]; then
  echo "> メッセージ: $DEPLOY_DESCRIPTION"
fi
printf '\n'
# read -p "> 実行してよろしいですか？ (y/n) [n] : " answer
# case $answer in
#   [Yy] ) break;;
#   [Nn] ) printf "処理を中断します。\n"
#     exit 1;;
#   "" ) printf "処理を中断します。\n"
#     exit 1;;
#   * ) printf "(y/n) で入力してください。\n"
#     exit 1;;
# esac

sed -i "" -e "s/$ORIGIN_SCRIPT_ID/$SCRIPT_ID/g" $CLASP_JSON_PATH
mkdir ./dist
cp -rf ./src/* ./dist/
cp -rf ./slackQuestionGenerator ./dist/slackQuestionGenerator
cp appsscript.json ./dist

npx clasp push

if [ $ENV = prod ]; then
  # get last deployment id
  LAST_DEPLOYMENT_ID=$(npx clasp deployments | grep -e '-[A-Za-z0-9\-\_\ ]\+ @[0-9]\+ - web app meta-version' | awk -F ' ' '{print $2}')

  if [ -z "$LAST_DEPLOYMENT_ID" ]; then
    LAST_DEPLOYMENT_ID=$(npx clasp deployments | grep -e '-[A-Za-z0-9\-\_\ ]\+ @[0-9]\+' | tail -n 1 | awk -F ' ' '{print $2}')
  fi

  npx clasp deploy -i "$LAST_DEPLOYMENT_ID"
fi

rm -rf ./dist
sed -i "" -e "s/$SCRIPT_ID/$ORIGIN_SCRIPT_ID/g" $CLASP_JSON_PATH

echo "> $ENV_STR への $JOB_STR が完了しました。"