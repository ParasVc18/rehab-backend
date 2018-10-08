include ActionController::HttpAuthentication::Token::ControllerMethods
class PoisonsController < ApplicationController
  before_action :set_poison, only: [:show, :update, :destroy]

  # GET /poisons
  def index
    @poisons = Poison.all

    render json: @poisons
  end

  # GET /poisons/1
  def show
    render json: @poison
  end

  # POST /poisons
  def create
    @poison = Poison.new(poison_params)
    authenticate_with_http_token do |token, options|
    user = User.find_by(auth_token: token)
    @poison.user_id = user.id
    end

    if @poison.time_type==="days"
      @poison.total= (@poison.no_of_doses * @poison.dose_size * @poison.time_period)
    elsif @poison.time_type==="months"
      @poison.total= (@poison.no_of_doses * @poison.dose_size * @poison.time_period * 30)
    elsif @poison.time_type==="years"
      @poison.total= (@poison.no_of_doses * @poison.dose_size * @poison.time_period * 365)  
    end

    @poison.alpha = 1
    @poison.counter = 0
    @poison.progress = 0
    @poison.avg_value = (@poison.dose_size * @poison.no_of_doses)
    @poison.spent = (@poison.total * @poison.price_of_doses)

    if @poison.save
      render json: @poison, status: :created, location: @poison
    else
      render json: @poison.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /poisons/1
  def update
    if @poison.update(poison_params)
      render json: @poison
    else
      render json: @poison.errors, status: :unprocessable_entity
    end
  end

  # DELETE /poisons/1
  def destroy
    @poison.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_poison
      @poison = Poison.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def poison_params
      params.require(:poison).permit(:name, :dose_size, :dose_type, :no_of_doses, :price_of_doses, :currency, :time_period, :time_type)
    end
end
