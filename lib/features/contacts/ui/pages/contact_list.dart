import 'package:contacts_app/features/contacts/ui/pages/contact_form.dart';
import 'package:contacts_app/features/contacts/ui/widgets/contact_list_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/contact_ontap_card.dart';
import '../../bloc/contacts_bloc.dart';

class ContactList extends StatefulWidget {
  const ContactList({super.key});

  @override
  State<ContactList> createState() => _ContactListState();
}

class _ContactListState extends State<ContactList> {
  @override
  void initState() {
    // when the page is loaded, the contacts will be fetched from the database
    BlocProvider.of<ContactsBloc>(context).add(GetContacts());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    /* this is the contact list page
     it will display a list of contacts
     each contact will have a name and phone number
   */
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text(
          'Contact List',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w400),
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(16),
          ),
        ),
      ),
      body: BlocConsumer<ContactsBloc, ContactsState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is ContactsLoading) {
            return const Center(
              child: CircularProgressIndicator(), // loading indicator
            );
          }

          if (state is ContactsError) {
            return const Center(
              child: Text('Error loading contacts'), // error message
            );
          }

          if (state is ContactsLoaded && state.contacts.isEmpty) {
            return const Center(
              child: Text('No contacts'), // no contacts message
            );
          }

          if (state is ContactsLoaded) {
            return ListView.builder(
              itemCount: state.contacts.length,
              itemBuilder: (context, index) {
                final contact = state.contacts[index];
                return GestureDetector(
                  onTap: () {
                    // open contact_ontap_card
                    // the user can tap on a contact to view more information about it
                    showDialog(
                        context: context,
                        builder: (context) {
                          return ContactOntapCard(
                            name: contact.name,
                            phone: contact.phone,
                            email: contact.email,
                            address: contact.address,
                          );
                        });
                  },
                  child: ContactListCard(
                    name: contact.name,
                    phone: contact.phone,
                  ),
                );
              },
            );
          }

          return const Center(
            child: Text('Something went wrong'),
          );
        },
      ),
      // the user can add a new contact by tapping the floating action button
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.of(context)
              .push(
            MaterialPageRoute(
              builder: (context) => BlocProvider(
                create: (context) => ContactsBloc(),
                child: ContactForm(),
              ),
            ),
          )
              .then((value) {
            BlocProvider.of<ContactsBloc>(context).add(GetContacts());
          });
        },
      ),
    );
  }
}
