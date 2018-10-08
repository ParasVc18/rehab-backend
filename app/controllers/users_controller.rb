include ActionController::HttpAuthentication::Token::ControllerMethods
class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy]

  # GET /users
  def index
    authenticate_with_http_token do |token, options|
    @user = User.find_by(auth_token: token)
    render json: @user
    end
  end


    # POST /sign_up
def sign_up
  @user = User.new(new_user_params)

  if @user.save
    render json: {token: @user.auth_token} 
  else
    render json: @user.errors, status: :unprocessable_entity
  end
end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def user_params
      params.require(:user).permit(:username, :password, :email, :auth_token)
    end

    def new_user_params
      params.require(:user).permit(:username, :password, :email)
    end
end
