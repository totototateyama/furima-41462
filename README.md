# テーブル設計

## users テーブル

| Column              | Type       | Options                        |
| ------------------- | ---------- | ------------------------------ |
| nickname            | string     | null: false                    |
| email               | string     | null: false, unique: true      |
| encrypted_password  | string     | null: false                    |
| first_name(zenkaku) | string     | null: false                    |
| last_name(zenkaku)  | string     | null: false                    |
| first_name(katakana)| string     | null: false                    |
| last_name(katakana) | string     | null: false                    |
| birthday            | date       | null: false                    |

### Association

- has_many:items
- has_many:purchases

## items テーブル

| Column              | Type       | Options                        |
| ------------------- | ---------- | ------------------------------ |
| item_name           | string     | null: false                    |
| description         | text       | null: false                    |
| category_id         | integer    | null: false                    |
| condition_id        | integer    | null: false                    |
| shipping_cost_id    | integer    | null: false                    |
| shipping_area_id    | integer    | null: false                    |
| shipping_day_id     | integer    | null: false                    |
| price               | integer    | null: false                    |
| user                | references | null: false, foreign_key: true |

### Association

- belongs_to:user
- has_one:purchases

## purchases テーブル

| Column              | Type       | Options                        |
| ------------------- | ---------- | ------------------------------ |
| item                | references | null: false, foreign_key: true |
| user                | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item
- has_one:shipping

## shippings テーブル

| Column              | Type       | Options                        |
| ------------------- | ---------- | ------------------------------ |
| post_code           | string     | null: false                    |
| prefecture_id       | integer    | null: false                    |
| city                | string     | null: false                    |
| house_number        | text       | null: false                    |
| building_name       | text       |                                |
| telephone_number    | string     | null: false                    |
| purchases           | references | null: false, foreign_key: true |

### Association

- belongs_to:purchase