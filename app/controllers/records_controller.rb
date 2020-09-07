class RecordsController < ApplicationController
  # before_action :set_board_message, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_account!
  # layout "records"

  def index # それぞれの条件併せて取得する
    @records = Record.all.order(created_at: :desc)
    # @day_time = Record.all
    # @week_time = Record.all
    # @all_time = Record.all
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
  end

  def show
    @record = target_record(params[:id])
  end

  def new
    @record = Record.new
  end

  def create
    @record = Record.new record_params
    @record.save!
    redirect_to @record
  end

  def edit
    @record = target_record(params[:id])
  end

  def update
    @record = target_record(params[:id])
    @record.update(record_params)
    redirect_to @record
  end

  def destroy
    @task = target_record(params[:id])
    @task.destroy
    redirect_to records_url
  end

  private

  def target_record(record_user_id)
    current_account.tasks.where(id: record_id).take
  end

  def record_params
    params.require(:record).permit(:do_on, :start_at, :end_at, :sammary, :content, :total, :calculation, :category_id, :account_id)
  end
end
