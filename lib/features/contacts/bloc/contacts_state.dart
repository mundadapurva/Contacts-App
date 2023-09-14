part of 'contacts_bloc.dart';

@immutable
sealed class ContactsState {} // base state

// initial state
final class ContactsInitial extends ContactsState {}

// loading state
final class ContactsLoading extends ContactsState {}

// loaded state
final class ContactsLoaded extends ContactsState {
  final List<ContactModel> contacts;

  ContactsLoaded(this.contacts);
}

// error state
final class ContactsError extends ContactsState {
  final String message;

  ContactsError(this.message);
}

// contact created state
final class ContactCreated extends ContactsState {}
