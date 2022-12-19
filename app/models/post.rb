class Post < ApplicationRecord
  belongs_to :user, inverse_of: :posts
  counter_culture :user
end
