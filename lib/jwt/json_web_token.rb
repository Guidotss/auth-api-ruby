class JsonWebToken
  SECRET_KEY = ENV['SECRET_KEY']

  def self.encode(payload)
    exp = 2.hours.from_now.to_i
    payload[:exp] = exp.to_i

    JWT.encode(payload, SECRET_KEY)

  end

  def self.decode(token)
    decode = JWT.decode(token, SECRET_KEY)[0]
    HashWithIndifferentAccess.new decode
  end
end
