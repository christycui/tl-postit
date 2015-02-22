class User < ActiveRecord::Base
  has_many :posts
  has_many :comments
  has_many :votes

  has_secure_password validations: false

  validates :username, presence: true, length: {minimum:3}, uniqueness: true
  validates :password, presence: true, length: {minimum:6}, on: :create

  before_save :generate_slug


  def generate_slug
    the_slug = to_slug(self.title)
    user = User.find_by slug: the_slug
    count = 1
    while user && user != self
      count += 1
      the_slug = append_suffix(the_slug, count)
      user = User.find_by slug: the_slug
    end
    self.slug = the_slug.downcase
  end

  def to_slug(name)
    str = username.strip
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