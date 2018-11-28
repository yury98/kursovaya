class OrgsController < ApplicationController

  before_action :set_org, only: [ :show, :edit, :update, :del, :destroy]
  before_action :set_orgs, only: [ :main, :view]

  def main; end

  # Для отображения контрактов по организации
  def contracts
    @con = Contract.where(org_id: params[:id]).order(:end_date)
  end

  def new
    @org = Org.new
  end

  def view; end

  # Для отображения корзины
  def dump
    @orgs = Org.where(status: true)
  end

  # Для восстановления из корзины
  def del
    @org.update_attribute(:status, nil)
    redirect_to orgs_dump_path
  end

  # Для удаления организации из списка
  def destroy
    @org.update_attribute(:status, true)
    redirect_to orgs_view_path
  end

  def create
    @org = Org.new(org_params)
    @org.created_by = current_user.fio
    @org.last_cb = current_user.fio
    if @org.save
      redirect_to @org
    else
      render :new
    end
  end

  def show; end

  def edit; end

  def update
    @org.last_cb = current_user.fio
    if @org.update_attributes(org_params)
      redirect_to @org
    else
      render :edit
    end
  end

  private

  # Поиск организации
  def set_org
    @org = Org.find(params[:id])
  end

  # Показ неудаленных организаций
  def set_orgs
    @orgs = Org.where(status: nil)
  end

  # Получение параметров организации
  def org_params
    params.require(:org).permit(:name, :code, :person, :typ, :full_name, :small_name, :usedge, :account, :u_address, :f_address, :foreign, :square, :people, :space_fp)
  end
end
