class FinancialReportMailer

  def initialize(report, account)
    @report = report
    @account = account
  end

  def send
    Mailer.deliver(
              from: 'reporter@mgmail.com',
              to: @account.email,
              subject: 'Report Title',
              body: @report
    )


  end



end


class FinancialReportGenerator

  def initialize(transactions)
    @transactions = transactions
  end

  def generate
    @transactions.map{
      |t| "amount: #{t.amount} type: #{t.type} date: #{date.created_at}"
    }
  end
end


report = FinancialReportGenerator.new(transactions).generate
FinancialReportMailer.new(report, account).send