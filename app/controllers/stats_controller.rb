include ActionController::HttpAuthentication::Token::ControllerMethods
class StatsController < ApplicationController
  before_action :set_stat, only: [:show, :update, :destroy]

  # GET /stats
  def index
    @stats = Stat.all

    render json: @stats
  end

  # GET /stats/1
  def show
    render json: @stat
  end

  # POST /stats
  def create
    @stat = Stat.new(stat_params)

    authenticate_with_http_token do |token, options|
      @user = User.find_by(auth_token: token)
      @poison = Poison.find_by(user_id: @user.id, name: params[:poison_name])
      @stat.user_id = @user.id
      @stat.poison_id = @poison.id
    end
    if @stat.save 
      render json: @stat, status: :created, location: @stat
    else
      render json: @stat.errors, status: :unprocessable_entity
    end
    @poison.progress=(@poison.progress + (((@poison.avg_value-@stat.dose_size)*@poison.alpha)/@poison.total))
    @poison.save
    if @poison.avg_value > @stat.dose_size 
        @poison.counter = @poison.counter+1
        @poison.save
    elsif @poison.avg_value < @stat.dose_size 
        @poison.counter = @poison.counter-1
        @poison.save
    end
    if @poison.counter === 5 
        @poison.alpha=(@poison.alpha * 0.9)
        a=Stat.where(user_id: @user.id, poison_id: @poison.id).order('id desc').limit(5).pluck(:id)
        @poison.avg_value = Stat.where(id: a).sum(:dose_size)/5.0
        @poison.counter = 0
        @poison.save
    elsif @poison.counter === -5 
        @poison.alpha=(@poison.alpha * 1.1)
        a=Stat.where(user_id: @user.id, poison_id: @poison.id).order('id desc').limit(5).pluck(:id)
        @poison.avg_value = Stat.where(id: a).sum(:dose_size)/5.0
        @poison.counter = 0
        @poison.save
    end  
  end

  # PATCH/PUT /stats/1
  def update
    if @stat.update(stat_params)
      render json: @stat
    else
      render json: @stat.errors, status: :unprocessable_entity
    end
  end

  # DELETE /stats/1
  def destroy
    @stat.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_stat
      @stat = Stat.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def stat_params
      params.require(:stat).permit(:dose_size, :poison_name, :user_id, :poison_id)
    end
end
