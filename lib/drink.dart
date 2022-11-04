import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobie1/drink_detail.dart';

class DrinPage extends StatelessWidget {
  final store = FirebaseFirestore.instance;

   DrinPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: store.collection('Drinkss').snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: const Color.fromRGBO(255, 77, 77, 1.0),
            title: Text('Drinks',
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
                ? buildDrinkList(snapshot.data!)
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
          Navigator.pushNamed(context, '/adddrin');
        });
  }

  ListView buildDrinkList(QuerySnapshot data) {
    return ListView.builder(
      itemCount: data.size,
      itemBuilder: (BuildContext context, int index) {
        var model = data.docs.elementAt(index);
        return ListTile(
          leading: Image(
                    image:NetworkImage(model['image']),
                    fit: BoxFit.cover,
                    height: 85,
                    width: 85,
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
            Navigator.push(context, MaterialPageRoute(builder: (context) => DrinkDetail(model['title'])));
          },
        );
      },
    );
  }
}