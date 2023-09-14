import 'package:flutter/material.dart';

class ContactListCard extends StatelessWidget {
  const ContactListCard({
    super.key,
    required this.name,
    required this.phone,
  });
  final String name;
  final String phone;

  @override
  Widget build(BuildContext context) {
    //  contact list card 
    // this is the card that will be displayed in the contact list
    // it will display the name and phone number of the contact
    
    return Card(
      child: ListTile(
        title: Text(name),
        subtitle: Text(phone),
        leading: const CircleAvatar(
          child: Icon(Icons.person),
        ),
      ),
    );
  }
}
