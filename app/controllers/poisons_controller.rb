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
    user = User.find_by(auth_token: params[:auth_token])
    @poison.user_id = user.id

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
      params.require(:poison).permit(:name, :dose_size, :dose_type, :no_of_doses, :price_of_doses, :currency, :time_period, :time_type, :avg_value, :alpha, :progress, :counter, :user_id, :auth_token)
    end
end
