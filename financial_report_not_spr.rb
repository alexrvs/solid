class Mailer; end

class FinancialReportMailer

  def initialize(transactions, account)
    @transactions = transactions
    @account = account
    @report = ''
  end

  def generate_report!
    @report = @transactions.map{
      |t| "amount: #{t.amount} type: #{t.type}  date: #{t.created_at}"
    }
  end

  def send_report
    Mailer.deliver(
              from: 'foo@bar.com',
              to: @account.email,
              subject: 'Your Report',
              body: @report
    )

  end


end

mailer = FinancialReportMailer.new(transactions, account)
mailer.generate_report!
mailer.send_report