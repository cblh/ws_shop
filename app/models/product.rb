require 'carrierwave/mongoid'
class Product
  include Mongoid::Document
  include Mongoid::Timestamps
  field :title, type: String
  field :description, type: String
  # field :image_url, type: String
  field :price, type: BigDecimal
  
  mount_uploader :image, ImageUploader
  #TODO 使用mongoid的scope
  # default_scope { order("title") }

  has_many :line_items
  # has_many :orders

  before_destroy :ensure_not_referenced_by_any_line_item

  private
    def ensure_not_referenced_by_any_line_item
      if line_items.empty?
        true
      else
        errors.add(:base, 'Line Items present')
        false
      end
    end


	VALIE_IMAGE_URL_REGEX = %r{\.(gif|jpg|png)\Z}i

	validates :title, :description, :image_url, presence: true
	validates :price, numericality: { only_integer: true, greater_than_or_equal_to: 0.01 }
	validates :title, uniqueness: true, length: { minimum: 1, maximum: 50 }
	# validates :image_url, format: {
	# 	with: VALIE_IMAGE_URL_REGEX,
	# 	message: 'must be a URL for GIF, JPG or PNG image.'

	# }

end
