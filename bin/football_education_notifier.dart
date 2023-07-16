import 'package:football_education_notifier/request.dart';
import 'package:football_education_notifier/mapper.dart';

void main() {
  final request = Request();
  final mapper = Mapper(request: request);

  mapper.map();

}
