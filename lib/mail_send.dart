import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

abstract class MailSendInterface {
  Future<String> mail(Message message, SmtpServer smtpServer);
}

class MailSend implements MailSendInterface{

  Future<String> mail(Message message, SmtpServer smtpServer) async {
    try {
      final sendReport = await send(message, smtpServer);
      return sendReport.toString();
    } on MailerException catch (e) {
      return e.message;
    }
  }
}
