require_relative 'payment_report'

class PaymentsController < ApplicationController

  before_action :set_pay, only: [ :show, :edit, :update, :paid]

  def new
    @con = Contract.find(params[:id]) if !params[:id].nil?
    @pay = Payment.new
  end

  def services_each; end

  # Для отображения статистики по услугам за указанный месяц
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

  # Для отображения статистики по контрактам за указанный месяц
  def plan_all
    @f = 0
    @p = 0
    @date = Date.civil(params[:month]["month(1i)"].to_i,
                       params[:month]["month(2i)"].to_i,
                       params[:month]["month(3i)"].to_i)
    @con = Contract.where(end_date: @date.to_s..'2100-09-13', podp_date: '2000-09-13'..(@date + 1.month).to_s)
    @pays = Payment.where(month: @date)
    @con.each { |n| @p += n.price + n.price_nds }
    @pays.each { |n| @f += n.summ }
  end

  def plan_each; end

  # Для формирования печатной версии счета
  def download
    name = params[:number]
    # Удаление сущестующей печатной версии отчета с таким же именем, если он существует
    File.delete("#{Rails.root}/public/#{name}.docx") if File.file?("#{Rails.root}/public/#{name}.docx")
    pay = Payment.where(file_name: name).first
    con = Contract.where(id: pay.contract_id).first
    mas = []
    # Проверка по каждой услуге и занесение в массив

    if con.gvs == 'true'
      mass = []
      mass << 'gvs'
      mass << con.v_gvs
      mass << con.t_gvs
      mass << con.o_gvs
      mas << mass
    end
    if con.hvs == 'true'
      mass = []
      mass << 'hvs'
      mass << con.v_hvs
      mass << con.t_hvs
      mass << con.o_hvs
      mas << mass
    end
    if con.vgvs == 'true'
      mass = []
      mass << 'vgvs'
      mass << con.v_vgvs
      mass << con.t_vgvs
      mass << con.o_vgvs
      mas << mass
    end
    if con.vhvs == 'true'
      mass = []
      mass << 'vhvs'
      mass << con.v_vhvs
      mass << con.t_vhvs
      mass << con.o_vhvs
      mas << mass
    end
    if con.otop == 'true'
      mass = []
      mass << 'otop'
      mass << con.v_otop
      mass << con.t_otop
      mass << con.o_otop
      mas << mass
    end
    if con.exp == 'true'
      mass = []
      mass << 'exp'
      mass << con.v_exp
      mass << con.t_exp
      mass << con.o_exp
      mas << mass
    end
    if con.tbo == 'true'
      mass = []
      mass << 'tbo'
      mass << con.v_tbo
      mass << con.t_tbo
      mass << con.o_tbo
      mas << mass
    end
    # Сборка файла
    PaymentReport.new.make_file(name, pay, mas)
    # Отправка файла
    send_file("#{Rails.root}/public/#{name}.docx")
  end

  # Простановка счета оплаченным
  def paid
    @pay.paid = true
    @pay.summ = Contract.find(@pay.contract_id).price + Contract.find(@pay.contract_id).price_nds + @pay.perep
    @pay.save
    redirect_to payments_view_path
  end

  def create
    @pay = Payment.new(pay_params)
    @pay.created_by = current_user.fio
    @pay.last_cb = current_user.fio
    @pay.file_name = @pay.number
    @pay.summ = 0
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
    @pay.last_cb = current_user.fio
    @pay.file_name = @pay.number
    if @pay.update_attributes(pay_paramss)
      @pay.summ = 0 if @pay.paid != true
      @pay.summ = Contract.find(@pay.contract_id).price + Contract.find(@pay.contract_id).price_nds + @pay.perep if @pay.paid == true
      @pay.save
      redirect_to @pay
    else
      render :edit
    end
  end

  private

  def set_pay
    @pay = Payment.find(params[:id])
  end

  def pay_paramss
    params.require(:payment).permit(:number, :date, :month, :nazn, :perep)
  end

  def pay_params
    params.require(:payment).permit(:number, :date, :month, :contract_id, :nazn, :perep)
  end
end
