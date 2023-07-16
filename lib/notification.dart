import 'package:football_education_notifier/education_dto.dart';
import 'package:football_education_notifier/education_email_sender.dart';
import 'package:football_education_notifier/info_file.dart';
import 'package:football_education_notifier/mapper.dart';

class Notification {
  final MapperInterface mapper;
  final InfoFileInterface infoFile;
  final EducationEmailSenderInterface educationEmailSender;

  Notification({required this.mapper, required this.infoFile, required this.educationEmailSender });

  check() async {
    var educationList = await mapper.map();
    var infoList = infoFile.getContent();

    List<EducationDTO> educationListToSend = [];

    for (EducationDTO educationDto in educationList) {
      if (infoList.contains(educationDto.id)) {
        continue;
      }

      educationListToSend.add(educationDto);

      infoList.add(educationDto.id);
    }

    if (educationListToSend.isNotEmpty) {
      educationEmailSender.sendEmail(educationListToSend);
    }

    infoFile.setContent(infoList);

  }
}
