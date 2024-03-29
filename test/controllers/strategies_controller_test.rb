require 'test_helper'

class StrategiesControllerTest < ActionController::TestCase
  setup do
    @strategy = strategies(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:strategies)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create strategy" do
    assert_difference('Strategy.count') do
      post :create, strategy: { date: @strategy.date, intro: @strategy.intro, title: @strategy.title, user_id: @strategy.user_id }
    end

    assert_redirected_to strategy_path(assigns(:strategy))
  end

  test "should show strategy" do
    get :show, id: @strategy
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @strategy
    assert_response :success
  end

  test "should update strategy" do
    patch :update, id: @strategy, strategy: { date: @strategy.date, intro: @strategy.intro, title: @strategy.title, user_id: @strategy.user_id }
    assert_redirected_to strategy_path(assigns(:strategy))
  end

  test "should destroy strategy" do
    assert_difference('Strategy.count', -1) do
      delete :destroy, id: @strategy
    end

    assert_redirected_to strategies_path
  end
end
