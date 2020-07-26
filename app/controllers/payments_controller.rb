class PaymentsController < ApplicationController
  include Pundit
  before_action :payment, only: %i[show edit update accept decline]
  append_before_action :pundit_authorize

  def index
    @payments = Payment.all.includes(:creator, :updater, :account).order(:created_at)
  end

  def new
    @payment = Payment.new
  end

  def create
    @payment = Payment.new(payment_params)
    if @payment.save
      redirect_to :payments
    else
      render :new
    end
  end

  def update
    @payment.assign_attributes(payment_params)
    if @payment.save
      redirect_to :payments
    else
      render :edit
    end
  end

  def show; end
  def edit; end

  def accept
    if @payment.accept!
      flash[:success] = 'The payment has been accepted'
    else
      flash[:error] = @payment.errors.full_messages
    end
    redirect_to :payments
  end

  def decline
    if @payment.decline!
      flash[:success] = 'The payment has been declined'
    else
      flash[:error] = @payment.errors.full_messages
    end
    redirect_to :payments
  end

  private

  def payment_params
    params.require(:payment).permit(:amount_in_cents, :currency, :account_id, :purpose, :lock_version)
  end

  def payment
    @payment ||= Payment.find(params[:id])
  end

  def pundit_authorize
    authorize [@payment || Payment]
  end
end
