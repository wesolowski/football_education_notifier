import 'package:dotenv/dotenv.dart';
import 'package:football_education_notifier/education_dto.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:test/test.dart';
import 'package:football_education_notifier/education_email_sender.dart';
import 'package:football_education_notifier/mail_send.dart';
import 'package:intl/intl.dart';

void main() {
  group('EducationEmailSender', () {

    late DotEnv env;

    setUp(() {
      env = DotEnv();
      env.load(['.env.test']);
    });

    tearDown(() {
      env.clear();
    });

    test('throw exception when environment is not set.', () async {
        var testData = [
          {
            'GMAIL_SMTP_PASSWORD': 'unit',
            'EMAIL_TO': 'unit'
          },
          {
            'GMAIL_SMTP_EMAIL': 'unit',
            'EMAIL_TO': 'unit'
          },
          {
            'GMAIL_SMTP_EMAIL': 'unit',
            'GMAIL_SMTP_PASSWORD': 'unit',
          },
        ];

        for (var data in testData) {
          env.clear();
          env.addAll(data);

          final EducationEmailSender educationEmailSender = EducationEmailSender(
            mailSend: SpyMailSend(),
            env: env,
          );
          expect(() => educationEmailSender.sendEmail([]), throwsException);
        }
    });


    test('check info for email', () async {

      List<EducationDTO> educationList = [];
      educationList.add(EducationDTO(
        id: '02LVDVS8U8000000VS5489BCVVOMIMKB',
        number: 'ABC123',
        locationName: 'Event Location',
        street: 'Event Street',
        city: 'Event City',
        begins: DateTime.parse('2099-07-01T10:00:00Z'),
        openSeats: 10,
        url: 'https://www.google.com',
      ));
      educationList.add(EducationDTO(
        id: 'unit',
        number: 'test',
        locationName: 'Unit Location',
        street: 'Unit Street',
        city: 'Unit City',
        begins: DateTime.parse('2099-01-01T12:00:00Z'),
        openSeats: 1,
        url: 'https://www.google.com',
      ));

      final SpyMailSend spyMailSend = SpyMailSend();

      final EducationEmailSender educationEmailSender = EducationEmailSender(
        mailSend: spyMailSend,
        env: env,
      );

      educationEmailSender.sendEmail(educationList);

      expect(spyMailSend.smtpServer.host, 'smtp.gmail.com');
      expect(spyMailSend.smtpServer.username, 'unit@test.com');
      expect(spyMailSend.smtpServer.password, 'YOUR_PASSWORD');

      expect(spyMailSend.message.from.mailAddress, 'unit@test.com');
      expect(spyMailSend.message.from.name, 'Football Education Bot');
      expect(spyMailSend.message.recipients[0], 'send_to@test.com');

      DateTime now = DateTime.now();
      String formattedDate = DateFormat('yyyy-MM-dd').format(now);

      expect(spyMailSend.message.subject, 'Fussball Fortbildung | $formattedDate');

      for (final education in educationList) {
        expect(spyMailSend.message.html, contains('Bildungsangebot ${education.number}'));
        expect(spyMailSend.message.html, contains('Ort: ${education.locationName}'));
        expect(spyMailSend.message.html, contains('Adresse: ${education.street}, ${education.city}'));
        expect(spyMailSend.message.html, contains('Beginn: ${DateFormat('yyyy-MM-dd HH:mm').format(education.begins)}'));
        expect(spyMailSend.message.html, contains('Freie Plätze: ${education.openSeats}'));
      }
    });
  });
}

class SpyMailSend implements MailSendInterface {
  late Message message;
  late SmtpServer smtpServer;

  @override
  Future<String> mail(Message message, SmtpServer smtpServer) async {
    this.message = message;
    this.smtpServer = smtpServer;

    return 'success';
  }
}
