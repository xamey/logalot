module Events::User
  class UserCreated
    def initialize(user)
      @user_id = user[:id]
      @user_type = user[:type]
    end
  end
end