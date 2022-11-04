

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobie1/drink.dart';
import 'package:mobie1/icecream.dart';
import 'package:mobie1/sidedish.dart';

class Promotion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color.fromRGBO(252, 243, 233, 1.0),
      child: SafeArea(
        child: Column(
          children: <Widget>[
            const SizedBox(height: 1),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  GestureDetector(
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => IceCreaPage()));
                    },
                    child: Image.asset('assets/icecreambanner.jpg',
                      fit: BoxFit.cover,
                      height: 100,
                      width: 200,
                    ), 
                  ),
                  const SizedBox(width: 3),
                  GestureDetector(
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SideDPage())
                      );
                    },
                    child: Image.asset('assets/sidedishbanner.jpg',
                      fit: BoxFit.cover,
                      height: 100,
                      width: 200,
                    ), 
                  ),
                  const SizedBox(width: 3),
                  GestureDetector(
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => DrinPage()));
                    },
                    child: Image.asset('assets/drinkbanner.jpg',
                      fit: BoxFit.cover,
                      height: 100,
                      width: 200,
                    ), 
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(),
              child: Text('Promotion',
                style: GoogleFonts.shrikhand(
                  fontSize: 20,
                  color: const Color.fromRGBO(255, 77, 77, 1.0),
                )
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: GridView.builder(
                  itemCount: promotionList.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    mainAxisSpacing: 20,
                    childAspectRatio: 1.65,
                  ),
                  itemBuilder: (context, index) => PromotionCard(
                    promotionList: promotionList[index],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PromotionCard extends StatelessWidget {
  final PromotionList promotionList;

  const PromotionCard({Key? key, required this.promotionList})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: promotionList.color,
        borderRadius: BorderRadius.circular(25), //18
      ),
      child: Row( 
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(20), //20
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Spacer(),
                  Text(
                    promotionList.title,
                    style: GoogleFonts.shrikhand(
                        fontSize: 20, //22
                        color: Colors.white),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 5), // 5
                  Text(promotionList.description,
                    style: GoogleFonts.syne(
                      color: Colors.white54),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  //const SizedBox(height: 5),
                  Row(
                    children: <Widget>[
                      const Icon(Icons.monetization_on_outlined,
                        color: Colors.white,
                      ),
                      const SizedBox(width: 5),
                      Text(promotionList.price,
                        style: GoogleFonts.syne(
                          color: Colors.white,
                          fontSize: 47,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      const SizedBox(width: 5),
                      Text('Bath',
                        style: GoogleFonts.syne(
                          color: Colors.white,
                          fontSize: 18,
                          fontStyle: FontStyle.italic
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  
                ],
              ),
            ),
          ),
          const SizedBox(width: 5), //5
          AspectRatio(
            aspectRatio: 0.71,
            child: Image.asset(
              promotionList.image,
              fit: BoxFit.cover,
              alignment: Alignment.centerLeft,
            ),
          )
        ],
      ),
    );
  }
}

class PromotionList {
  final int id;
  final String title, price, description, image;
  final Color color;

  PromotionList(
    {
      required this.id,
      required this.price,
      required this.title,
      required this.description,
      required this.image,
      required this.color
    }
  );
}

List<PromotionList> promotionList = [
  PromotionList(
    id: 1,
    price: '29',
    title: "Sale!! Ice Cream 1 Scoop",
    description: "New and tasty scoop every day.",
    image: "assets/promo11.png",
    color: const Color.fromRGBO(203, 196, 176, 1)
  ),
  PromotionList(
    id: 2,
    price: '129',
    title: "New!! Mango Sticky Rice",
    description: "New and Thai tasty recipes arrived now!!",
    image: "assets/promo2.png",
    color: const Color.fromRGBO(234, 194, 17, 1)
  ),
  PromotionList(
    id: 3,
    price: '133',
    title: "Hit Set!! Matcha Latte Iced + Fruity Yogurt",
    description: "Best Macha & Fruit gonna me you feel good.",
    image: "assets/promo3.png",
    color: const Color.fromRGBO(12, 120, 36, 1),
  ),
  PromotionList(
    id: 4,
    price: '0',
    title: "demo title",
    description: "demo description",
    image: "assets/mainpic.png",
    color: Color(0xFFD82D40),
  ),
  PromotionList(
    id: 5,
    price: '0',
    title: "demo title",
    description: "demo description",
    image: "assets/mainpic.png",
    color: Color.fromARGB(255, 33, 92, 186),
  ),
  PromotionList(
    id: 6,
    price: '0',
    title: "demo title",
    description: "demo description",
    image: "assets/mainpic.png",
    color: Color.fromARGB(255, 65, 155, 95),
  ),
  PromotionList(
    id: 7,
    price: '0',
    title: "demo title",
    description: "demo description",
    image: "assets/mainpic.png",
    color: Color.fromARGB(255, 224, 80, 32),
  ),
];