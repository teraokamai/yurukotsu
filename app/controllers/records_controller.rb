class RecordsController < ApplicationController
  before_action :authenticate_account!

  def index
    day_start = Time.zone.now.beginning_of_day
    day_end = Time.zone.now.end_of_day
    lastweek = day_start - 6.day

    @records = Record.where(account_id: current_account.id).order(do_on: :desc, start_at: :desc, end_at: :desc)
    @day = Record.where("account_id == ? and do_on between ? and ?", current_account.id, day_start, day_end).sum(:total)
    @week = Record.where("account_id == ? and do_on between ? and ?", current_account.id, lastweek, day_end).sum(:total)
    @all = Record.where(account_id: current_account.id).sum(:total)
    @categories = Category.where(account_id: current_account.id)
    # @records = Record.page(params[:page]).order("created_at desc")

    render :layout => "records"
  end

  def show
    @record = Record.find(params[:id])
    render :layout => "records_show"
  end

  def new
    @record = Record.new
    @record.do_on = Time.current.strftime("%Y/%m/%d")
    @record.account_id = current_account.id
    render :layout => "records_new"
  end

  def create
    @record = Record.new record_params
    if @record.save!
      redirect_to records_path
    else
      # render :layout => "records_new"
      render "new"
    end
  end

  def edit
    @record = Record.find(params[:id])
    render :layout => "records_new"
  end

  def update
    @record = Record.find(params[:id])
    if @record.update(record_params)
      redirect_to records_path
    else
      # render :layout => "records_new"
      render "edit"
    end
  end

  def destroy
    @record = Record.find(params[:id])
    @record.destroy
    redirect_to records_url
  end

  private

  def record_params
    params.require(:record).permit(:do_on, :start_at, :end_at, :summary, :content, :total, :calculation, :category_id, :account_id)
  end
end
