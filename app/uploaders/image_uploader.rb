# encoding: utf-8
require 'carrierwave/processing/mini_magick'
# 在图片空间里面定义好的“缩略图版本名称”，以防止调用错误
IMAGE_UPLOADER_ALLOW_IMAGE_VERSION_NAMES = %(tiny small normal large 20x20 30x30 100x100 240x240)
class ImageUploader < CarrierWave::Uploader::Base
  storage :upyun

  def store_dir
    "#{model.class.to_s.underscore}/#{mounted_as}"
  end

  def default_url
    # 搞一个大一点的默认图片取名 blank.png 用 FTP 传入图片空间，用于作为默认图片
    # 由于有自动的缩略图处理，小图也不成问题
    # Setting.upload_url 这个是你的图片空间 URL
    "http://ws-shop.b0.upaiyun.com/blank.png#{version_name}"
  end

  # 覆盖 url 方法以适应“图片空间”的缩略图命名
  def url(version_name = "")
    @url ||= super({})
    version_name = version_name.to_s
    return @url if version_name.blank?
    if not version_name.in?(IMAGE_UPLOADER_ALLOW_IMAGE_VERSION_NAMES)
      # 故意在调用了一个没有定义的“缩略图版本名称”的时候抛出异常，以便开发的时候能及时看到调错了
      raise "ImageUploader version_name:#{version_name} not allow."
    end
    [@url,version_name].join("!") # 我这里在图片空间里面选用 ! 作为“间隔标志符”
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end

  def filename
    # if super.present?
    #   model.uploader_secure_token ||= SecureRandom.uuid.gsub("-","")
    #   Rails.logger.debug("(BaseUploader.filename) #{model.uploader_secure_token}")
    #   "#{model.uploader_secure_token}.#{file.extension.downcase}"
    # end
    if original_filename
      # current_path 是 Carrierwave 上传过程临时创建的一个文件，有时间标记
      # 例如: /Users/jason/work/ruby-china/public/uploads/tmp/20131105-1057-46664-5614/_____2013-11-05___10.37.50.png
      @name ||= Digest::MD5.hexdigest(current_path)
      "#{@name}.#{file.extension}"
    end
  end
end