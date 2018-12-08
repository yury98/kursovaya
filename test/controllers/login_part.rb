require 'test_helper'

def login_help
  get "/users/sign_up"
  assert_response :success

  post "/users",
       params: { user: { email: "yshashkin@yandex.ru", password: "123456", password_confirmation: "123456"  } }
  assert_response :redirect
  follow_redirect!
  assert_response :success
end

def admin_help
  u = User.find_by_email("yshashkin@yandex.ru")
  u.admin = true
  u.save
end