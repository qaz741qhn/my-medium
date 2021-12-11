class Follow < ApplicationRecord
  belongs_to :user

  #為了設定foreign_key是'following_id'才寫的。即使following不存在也可以
  belongs_to :following, foreign_key: 'following_id', class_name: 'User'
end
