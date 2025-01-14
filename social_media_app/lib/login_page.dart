import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:social_media_app/register_page.dart';
import 'home_screen.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue  ,
        title: Text('Login',
        style: TextStyle(fontSize: 24),),
        
        centerTitle: true,
        titleTextStyle: TextStyle(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0).copyWith(top: 70.0),
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
                controller: _emailController,
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
                controller: _passwordController,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    try {
                      await FirebaseAuth.instance.signInWithEmailAndPassword(
                        email: _emailController.text,
                        password: _passwordController.text,
                      );
                      Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context)=>HomePage(postId: 'some_post_id',)),
                      );
                    } on FirebaseException catch (e) {
                      if (e.code == 'invalid-email') {
                         ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Invalid email address. Please try again.')),
                      );

                      } else if(e.code == 'user-not-found') {

                       ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('User not found. Please try again.')),
          );
        } else if (e.code == 'wrong-password') {

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Incorrect password. Please try again.')),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(e.message!)),
          );
        }


                     
                    }
                  }
                },
                child: Text('Login'),
              ),

              const SizedBox(height: 10),
              TextButton(
                onPressed: (){
                  Navigator.push(
                    context, 
                    MaterialPageRoute(builder: (context) => RegisterPage()),
                    );

              }, child: const Text('Dont have an account? Register'),
              ),
          
            ],
          ),
        ),
      ),
    );
  }
}



