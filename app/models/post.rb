class Post < ActiveRecord::Base
	has_many :comments
	validates :title, presence: true, uniqueness: true
	validates :body, length:{ minimum: 100 }

end
