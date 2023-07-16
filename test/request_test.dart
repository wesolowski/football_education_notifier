import 'package:test/test.dart';

import 'package:football_education_notifier/request.dart';


void main() {
  test('Fetch data test', () async {
    final request = Request();

    final url = 'https://www.dfbnet.org/coach/api/tenants/0123456789ABCDEF0123456700004120/events';
    var responseData = await request.fetchData(url);

    expect(responseData.isNotEmpty, true);
    expect(responseData[0].containsKey('id'), true);
  });

  test('Exception test', () async {
    final request = Request();

    final url = 'https://www.googleapis.com/';
    expect(() async => await request.fetchData(url), throwsException);
  });
}
