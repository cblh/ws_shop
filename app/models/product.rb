class Product < ActiveRecord::Base
	default_scope { order("title") }

	VALIE_IMAGE_URL_REGEX = %r{\.(gif|jpg|png)\Z}i

	validates :title, :description, :image_url, presence: true
	validates :price, numericality: { only_integer: true, greater_than_or_equal_to: 0.01 }
	validates :title, uniqueness: true, length: { minimum: 10, maximum: 50 }
	validates :image_url, format: {
		with: VALIE_IMAGE_URL_REGEX,
		message: 'must be a URL for GIF, JPG or PNG image.'
	}
end
