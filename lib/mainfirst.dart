import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MainFirst extends StatefulWidget {
  const MainFirst({super.key});

  @override
  State<MainFirst> createState() => _MainFirstState();
}

class _MainFirstState extends State<MainFirst> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Sweetday',
      //     style: GoogleFonts.shrikhand(
      //       fontWeight: FontWeight.bold,
      //       color: const Color.fromRGBO(252, 243, 233, 1.0),
      //     )
      //   ),
      //   backgroundColor: const Color.fromRGBO(255, 77, 77, 1.0),
      // ),
      body:
        Material(
          color: const Color.fromRGBO(252, 243, 233, 1.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                Text('Sweetday',
                  style: GoogleFonts.shrikhand(
                    fontSize: 50.0,
                    color: const Color.fromRGBO(255, 77, 77, 1.0),
                  )
                ),
                Image.asset('assets/mainpic.png', //รูปไอคอนเค้ก
                  height: 220,
                  width: 220,
                ),
                //const SizedBox(height: 50,),
                SizedBox(
                  width: 300,
                  height: 50,
                  child: buildLoginButton(context),
                ),
                const SizedBox(height: 12,),
                SizedBox(
                  width: 300,
                  height: 50,
                  child: buildRegisterButton(context),
                ),
                
                const Spacer(),
              ],
            ),),
        )
    );
  }

  ElevatedButton buildRegisterButton(BuildContext context) {
    return ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(30)
                      )
                    ),
                    backgroundColor: const Color.fromRGBO(255, 77, 77, 1.0),
                  ),
                  onPressed: () {
                  Navigator.pushNamed(context, '/register');
                  }, 
                  child: Text('Register',
                    style: GoogleFonts.shrikhand(
                      fontSize: 25.0,
                      color: const Color.fromRGBO(252, 243, 233, 1.0),
                    )
                  ));
  }
  
  ElevatedButton buildLoginButton(BuildContext context) {
    return ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(30)
                      )
                    ),
                    backgroundColor: const Color.fromRGBO(252, 243, 233, 1.0),
                  ),
                  onPressed: () {
                  Navigator.pushNamed(context, '/login');
                  }, 
                  child: Text('Login',
                    style: GoogleFonts.shrikhand(
                      fontSize: 25.0,
                      color: const Color.fromRGBO(255, 77, 77, 1.0),
                    )
                  ));
  }

  
  
}

