import 'package:dotenv/dotenv.dart';
import 'package:football_education_notifier/education_email_sender.dart';
import 'package:football_education_notifier/info_file.dart';
import 'package:football_education_notifier/mail_send.dart';
import 'package:football_education_notifier/notification.dart';
import 'package:football_education_notifier/request.dart';
import 'package:football_education_notifier/mapper.dart';

void main() {

  final DotEnv env = DotEnv(includePlatformEnvironment: true)..load();

  final Request request = Request();
  final Mapper mapper = Mapper(request: request);
  final InfoFile infoFile = InfoFile('check_event.json');
  final MailSend mailSend = MailSend();
  final EducationEmailSender educationEmailSender = EducationEmailSender(mailSend: mailSend, env: env);
  final Notification notification = Notification(mapper: mapper, infoFile: infoFile, educationEmailSender: educationEmailSender);

  notification.check();
}
