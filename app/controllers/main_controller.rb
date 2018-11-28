class MainController < ApplicationController
  # Выдача администраторских прав первому пользователю
  def index
    u = User.first
    u.admin = true
    u.save
  end
end
