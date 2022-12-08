ImageKitIo.configure do |config|
    if Rails.env.development? || Rails.env.production?
      config.public_key = 'public_FbHvKLKUQasD0G/tcdKYjl+MyO4='
      config.private_key = 'private_2y+gHpvzlTRMDjMDI9+drkeJlYU='
      config.url_endpoint = 'https://ik.imagekit.io/carbackend' 
    end
    config.service = :active_storage
  end