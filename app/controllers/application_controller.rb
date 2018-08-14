class ApplicationController < ActionController::Base

  before_action :five_days

  private

  def five_days
    @conn = Contract.where(end_date: Time.now()..(Time.now() + 5.days))
  end
end
