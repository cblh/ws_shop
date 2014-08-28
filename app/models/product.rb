class Product < ActiveRecord::Base

	VALIE_IMAGE_URL_REGEX = %r{\.(gif|jpg|png)$}i

	validates :title, :description, :image_url, presence: true
	validates :price, numericality: { greater_than_or_equal_to => 0.01 }
	validates :title, uniqueness: true
	validates :image_url, format: {
		with: VALIE_IMAGE_URL_REGEX,
		message: 'must be a URL for GIF, JPG or PNG image.'
	}
end
