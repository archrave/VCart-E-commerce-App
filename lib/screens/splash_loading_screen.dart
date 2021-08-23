import 'package:flutter/material.dart';

class SplashLoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 70,
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 13),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset(
                        'images/cartpic.png',
                        scale: 8,
                      ),
                    ],
                  ),
                ),
                Text(
                  'V',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 40,
                    fontFamily: 'Nexa',
                    //fontWeight: FontWeight.w300,
                  ),
                ),
                Text(
                  'CART',
                  style: TextStyle(
                    color: Theme.of(context).accentColor,
                    fontSize: 40,
                    fontFamily: 'Nexa',
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            CircularProgressIndicator(
              strokeWidth: 3,
              color: Colors.blueGrey,
              backgroundColor: Colors.grey[400],
            ),
          ],
        ),
      ),
    );
  }
}
