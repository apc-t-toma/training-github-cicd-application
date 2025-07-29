# Terraform Infrastructure Structure Documentation

## プロジェクト概要

このTerraformプロジェクトは、Azure上でJava 8ベースのWebアプリケーションを実行するためのApp Serviceインフラストラクチャを定義しています。シンプルで保守しやすく、スケーラブルな設計となっています。

## アーキテクチャ概要

このインフラストラクチャは、Azure上でセキュアなWebアプリケーションホスティング環境を実現しています。

### アプリケーション提供層

**Azure App Service**を使用してJava 8アプリケーションをホストし、**デプロイメントスロット**により開発環境と本番環境の分離を実現しています。HTTPSを強制することでセキュアな通信を保証し、Premium V2プランによる高いパフォーマンスを提供します。

### 基盤管理

すべてのリソースは**リソースグループ**内で一元管理され、一貫したタグ付けによりリソースの識別とコスト管理を効率化しています。

## ディレクトリ構造

```text
terraform/
├── main.tf                    # メインエントリポイント、モジュール統合
├── variables.tf               # グローバル変数定義
├── outputs.tf                 # グローバル出力値
├── terraform.tfvars          # 変数値設定
├── terraform.tfstate         # Terraformステート（自動生成）
├── terraform.tfstate.backup  # ステートバックアップ（自動生成）
│
├── base/                      # 基盤リソース
│   ├── resource_group.tf      # リソースグループ
│   ├── variables.tf           # ベースモジュール変数
│   └── outputs.tf             # ベースモジュール出力
│
└── app_service/               # App Serviceリソース
    ├── service_plan.tf        # App Service Plan
    ├── linux_web_app.tf       # Linux Web App
    ├── linux_web_app_slot.tf  # デプロイメントスロット
    └── variables.tf           # App Service変数
```

## モジュール詳細

### 1. Base Module (`base/`)

**目的**: 基盤となるAzureリソースの管理

- **リソースグループ**: すべてのリソースを格納する論理コンテナ
- **場所**: Japan East リージョンでのリソース配置
- **タグ管理**: 一貫したリソース識別とコスト管理

### 2. App Service Module (`app_service/`)

**目的**: Webアプリケーションのホスティングとデプロイメント

- **App Service Plan**:
  - Premium V2 P1v2 SKU
  - Linux OS
  - ゾーン冗長無効（開発環境構成）
- **Linux Web App**:
  - Java 8ランタイム
  - Java SEウェブサーバー
  - HTTPS強制設定
  - HTTP/2有効化
- **デプロイメントスロット（develop）**:
  - 本番環境と同一設定
  - 設定の複製なし

## セキュリティ特徴

### アプリケーションセキュリティ

- **HTTPS強制**: すべてのWebトラフィックをHTTPS経由で暗号化
- **HTTP/2有効化**: モダンなプロトコルによる効率的な通信
- **デプロイメントスロット分離**: 開発環境と本番環境の論理的分離

### 認証・認可

- **App Service認証**: 組み込みの認証機能により、アプリケーションレベルでのセキュリティ制御

### データ保護

- **暗号化**: 転送時および保存時のデータ暗号化
- **最小アクセス制御**: 必要最小限のアクセス権限設定

## デプロイメント順序

Terraformの依存関係に基づく推奨デプロイメント順序：

1. **Base**: リソースグループ作成
2. **App Service**: App Service PlanとWeb App構築

## 変数設定

### オプション変数（デフォルト値付き）

- `resource_group`: リソースグループ名（デフォルト: "t_toma-test"）
- `location`: デプロイリージョン（デフォルト: "Japan East"）
- `tags`: リソースタグ（デフォルト: owner = "t_toma"）

## 出力値

各モジュールは必要な情報を他のモジュールに提供するための出力値を定義しています：

- **リソース識別子**: リソースグループ情報
- **App Service情報**: Web App名、URL、デプロイメントスロット情報
- **App Service Plan情報**: プラン名とID

## 運用考慮事項

### スケーラビリティ

- App Service Planのスケールアップ・スケールアウト対応
- デプロイメントスロットによるBlue-Green デプロイメント

### 監視とログ

- Azure Monitor統合準備
- Application Insightsによるアプリケーション監視

### 災害復旧

- リージョン間での復旧戦略
- バックアップとリストア手順

### コスト最適化

- 開発環境向けの最小構成
- 本番環境への段階的スケールアップ対応

## ベストプラクティス

1. **モジュラー設計**: 機能別モジュール分割による保守性向上
2. **依存関係管理**: 明示的な`depends_on`による順序制御
3. **設定の一元化**: 変数とタグの統一管理
4. **セキュリティファースト**: デフォルトでセキュアな設定
5. **Infrastructure as Code**: 宣言的なインフラ管理

この構造により、シンプルで保守しやすく、セキュアなWebアプリケーションプラットフォームを提供しています。
