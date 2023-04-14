// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'contact_cubit.dart';

abstract class ContactState extends Equatable {
  const ContactState();

  @override
  List<Object> get props => [];
}

class ContactInitial extends ContactState {}

class GetContactSuccess extends ContactState {
    final List<Contact> contacts;
  
    GetContactSuccess(this.contacts);

    @override
  // TODO: implement props
  List<Object> get props => [contacts];
    
}

class GetContactError extends ContactState {
    final String error;
  
    GetContactError(this.error);

    @override
  // TODO: implement props
  List<Object> get props => [error];
    
}

class GetContactCreateSuccess extends ContactState {
    final String status;

   const GetContactCreateSuccess(this. status);
}

class DeleteContactSuccess extends ContactState {
    final String status;
    const DeleteContactSuccess(this.status);
}