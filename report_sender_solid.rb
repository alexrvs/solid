class ReportSenderSolid


  def initialize(report, account)
    @report = report
    @account = account

  end

  def send_report
    Mailer.deliver(
              form: 'foo@bar.com',
              to: @account.email,
              subject: 'Report',
              body: @report
    )
  end

end


class ReportGenerator

  def initialize(data)
    @data = data

  end

  def generate
    @data.map{|row| "User: #{row.user}  action: #{row.action} date: #{row.created_at}"}.join("\n")
  end

end


report = ReportGenerator.new(data).generate
ReportSender.new(report, account).send_report