class ContragentsController < ApplicationController

  before_action :set_cont, only: [ :show, :edit, :update, :del, :destroy]
  before_action :set_conts, only: [ :main, :view]

  def main; end

  def new
    @cont = Contragent.new
  end

  def view; end

  def dump
    @conts = Contragent.where(status: true)
  end

  def del
    @cont.update_attribute(:status, nil)
    redirect_to contragents_dump_path
  end

  def destroy
    @cont.update_attribute(:status, true)
    redirect_to contragents_view_path
  end

  def new
    @cont = Contragent.new
  end

  def create
    @cont = Contragent.new(cont_params)
    if @cont.save
      redirect_to @cont
    else
      render :new
    end
  end

  def show;end

  def update
    if @cont.update_attributes(cont_params)
      redirect_to @cont
    else
      render :edit
    end
  end

  def edit;end

  private

  def set_cont
    @cont = Contragent.find(params[:id])
  end

  def set_conts
    @conts = Contragent.where(status: nil)
  end

  def cont_params
    params.require(:contragent).permit(:name, :code, :typ, :full_name, :group, :inn, :kpp, :code_okpo, :u_address, :f_address, :tel, :other, :bank_code, :code_name, :bank_name)
  end
end
