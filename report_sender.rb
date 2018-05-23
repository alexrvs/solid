class ReportSender

  def initialize(data, account)
    @data = data
    @account = account
    @report = ''

  end

  def generate_report!
    @report = @data.map {|row| "User: #{row.user} action: #{row.action} date: #{row.created_at}"}.join("\n")
  end

  def send_report
    Mailer.deliver(
              from: 'foo@bar.com',
              to: @account.email,
              subject: 'Report',
              body: @report
    )

  end

end

report_sender = ReportSender.new(data, account)
report_sender.generate_report!
report_sender.send_report
