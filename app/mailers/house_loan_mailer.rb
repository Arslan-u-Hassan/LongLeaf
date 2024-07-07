class HouseLoanMailer < ApplicationMailer
  default from: 'mirzag1007@gmail.com'

  def termsheet_email
    @house_loan = params[:house_loan]
    attachments['termsheet.pdf'] = params[:pdf]
    mail(to: @house_loan.email, subject: 'Your Loan Term Sheet')
  end
end
