require 'test_helper'

class To2dosControllerTest < ActionController::TestCase
  setup do
    @to2do = to2dos(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:to2dos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create to2do" do
    assert_difference('To2do.count') do
      post :create, to2do: @to2do.attributes
    end

    assert_redirected_to to2do_path(assigns(:to2do))
  end

  test "should show to2do" do
    get :show, id: @to2do.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @to2do.to_param
    assert_response :success
  end

  test "should update to2do" do
    put :update, id: @to2do.to_param, to2do: @to2do.attributes
    assert_redirected_to to2do_path(assigns(:to2do))
  end

  test "should destroy to2do" do
    assert_difference('To2do.count', -1) do
      delete :destroy, id: @to2do.to_param
    end

    assert_redirected_to to2dos_path
  end
end
