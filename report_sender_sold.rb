class EmailSender; end

class Mailer; end

class ReportSender

  def initialize(report, account)
    @report = report
    @account = account
  end

  def send_report(sender = EmailSender.new)
    sender.send(@account)
  end
end



class ReportGenerator
  data = {"widget": {
      "debug": "on",
      "window": {
          "title": "Sample Konfabulator Widget",
          "name": "main_window",
          "width": 500,
          "height": 500
      },
      "image": {
          "src": "Images/Sun.png",
          "name": "sun1",
          "hOffset": 250,
          "vOffset": 250,
          "alignment": "center"
      },
      "text": {
          "data": "Click Here",
          "size": 36,
          "style": "bold",
          "name": "text1",
          "hOffset": 250,
          "vOffset": 100,
          "alignment": "center",
          "onMouseUp": "sun1.opacity = (sun1.opacity / 100) * 90;"
      }
  }}

end

class Sender

  def send(account)
    raise NotImplementError
  end

end


class EmailSender < Sender

  def send(account)
    Mailer.deliver(
        from: 'foo@bar.com',
        to: @account.email,
        subject: 'Report',
        body: @report
    )
  end

end


class SmsSender < Sender

  def send(account)
    client = Twilio::REST::Client.new('ACXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX', account.auth_token)
    client.account.messages.create(
        from: '+66613371337',
        to: @account.phone,
        body: @report
    )
  end

end


report = ReportGenerator.new(data).generate
ReportSender.new(report, account).send_report(SmsSender.new)
