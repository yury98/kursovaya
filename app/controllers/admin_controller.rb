class AdminController < ApplicationController
  before_action :adm
  skip_before_action :verify_authenticity_token, only: :new
  def stats
    @us = User.all
  end

  def info
    if InfoAdmin.all.length.zero?
      @info = InfoAdmin.new
    else
      @info = InfoAdmin.last
    end
  end

  def new
    @info = InfoAdmin.new(info_params)
    if @info.save
      redirect_to main_index_path
    else
      render :info
    end
  end

  private

  def adm
    if current_user.admin == false
      redirect_to main_index_path
    end
  end

  def info_params
    params.require(:info_admin).permit(:post, :address, :tel, :destination, :trans, :fil, :bik, :ksch, :innkpp, :gruz, :addressg, :dir, :main_buh)
  end
end
