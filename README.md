| モデル名 	 | カラム名        	   | データ型 	|
|----------	|-----------------	|----------	|
| User     	| id              	| integer  	|
|          	| name            	| string   	|
|          	| email           	| string   	|
|          	| password-digest 	| string   	|

<br>
<br>

| モデル名 	 | カラム名        	   | データ型 	|
|----------	|-----------------	|----------	|
| Task     	| id              	| integer  	|
|          	| task_name         | string   	|
|          	| task_content      | text    	|
|          	| deadline        	| date   	  |
|          	| status            | string   	|
|          	| priority          | string   	|
|          	| user_id         	| references|

<br>
<br>

| モデル名 	 | カラム名        	   | データ型 	|
|----------	|-----------------	|----------	|
| Label     | id              	| integer  	|
|          	| label_name        | string   	|

<br>
<br>

| モデル名 	 | カラム名        	   | データ型 	|
|----------	|-----------------	|----------	|
|Task_label | id              	| integer  	|
|          	| task_id           | references|
|          	| label_id          | references|

<br>
<br>
<br>
<br>
 Herokuデプロイ方法<br>
①コミットする。
<br>

② 新しいアプリケーションを作成する。<br>
```
% heroku create
```
のコマンドを入力して作成。

③Gemfileに
```
gem 'net-smtp'
gem 'net-imap'
gem 'net-pop'
```
を追加し、% bundle install

④Heroku buildpackを追加する
```
% heroku buildpacks:set heroku/ruby
% heroku buildpacks:add --index 1 heroku/nodejs
```
をターミナルに入力して、buildpackを追加する。

⑤ プッシュする
```
% git push heroku ブランチ名:master
```
でherokuにデプロイする。<br>
⑥アプリ起動
```
% heroku run rails db:migrate
% heroku open
```