class Post < ActiveRecord::Base
  include Voteable

  belongs_to :creator, foreign_key: "user_id", class_name: "User"
  has_many :comments
  has_many :post_categories
  has_many :categories, through: :post_categories
  has_many :votes, as: :voteable

  validates :title, presence: true
  validates :url, presence: true
  validates :description, presence: true

  before_save :generate_slug!

  def to_param
    self.slug
  end

  def generate_slug!
    the_slug = to_slug(self.title)
    post = Post.find_by(slug: the_slug)
    count = 2
    while post && post != self
      the_slug = append_suffix(the_slug, count)
      post = Post.find_by(slug: the_slug)
      count += 1
    end
    self.slug = the_slug.downcase
  end

  def append_suffix(str,count)
    if str.split('-').last.to_i != 0
      return str.split('-').slice(0...-1).join('-') + "-#{count}"
    else
      return str + "-#{count}"
    end
  end

  def to_slug(name)
    str = name.strip
    str.gsub!(/\s*[^A-Za-z0-9]\s*/, '-')
    str.gsub!(/-+/,"-")
    str.chop! if str.last == '-'
    str.downcase
  end
end