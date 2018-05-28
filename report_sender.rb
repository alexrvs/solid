class ReportSender

  def initialize(report, account)
    @report = report
    @account = account
  end


  def send_report(way_of_sending = :email)
    case way_of_sending
    when :email
      Mailer.deliver(
        from: 'foo@bar.com',
        to: @account.email,
        subject: 'Report',
        body: @report
      )
    when :sms
      client = Twilio::REST::Client.new('ACXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX', @account.auth_token)
      client.account.messages.create(
         from: '+66613371337',
         to: @account.phone,
         body: @report
      )
    end
  else
    raise NotImpelementedError

  end

end


class ReportGenerator
end


report = ReportGenerator.new(data).generate
ReportSender.new(report, account).send_report(:sms)
