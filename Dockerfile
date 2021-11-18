# ベースイメージの作成
FROM node:12.16.1
# コンテナ内で作業するディレクトリを指定
WORKDIR /usr/src/app
# package.jsonとyarn.lockを/usr/src/appにコピー
COPY ["package.json", "./"]
# パッケージをインストール
RUN npm install
# ファイルを全部作業用ディレクトリにコピー
COPY . .
# コンテナを起動する際に実行されるコマンド
ENTRYPOINT [ "npm", "start", "--host", "0.0.0.0:3000" ]