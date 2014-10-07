CarrierWave.configure do |config|
  config.storage = :upyun
  config.upyun_username = "baulin"
  config.upyun_password = 'chenbaolin'
  config.upyun_bucket = "ws-shop"
  config.upyun_bucket_host = "http://ws-shop.b0.upaiyun.com"
end