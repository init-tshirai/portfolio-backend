## 認証・認可について

### 流れ

1. ユーザーがフロントの /login からログインする
2. フロントがPOSTで /auth/sign_in を呼び、JWTをCookieに保存する
3. 以降はCookieからトークンを取り出し、 Authorization: Bearer <token> 付きでAPIを呼ぶ
4. API側はDevise JWTで認証、CanCanCanで認可する

### ロールと権限（CanCanCan）

| role     | 権限            |
| -------- | ------------- |
| `normal` | `Task` の CRUD |
| `admin`  | すべてのリソースを管理   |
| `viewer` | `Task` の閲覧のみ  |
