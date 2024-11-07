# exp-gcloud-postgres

以下の手順は仮作成（未検証）

### Google Cloud アカウント作成から Terraform 適用までの手順

### 1. Google Cloud アカウントの作成

1. [Google Cloud](https://cloud.google.com/)にアクセスし、アカウントを作成する。
2. クレジットカード情報を登録し、無料トライアルを開始する。

### 2. gcloud CLI のインストール

1. ローカルマシンに gcloud CLI をインストールする。

   - macOS の場合：
     ```bash
     brew install --cask google-cloud-sdk
     ```
   - Linux や Windows の場合は、[Google Cloud CLI のインストールガイド](https://cloud.google.com/sdk/docs/install)を参照する。

2. インストールが完了したら、以下のコマンドで gcloud CLI を初期化する。
   ```bash
   gcloud init
   ```

### 3. Google Cloud にログイン

1. gcloud CLI で Google アカウントにログインする。
   ```bash
   gcloud auth login
   ```

### 4. 初期プロジェクトの作成

1. 初期プロジェクトを作成する。プロジェクト ID は任意の一意な ID を指定する。

   ```bash
   gcloud projects create <YOUR_INITIAL_PROJECT_ID> --name="<YOUR_PROJECT_NAME>"
   ```

2. 作成したプロジェクトをデフォルトプロジェクトに設定する。
   ```bash
   gcloud config set project <YOUR_INITIAL_PROJECT_ID>
   ```

### 5. 課金アカウントの設定

1. Google Cloud Console にアクセスし、[課金ページ](https://console.cloud.google.com/billing)から課金アカウントを作成したプロジェクトにリンクする。

### 6. サービスアカウントの作成

1. Terraform が使用するサービスアカウントを作成する。

   ```bash
   gcloud iam service-accounts create <SERVICE_ACCOUNT_NAME> --display-name="<SERVICE_ACCOUNT_DISPLAY_NAME>"
   ```

2. サービスアカウントの JSON キーを発行し、ローカルに保存する。
   ```bash
   gcloud iam service-accounts keys create ~/path/to/key.json --iam-account=<SERVICE_ACCOUNT_NAME>@<YOUR_INITIAL_PROJECT_ID>.iam.gserviceaccount.com
   ```

### 7. サービスアカウントに必要なロールを付与

1. サービスアカウントにプロジェクト作成や IAM 管理に必要なロールを付与する。

   ```bash
   gcloud projects add-iam-policy-binding <YOUR_INITIAL_PROJECT_ID> \
     --member="serviceAccount:<SERVICE_ACCOUNT_NAME>@<YOUR_INITIAL_PROJECT_ID>.iam.gserviceaccount.com" \
     --role="roles/resourcemanager.projectCreator"

   gcloud projects add-iam-policy-binding <YOUR_INITIAL_PROJECT_ID> \
     --member="serviceAccount:<SERVICE_ACCOUNT_NAME>@<YOUR_INITIAL_PROJECT_ID>.iam.gserviceaccount.com" \
     --role="roles/iam.admin"
   ```

2. 必要に応じてその他のロール（例: `roles/billing.user`）を付与する。

### 8. Terraform のインストール

1. [Terraform 公式サイト](https://www.terraform.io/downloads)から Terraform をダウンロードし、インストールする。
2. インストール後、以下のコマンドでバージョンを確認し、インストールが正しく行われたことを確認する。
   ```bash
   terraform -v
   ```

### 9. Terraform の認証設定

1. サービスアカウントキーを使用し、Terraform が Google Cloud にアクセスできるように環境変数を設定する。
   ```bash
   export GOOGLE_APPLICATION_CREDENTIALS=~/path/to/key.json
   ```

### 10. Terraform 構成ファイルの作成

1. 作業ディレクトリを作成し、その中に Terraform 構成ファイル（例: `main.tf`）を作成する。
2. `main.tf`に以下のような設定を追加し、Google Cloud プロバイダーの設定を行う。

   ```hcl
   provider "google" {
     credentials = file(var.credentials)
     project     = var.project
     region      = "us-central1"
   }

   variable "project" {
     default = "<YOUR_INITIAL_PROJECT_ID>"
   }

   variable "credentials" {
     default = "<path/to/key.json>"
   }
   ```

### 11. Terraform の初期化

1. 作成したディレクトリ内で Terraform を初期化し、プロバイダープラグインをインストールする。
   ```bash
   terraform init
   ```

### 12. Terraform の適用

1. 設定ファイルを検証する。

   ```bash
   terraform plan
   ```

2. 問題がなければ、以下のコマンドで Terraform を適用し、インフラを構築する。

   ```bash
   terraform apply
   ```

3. 確認を求められたら `yes` と入力し、適用を完了する。

```

```
