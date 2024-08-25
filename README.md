## About
[frontend](https://github.com/aisaka-1653/twitter_react_front)と同時に使用する｡

## Setup

> [!WARNING]
> フロント側で既に外部ネットワーク(external)を作成している場合は､手順1をスキップしてください

1. フロントコンテナとの通信用に外部ネットワークを作成する  
```bash
$ docker network create external
```

2. リポジトリをクローンする
```bash
$ git clone https://github.com/aisaka-1653/twitter_rails_api.git
$ cd twitter_rails_api
```

3. docker-composeをビルドする
```bash
$ docker-compose build
```

4. Gemをインストールする
```bash
$ docker-compose run --rm api bundle install
```

5. dbを作成する
```bash
$ docker-compose run --rm api bin/rails db:create
```

6. migrateする
```bash
$ docker-compose run --rm api bin/rails db:migrate
```


7. 開発サーバーを起動する
```bash
$ docker-compose up -d
```
