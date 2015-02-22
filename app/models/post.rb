class Post < ActiveRecord::Base
  include Voteable
  belongs_to :creator, foreign_key: 'user_id', class_name: 'User'
  has_many :comments
  has_many :post_categories
  has_many :categories, through: :post_categories
  validates :title, :description, presence: true

  before_save :generate_slug

  def generate_slug
    the_slug = to_slug(self.title)
    post = Post.find_by slug: the_slug
    count = 1
    while post && post != self
      count += 1
      the_slug = append_suffix(the_slug, count)
      post = Post.find_by slug: the_slug
    end
    self.slug = the_slug.downcase
  end

  def to_slug(name)
    str = title.strip
    str.gsub! /\s*[^A-Za-z0-9]\s*/, '-'
    str.gsub! /-+/, '-'
    str.downcase
  end

  def append_suffix(str, count)
    if str.split('-').last.to_i != 0
      return str.split('-').slice(0...-1).join('-') + '-' + count.to_s
    else
      return str + '-' + count.to_s
    end
  end

  def to_param
    self.slug
  end
end