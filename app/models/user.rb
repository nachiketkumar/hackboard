class User < ActiveRecord::Base
  #make this model use omniauth for authentication
  devise :omniauthable

  # set model relationships/associations
  has_many :boards
  has_many :pins, through: :boards
  has_many :comments

  #Find user with a specific user-id, if no user is found then create one
  def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.nickname = auth.info.nickname
      user.name = auth.info.name
      user.image_url = auth.info.image
    end
  end

  #The controller by default calls "User.new_with_session" before building a resource.
  #Use data in session to create the new user. "without_protection" will allow mass assignment.
  def self.new_with_session(params, session)
    if session["devise.user_attributes"]
      new(session["devise.user_attributes"], without_protection: true) do |user|
        user.attributes = params
        user.valid?
      end
    else
      super
    end
  end

  def owns?(object)
    #if the object has a user check that the user is 'self'(the caller).
    object.user == self if object.respond_to?(:user)
  end

end
