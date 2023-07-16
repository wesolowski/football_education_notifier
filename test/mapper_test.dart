import 'package:football_education_notifier/education_dto.dart';
import 'package:test/test.dart';
import 'package:football_education_notifier/mapper.dart';
import 'package:football_education_notifier/request.dart';

void main() {
  test('Mapper maps events correctly', () async {
    final MockRequestInterface mockRequest = MockRequestInterface();

    final Mapper mapper = Mapper(request: mockRequest);

    final responseData = [
      {
        'events': [
          {
            'section': {'id': 'unit'},
          },
          {
            'id': '02LVDVS8U8000000VS5489BCVVOMIMKB',
            'number': 'ABC123',
            'location': {
              'name': 'Event Location',
              'address': {
                'street': 'Event Street',
                'city': 'Event City',
              },
            },
            'begins': '2099-07-01T10:00:00Z',
            'openSeats': 10,
            'section': {'id': '02JH75VKLS000000VS5489B6VS5JE35A'},
          },
        ],
      },
      {
        'events': [
          {
            'id': 'unit',
            'number': 'test123',
            'location': {
              'name': 'Ttest Location',
              'address': {
                'street': 'Ttest Street',
                'city': 'Ttest City',
              },
            },
            'begins': '2099-07-01T10:00:00Z',
            'openSeats': 4,
            'section': {'id': '02JH75VKLS000000VS5489B6VS5JE35A'},
          },
          {
            'section': {'id': 'unit'},
          },
        ],
      },
    ];

    mockRequest.mockResponse = Future.value(responseData);


    final List<EducationDTO> result = await mapper.map();

    expect(result, isNotNull);
    expect(result, isA<List<EducationDTO>>());

    expect(result.length, 2);
    expect(result[0].id, '02LVDVS8U8000000VS5489BCVVOMIMKB');
    expect(result[0].number, 'ABC123');
    expect(result[0].locationName, 'Event Location');
    expect(result[0].street, 'Event Street');
    expect(result[0].city, 'Event City');
    expect(result[0].begins, DateTime.parse('2099-07-01T10:00:00Z'));
    expect(result[0].openSeats, 10);

    expect(result[1].id, 'unit');
    expect(result[1].number, 'test123');
    expect(result[1].openSeats, 4);
  });
}

// Mock RequestInterface class for testing
class MockRequestInterface implements RequestInterface {
  dynamic mockResponse;

  @override
  Future<List<dynamic>> fetchData(String url) {
    return Future.value(mockResponse);
  }
}
