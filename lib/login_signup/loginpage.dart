import 'package:flutter/material.dart';
import 'package:splash_screen/login_signup/signuppage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:splash_screen/cardsPage.dart';

class LoginPage extends StatefulWidget {
  static String tag = 'login-page';
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = new GlobalKey<FormState>();
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String _email;
  String _password;
  String name = 'Log In';

//Validating Data
  bool validateAndSave() {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      //print('Login Successful. Email:$_email, Password:$_password');
      return true;
    }
    return false;
  }

//Signin Details Function check
  void validateAndSubmit() async {
    if (validateAndSave()) {
      try {
        FirebaseUser user = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: _email, password: _password);
        print('Signed In!: ${user.uid}');
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => CardsPage()));
      } catch (e) {
        print('Error: $e');
      }
    }
  }

  //Google Signin Function
  Future<FirebaseUser> _handleSignIn() async {
    GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    FirebaseUser user = await _auth.signInWithGoogle(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    setState(() {
      name = user.displayName.toString();
      name = user.phoneNumber.toString();
      name = user.email.toString();
    });
    print("signed in! Display Name of User: ");

    return user;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        resizeToAvoidBottomPadding: false,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              child: Stack(
                children: <Widget>[
                  Container(
                    //Login Title
                    padding: EdgeInsets.fromLTRB(16.0, 90.0, 0.0, 0.0),
                    child: Text('Log In',
                        style: TextStyle(
                            fontSize: 40.0, fontWeight: FontWeight.bold)),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(125.0, 60.0, 0.0, 0.0),
                    child: Text('.',
                        style: TextStyle(
                            fontSize: 80.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.green)),
                  )
                ],
              ),
            ),
            Form(
                key: formKey,
                child: Container(
                    padding:
                        EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
                    child: Column(
                      children: <Widget>[
                        //Email Field
                        TextFormField(
                            decoration: InputDecoration(
                                labelText: 'EMAIL',
                                labelStyle: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.green))),
                            validator: (value) => value.isEmpty
                                ? 'Email Address cannot be empty!'
                                : null,
                            onSaved: (value) => _email = value),
                        SizedBox(height: 20.0),

                        //Password Field
                        TextFormField(
                          decoration: InputDecoration(
                              labelText: 'PASSWORD',
                              labelStyle: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.green))),
                          obscureText: true,
                          validator: (value) => value.isEmpty
                              ? 'Password cannot be empty!'
                              : null,
                          onSaved: (value) => _password = value,
                        ),

                        SizedBox(height: 5.0),

                        //Forgot Password Button
                        Container(
                          alignment: Alignment(1.0, 0.0),
                          padding: EdgeInsets.only(
                              top: 15.0, left: 20.0, bottom: 15.0),
                          child: InkWell(
                            child: Text(
                              'Forgot Password?',
                              style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Montserrat',
                              ),
                            ),
                          ),
                        ),

                        //Login Button
                        ButtonTheme(
                          height: 40.0,
                          minWidth: double.infinity,
                          child: RaisedButton(
                            child: new Text("Login"),
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

                        //Google Signin Button
                        ButtonTheme(
                          height: 40.0,
                          minWidth: double.infinity,
                          child: RaisedButton(
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  borderRadius: BorderRadius.circular(20.0)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Center(
                                      child: new Image.asset(
                                    'assets/google_login.jpg',
                                    width: 25.0,
                                    height: 25.0,
                                  )),
                                  SizedBox(width: 10.0),
                                  Center(
                                    child: Text(
                                      'Log in with Google',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Montserrat'),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            textColor: Colors.white,
                            onPressed: () {
                              _handleSignIn()
                                  .then((FirebaseUser user) => print(user))
                                  .catchError((e) => print(e));
                            },
                            elevation: 7.0,
                            color: Colors.white,
                            shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30.0),
                            ),
                          ),
                        ),
                      ],
                    ))),

            //Dont have account button
            SizedBox(height: 15.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Dont have an account?',
                  style: TextStyle(fontFamily: 'Montserrat'),
                ),
                SizedBox(width: 5.0),
                InkWell(
                  onTap: () {
                    // Navigator.of(context).pushNamed('/signup');
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SignupPage()));
                  },
                  child: Text(
                    'Register',
                    style: TextStyle(
                        color: Colors.green,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline),
                  ),
                )
              ],
            )
          ],
        ));
  }
}
