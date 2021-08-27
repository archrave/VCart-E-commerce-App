import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth.dart';
import '../models/http_exception.dart';

enum AuthMode { Signup, Login }

class AuthScreen extends StatelessWidget {
  static const routeName = '/auth';

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).accentColor.withOpacity(0.05),
            ),
          ),
          SingleChildScrollView(
            child: Container(
              height: deviceSize.height,
              width: deviceSize.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 50,
                  ),
                  // Commented this flexible to make the card entirely visible in signup mode
                  // Flexible(
                  //   child:
                  Container(
                    margin: EdgeInsets.only(bottom: 20.0),
                    padding:
                        EdgeInsets.symmetric(vertical: 8.0, horizontal: 50.0),
                    // transform: Matrix4.rotationZ(-8 * pi / 180)
                    //   ..translate(-10.0),
                    // ..translate(-10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 70,
                          padding:
                              EdgeInsets.symmetric(horizontal: 8, vertical: 13),
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
                  ),
                  // ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: EdgeInsets.all(8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // SizedBox(width: 50),
                        Text(
                          'Hello',
                          style: TextStyle(
                            fontSize: 35,
                            fontFamily: 'Nexa',
                            fontWeight: FontWeight.w900,
                            color: Colors.blueGrey[900],
                          ),
                        ),
                        Text(
                          ' there!',
                          style: TextStyle(
                            fontSize: 35,
                            fontFamily: 'Nexa',
                            fontWeight: FontWeight.w900,
                            color: Colors.blueGrey[900],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    flex: deviceSize.width > 600 ? 2 : 1,
                    child: AuthCard(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AuthCard extends StatefulWidget {
  const AuthCard({
    Key key,
  }) : super(key: key);

  @override
  _AuthCardState createState() => _AuthCardState();
}

// This Mixin provides a few more methods and properties which are implicitly used by vsync and animationcontroller,etc. (behind the scenes). using this to apply animations.
class _AuthCardState extends State<AuthCard>
    with SingleTickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey();
  AuthMode _authMode = AuthMode.Login;
  Map<String, String> _authData = {
    'email': '',
    'password': '',
  };
  var _isLoading = false;
  final _passwordController = TextEditingController();
  // var containerHeight = 260;
  AnimationController _controller;
  Animation<Size> _heightAnimation;
  Animation<double> _opacityAnimation;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
    _heightAnimation = Tween<Size>(
            begin: Size(double.infinity, 260), end: Size(double.infinity, 320))
        .animate(
      //Curve.linear animates it linearly
      CurvedAnimation(
        parent: _controller,
        curve: Curves.linear,
      ),
    );
    _opacityAnimation = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeIn,
      ),
    );

    // Using AnimatedBuilder(AnimatedContainer now) now instead of manually managing a listener

    // //Adding a listener to call setState to redraw the screen.
    // _heightAnimation.addListener(
    //   () => setState(() {}),
    // );

    /*
      Animation set up syntax :

    _controller = AnimationController(vsync:, duration:);
    _animation = Tween<>(begin: , end:, ).animate( CurvedAnimation(parent: (contoller), curve: (animation type),),);
 
   */
  }

// Disposing the controller
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('An error occurred!'),
        content: Text(message),
        actions: [
          RaisedButton(
            child: Text('Close'),
            color: Theme.of(ctx).accentColor,
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          ),
        ],
      ),
    );
  }

  void _submit() async {
    if (!_formKey.currentState.validate()) {
      // Invalid!
      return;
    }
    _formKey.currentState.save();
    setState(() {
      _isLoading = true;
    });

    try {
      if (_authMode == AuthMode.Login) {
        // Log user in
        await Provider.of<Auth>(context, listen: false).login(
          _authData['email'],
          _authData['password'],
        );
      } else {
        // Sign user up
        await Provider.of<Auth>(context, listen: false).signup(
          _authData['email'],
          _authData['password'],
        );
      }
      setState(
          () {}); // This fixed the loading spinner error somehow ^_^ (i realised that didnt solve it, and the error was from firebase only ig)

    } on HttpException catch (error) {
      var errorMessage = 'Authentication failed.';
      if (error.toString().contains('EMAIL_EXISTS')) {
        errorMessage = 'This email address is already in use. Try logging in.';
      }
      if (error.toString().contains('INVALID_EMAIL')) {
        errorMessage = 'Please enter a valid email address.';
      }
      if (error.toString().contains('WEAK_PASSWORD')) {
        errorMessage = 'This password is too weak.';
      }
      if (error.toString().contains('EMAIL_NOT_FOUND')) {
        errorMessage = 'Could not find a user with that email.';
      }
      if (error.toString().contains('INVALID_PASSWORD')) {
        errorMessage = 'Incorrect password! Please try again.';
      }
      _showErrorDialog(errorMessage);
      setState(() {});
    } catch (error) {
      const errorMessage =
          'Could not authenticate you. Please try again later.';
      _showErrorDialog(errorMessage);
      setState(() {});
    }
    setState(() {
      _isLoading = false;
    });
  }

  void _switchAuthMode() {
    if (_authMode == AuthMode.Login) {
      setState(() {
        _authMode = AuthMode.Signup;
      });
      // Kicking off the animation
      _controller.forward();
    } else {
      setState(() {
        _authMode = AuthMode.Login;
      });
      // Kicking back the animation (apacityAnim)
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 8.0,

      // Delted AnimatedBuilder and replaced it with AnimatedContainer

      // For this we don't need that animationController and the pre declared heightAnimation
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        curve: Curves.linear,
        height: _authMode == AuthMode.Signup ? 320 : 260,

        // Calling the height component of the animation.
        // height: _heightAnimation.value.height,
        constraints:
            BoxConstraints(minHeight: _authMode == AuthMode.Signup ? 320 : 260),
        //     BoxConstraints(
        //   minHeight: _heightAnimation.value.height,
        // ),
        width: deviceSize.width * 0.75,
        padding: EdgeInsets.all(16.0),

        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(
                      labelText: 'E-Mail',
                      prefixIcon: Icon(
                        Icons.email_outlined,
                        size: 20,
                      )),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value.isEmpty || !value.contains('@')) {
                      return 'Invalid email!';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _authData['email'] = value;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Password',
                    prefixIcon: Icon(
                      Icons.lock_outlined,
                      size: 20,
                    ),
                  ),
                  obscureText: true,
                  controller: _passwordController,
                  validator: (value) {
                    if (value.isEmpty || value.length < 5) {
                      return 'Password is too short!';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _authData['password'] = value;
                  },
                ),
                // if (_authMode == AuthMode.Signup)

                // Adding this so that extra space w 0 opacity goes away(shrinks)
                AnimatedContainer(
                  constraints: BoxConstraints(
                    minHeight: _authMode == AuthMode.Signup ? 60 : 0,
                    maxHeight: _authMode == AuthMode.Signup ? 120 : 0,
                  ),
                  curve: Curves.easeIn,
                  duration: Duration(milliseconds: 300),
                  child: FadeTransition(
                    opacity: _opacityAnimation,
                    child: TextFormField(
                      enabled: _authMode == AuthMode.Signup,
                      decoration: InputDecoration(
                        labelText: 'Confirm Password',
                        // icon: Icon(
                        //   Icons.lock,
                        //   size: 20,
                        // ),
                        prefixIcon: Icon(
                          Icons.lock,
                          size: 20,
                        ),
                      ),
                      obscureText: true,
                      validator: _authMode == AuthMode.Signup
                          ? (value) {
                              if (value != _passwordController.text) {
                                return 'Passwords do not match!';
                              }
                              return null;
                            }
                          : null,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                if (_isLoading)
                  CircularProgressIndicator()
                else
                  Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Theme.of(context).accentColor.withOpacity(0.6),
                          blurRadius: 20,
                          spreadRadius: 1,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: RaisedButton(
                      child: Text(
                          _authMode == AuthMode.Login ? 'LOGIN' : 'SIGN UP'),
                      onPressed: _submit,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: EdgeInsets.symmetric(
                          horizontal: 80.0, vertical: 10.0),
                      color: Theme.of(context).accentColor,
                      textColor:
                          Theme.of(context).primaryTextTheme.button.color,
                    ),
                  ),
                FlatButton(
                  child: Text(
                    '${_authMode == AuthMode.Login ? 'SIGNUP' : 'LOGIN'} INSTEAD',
                    style: TextStyle(fontSize: 12),
                  ),
                  onPressed: _switchAuthMode,
                  padding: EdgeInsets.fromLTRB(30, 10, 30, 8),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  textColor: Theme.of(context).accentColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
