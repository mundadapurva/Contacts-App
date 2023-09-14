part of 'contacts_bloc.dart';

@immutable
sealed class ContactsEvent {} // base event

// get contacts event
class GetContacts extends ContactsEvent {}

// create contact event
class CreateContact extends ContactsEvent {
  final ContactModel contact;

  CreateContact(this.contact);
}
