import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobie1/sidedish.dart';

class AddSideDPage extends StatefulWidget {
  const AddSideDPage({Key? key}) : super(key: key);

  @override
  _AddSideDPageState createState() => _AddSideDPageState();
}

class _AddSideDPageState extends State<AddSideDPage> {
  final _form = GlobalKey<FormState>();
  TextEditingController title = TextEditingController();
  TextEditingController detail = TextEditingController();
  TextEditingController price = TextEditingController();
  File? file;
  final store = FirebaseFirestore.instance;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(255, 77, 77, 1.0),
        title: Text('Add Side Dish',
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
                buildTitleField(),
                const SizedBox(height: 10),
                buildDetailField(),
                const SizedBox(height: 10),
                buildPriceField(),
                groupImage(),
                const SizedBox(height: 10),
                buildSaveButton()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<Null> chooseImage(ImageSource source) async {
    try {
      var object = await ImagePicker().getImage(
        source: source,
        maxWidth: 800.0,
        maxHeight: 800.0,
      );
      setState(() {
        file = File(object!.path);
      });
    } catch (e) {}
  }
  Widget groupImage() => Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          IconButton(
            icon: const Icon(Icons.add_a_photo),
            onPressed: () => chooseImage(ImageSource.camera),
          ),
          Container(
            padding: const EdgeInsets.all(16.0),
            width: 200,
            height: 200,
            child: file == null?
              Card(elevation: 5,color: const Color.fromARGB(255, 245, 244, 244),shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
                child:Container(
                width: 70,
                height: 70,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                  image:AssetImage('assets/mainpic.png'),
                  alignment: Alignment.center,
                  )
                  ),
                )
              ): Container( 
                  width: 70,
                  height: 70,
                  child: Image.file(file!))
                  ),
          IconButton(
            icon: const Icon(Icons.add_photo_alternate),
            onPressed: () => chooseImage(ImageSource.gallery),
          ),
        ],
      );
  Future uploadPost()async{
     Random random = Random();
    int i = random.nextInt(100);
    final path = 'SideDish/post$i.jpg';
   final ref =FirebaseStorage.instance.ref().child(path);
    final storageUploadTask = ref.putFile(file!);
    print('$path');
    print('post$i.jpg');
    final snapshot = await storageUploadTask.whenComplete(() {});

  final urlPicture = await snapshot.ref.getDownloadURL();
  print('$urlPicture');
  insertPost(urlPicture);
   
  }
  Future<void> insertPost(String urlPicture)async{
    final FirebaseAuth _auth = FirebaseAuth.instance;
    var  currentUser = _auth.currentUser;
    Map<String, dynamic> data = {
              "title": title.text,
              "detail": detail.text,
              "price": price.text,
              "image": urlPicture
  };
              CollectionReference _collectionRef = FirebaseFirestore.instance.collection("Side-Dish");
            //  print(_firstname.toString());
                return _collectionRef.doc()
                .set(data)
                .then((value) =>
                Navigator.push(context, MaterialPageRoute(builder: (_)=> SideDPage())));
  }


  ElevatedButton buildSaveButton() {
    return ElevatedButton(
        
        onPressed: () async {
           print('save button press');
          if (_form.currentState!.validate()) {
            if(file!=null){
               uploadPost();
               }else{ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: const Text('Please choose picture')
                ),
              );
              }
            }

          } ,
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

  TextFormField buildTitleField() {
    return TextFormField(
      controller: title,
      decoration: const InputDecoration(
        labelText: 'Title of Side Dish',
        icon: Icon(Icons.book),
      ),
      validator: (value) => value!.isEmpty ? 'Please fill in title' : null,
    );
  }

  TextFormField buildDetailField() {
    return TextFormField(
      controller: detail,
      decoration: const InputDecoration(
        labelText: 'Detail of Side Dish',
        icon: Icon(Icons.list),
      ),
      validator: (value) => value!.isEmpty ? 'Please fill in detail' : null,
    );
  }

  TextFormField buildPriceField() {
    return TextFormField(
        controller: price,
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(
          labelText: 'price',
          icon: Icon(Icons.list),
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please fill in price';
          } else {
            double price = double.parse(value);
            if (price < 0) {
              return 'Please fill in price';
            } else {
              return null;
            }
          }
        });
  }
}