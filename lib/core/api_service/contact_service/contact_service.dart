import 'models/contact_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ContactApiService {
  Future<List<ContactModel>> getContacts() async {
    List<ContactModel> lt = [];
    try {
      await FirebaseFirestore.instance
          .collection('contacts')
          .get()
          .then((QuerySnapshot querySnapshot) {
        //  get all contacts from the database
        //  and add them to the list
        for (var doc in querySnapshot.docs) {
          final contact = ContactModel(
            id: doc["id"],
            name: doc["name"],
            phone: doc["phone"],
            email: doc["email"],
            address: doc["address"],
          );
          lt.add(contact);
        }
      });
      return lt;
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<bool> createContact(ContactModel contact) async {
    try {
      // add the contact to the database
      // the contact will be added to the database and the contact list will be updated
      await FirebaseFirestore.instance
          .collection('contacts')
          .add(contact.toMap());
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> checkIfContactExists(String phone) async {
    try {
      // check if the contact already exists
      final result = await FirebaseFirestore.instance
          .collection('contacts')
          .where('phone', isEqualTo: phone)
          .get();
      return result.docs.isEmpty;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
