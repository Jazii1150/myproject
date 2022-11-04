import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class IceCreamDetail extends StatefulWidget {
  final String _idi; //if you have multiple values add here
  IceCreamDetail(this._idi, {Key? key})
      : super(key: key); //add also..example this.abc,this...

  @override
  _IceCreamDetailState createState() => _IceCreamDetailState();
}

class _IceCreamDetailState extends State<IceCreamDetail> {
    FirebaseFirestore _firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    String _id = widget._idi;
    return StreamBuilder(
        stream: getBook(_id),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: const Color.fromRGBO(255, 77, 77, 1.0),
              title: Text("Detail Ice Cream",
                style: GoogleFonts.shrikhand(
                  fontWeight: FontWeight.bold,
                  color: const Color.fromRGBO(255, 255, 255, 1.0),
                ),
              ),
            ),
            body: Material(
              color: const Color.fromRGBO(252, 243, 233, 1.0),
              child: snapshot.hasData
                  ? buildIceCreamList(snapshot.data!)
                  : const Center(
                      child: CircularProgressIndicator(),
                    ),
            ),
          );
        });
  }

  ListView buildIceCreamList(QuerySnapshot data) {
    return ListView.builder(
      itemCount: data.docs.length,
      itemBuilder: (BuildContext context, int index) {
        var model = data.docs.elementAt(index);
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 50),
                  Text(model['title'],
                    style: GoogleFonts.shrikhand(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromRGBO(255, 77, 77, 1.0),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Image(
                    image:NetworkImage(model['image']),
                    fit: BoxFit.cover,
                    height: 120,
                    width: 120,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(model['price'].toString(),
                        style: GoogleFonts.shrikhand(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromRGBO(255, 77, 77, 1.0),
                      ),
                      ),
                      const SizedBox(width: 5,),
                      Text('Bath.',
                        style: GoogleFonts.syne(
                      fontSize: 15,
                      ),
                      )
                    ],
                  ),
                  const SizedBox(height: 8),
                  Center(child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(model['detail'],
                        style: GoogleFonts.syne(
                      fontSize: 15,
                      ),
                      ),
                    ],
                  )),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(30)
                      )
                    ),
                    backgroundColor: const Color.fromRGBO(255, 77, 77, 1.0),
                  ),
                    child: Text('Delete',
                      style: GoogleFonts.shrikhand(
                      fontSize: 20,
                      color: const Color.fromRGBO(255, 255, 255, 1.0),
                      ),
                    ),
                    onPressed: () {
                      print(model.id);
                      deleteValue(model.id);
                      Navigator.pop(context);
                    }
                  ),
                ],
              ),
          ),
        );
      },
    );
  }
  

  Future<void> deleteValue(String titleName) async {
   await _firestore
       .collection('Ice-Cream')
       .doc(titleName)
       .delete()
       .catchError((e) {
     print(e);
   });
  }

  Stream<QuerySnapshot> getBook(String titleName) {
    // Firestore _firestore = Firestore.instance;
    return _firestore
        .collection('Ice-Cream')
        .where('title', isEqualTo: titleName)
        .snapshots();
  }
}

