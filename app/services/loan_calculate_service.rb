class LoanCalculateService
  MONTHLY_INTEREST_RATE = 0.13 / 12

  def initialize(house_loan)
    @house_loan = house_loan
  end

  def cal
    loan_amount = calculate_loan_amount(@house_loan.purchase_price, @house_loan.after_repair_value)
    interest_expense = calculate_interest_expense(loan_amount, @house_loan.loan_term)
    profit = (@house_loan.after_repair_value - loan_amount - interest_expense).round(2)
    pdf = generate_pdf(@house_loan, loan_amount, profit)
    encoded_pdf = Base64.encode64(pdf)
    TermsheetEmailSendWorker.perform_async(@house_loan.id, encoded_pdf)
  end

  private

  def calculate_loan_amount(purchase_price, after_repair_value)
    max_by_purchase_price = purchase_price * 0.90
    max_by_arv = after_repair_value * 0.70
    [max_by_purchase_price, max_by_arv].min
  end

  def calculate_interest_expense(loan_amount, loan_term)
    total_interest_expense = MONTHLY_INTEREST_RATE * loan_amount * loan_term
    total_interest_expense.round(2)
  end

  def generate_pdf(loan, loan_amount, profit)
    Prawn::Document.new do |pdf|
      pdf.text "Term Sheet"
      pdf.text "Name: #{loan.name}"
      pdf.text "Email: #{loan.email}"
      pdf.text "Phone: #{loan.phone}"
      pdf.text "Address: #{loan.address}"
      pdf.text "Loan Term: #{loan.loan_term} months"
      pdf.text "Purchase Price: $#{loan.purchase_price}"
      pdf.text "Repair Budget: $#{loan.repair_budget}"
      pdf.text "After Repair Value: $#{loan.after_repair_value}"
      pdf.text "Calculated Loan Amount: $#{loan_amount}"
      pdf.text "Estimated Profit: $#{profit}"
    end.render
  end
end
