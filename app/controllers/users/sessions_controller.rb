class Users::SessionsController < Devise::SessionsController
  #respond_to :json

  def destroy
    if request.headers['Authorization'].nil?
      render json: { message: 'Missing token.' }, status: :unauthorized
      return
    end
    user = user_from_token
    if user_signed_in? && current_user.id == user.id
      sign_out(current_user)
      render json: {
        message: 'You are logged out.'
      }, status: :ok
    else
      render json: { message: 'Invalid token.' }, status: :unauthorized
    end
  end

  private

  def user_from_token
    jwt_payload = JWT.decode(request.headers['Authorization'].split[1],
                             Rails.application.credentials.devise[:jwt_secret_key]).first
    user_id = jwt_payload['sub']
    User.find(user_id.to_s)
  end

  def respond_with(_resource, _opts = {})
    if current_user.nil?
      render json: { message: 'Invalid email or password.' }, status: :unauthorized
    else
      render json: {
        message: 'You are logged in.',
        user: current_user
      }, status: :ok
    end
  end
end
