import 'dart:convert';

class ContactModel {
  // this is the contact model
  // it will be used to create a contact object
  // the contact object will be used to create a contact card
  final String id;
  final String name;
  final String phone;
  final String email;
  final String address;

  ContactModel({
    required this.id,
    required this.name,
    required this.phone,
    required this.email,
    required this.address,
  });
  

  Map<String, dynamic> toMap() {
    // this function will convert the contact object to a map
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'email': email,
      'address': address,
    };
  }

  factory ContactModel.fromMap(Map<String, dynamic> map) {
    return ContactModel(
    // this function will convert the map to a contact object
      id: map['id'],
      name: map['name'],
      phone: map['phone'],
      email: map['email'],
      address: map['address'],
    );
  }
  // this function will convert the contact object to a json string
  String toJson() => json.encode(toMap());

  // this function will convert the json string to a contact object
  factory ContactModel.fromJson(String source) => ContactModel.fromMap(json.decode(source));

  @override
  String toString() {
    // this function will return a string representation of the contact object
    return 'ContactModel(id: $id, name: $name, phone: $phone, email: $email, address: $address)';
  }

  @override
  bool operator ==(Object other) {
    // this function will check if two contact objects are equal
    if (identical(this, other)) return true;
  
    return other is ContactModel &&
      other.id == id &&
      other.name == name &&
      other.phone == phone &&
      other.email == email &&
      other.address == address;
  }

  @override
  int get hashCode {
    // if the hashcodes are equal, then the two contact objects are equal
    // this will prevent duplicate contact objects in the list
    return id.hashCode ^
      name.hashCode ^
      phone.hashCode ^
      email.hashCode ^
      address.hashCode;
  }
}
