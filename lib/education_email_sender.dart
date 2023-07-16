import 'package:dotenv/dotenv.dart';
import 'package:football_education_notifier/education_dto.dart';
import 'package:football_education_notifier/mail_send.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:intl/intl.dart';

abstract class EducationEmailSenderInterface {
  Future<String> sendEmail(List<EducationDTO> educationList);
}

class EducationEmailSender implements EducationEmailSenderInterface {

  final MailSendInterface mailSend;
  final DotEnv env;

  EducationEmailSender({required this.mailSend, required this.env});

  @override
  Future<String> sendEmail(List<EducationDTO> educationList) async {

    final email = env['GMAIL_SMTP_EMAIL'];
    final password = env['GMAIL_SMTP_PASSWORD'];
    final emailTo = env['EMAIL_TO'];

    if (email == null || password == null || emailTo == null) {
      throw Exception('No email, password or email_to found in .env file');
    }

    final SmtpServer smtpServer = gmail(email, password);

    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd').format(now);

    final message = Message()
      ..from = Address(email, 'Football Education Bot')
      ..recipients.add(emailTo)
      ..subject = 'Fussball Fortbildung | $formattedDate'
      ..html =
          "<h2>Fussball Fortbildung</h2>\n${formatEducationList(educationList)}";

    try {
      final sendReport = await mailSend.mail(message, smtpServer);
      return sendReport.toString();
    } on MailerException catch (e) {
      return e.message;
    }
  }

  String formatEducationList(List<EducationDTO> educationList) {
    final StringBuffer buffer = StringBuffer();

    for (final education in educationList) {
      buffer.writeln('<p></p>');
      buffer.writeln('<br />');
      buffer.writeln('<p>Bildungsangebot ${education.number}</p>');
      buffer.writeln('<p>Ort: ${education.locationName}</p>');
      buffer.writeln('<p>Adresse: ${education.street}, ${education.city}</p>');
      buffer.writeln('<p>Beginn: ${DateFormat('yyyy-MM-dd HH:mm').format(education.begins)}</p>');
      buffer.writeln('<p>Freie Plätze: ${education.openSeats}</p>');
      buffer.writeln('<p>Link: <a href="${education.url}">Anmelden</a></p>');
      buffer.writeln('<p>----------------</p>');

      buffer.writeln();
    }

    return buffer.toString();
  }
}
