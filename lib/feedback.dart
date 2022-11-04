import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobie1/feedback_datail.dart';

class FeedBackPage extends StatelessWidget {
  final store = FirebaseFirestore.instance;

   FeedBackPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: store.collection('Feedback').snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: const Color.fromRGBO(255, 77, 77, 1.0),
            title: Text('Feedbacks',
              style: GoogleFonts.shrikhand(
                fontWeight: FontWeight.bold,
                color: const Color.fromRGBO(252, 243, 233, 1.0),
              )
            ),
            actions: <Widget>[buildAddButton(context)],
          ),
          body: Material(
            color: const Color.fromRGBO(252, 243, 233, 1.0),
            child: snapshot.hasData
                ? buildFeedbackList(snapshot.data!)
                : Center(
              child: CircularProgressIndicator(),
            ),
          ),
        );
      },
    );
  }

  IconButton buildAddButton(context) {
    return IconButton(
        icon: const Icon(Icons.add),
        onPressed: () {
          print("add icon press");
          Navigator.pushNamed(context, '/addfeed');
        });
  }

  ListView buildFeedbackList(QuerySnapshot data) {
    return ListView.builder(
      itemCount: data.size,
      itemBuilder: (BuildContext context, int index) {
        var model = data.docs.elementAt(index);
        return ListTile(
          title: Text('From: '+model['title'],
          maxLines: 2,
            style: GoogleFonts.shrikhand(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: const Color.fromRGBO(255, 77, 77, 1.0),
          )),
          subtitle: Text('Detail: '+model['detail'],
          maxLines: 2,
            style: GoogleFonts.syne(),
          ),
          onTap: () {
            print(model['title']);
            Navigator.push(context, MaterialPageRoute(builder: (context) => FeedBackDetail(model['title'])));
          },
        );
      },
    );
  }
}