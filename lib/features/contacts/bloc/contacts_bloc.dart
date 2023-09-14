import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../core/api_service/contact_service/contact_service.dart';
import '../../../core/api_service/contact_service/models/contact_model.dart';

part 'contacts_event.dart';
part 'contacts_state.dart';

class ContactsBloc extends Bloc<ContactsEvent, ContactsState> {
  ContactsBloc() : super(ContactsInitial()) {
    on<ContactsEvent>((event, emit) {});

    on<GetContacts>((event, emit) async {
      emit(ContactsLoading());
      try {
        // get contacts from the database
        // if successful, emit ContactsLoaded
        // if unsuccessful, emit ContactsError
        final contacts = await ContactApiService().getContacts();
        emit(ContactsLoaded(contacts));
      } catch (e) {
        emit(ContactsError(e.toString()));
      }
    });

    on<CreateContact>((event, emit) async {
      emit(ContactsLoading());
      try {
        // create contact in the database
        // if successful, emit ContactCreated
        // if unsuccessful, emit ContactsError
        final result = await ContactApiService().createContact(event.contact);
        if (result) {
          emit(ContactCreated());
        } else {
          emit(ContactsError('Failed to create contact'));
        }
      } catch (e) {
        emit(ContactsError(e.toString()));
      }
    });
  }
}
