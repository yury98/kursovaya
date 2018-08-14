class OrgsController < ApplicationController

  before_action :set_org, only: [ :show, :edit, :update, :del, :destroy]
  before_action :set_orgs, only: [ :main, :view]

  def main; end

  def contracts
    @con = Contract.where(org_id: params[:id]).order(:end_date)
  end

  def new
    @org = Org.new
  end

  def view; end

  def dump
    @orgs = Org.where(status: true)
  end

  def del
    @org.update_attribute(:status, nil)
    redirect_to orgs_dump_path
  end

  def destroy
    @org.update_attribute(:status, true)
    redirect_to orgs_view_path
  end

  def create
    @org = Org.new(org_params)
    if @org.save
      redirect_to @org
    else
      render :new
    end
  end

  def show; end

  def edit; end

  def update
    if @org.update_attributes(org_params)
      redirect_to @org
    else
      render :edit
    end
  end

  private

  def set_org
    @org = Org.find(params[:id])
  end

  def set_orgs
    @orgs = Org.where(status: nil)
  end

  def org_params
    params.require(:org).permit(:name, :code, :person, :typ, :full_name, :small_name, :usedge, :account, :u_address, :f_address, :foreign, :square, :people, :space_fp)
  end
end
