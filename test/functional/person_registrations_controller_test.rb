require 'test_helper'

class PersonRegistrationsControllerTest < ActionController::TestCase
  setup do
    @person_registration = person_registrations(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:person_registrations)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create person_registration" do
    assert_difference('PersonRegistration.count') do
      post :create, person_registration: {  }
    end

    assert_redirected_to person_registration_path(assigns(:person_registration))
  end

  test "should show person_registration" do
    get :show, id: @person_registration
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @person_registration
    assert_response :success
  end

  test "should update person_registration" do
    put :update, id: @person_registration, person_registration: {  }
    assert_redirected_to person_registration_path(assigns(:person_registration))
  end

  test "should destroy person_registration" do
    assert_difference('PersonRegistration.count', -1) do
      delete :destroy, id: @person_registration
    end

    assert_redirected_to person_registrations_path
  end
end
