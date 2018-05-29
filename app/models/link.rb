class Link < ApplicationRecord
  before_create :set_code
  belongs_to :user, optional: true
  validates :url_code, uniqueness: true
  validates :original, presence: true, url: true

  def generate_code(size = 5)
    charset = %w{ 2 3 4 6 7 9 A C D E F G H J K M N P Q R T V W X Y Z}
    (0...size).map{ charset.to_a[rand(charset.size)] }.join
  end

  def set_code
    self.url_code = generate_code(5)
  end
end


