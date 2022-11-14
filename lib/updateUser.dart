// ignore_for_file: deprecated_member_use

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UpdateUser extends StatefulWidget {
  final String id;
  const UpdateUser({Key? key, required this.id}) : super(key: key);

  @override
  State<UpdateUser> createState() => _UpdateUserState();
}

class _UpdateUserState extends State<UpdateUser> {
  final _formkey = GlobalKey<FormState>();
  CollectionReference updateUsers =
      FirebaseFirestore.instance.collection('user');
  Future<void> updateUser(id, name, email, password) {
    // print('Updated Succesfully $id');
    return updateUsers
        .doc(id)
        .update({
          'name': name,
          'email': email,
          'password': password,
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  Future<void> resetUser(id, resetName, resetEmail, resetPassword) {
    // print('Updated Succesfully $id');
    return updateUsers
        .doc(id)
        .update({
          'name': resetName,
          'email': resetEmail,
          'password': resetPassword,
        })
        .then((value) => print("User Reset Done"))
        .catchError((error) => print("Failed to reset user: $error"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: const Text('Update data'),
      ),
      body: Form(
        key: _formkey,
        child: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          future: FirebaseFirestore.instance
              .collection('user')
              .doc(widget.id)
              .get(),
          builder: (_, snapshot) {
            if (snapshot.hasError) {
              print('Something went wrong');
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.red,
                ),
              );
            }
            var data = snapshot.data!.data();
            var name = data!['name'];
            var email = data['email'];
            var password = data['password'];

            var resetName = data['name'];
            var resetEmail = data['email'];
            var resetPassword = data['password'];

            var updateId = data['id'];

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: ListView(
                children: [
                  Container(
                    margin: const EdgeInsets.all(10),
                    child: TextFormField(
                      autofocus: false,
                      initialValue: name,
                      decoration: InputDecoration(
                        labelText: 'Name',
                        labelStyle:
                            const TextStyle(fontWeight: FontWeight.bold),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        errorStyle: const TextStyle(
                          color: Colors.red,
                          fontSize: 15,
                        ),
                      ),
                      onChanged: (value) => {name = value},
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your name';
                        }
                        return null;
                      },
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(10),
                    child: TextFormField(
                      autofocus: false,
                      initialValue: email,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        labelStyle:
                            const TextStyle(fontWeight: FontWeight.bold),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        errorStyle: const TextStyle(
                          color: Colors.red,
                          fontSize: 15,
                        ),
                      ),
                      onChanged: (value) => {email = value},
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        return null;
                      },
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(10),
                    child: TextFormField(
                      autofocus: false,
                      initialValue: password,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        labelStyle:
                            const TextStyle(fontWeight: FontWeight.bold),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        errorStyle: const TextStyle(
                          color: Colors.red,
                          fontSize: 15,
                        ),
                      ),
                      onChanged: (value) => {password = value},
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                    ),
                  ),
                  ButtonBar(
                    alignment: MainAxisAlignment.center,
                    buttonPadding: const EdgeInsets.symmetric(horizontal: 25),
                    children: [
                      RaisedButton(
                        onPressed: () {
                          if (_formkey.currentState!.validate()) {
                            setState(() {
                              final snackBar = SnackBar(
                                content: Text(
                                  resetName + ' Updated Successfully',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                backgroundColor: Colors.blue,
                                dismissDirection: DismissDirection.horizontal,
                                elevation: 10,
                                action: SnackBarAction(
                                  label: 'Done',
                                  textColor: Colors.black,
                                  onPressed: () {
                                    // Some code to undo the change.
                                  },
                                ),
                              );

                              // Find the ScaffoldMessenger in the widget tree
                              // and use it to show a SnackBar.
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);

                              updateUser(widget.id, name, email, password);
                              Navigator.pop(context);
                            });
                          }
                        },
                        color: Colors.deepPurpleAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 10,
                        child: const Text('Update'),
                      ),
                      RaisedButton(
                        onPressed: () {
                          resetUser(
                              widget.id, resetName, resetEmail, resetPassword);
                          final snackBar = SnackBar(
                            content: const Text(
                              'User Reset Done',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            backgroundColor: Colors.yellow,
                            dismissDirection: DismissDirection.horizontal,
                            elevation: 10,
                            action: SnackBarAction(
                              label: 'Done',
                              textColor: Colors.black,
                              onPressed: () {
                                // Some code to undo the change.
                              },
                            ),
                          );

                          // Find the ScaffoldMessenger in the widget tree
                          // and use it to show a SnackBar.
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          Navigator.pop(context);
                        },
                        color: Colors.grey,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 10,
                        child: const Text('Reset'),
                      ),
                    ],
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
