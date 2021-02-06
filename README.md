# VIPERSample
VIPER sample

## それぞれの役割の詳細

### Router

- 画面遷移とDIを担当
- 他のアーキテクチャでは画面遷移の処理をView層が受け持っており  
コードの見通しが悪くなりがった


### View
- 画面の更新とPresenterへのイベントを通知する
- Presenterから表示指示を待つ

### Presenter
- Viewに対して画面の更新を依頼する
- Interactorに対してデータの取得を依頼する
- Routerに対して画面遷移を依頼する

### Interactor
- ビジネスロジックを担当
- データのやりとり(CRUD)
- Entityの作成と破棄
- `import UIKit`禁止

### Entity
- データ構造の定義を担当
- structでデータ構造を定義する

