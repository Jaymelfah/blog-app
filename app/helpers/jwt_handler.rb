class JwtHandler
    def self.encode(payload)
      JWT.encode(payload, secret_key, 'HS256')
    end
  
    def self.decode(token)
      JWT.decode(token, secret_key, true, { algorithm: 'HS256' })[0]
    rescue JWT::DecodeError
      nil
    end
  
    def self.secret_key
      Rails.application.secrets.secret_key_base
    end
end