class EducationDTO {
  final String id;
  final String number;
  final String locationName;
  final String street;
  final String city;
  final DateTime begins;
  final int openSeats;
  final String url;

  EducationDTO({
    required this.id,
    required this.number,
    required this.locationName,
    required this.street,
    required this.city,
    required this.begins,
    required this.openSeats,
    required this.url,
  });
}
