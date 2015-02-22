module Sluggable
  extend ActiveSupport::Concern
  included do
    before_save :generate_slug
  end

  def generate_slug
    the_slug = to_slug(self.send(self.class.slug_col.to_sym))
    obj = self.class.find_by slug: the_slug
    count = 1
    while obj && obj != self
      count += 1
      the_slug = append_suffix(the_slug, count)
      obj = self.class.find_by slug: the_slug
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

  module ClassMethods
    def sluggable_column(col_name)
      slug_col = col_name
    end
  end
end