import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
        appBar: AppBar(
          bottom: const TabBar(tabs: [
            Tab(
              icon: Icon(Icons.looks_one_outlined),
            ),
            Tab(
              icon: Icon(Icons.looks_two_outlined),
            ),
            Tab(
              icon: Icon(Icons.looks_3_outlined),
            )
          ]),
          backgroundColor: const Color.fromRGBO(255, 77, 77, 1.0),
          title: Text('About Us',
            style: GoogleFonts.shrikhand(
              fontWeight: FontWeight.bold,
              color: const Color.fromRGBO(252, 243, 233, 1.0),
            )
          ),
        ),
        body: Material(
          color: const Color.fromRGBO(252, 243, 233, 1.0),
          child: TabBarView(
            children: [
              dev_st(context),
              dev_nd(context),
              dev_rd(context),
            ]
          ),
        )
        )
      ),
    );
  }

  Center dev_st(BuildContext context) {
    return Center(
      child: Center(
        child: Column(
          children: [
            const Spacer(),
            Image.asset('assets/dev1.jpg',
              fit: BoxFit.cover,
              height: 200,
              width: 200,
            ),
            const SizedBox(height: 10),
            Text("Chadapron Khakaew",
              style: GoogleFonts.shrikhand(
                fontSize: 30,
                color: const Color.fromRGBO(255, 77, 77, 1.0),
              ),
            ),
            const SizedBox(height: 5),
            Text("116310462033-6",
              style: GoogleFonts.shrikhand(
                fontSize: 18,
                color: const Color.fromRGBO(255, 77, 77, 1.0),
              ),
            ),
            const SizedBox(height: 10,),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/instagram.png',
                    width: 20,
                    height: 20,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(": _ja.cdpkk",
                      style: GoogleFonts.syne(
                        fontSize: 20
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/facebook.png',
                    width: 20,
                    height: 20,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(":  Chadapron Khakaew",
                      style: GoogleFonts.syne(
                        fontSize: 20
                      ),
                    ),
                  ],
                )
              ],
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }

  Center dev_nd(BuildContext context) {
    return Center(
      child: Center(
        child: Column(
          children: [
            const Spacer(),
            Image.asset('assets/dev2.jpg',
              fit: BoxFit.cover,
              height: 200,
              width: 200,
            ),
            const SizedBox(height: 10),
            Text("Thirathit",
              style: GoogleFonts.shrikhand(
                fontSize: 30,
                color: const Color.fromRGBO(255, 77, 77, 1.0),
              ),
            ),
            Text('Thanaphimonphaisan',
              style: GoogleFonts.shrikhand(
                fontSize: 30,
                color: const Color.fromRGBO(255, 77, 77, 1.0),
              ),
            ),
            const SizedBox(height: 5),
            Text("116310400319-4",
              style: GoogleFonts.shrikhand(
                fontSize: 18,
                color: const Color.fromRGBO(255, 77, 77, 1.0),
              ),
            ),
            const SizedBox(height: 10,),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/instagram.png',
                    width: 20,
                    height: 20,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(": _thirathit",
                      style: GoogleFonts.syne(
                        fontSize: 20
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/facebook.png',
                    width: 20,
                    height: 20,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(":  Thirathit Thanaphimonphaisan",
                      style: GoogleFonts.syne(
                        fontSize: 20
                      ),
                    ),
                  ],
                )
              ],
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }

  Center dev_rd(BuildContext context) {
    return Center(
      child: Center(
        child: Column(
          children: [
            const Spacer(),
            Image.asset('assets/dev1.jpg',
              fit: BoxFit.cover,
              height: 200,
              width: 200,
            ),
            const SizedBox(height: 10),
            Text("Ponpipat Phacheen",
              style: GoogleFonts.shrikhand(
                fontSize: 30,
                color: const Color.fromRGBO(255, 77, 77, 1.0),
              ),
            ),
            const SizedBox(height: 5),
            Text("116310400067-9",
              style: GoogleFonts.shrikhand(
                fontSize: 18,
                color: const Color.fromRGBO(255, 77, 77, 1.0),
              ),
            ),
            const SizedBox(height: 10,),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/instagram.png',
                    width: 20,
                    height: 20,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(": heyugotdrugs_",
                      style: GoogleFonts.syne(
                        fontSize: 20
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/facebook.png',
                    width: 20,
                    height: 20,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(":  Ponpipat Phacheen",
                      style: GoogleFonts.syne(
                        fontSize: 20
                      ),
                    ),
                  ],
                )
              ],
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}