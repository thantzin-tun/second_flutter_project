import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:second_flutter_project/bloc/contac%20cubit/contact_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:second_flutter_project/model/contact/contact_model.dart';
import 'package:second_flutter_project/repository/contact_repository.dart';
import 'package:second_flutter_project/screen/contact/contact_add_screen.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var result = await Get.to(() => ContactAddScreen(edit: false));
          if (result != null && result == "success") {
            BlocProvider.of<ContactCubit>(context).getContact();
          }
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text("Contact List"),
      ),
      body: BlocBuilder<ContactCubit, ContactState>(
        builder: (context, state) {
          if (state is GetContactSuccess) {
            List<Contact> contacts = state.contacts;
            return ListView.builder(
              itemCount: contacts.length,
              itemBuilder: (context, position) {
                return Slidable(
                    key: ValueKey(position),
                    startActionPane: ActionPane(
                        extentRatio: 0.5,
                        motion: const DrawerMotion(),
                        dismissible: DismissiblePane(onDismissed: () {
                          Get.to(() => ContactAddScreen(
                                edit: true,
                                contact: contacts[position],
                              ));
                        }),
                        children: const <Widget>[
                          SlidableAction(
                            onPressed: null,
                            icon: Icons.edit,
                            backgroundColor: Colors.blue,
                            foregroundColor: Colors.white,
                          ),
                        ]),
                    endActionPane: ActionPane(
                        motion: const DrawerMotion(),
                        dismissible: DismissiblePane(onDismissed: () {
                          // showDialog(
                          //   context: context,
                          //   builder: (context) => AlertDialog(
                          //       title: const Text("Are you sure you want to delete?"),
                          //       content: Text("Name : $contacts[position].name"),
                          //       actions: [
                          //         TextButton(onPressed: (){
                          //           print("Delete Contact");
                          //         }, child: const Text("Yes,delete it!")),
                          //         TextButton(onPressed: (){
                          //             Get.back();
                          //         }, child: const Text("Cancel")),
                          //       ],
                          //     )
                          // );
                          BlocProvider.of<ContactCubit>(context)
                              .deleteContact(contacts[position].id.toString());
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                                  duration: Duration(seconds: 3),
                                  backgroundColor: Colors.blue,
                                  content: Text(
                                    "Successfully Delete contact",
                                    style: TextStyle(color: Colors.white),
                                  )));
                          
                        }),
                        children: const <Widget>[
                          SlidableAction(
                            onPressed: null,
                            icon: Icons.delete,
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.white,
                          )
                        ]),
                    child: contactUser(contacts[position]));
              },
            );
          } else if (state is GetContactError) {
            return const Text("Error");
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

Widget contactUser(Contact contact) {
  return Column(children: [
    ListTile(
      title: Text(
        contact.name,
        style: const TextStyle(fontSize: 18),
      ),
      subtitle: Text(contact.phone_number),
      trailing: const Icon(Icons.phone, color: Colors.lightBlue),
      leading: const CircleAvatar(
        backgroundColor: Colors.white,
        child: Icon(Icons.person_2_sharp, color: Colors.blue),
      ),
    ),
  ]);
}
