class ApplicationController < ActionController::Base

  # Проверка авторизации
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!
  before_action :five_days

  private

  # Завершающиеся контракты
  def five_days
    @conn = Contract.where(end_date: Time.now()..(Time.now() + 5.days))
  end

  # Получение информации о регистрирующихся пользователях
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:account_update) do |user_params|
      user_params.permit(:email, :password, :password_confirmation, :current_password, :mail, :fio )
    end
  end
end
