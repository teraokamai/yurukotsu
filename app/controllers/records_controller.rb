class RecordsController < ApplicationController
  # before_action :set_board_message, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_account!
  # layout "records"

  def index # それぞれの条件にあわせて取得する
    @records = Record.all.order(created_at: :desc)
    @day = Record.all.sum(:total)
    @week = Record.all.sum(:total)
    @all = Record.all.sum(:total)
    # @records = Record.page(params[:page]).order("created_at desc")
    # users = BoardUser.where("account_id == ?", current_account.id)
    # if users[0] == nil
    #   record = BoardUser.new
    #   record.account_id = current_account.id
    #   record.nickname = "<<no name>>"
    #   record.save
    #   records = BoardUser.where "account_id == ?", current_account.id
    # end
    # @record = users[0]
    # @record = Record.new
    # @record.record_user_id = @record_user.id
    render :layout => "records"
  end

  def show
    @record = Record.find(params[:id])
    render :layout => "records_show"
  end

  def new
    @record = Record.new
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
