module CrOTP
  class TOTP
    PERIOD = 30

    include CrOTP::OTP

    def initialize(@secret : String, @digits : Int = 6, @algorithm : OTP::Algorithm = OTP::Algorithm::SHA1)
    end

    def generate(at : Int = Time.now.epoch) : String
      counter = at / PERIOD
      generate_otp(counter)
    end

    def generate(at : Time) : String
      generate(at.epoch)
    end

    def verify(token : String, at : Int = Time.now.epoch, allowed_drift : Int = 0) : Bool
      counter = at / PERIOD
      Array.new(allowed_drift+1) { |i| verify_otp(token, counter - i) }.any?
    end

    def verify(token : String, at : Time, allowed_drift : Int = 0) : Bool
      verify(token, at.epoch, allowed_drift)
    end

    def authenticator_uri(issuer : String, user : String) : String
      label = "#{URI.escape(issuer)}:#{URI.escape(user)}"
      build_authenticator_uri(issuer: issuer, label: label)
    end

    def authenticator_uri(issuer : String) : String
      label = URI.escape(issuer)
      build_authenticator_uri(issuer: issuer, label: label)
    end

    private def build_authenticator_uri(issuer : String, label : String) : String
      query =  "secret=#{base32_secret}"
      query += "&algorithm=#{@algorithm}"
      query += "&period=#{PERIOD}"
      query += "&digits=#{@digits}"
      query += "&issuer=#{URI.escape(issuer)}"
      "otpauth://totp/#{label}?#{query}"
    end
  end
end
