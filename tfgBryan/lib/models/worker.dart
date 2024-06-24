import 'dart:convert';

class Worker {
  int? id;
  String? imagePath;
  String? firsName;
  String? lastName;
  String? email;
  String? dateOfBirth;
  String? phone;
  String? address;

  Worker({
    required this.id,
    required this.imagePath,
    required this.firsName,
    required this.lastName,
    required this.email,
    required this.dateOfBirth,
    required this.phone,
    required this.address,
  });

  factory Worker.fromJson(Map<String, dynamic> json) => Worker(
        id: json['ID'] ?? '',
        imagePath: json['ImagePath'] ?? '',
        firsName: json['FirstName'] ?? '',
        lastName: json['LastName'] ?? '',
        email: json['Email'] ?? '',
        dateOfBirth: json['DateOfBirth'] ?? '',
        phone: json['Phone'] ?? '',
        address: json['Address'] ?? '',
      );

  factory Worker.fromRawJson(String s) => Worker.fromJson(json.decode(s));

  @override
  String toString() {
    return 'Worker{id: $id, imagePath: $imagePath, firsName: $firsName, lastName: $lastName, email: $email, dateOfBirth: $dateOfBirth, phone: $phone, address: $address}';
  }
}
