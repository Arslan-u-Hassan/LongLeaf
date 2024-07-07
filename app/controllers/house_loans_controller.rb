class HouseLoansController < ApplicationController
  def new
    @house_loan = HouseLoan.new
  end

  def create
    @house_loan = HouseLoan.new(loan_params)
    if @house_loan.save
      LoanCalculateService.new(@house_loan).cal
      redirect_to new_house_loan_path, notice: 'House Loan calculated and termsheet sent to your email.'
    else
      render :new
    end
  end

  private

  def loan_params
    params.require(:house_loan).permit(:address, :loan_term, :purchase_price, :repair_budget, :after_repair_value, :name, :email, :phone)
  end
end
