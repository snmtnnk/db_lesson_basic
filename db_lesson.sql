-- DB Lesson -----------------------------------

-- Q1 departmentsテーブルを追加
create table departments (
  department_id int unsigned auto_increment primary key,
  name varchar(20) not null,
  created_at timestamp default current_timestamp,
  updated_at timestamp default current_timestamp on update current_timestamp
);

-- Q2 peopleテーブルにdepartment_idカラムを追加・移動
alter table people add column department_id int unsigned;
alter table people modify department_id int after email;
-- alter table people add department_id int unsigned after email で省略可;

-- Q3 departments、people、reportsテーブルに以下の条件を満たすようなレコードを挿入してください。
-- departments
-- 営業
-- 開発
-- 経理
-- 人事
-- 情報システム
insert into departments (name)
values
('営業'),
('開発'),
('経理'),
('人事'),
('情報システム');

-- people
-- 10人分のレコードを追加する
-- 人数比率は営業3人、開発4人、経理1人、人事1人、情報システム1人
insert into people (name, email, department_id, age, gender)
values
('佐藤たろう', 'satou@gizumo.jp', 1, 30, 1),
('高橋あみ', 'takahashi@gizumo.jp', 1, 22, 2),
('阿部たつや', 'abe@gizumo.jp', 1, 44, 1),
('安藤なな', 'andou@gizumo.jp', 2, 28, 2),
('高宮りょう', 'takamiya@gizumo.jp', 2, 37, 1),
('塩沢あや', 'shiozawa@gizumo.jp', 2, 52, 2),
('後藤けんや', 'gotou@gizumo.jp', 2, 40, 1),
('松本さやか', 'matsumoto@gizumo.jp', 3, 38, 2),
('本山しょうや', 'motoyama@gizumo.jp', 4, 48, 1),
('相澤まい', 'aizawa@gizumo.jp', 5, 51, 2);

-- reports
-- 10件の日報を追加する
-- 日報は誰に紐付けてもいいが、存在しないperson_idとは紐付けない
-- 日報の文字数は最低10文字で、同じ日報を作成しない
insert into reports (person_id, content)
values
(7, '電話対応'),
(8, '提案書作成'),
(9, 'データ分析'),
(10, '品質改善'),
(11, '環境構築'),
(12, '電話アプローチ'),
(13, 'メール対応'),
(14, '進捗報告'),
(15, '注文処理'),
(16, '実装テスト');

-- Q4 department_idのNULLを、以下の条件に当てはまる値で埋めるためのクエリを作成してください。
-- 存在する部署のIDが割り振られること
-- どう割り振るかは指定しませんが、必ずWHEREを使って条件を絞ってください
update people set department_id = 3 where person_id = 1;
update people set department_id = 3 where person_id = 2;
update people set department_id = 4 where person_id = 3;
update people set department_id = 4 where person_id = 4;
update people set department_id = 5 where person_id = 6;

-- Q5 年齢の降順で男性の名前と年齢を取得してください。
select
  name, age
from
  people
where
  gender = 1 
order by
  age asc;

-- Q6 テーブル・レコード・カラムという3つの単語を適切に使用して、下記のSQL文を日本語で説明してください。
SELECT
  `name`, `email`, `age`
→ nameカラムとemailカラムとageカラムを指定して、レコードを一覧表示する

FROM
  `people`
→ selectで選んだカラムに対してpeopleテーブルと指定

WHERE
  `department_id` = 1
→ department_idカラムの値が1のレコードだけ取得する

ORDER BY
  `created_at`;
→ created_atカラムを指定して並び替えをする

-- Q7 20代の女性と40代の男性の名前一覧を取得してください。
select 
  name
from
  people
where
  (age >= 20 and age < 30 and gender = 2)
  or 
  (age >= 40 and age < 50 and gender = 1);

-- Q8 営業部に所属する人だけを年齢の昇順で取得してください。
select
  *
from
  people
where
  department_id = 1
order by
  age asc;

-- Q9 開発部に所属している女性の平均年齢を取得してください。
select
  avg(age)
as
  average_age
from
  people
where
  (department_id = 2)
  and
  (gender = 2)

  -- Q10 名前と部署名とその人が提出した日報の内容を同時に取得してください。（日報を提出していない人は含めない）
select
  p.name,
  d.name,
  r.content
from
  people as p
inner join
  departments as d
  on
  p.department_id = d.department_id
inner join
  reports as r
  on
  p.person_id = r.person_id;

-- Q11 日報を一つも提出していない人の名前一覧を取得してください。
select
  p.name
from
  people as p
left outer join
  reports as r
  on
  p.person_id = r.person_id
where
  r.content is null;