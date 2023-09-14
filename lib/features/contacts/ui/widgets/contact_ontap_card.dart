import 'package:flutter/material.dart';

class ContactOntapCard extends StatelessWidget {
  const ContactOntapCard(
      {super.key,
      required this.name,
      required this.phone,
      required this.email,
      required this.address});
  final String name;
  final String phone;
  final String email;
  final String address;

  @override
  Widget build(BuildContext context) {
    // contact ontap card
    // this is the card that will be displayed when a contact is tapped
    // it will display the name, phone number, email and address of the contact
    
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Card(
          child: SizedBox(
            width: 300,
            height: 300,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const CircleAvatar(
                  radius: 35,
                  child: Icon(Icons.person, size: 45),
                ),
                Text(
                  name,
                  style: const TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 10),
                const Text("Contact info:",
                    style:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
                Text(
                  phone,
                  style: const TextStyle(
                      fontSize: 17, fontWeight: FontWeight.w600),
                ),
                Text(
                  email,
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.w500),
                ),
                Text(
                  address,
                  style: const TextStyle(fontSize: 15),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
