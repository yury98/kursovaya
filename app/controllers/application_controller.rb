class ApplicationController < ActionController::Base

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!
  before_action :five_days

  private

  def five_days
    @conn = Contract.where(end_date: Time.now()..(Time.now() + 5.days))
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:account_update) do |user_params|
      user_params.permit(:email, :password, :password_confirmation, :current_password, :mail, :fio )
    end
  end
end
