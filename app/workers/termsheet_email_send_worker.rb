class TermsheetEmailSendWorker
  include Sidekiq::Worker
  # sidekiq_options queue: :email_send_queue

  def perform(house_loan_id, encoded_pdf)
    house_loan = HouseLoan.find(house_loan_id)
    pdf = Base64.decode64(encoded_pdf)
    HouseLoanMailer.with(house_loan: house_loan, pdf: pdf).termsheet_email.deliver_later
  end
end
