class PaymentsController < ApplicationController

  before_action :set_pay, only: [ :show, :edit, :update]
  def new
    @con = Contract.find(params[:id]) if !params[:id].nil?
    @pay = Payment.new
  end

  def services_each; end

  def services_all
    @f = 0
    @p = 0
    @date = Date.civil(params[:month]["month(1i)"].to_i,
                       params[:month]["month(2i)"].to_i,
                       params[:month]["month(3i)"].to_i)
    @con = Contract.where(end_date: @date.to_s..'2100-09-13', podp_date: '2000-09-13'..(@date + 1.month).to_s)
    @pays = Payment.where(month: @date)
    @con.each { |n| @p += n.price }
    @pays.each { |n| @f += n.summ }
  end

  def plan_all
    @f = 0
    @p = 0
    @date = Date.civil(params[:month]["month(1i)"].to_i,
                       params[:month]["month(2i)"].to_i,
                       params[:month]["month(3i)"].to_i)
    @con = Contract.where(end_date: @date.to_s..'2100-09-13', podp_date: '2000-09-13'..(@date + 1.month).to_s)
    @pays = Payment.where(month: @date)
    @con.each { |n| @p += n.price }
    @pays.each { |n| @f += n.summ }
  end

  def plan_each; end

  def create
    @pay = Payment.new(pay_params)
    if @pay.save
      redirect_to @pay
    else
      render :new
    end
  end

  def show; end

  def view
    @pays = Payment.all
  end

  def edit; end

  def update
    if @pay.update_attributes(pay_params)
      redirect_to @pay
    else
      render :edit
    end
  end
  private

  def set_pay
    @pay = Payment.find(params[:id])
  end

  def pay_params
    params.require(:payment).permit(:number, :date, :month, :contract_id, :bank, :summ)
  end

end
