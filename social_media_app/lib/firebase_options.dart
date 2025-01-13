
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';


const firebaseConfig = FirebaseOptions(
  apiKey: 'AIzaSyCGPCmlDxTCtWY33_7HMjjmIfB1FDDYSDQ',
  appId: '1:53493921318:web:ca24730299f647437e98e7',
  messagingSenderId: '53493921318',
  projectId: 'my-social-media-app-49d7e',
);

final databaseURL = 'https://my-social-media-app-49d7e.firebaseio.com';



Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: firebaseConfig,
  );
  FirebaseDatabase.instanceFor(
    app: Firebase.app(),
    databaseURL: databaseURL,
  );
  
}
