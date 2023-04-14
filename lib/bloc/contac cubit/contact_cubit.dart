import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:second_flutter_project/model/contact/contact_model.dart';
import 'package:second_flutter_project/repository/contact_repository.dart';

part 'contact_state.dart';

class ContactCubit extends Cubit<ContactState> {
  final ContactRepository _contactRepository;
  ContactCubit(this._contactRepository) : super(ContactInitial()) {
    getContact();
  }

  void getContact() {
    emit(ContactInitial());
    _contactRepository
        .getContacts()
        .then((value) => emit(GetContactSuccess(value)))
        .catchError((error) => emit(GetContactError(error)));
  }

//Add new contact
  addContact(Contact contact) {
    emit(ContactInitial());
    _contactRepository
        .addContact(contact)
        .then((value) => emit(
            const GetContactCreateSuccess("Successfully create new contact")))
        .catchError((error) => emit(GetContactError("Sorry try again!")));
  }

  //Delete Contact
  deleteContact(String contactId) {
    emit(ContactInitial());
    _contactRepository
        .deleteContact(contactId);
        // .then((value) => emit(
        //     const GetContactCreateSuccess("Successfully delete new contact")))
        // .catchError((error) => emit(GetContactError("Sorry try again!")));
  }

  //Update Contact
  updateContact(String contactId, Contact contact) {
    emit(ContactInitial());
    _contactRepository
        .updateContact(contactId, contact);
        // .then((value) => emit(
        //     const GetContactCreateSuccess("Successfully Update new contact")))
        // .catchError((error) => emit(GetContactError("Sorry try again!")));
  }

}
