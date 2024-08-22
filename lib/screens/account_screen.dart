import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class AccountScreen extends StatelessWidget {
  final DatabaseReference _dbRef =
  FirebaseDatabase.instance.reference().child('accounts');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan.shade900,
      appBar: AppBar(
        backgroundColor: Colors.cyan.shade900,
        title: Image.asset(
          'lib/images/logoo.png',
          height: 100.0,
          fit: BoxFit.fitHeight,
        ),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Container(
        padding: const EdgeInsets.only(top: 40),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Who\'s Here?',
              style: TextStyle(fontSize: 28.0, color: Colors.white),
            ),
            Expanded(
              child: StreamBuilder(
                stream: _dbRef.onValue,
                builder: (context, snapshot) {
                  if (snapshot.hasData && !snapshot.hasError) {
                    Map<dynamic, dynamic>? accountMap =
                    snapshot.data!.snapshot.value as Map<dynamic, dynamic>?;

                    List<dynamic> accounts = accountMap != null
                        ? accountMap.values.toList()
                        : [];

                    return GridView.builder(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50.0, vertical: 30.0),
                      gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 1.0,
                        mainAxisSpacing: 15.0,
                        crossAxisSpacing: 8.0,
                        crossAxisCount: 2,
                      ),
                      itemCount: accounts.length + 1,
                      itemBuilder: (BuildContext ctx, index) {
                        if (index == accounts.length) {
                          // Add profile button
                          return GestureDetector(
                            onTap: () {
                              _showAddAccountModal(context);
                            },
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: CircleAvatar(
                                      radius: 70,
                                      backgroundColor: Colors.white70,
                                      child: const Icon(
                                        Icons.edit,
                                        color: Colors.white,
                                        size: 34.0,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 8.0),
                                const Text('Add Profile',
                                    style: TextStyle(color: Colors.white)),
                              ],
                            ),
                          );
                        } else {
                          // Existing profile display
                          return GestureDetector(
                            onTap: () {
                              // Navigate to the Home Screen first
                              Navigator.pushReplacementNamed(
                                context,
                                '/home',
                                arguments: {
                                  'username': accounts[index]['username'],
                                  'email': accounts[index]['email'],
                                },
                              );
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: CircleAvatar(
                                      radius: 60,
                                      backgroundColor: Colors.primaries[
                                      index % Colors.primaries.length],
                                      child: Text(
                                        accounts[index]['username'][0]
                                            .toUpperCase(),
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 34.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 8.0),
                                Text(
                                  accounts[index]['username'],
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }
                      },
                    );
                  } else {
                    return Center(
                      child: GestureDetector(
                        onTap: () {
                          _showAddAccountModal(context);
                        },
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              radius: 70,
                              backgroundColor: Colors.white70,
                              child: const Icon(
                                Icons.edit,
                                color: Colors.white,
                                size: 34.0,
                              ),
                            ),
                            const SizedBox(height: 8.0),
                            const Text('Add Profile',
                                style: TextStyle(color: Colors.white)),
                          ],
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showAddAccountModal(BuildContext context) {
    String username = '';
    String email = '';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Add Profile"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                onChanged: (value) {
                  username = value;
                },
                decoration: const InputDecoration(labelText: 'Username'),
              ),
              TextField(
                onChanged: (value) {
                  email = value;
                },
                decoration: const InputDecoration(labelText: 'Email'),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                if (username.isNotEmpty && email.isNotEmpty) {
                  _addNewAccount(username, email);
                  Navigator.of(context).pop();
                }
              },
              child: const Text('Save'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the modal
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  void _addNewAccount(String username, String email) {
    String accountId = _dbRef.push().key!; // Generate a unique ID for the account
    _dbRef.child(accountId).set({
      'username': username,
      'email': email,
    });
  }
}
