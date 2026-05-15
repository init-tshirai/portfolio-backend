class Comment < ApplicationRecord
  belongs_to :task
  belongs_to :user

  validates :task_id, presence: true # 整合性（taskが存在するか？）は外部キー制約に任せる
  validates :user_id, presence: true # 整合性（userが存在するか？）は外部キー制約に任せる
  validates :content, presence: true, length: { maximum: 10000 }
  validates :task_update_info, presence: true, length: { maximum: 10000 }
end
