class JsonWebToken
  require 'jwt'
  SECRET_KEY = ENV['JWT_SECRET']
  JWT_EXPIRY = 1.days

  def self.encode(payload, exp = JWT_EXPIRY.from_now)
    payload[:exp] = exp.to_i
    JWT.encode(payload, SECRET_KEY, 'HS512')
  end

  def self.decode(token)
    decoded = JWT.decode(token, SECRET_KEY, true, { algorithm: 'HS512' })[0]
    res = HashWithIndifferentAccess.new decoded
    res if Time.at(res[:exp]) > Time.now
  rescue StandardError
    nil
  end
end
