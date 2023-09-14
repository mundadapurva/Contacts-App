import 'package:contacts_app/core/api_service/contact_service/contact_service.dart';
import 'package:contacts_app/core/api_service/contact_service/models/contact_model.dart';
import 'package:contacts_app/features/contacts/bloc/contacts_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

class ContactForm extends StatelessWidget {
  ContactForm({super.key});

  // create a global key that uniquely identifies the Form widget
  final _formKey = GlobalKey<FormState>();

  // create text controllers
  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _phoneController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //  this is the contact form page
    // it will display a form that will allow the user to enter their contact information

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text(
            'Contact Form',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w400),
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(16),
            ),
          ),
        ),
        body: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: <Widget>[
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: _nameController,
                keyboardType: TextInputType.name,
                maxLength: 30,
                decoration: const InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                  counter: Offstage(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _phoneController,
                keyboardType: TextInputType.number,
                maxLength: 10,
                decoration: const InputDecoration(
                  labelText: 'Phone',
                  border: OutlineInputBorder(),
                  counter: Offstage(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your phone number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                maxLength: 320,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                  counter: Offstage(),
                ),
                validator: (value) {
                  if ((value == null || value.isEmpty) ||
                      !isEmailValid(value)) {
                    return 'Please enter your email address';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _addressController,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: const InputDecoration(
                  labelText: 'Address',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your address';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  textStyle: const TextStyle(fontSize: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () async {
                  // validate the form
                  if (_formKey.currentState!.validate()) {
                    final exists = await ContactApiService()
                        .checkIfContactExists(_phoneController.text);
                    if (!exists) {
                      // if the contact already exists, show an alert
                      // ignore: use_build_context_synchronously
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Alert'),
                            content: const Text('This contact already exists!'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('OK'),
                              ),
                            ],
                          );
                        },
                      );
                      return;
                    }
                    // ignore: use_build_context_synchronously
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Processing Data')),
                    );
                    final contact = ContactModel(
                      id: const Uuid().v4(), // generate a random id
                      name: _nameController.text, // get the name
                      phone: _phoneController.text, // get the phone number
                      email: _emailController.text, // get the email
                      address: _addressController.text, // get the address
                    );

                    // add the contact to the database
                    // the contact will be added to the database and the contact list will be updated
                    BlocProvider.of<ContactsBloc>(context)
                        .add(CreateContact(contact));
                    Navigator.of(context).pop();
                  }
                },
                child: const Text(
                  'Submit',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ],
          ),
        ));
  }
}

bool isEmailValid(String email) {
  // Define a regular expression pattern for a valid email address.
  // This pattern checks for a sequence of characters, followed by an @ symbol,
  // followed by another sequence of characters, a dot (.), and a top-level domain (TLD).
  // The TLD is limited to common domains such as .com, .org, .net, etc.
  final RegExp emailRegex =
      RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');

  return emailRegex.hasMatch(email);
}
