module ApplicationHelper
  def product_img_tag(product, options = {})
    options[:style] ||= :small
    style = case options[:style].to_s
    when 'small' then '30x30'
    when 'normal' then '100x100'
    when 'large' then '240x240'
    else options[:style].to_s
    end
    link_to image_tag(product.image.url(style), class: "img-responsive"), product
  end
end
