# == Schema Information
#
# Table name: posts
#
#  id         :bigint(8)        not null, primary key
#  title      :string           not null
#  url        :string
#  content    :text
#  user_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Post < ApplicationRecord
  validates :title, presence: true
  
  belongs_to :author,
  foreign_key: :user_id,
  class_name: :User
  
  has_many :post_subs, inverse_of: :post
  has_many :subs, through: :post_subs, source: :sub
  has_many :comments
  
  def comments_by_parent_id
    hash_result = Hash.new{|h,k| h[k] = []}
    
    self.comments.each do |comment|
      hash_result[comment.parent_comment_id] << comment
    end
    
    hash_result
  end
  
end
