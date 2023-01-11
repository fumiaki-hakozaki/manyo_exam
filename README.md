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
|          	| deadline        	| date   	|
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