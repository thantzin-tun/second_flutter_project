// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:second_flutter_project/api/contact/contact_api_service.dart';
import 'package:second_flutter_project/model/contact/contact_model.dart';

class ContactRepository {
  
  final ContactApiService _contactApiService;

  ContactRepository(this._contactApiService);

  Future<List<Contact>> getContacts() => _contactApiService.getContacts();

  Future<Contact> getContact(String contactId) => _contactApiService.getContact(contactId);

  Future<Contact> addContact(Contact contact) => _contactApiService.addContact(contact);

  Future<Contact> updateContact(String contactId,Contact contact) => _contactApiService.updateContact(contactId,contact);

  Future<Contact> deleteContact(String contactId) => _contactApiService.deleteContact(contactId);

}
