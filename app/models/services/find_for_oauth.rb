class Services::FindForOauth
  attr_reader :auth

  def initialize(auth)
    @auth = auth
  end

  def call
    authorization = Authorization.find_by(provider: auth.provider, uid: auth.uid.to_s)
    return authorization&.user if authorization

    email = auth&.info&.email
    return unless email

    email = auth.info[:email]
    user = User.find_by(email: email)

    user = User.find_by(email: email)
    user ||= create_user(email)
    user.create_authorization(auth)
    user
  end 

  private

  def create_user(email)
    password = Devise.friendly_token[0, 20]
    User.create!(email: email, password: password, password_confirmation: password)
  end
end
