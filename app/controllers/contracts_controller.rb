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
    @con.created_by = current_user.fio
    @con.last_cb = current_user.fio
    @con.price_nds = @con.price * (@con.nds.to_i * 0.01)
    @con.price_name = RuPropisju.rublej(@con.price + @con.price_nds)
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
    @con.last_cb = current_user.fio
    if @con.update_attributes(con_params)
      @con.price_nds = @con.price * (@con.nds.to_i * 0.01)
      @con.price_name = RuPropisju.rublej(@con.price + @con.price_nds)
      @con.gvs = nil if @con.v_gvs.nil?
      @con.hvs = nil if @con.v_hvs.nil?
      @con.vgvs = nil if @con.v_vgvs.nil?
      @con.vhvs = nil if @con.v_vhvs.nil?
      @con.otop = nil if @con.v_otop.nil?
      @con.exp = nil if @con.v_exp.nil?
      @con.tbo = nil if @con.v_tbo.nil?
      @con.save
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
    params.require(:contract).permit(:name, :code, :org_id, :contragent_id, :gvs, :v_gvs, :t_gvs, :o_gvs, :hvs, :v_hvs, :t_hvs, :o_hvs, :vgvs, :v_vgvs, :t_vgvs, :o_vgvs, :vhvs, :v_vhvs, :t_vhvs, :o_vhvs, :otop, :v_otop, :t_otop, :o_otop, :exp, :v_exp, :t_exp, :o_exp, :tbo, :v_tbo, :t_tbo, :o_tbo, :price, :nds, :kod_p, :innkpp, :rsch, :bank, :ksch, :bik, :u_address, :tel, :p_address, :podp_date, :end_date)
  end
end
