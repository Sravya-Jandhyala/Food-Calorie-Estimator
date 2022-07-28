import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'signup_screen.dart';
import 'home_screen.dart';
import '../models/authentication.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final GlobalKey<FormState> _formKey = GlobalKey();

  Map<String, String> _authData = {
    'email' : '',
    'password': ''
  };

  void _showErrorDialog(String msg)
  {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('An Error Occured'),
          content: Text(msg),
          actions: <Widget>[
            FlatButton(
              child: Text('Okay'),
              onPressed: (){
                Navigator.of(ctx).pop();
              },
            )
          ],
        )
    );
  }

  Future<void> _submit() async
  {
    final f=_formKey.currentState;
    if(f!=null && !f.validate())
    {
      return;
    }
    if(f!=null)
      {
        f.save();
      }


    try{
      final x=_authData['email'];
      final y=_authData['password'];
      if(x!=null && y!=null)
      {
        //Navigator.pop(context);
        await Provider.of<Authentication>(context, listen: false).logIn(x,y);
        Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
      }


    } catch (error)
    {
      var errorMessage = 'Authentication Failed. Please try again later.';
      _showErrorDialog(errorMessage);
    }

  }
  @override
  Widget build(BuildContext context) {
    //Navigator.pop(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Food Calorie Estimator'),
        backgroundColor: Colors.pink[700],
        actions: <Widget>[
          FlatButton(
            child: Row(
              children: <Widget>[
                Text('Signup'),
                Icon(Icons.person_add)
              ],
            ),
            textColor: Colors.white,
            onPressed: (){
              Navigator.of(context).pushReplacementNamed(SignupScreen.routeName);
            },
          )
        ],
      ),
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                color:Colors.pink[20],
            ),
          ),
          Center(
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              elevation: 15,
              shadowColor: Colors.pink,
              color: Colors.white,
              child: Container(
                height: 260,
                width: 300,
                padding: EdgeInsets.all(16),
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        //email
                        TextFormField(
                          decoration: InputDecoration(labelText: 'Email'),
                          keyboardType: TextInputType.emailAddress,
                          validator: (value)
                          {
                            if(value!=null)
                            {
                              if(value.isEmpty || !value.contains('@'))
                              {
                                return 'invalid email';
                              }
                              return null;
                            }

                          },
                          onSaved: (value)
                          {
                            if(value!=null)
                              {
                                _authData['email'] = value;
                              }
                          },
                        ),

                        //password
                        TextFormField(
                          decoration: InputDecoration(labelText: 'Password'),

                          obscureText: true,
                          validator: (value)
                          {
                            if(value!=null)
                            {
                              if(value.isEmpty || value.length<=5)
                              {
                                return 'invalid password';
                              }
                              return null;
                            }

                          },
                          onSaved: (value)
                          {
                            if(value!=null) {
                              _authData['password'] = value;
                            }
                          },
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        RaisedButton(
                          child: Text(
                              'Login'
                          ),
                          onPressed: ()
                          {
                            _submit();
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          color: Colors.pink[700],
                          textColor: Colors.white,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}