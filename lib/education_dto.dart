class EducationDTO {
  String id;
  String number;
  String locationName;
  String street;
  String city;
  DateTime begins;
  int openSeats;

  EducationDTO({
    required this.id,
    required this.number,
    required this.locationName,
    required this.street,
    required this.city,
    required this.begins,
    required this.openSeats,
  });
}
