import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:splash_screen/cardsPage.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  String _fullname;
  String _email;
  String _confirmEmail;
  String _password;
  String _phoneNo;

  final formKey = new GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;

//Validating Data Function
  bool validateAndSave() {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      //print('Login Successful. Email:$_email, Password:$_password');
      return true;
    }
    return false;
  }

//Creating a User on Firebase Function
  void validateAndSubmit() async {
    if (validateAndSave()) {
      try {
        FirebaseUser user = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: _email, password: _password);
        print('Account Created!: ${user.uid}');
        Future.delayed(
            Duration.zero,
            () => Navigator.push(
                context, MaterialPageRoute(builder: (context) => CardsPage())));
      } catch (e) {
        print('Error: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        resizeToAvoidBottomPadding: false,
        body: ListView(
          //crossAxisAlignment: CrossAxisAlignment.start, 
          children: <Widget>[
          Container(
            child: Stack(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.fromLTRB(16.0, 90.0, 0.0, 0.0),
                  child: Text(
                    'Signup',
                    style:
                        TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(140.0, 65.0, 0.0, 0.0),
                  child: Text(
                    '.',
                    style: TextStyle(
                        fontSize: 80.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.green),
                  ),
                ),
              ],
            ),
          ),
          Form(
            key: formKey,
            child: Container(
                padding: EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
                child: Column(
                  children: <Widget>[
                    //Full Name Field
                    TextFormField(
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                            labelText: 'Full Name',
                            labelStyle: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                            // hintText: 'EMAIL',
                            // hintStyle: ,
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.green))),
                        validator: (value) => value.isEmpty
                            ? 'Name cannot be Blank Field!'
                            : null,
                        onSaved: (value) => _fullname = value),

                    //Email Address Field
                    SizedBox(height: 10.0),
                    TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            labelText: 'Email Address ',
                            labelStyle: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.green))),
                        obscureText: false,
                        validator: (value) =>
                            value.isEmpty ? 'Email cannot be empty!' : null,
                        onSaved: (value) => _email = value),

                    //Confirm Email Address Field
                    SizedBox(height: 10.0),
                    TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            labelText: 'Confirm Email Address ',
                            labelStyle: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.green))),
                        validator: (value) =>
                            value.isEmpty ? 'Email cannot be empty!' : null,
                        onSaved: (value) => _confirmEmail = value),

                    //Password Field
                    SizedBox(height: 10.0),
                    TextFormField(
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                            labelText: 'Password',
                            labelStyle: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.green))),
                        obscureText: true,
                        validator: (value) =>
                            value.isEmpty ? 'Password cannot be empty!' : null,
                        onSaved: (value) => _password = value),

                    //Phone Number Field
                    SizedBox(height: 10.0),
                    TextFormField(
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                            labelText: 'Phone Number ',
                            labelStyle: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.green))),
                        obscureText: false,
                        validator: (value) => value.isEmpty
                            ? 'Phone number cannot be Blank Field!'
                            : null,
                        onSaved: (value) => _phoneNo = value),

                    //Login Button
                    SizedBox(height: 20.0),
                    ButtonTheme(
                      height: 40.0,
                      minWidth: double.infinity,
                      child: RaisedButton(
                        child: new Text("Signup"),
                        textColor: Colors.white,
                        onPressed: () {
                          validateAndSubmit();
                        },
                        color: Colors.green,
                        elevation: 7.0,
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0),
                        ),
                      ),
                    ),

                    // Back Button
                    SizedBox(height: 20.0),
                    Container(
                      height: 40.0,
                      color: Colors.transparent,
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.black,
                                style: BorderStyle.solid,
                                width: 1.0),
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(20.0)),
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Center(
                            child: Text('Go Back',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Montserrat')),
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
          )
        ]));
  }
}
