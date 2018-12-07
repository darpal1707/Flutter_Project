import 'package:flutter/material.dart';
import 'homePage.dart';
import 'package:intro_views_flutter/Models/page_view_model.dart';
import 'package:intro_views_flutter/intro_views_flutter.dart';

class CardsPage extends StatelessWidget {
  final pages = [
    new PageViewModel(
      mainImage: Image.asset(
        'assets/logo.png',
        height: 285.0,
        width: 285.0,
        alignment: Alignment.center,
      ),
      pageColor: const Color(0xFFd1001c),
      iconColor: Colors.white,
      body: Text(
        'Page 1',
      ),
      title: Text(
        'Title 1',
      ),
      textStyle: TextStyle(fontFamily: 'Montserrat', color: Colors.white),
    ), //page1
    new PageViewModel(
      pageColor: const Color(0xFF8a0303),
      iconColor: Colors.white,
      body: Text(
        'Page 2',
      ), //Page2
      title: Text('Title 2'),
      mainImage: Image.asset(
        'assets/logo.png',
        height: 285.0,
        width: 285.0,
        alignment: Alignment.center,
      ),
      textStyle: TextStyle(fontFamily: 'Montserrat', color: Colors.white),
    ),
    new PageViewModel(
      pageColor: const Color(0xFFa41313),
      iconColor: Colors.white,
      body: Text(
        'Page 3',
      ),
      title: Text('Title 3'),
      mainImage: Image.asset(
        'assets/logo.png',
        height: 285.0,
        width: 285.0,
        alignment: Alignment.center,
      ),
      textStyle: TextStyle(fontFamily: 'Montserrat', color: Colors.white),
    ), //Page3
  ];

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new Builder(
        builder: (context) => new IntroViewsFlutter(
              pages,
              onTapDoneButton: () {
                Navigator.push(
                  context,
                  new MaterialPageRoute(
                    builder: (context) => new HomePage(),
                  ), //MaterialPageRoute
                );
              },
              showSkipButton:
                  true, //Whether you want to show the skip button or not.
              pageButtonTextStyles: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
              ),
            ), //IntroViewsFlutter
      ), //Builder
    ); //Material App
  }
}
