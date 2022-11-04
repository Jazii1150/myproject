import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobie1/feedback.dart';

class AddFeedBackPage extends StatefulWidget {
  const AddFeedBackPage({Key? key}) : super(key: key);

  @override
  _AddFeedBackPageState createState() => _AddFeedBackPageState();
}

class _AddFeedBackPageState extends State<AddFeedBackPage> {
  final _form = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController detail = TextEditingController();
  final store = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(255, 77, 77, 1.0),
        title: Text('Add Feedback',
          style: GoogleFonts.shrikhand(
            fontWeight: FontWeight.bold,
            color: const Color.fromRGBO(255, 255, 255, 1.0),
          ),
        ),
      ),
      body: Material(
        color: const Color.fromRGBO(252, 243, 233, 1.0),
        child: Container(
          margin: const EdgeInsets.fromLTRB(25, 25, 25, 0),
          child: Form(
            key: _form,
            child: ListView(
              children: <Widget>[
                const SizedBox(height: 50),
                buildEmailField(),
                const SizedBox(height: 10),
                buildDetailField(),
                const SizedBox(height: 10),
                buildSaveButton()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> insertPost(String urlPicture) async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    var  currentUser = _auth.currentUser;
    Map<String, dynamic> data = {
      "email": email.text,
      "detail": detail.text,
    };
    CollectionReference _collectionRef = FirebaseFirestore.instance.collection("Feedback");
            //  print(_firstname.toString());
      return _collectionRef.doc().set(data).then(
        (value) =>
        Navigator.push(
          context, 
          MaterialPageRoute(
            builder: (_)=> FeedBackPage()
          )
        )
      );
  }

  ElevatedButton buildSaveButton() {
    return ElevatedButton(
      onPressed: () async {
        if (_form.currentState!.validate()) {
          print('save button press');
          Map<String, dynamic> data = {
            'title': email.text,
            'detail': detail.text,
          };
          try {
            DocumentReference ref = await store.collection('Feedback').add(data);
            print('save id = ${ref.id}');
            Navigator.pop(context);
          } 
          catch (e) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Error $e'),
              ),
            );
          }
        } 
        else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Please validate value'),
            ),
          );
        }
      },
      style: ElevatedButton.styleFrom(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(30)
          )
        ),
        backgroundColor: const Color.fromRGBO(255, 77, 77, 1.0),
      ),
      child: Text('Add',
        style: GoogleFonts.shrikhand(
          fontSize: 20,
          color: const Color.fromRGBO(255, 255, 255, 1.0),
        ),
      ),
    );
  }

  TextFormField buildEmailField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      controller: email,
      decoration: const InputDecoration(
        labelText: 'Email',
        icon: Icon(Icons.book),
      ),
      validator: (value) => value!.isEmpty ? 'Please fill in Email' : null,
    );
  }

  TextFormField buildDetailField() {
    return TextFormField(
      controller: detail,
      decoration: const InputDecoration(
        labelText: 'Detail',
        icon: Icon(Icons.list),
      ),
      validator: (value) => value!.isEmpty ? 'Please fill in detail' : null,
    );
  }
}