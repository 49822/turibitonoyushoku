class Recipe < ApplicationRecord
  belongs_to :user
  has_many :recipe_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  
  validates :title,presence:true
  validates :body,presence:true,length:{maximum:200}
  
  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end
	
  def self.search_for(content, method)
    if method == 'perfect'
      Recipe.where(title: content)
    elsif method == 'forward'
      Recipe.where('title LIKE ?', content+'%')
    elsif method == 'backward'
      Recipe.where('title LIKE ?', '%'+content)
    else
      Recipe.where('title LIKE ?', '%'+content+'%')
    end
  end
end
