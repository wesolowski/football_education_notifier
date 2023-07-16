import 'package:football_education_notifier/education_dto.dart';
import 'package:football_education_notifier/request.dart';
import 'package:football_education_notifier/mapper.dart';

void main() {
  final request = Request();
  final mapper = Mapper(request: request);

  var educationListFuture = mapper.map();
  educationListFuture.then((educationList) {
    for (EducationDTO educationDto in educationList) {
      print(educationDto.locationName);
    }

  });


}
