class NoticeMailer < ApplicationMailer
  def sendmail_topic(topic)
    @topic = topic

    mail to: "kouhik06@gmail.com",
      subject: '【clonebook】新規投稿されました'
  end
end
