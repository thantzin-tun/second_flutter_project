import "package:flutter/material.dart";
import "package:flutter/scheduler.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:get/get.dart";
import "package:second_flutter_project/bloc/contac%20cubit/contact_cubit.dart";
import "package:second_flutter_project/model/contact/contact_model.dart";
import "package:second_flutter_project/repository/contact_repository.dart";
import "package:second_flutter_project/screen/contact/contact_screen.dart";

class ContactAddScreen extends StatefulWidget {
  bool edit;
  Contact? contact;
  Key? key;

  ContactAddScreen({this.edit = false, this.contact, this.key})
      : super(key: key);

  @override
  State<ContactAddScreen> createState() =>
      _ContactAddScreenState(this.edit, this.contact);
}

class _ContactAddScreenState extends State<ContactAddScreen> {
  final bool edit;
  Contact? contact;

  _ContactAddScreenState(this.edit, this.contact);

  @override
  Widget build(BuildContext context) {
    ContactRepository contactRepository = ContactRepository(Get.find());
    final textNameEditingController =
        TextEditingController(text: contact?.name);
    final textPhoneNumberEditingController =
        TextEditingController(text: contact?.phone_number);
    final _formKey = GlobalKey<FormState>();
    String name = "";
    String phone_number = "";
    return BlocProvider<ContactCubit>(
      create: (context) => ContactCubit(contactRepository),
      child: Scaffold(
        appBar: AppBar(
          title: Text(edit == true ? "Update Contact" : "Create Contact"),
          // leading: IconButton(onPressed: ()  {
          //     Navigator.pop(context);
          // }, icon: const Icon(Icons.list)),
        ),
        body: BlocBuilder<ContactCubit, ContactState>(
          builder: (context, state) {
            if (state is GetContactCreateSuccess) {
              textNameEditingController.clear();
              textPhoneNumberEditingController.clear();
              SchedulerBinding.instance.addPostFrameCallback((_) {
                final snackBar = SnackBar(
                  backgroundColor: Colors.blue,
                  duration: const Duration(seconds: 10),
                  content: const Text('Successfully create new contact',
                      style: TextStyle(color: Colors.white)),
                  action: SnackBarAction(
                      label: "Back",
                      onPressed: () {
                        Get.back(result: 'success');
                      }),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              });
            } else if (state is GetContactError) {}
            return Container(
              padding: const EdgeInsets.all(10),
              child: Form(
                key: _formKey,
                child: Card(
                  elevation: 2,
                  borderOnForeground: true,
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            (edit == true ? "Edit Contact" : "Create Contact"),
                            style: TextStyle(fontSize: 30, color: Colors.blue),
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            controller: textNameEditingController,
                            decoration: const InputDecoration(
                              labelText: "Name",
                              labelStyle: TextStyle(fontSize: 15),
                              border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 10.0),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.blue)),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.blue),
                              ),
                            ),
                            validator: (value) {
                              if (value?.isEmpty ?? true) {
                                return "Enter your contact name";
                              }
                              return null;
                            },
                            onSaved: (value) {
                              name = value.toString();
                            },
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            controller: textPhoneNumberEditingController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              labelText: "Phone Number",
                              labelStyle: TextStyle(fontSize: 15),
                              border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 10.0),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.blue)),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.blue),
                              ),
                            ),
                            validator: (value) {
                              if (value?.isEmpty ?? true) {
                                return "Enter phone number please";
                              }
                              return null;
                            },
                            onSaved: (value) {
                              phone_number = value.toString();
                            },
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () async {
                              if (_formKey.currentState?.validate() ?? true) {
                                _formKey.currentState?.save();
                                if (edit == true) {
                                  Contact contact =
                                      Contact(name, phone_number, null);
                                  await BlocProvider.of<ContactCubit>(context)
                                      .updateContact("5", contact);
                                  Navigator.pop(context,"success");
                                } else {
                                  Contact contact =
                                      Contact(name, phone_number, null);
                                  await BlocProvider.of<ContactCubit>(context)
                                      .addContact(contact);
                                                          Get.back(result: "success");
                                }
                                // textNameEditingController.clear();
                                // textPhoneNumberEditingController.clear();
                              }
                            },
                            child: Text(edit == true
                                ? "Update Contact"
                                : "Create Contact"),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
