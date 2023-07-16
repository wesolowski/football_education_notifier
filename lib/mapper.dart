import 'package:football_education_notifier/education_dto.dart';
import 'request.dart';

class Mapper {
  final RequestInterface request;

  Mapper({required this.request});

  Future<List<EducationDTO>> map() async {

    List<EducationDTO> educationList = [];
    final String url = 'https://www.dfbnet.org/coach/api/tenants/0123456789ABCDEF0123456700004120/events';
    //final String name = 'C-Lizenz Fortbildung'
    final String sectionId = '02JH75VKLS000000VS5489B6VS5JE35A';

    List<dynamic> responseData = await request.fetchData(url);
    for (var eventList in responseData) {
      eventList['events'].forEach((event) {
        if (event['section']['id'] == sectionId) {
          EducationDTO educationDTO = EducationDTO(
            id: event['id'],
            number: event['number'],
            locationName: event['location']['name'],
            street: event['location']['address']['street'],
            city: event['location']['address']['city'],
            begins: DateTime.parse(event['begins']),
            openSeats: event['openSeats'],
          );

          educationList.add(educationDTO);
        }
      });
    }

    return educationList;
  }
}
