import 'request.dart';

class Mapper {
  final RequestInterface request;

  Mapper({required this.request});

  Future<void> map() async {
    final String url = 'https://www.dfbnet.org/coach/api/tenants/0123456789ABCDEF0123456700004120/events';
    //final String name = 'C-Lizenz Fortbildung'
    final String sectionId = '02JH75VKLS000000VS5489B6VS5JE35A';

    List<dynamic> responseData = await request.fetchData(url);
    for (var eventList in responseData) {
      eventList['events'].forEach((event) {
        if (event['section']['id'] == sectionId) {
          print(event['name']);
        }
      });
    }

  }
}
