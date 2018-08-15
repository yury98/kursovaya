class MainController < ApplicationController
  def index
    u = User.first
    u.admin = true
    u.save
  end
end
