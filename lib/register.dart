import 'package:mobie1/login.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formstate = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  final auth = FirebaseAuth.instance;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register Page',
          style: GoogleFonts.shrikhand(
            fontWeight: FontWeight.bold,
            color: const Color.fromRGBO(255, 77, 77, 1.0),
          )),
        backgroundColor: const Color.fromRGBO(252, 243, 233, 1.0),
      ),
      body: Material(
        color: const Color.fromRGBO(255, 77, 77, 1.0),
        child: Container(
          margin: const EdgeInsets.fromLTRB(25, 25, 25, 0),
          child: Form(
          key: _formstate,
        child: ListView(
          children: <Widget>[
            const Spacer(),
            Image.asset('assets/register.png', //รูปไอคอนเค้ก
                  height: 220,
                  width: 220,
              ),
            buildEmailField(),
            const SizedBox(height: 15,),
            buildPasswordField(),
            const SizedBox(height: 15,),
            SizedBox(
              width: 300,
              height: 50,
              child: buildRegisterButton()
            ),
            const Spacer()
          ],
        ),
      ),))
      
    );
  }

  ElevatedButton buildRegisterButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(30)
                      )
                    ),
                    backgroundColor: const Color.fromRGBO(252, 243, 233, 1.0),
                  ),
      child: Text('Register',
                    style: GoogleFonts.shrikhand(
                      fontSize: 25.0,
                      color: const  Color.fromRGBO(255, 77, 77, 1.0),
                    )
                  ),
      onPressed: () async {
        print('Regis new Account');
        if (_formstate.currentState!.validate()) print(email.text);
        print(password.text);
        final _user = await auth.createUserWithEmailAndPassword(
            email: email.text.trim(), password: password.text.trim());
        _user.user!.sendEmailVerification();
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const LoginPage()),
            ModalRoute.withName('/login'));
      },
    );
  }

  TextFormField buildPasswordField() {
    return TextFormField(
      controller: password,
      validator: (value) {
        if (value!.length < 8)
          return 'Please Enter more than 8 Character';
        else
          return null;
      },
      obscureText: true,
      keyboardType: TextInputType.text,
      decoration: const InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 2,
            color: Color.fromRGBO(252, 243, 233, 1.0),
          )
        ),
        enabledBorder: OutlineInputBorder(
          // borderRadius: BorderRadius.all(
          //   Radius.circular(30)
          // ),
          borderSide: BorderSide(
            width: 2,
            color: Color.fromRGBO(252, 243, 233, 1.0),
          )
        ),
        border: OutlineInputBorder(),
        labelText: 'Password',
        icon: Icon(Icons.lock),
      ),
    );
  }

  TextFormField buildEmailField() {
    return TextFormField(
      controller: email,
      validator: (value) {
        if (value!.isEmpty)
          return 'Please fill in E-mail field';
        else
          return null;
      },
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      decoration: const InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 2,
            color: Color.fromRGBO(252, 243, 233, 1.0),
          )
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 2,
            color: Color.fromRGBO(252, 243, 233, 1.0),
          )
        ),
        border: OutlineInputBorder(),
        labelText: 'E-mail',
        icon: Icon(Icons.email),
        hintText: 'x@x.com',
      ),
    );
  }
}