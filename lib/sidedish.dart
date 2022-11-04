import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobie1/sidedish_detail.dart'; 

class SideDPage extends StatelessWidget {
  final store = FirebaseFirestore.instance;

   SideDPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: store.collection('Side-Dish').snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: const Color.fromRGBO(255, 77, 77, 1.0),
            title: Text('Side Dishes',
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
                ? buildSideDishList(snapshot.data!)
                : const Center(
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
          Navigator.pushNamed(context, '/addside');
        });
  }

  ListView buildSideDishList(QuerySnapshot data) {
    return ListView.builder(
      itemCount: data.size,
      itemBuilder: (BuildContext context, int index) {
        var model = data.docs.elementAt(index);
        return ListTile(
          leading: Image(
                    image:NetworkImage(model['image']),
                    fit: BoxFit.cover,
                    // height: 120,
                    // width: 120,
                    ),
          title: Text(model['title'],
          maxLines: 1,
            style: GoogleFonts.shrikhand(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: const Color.fromRGBO(255, 77, 77, 1.0),
          )),
          subtitle: Text(model['detail'],
          maxLines: 2,
            style: GoogleFonts.syne(),
          ),
          trailing: Text(model['price'].toString()+'฿',
            style: GoogleFonts.syne(
              fontSize: 40,
              color: const Color.fromRGBO(255, 77, 77, 1.0),
            ),
          ),
          onTap: () {
            print(model['title']);
            Navigator.push(context, MaterialPageRoute(builder: (context) => SideDishDetail(model['title'])));
          },
        );
      },
    );
  }
}

