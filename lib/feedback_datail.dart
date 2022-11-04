import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FeedBackDetail extends StatefulWidget {
  final String _idi; //if you have multiple values add here
  FeedBackDetail(this._idi, {Key? key})
      : super(key: key); //add also..example this.abc,this...

  @override
  _FeedBackDetailState createState() => _FeedBackDetailState();
}

class _FeedBackDetailState extends State<FeedBackDetail> {
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
            title: Text("Detail Feedback",
              style: GoogleFonts.shrikhand(
                fontWeight: FontWeight.bold,
                color: const Color.fromRGBO(255, 255, 255, 1.0),
              ),
            ),
          ),
          body: Material(
            color: const Color.fromRGBO(252, 243, 233, 1.0),
            child: snapshot.hasData
            ? buildFeedbackList(snapshot.data!)
            : const Center(
              child: CircularProgressIndicator(),
            ),
          ),
        );
      }
    );
  }

  ListView buildFeedbackList(QuerySnapshot data) {
    return ListView.builder(
      itemCount: data.docs.length,
      itemBuilder: (BuildContext context, int index) {
        var model = data.docs.elementAt(index);
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 50),
                  Text("From",
                    style: GoogleFonts.syne(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(model['title'],
                    style: GoogleFonts.shrikhand(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromRGBO(255, 77, 77, 1.0),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text("Detail",
                    style: GoogleFonts.syne(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
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
       .collection('Feedback')
       .doc(titleName)
       .delete()
       .catchError((e) {
     print(e);
   });
  }

  Stream<QuerySnapshot> getBook(String titleName) {
    // Firestore _firestore = Firestore.instance;
    return _firestore
        .collection('Feedback')
        .where('title', isEqualTo: titleName)
        .snapshots();
  }
}

