class ContractsController < ApplicationController

  before_action :set_con, only: [ :show, :edit, :update]

  def main
    @cons = Contract.where(end_date: Time.now()..'2100-09-13').order(:end_date)
  end

  def new
    @con = Contract.new
  end

  def create
    @con = Contract.new(con_params)
    if @con.save
      redirect_to @con
    else
      render :new
    end
  end

  def show; end

  def view
    @cons = Contract.where(end_date: Time.now()..'2100-09-13')
  end

  def edit; end

  def update
    if @con.update_attributes(con_params)
      redirect_to @con
    else
      render :edit
    end
  end

  def all
    @cons = Contract.where(end_date: '2000-09-13'...Time.now())
  end

  private

  def set_con
    @con = Contract.find(params[:id])
  end

  def con_params
    params.require(:contract).permit(:name, :code, :org_id, :contragent_id, :gvs, :v_gvs, :t_gvs, :o_gvs, :hvs, :v_hvs, :t_hvs, :o_hvs, :vgvs, :v_vgvs, :t_vgvs, :o_vgvs, :vhvs, :v_vhvs, :t_vhvs, :o_vhvs, :otop, :v_otop, :t_otop, :o_otop, :exp, :v_exp, :t_exp, :o_exp, :tbo, :v_tbo, :t_tbo, :o_tbo, :price, :podp_date, :end_date)
  end
end
