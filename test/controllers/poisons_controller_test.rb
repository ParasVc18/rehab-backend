require 'test_helper'

class PoisonsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @poison = poisons(:one)
  end

  test "should get index" do
    get poisons_url, as: :json
    assert_response :success
  end

  test "should create poison" do
    assert_difference('Poison.count') do
      post poisons_url, params: { poison: { alpha: @poison.alpha, avg_value: @poison.avg_value, counter: @poison.counter, currency: @poison.currency, dose_size: @poison.dose_size, dose_type: @poison.dose_type, name: @poison.name, no_of_doses: @poison.no_of_doses, price_of_doses: @poison.price_of_doses, progress: @poison.progress, time_period: @poison.time_period, time_type: @poison.time_type, user_id: @poison.user_id } }, as: :json
    end

    assert_response 201
  end

  test "should show poison" do
    get poison_url(@poison), as: :json
    assert_response :success
  end

  test "should update poison" do
    patch poison_url(@poison), params: { poison: { alpha: @poison.alpha, avg_value: @poison.avg_value, counter: @poison.counter, currency: @poison.currency, dose_size: @poison.dose_size, dose_type: @poison.dose_type, name: @poison.name, no_of_doses: @poison.no_of_doses, price_of_doses: @poison.price_of_doses, progress: @poison.progress, time_period: @poison.time_period, time_type: @poison.time_type, user_id: @poison.user_id } }, as: :json
    assert_response 200
  end

  test "should destroy poison" do
    assert_difference('Poison.count', -1) do
      delete poison_url(@poison), as: :json
    end

    assert_response 204
  end
end
