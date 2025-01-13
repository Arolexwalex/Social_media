import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';


class AuthenticationScreen extends StatefulWidget {
  @override
  _AuthenticationScreenState createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? _email;
  String? _password;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void _signUp(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = result.user;
      print('Signed up user: ${user?.uid}');
    } catch (e) {
      print('Error signing up: $e');
    }
  }

  void _login(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = result.user;
      print('Logged in user: ${user?.uid}');
    } catch (e) {
      print('Error logging in: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Authentication'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter an email';
                  }
                  return null;
                },
                onSaved: (value) => _email = value,
              ),
              SizedBox(height: 20),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a password';
                  }
                  return null;
                },
                onSaved: (value) => _password = value,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  try {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      if (_email != null && _password != null) {
                        _signUp(_email!, _password!);
                      }
                    }
                  } on FirebaseException catch(e){
                    print('Firebase exception:${e.message}');
                  }catch (e) {
                    print('Error: $e');
                  }
                },
                child: Text('Sign Up'),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  try {
                     if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      if (_email != null && _password != null) {
                        _login(_email!, _password!);
                      }
                    }
                  } catch (e) {
                    print('Error: $e');
                  }
                },
                child: Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}




