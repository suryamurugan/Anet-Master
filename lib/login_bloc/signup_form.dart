import 'package:anet/login_bloc/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:anet/authentication_bloc/authentication.dart';

class SignupForm extends StatefulWidget {
  @override
  _SignupFormState createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _password1Controller = TextEditingController();
  final _password2Controller = TextEditingController();
  final _usnController = TextEditingController();
  //final _deptController = TextEditingController();
  final _ut_idController = TextEditingController();
  final _phone_numberController = TextEditingController();

  final key = GlobalKey<FormState>();

  var departmentValue = 1;
  @override
  Widget build(BuildContext context) {
    final loginBloc = BlocProvider.of<LoginBloc>(context);
    final authbloc = BlocProvider.of<AuthenticationBloc>(context);

    onRegisterButtonPressed() {
      print("Register Button Clicked");
      loginBloc.dispatch(RegisterButtonPressed(
          username: _usernameController.text.trim(),
          password1: _password1Controller.text.trim(),
          email: _emailController.text,
          usn: _usnController.text,
          dept: departmentValue,
          //ut_id: _ut_idController.text,
          phone_number: '+91' + _phone_numberController.text,
          password2: _password2Controller.text));
    }

    // final GlobalKey < FormState > formKey1 = GlobalKey < FormState > ();

    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is RegistrationFailure) {
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text('${state.error}'),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          return SingleChildScrollView(
            padding: EdgeInsets.all(20),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
                    Widget>[
              SizedBox(
                height: 20,
              ),
              Text(
                'You\'re a form away from being a part of',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                textAlign: TextAlign.start,
              ),
              SizedBox(
                height: 4,
              ),
              Row(
                children: <Widget>[
                  Text(
                    'CommunitiesIN',
                    style:
                        TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.start,
                  ),
                  Text(
                    'Atria',
                    style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.green),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Form(
                //autovalidate: false,
                key: key,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                        decoration: InputDecoration(
                            labelText: 'Username',
                            labelStyle: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                            // hintText: 'EMAIL',
                            // hintStyle: ,
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.green))),
                        controller: _usernameController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Username cannot be empty';
                          } else if (value.toString().length < 5) {
                            return 'Username length is small';
                          } else {
                            return null;
                          }
                        }

                        //onSaved: (value) => name = value,
                        ),
                    SizedBox(height: 10.0),
                    TextFormField(
                      decoration: InputDecoration(
                          labelText: 'Password ',
                          labelStyle: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.green))),
                      controller: _password1Controller,
                      obscureText: true,
                      validator: validatePassword,
                      //onSaved: (value) => name = value,
                    ),
                    SizedBox(height: 10.0),
                    TextFormField(
                        decoration: InputDecoration(
                            labelText: 'Re-enter Password ',
                            labelStyle: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.green))),
                        controller: _password2Controller,
                        validator: (value) {
                          if (value.toString() !=
                              _password1Controller.text.toString()) {
                            return "Password doesn't match";
                          }
                        }),
                    SizedBox(height: 10.0),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          labelText: 'Email',
                          labelStyle: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.green))),
                      controller: _emailController,
                      validator: validateEmail,
                    ),
                    SizedBox(height: 10.0),
                    TextFormField(
                      textCapitalization: TextCapitalization.characters,
                      decoration: InputDecoration(
                          labelText: 'USN',
                          labelStyle: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.green))),
                      controller: _usnController,
                      validator: (value) =>
                          value.isEmpty ? "Field cannot be empty" : null,
                    ),
                    SizedBox(height: 10.0),
                    /*   TextFormField(
                          decoration: InputDecoration(
                              labelText: 'Department',
                              labelStyle: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.green))),
                          // controller: _usnController,
                          validator: (value) =>
                              value.isEmpty ? "Field cannot be empty" : null,
                        ), */
                    DropdownButtonFormField<int>(
                      items: [
                        DropdownMenuItem<int>(
                          value: 1,
                          child: Text(
                            "Computer Science & Engineering",
                          ),
                        ),
                        DropdownMenuItem<int>(
                          value: 2,
                          child: Text(
                            "Information Science  & Engineering",
                          ),
                        ),
                        DropdownMenuItem<int>(
                          value: 3,
                          child: Text(
                            "Electronics & Communication Engineering",
                          ),
                        ),
                        DropdownMenuItem<int>(
                          value: 4,
                          child: Text(
                            "Mechanical Engineering",
                          ),
                        ),
                        DropdownMenuItem<int>(
                          value: 5,
                          child: Text(
                            "Civil Engineering",
                          ),
                        ),
                        DropdownMenuItem<int>(
                          value: 6,
                          child: Text(
                            "MBA",
                          ),
                        ),
                      ],
                      onChanged: (value) {
                        print("value: $value");
                        setState(() {
                          departmentValue = value;
                        });
                      },
                      value: departmentValue,
                      hint: Text(
                        "Please select the number!",
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(height: 10.0),
                    TextFormField(
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                          labelText: 'Phone Number',
                          labelStyle: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.green))),
                      controller: _phone_numberController,
                      validator: validateMobile,
                    ),
                    SizedBox(height: 50.0),
                    Container(
                        height: 40.0,
                        child: Material(
                          borderRadius: BorderRadius.circular(20.0),
                          shadowColor: Colors.greenAccent,
                          color: Colors.green,
                          elevation: 7.0,
                          child: SizedBox.expand(
                            child: RaisedButton(
                              onPressed: () {
                                print("hi");
                                if (key.currentState.validate()) {
                                  print("ih");
                                  print("Hi.... KAKAKEKETUKETUKE!!");
                                  onRegisterButtonPressed();
                                  //Navigator.of(context).pop();
                                }
                              },
                              child: Text(
                                'SIGNUP',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Montserrat'),
                              ),
                              shape: StadiumBorder(),
                              color: Colors.green,
                              splashColor: Colors.greenAccent,
                              colorBrightness: Brightness.dark,
                            ),
                          ),
                        )),
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
                            //Navigator.of(context).pop();
                            authbloc.dispatch(LoggedOut());
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
                ),
              )
            ]),
          );
        },
      ),
    );
  }

  String validateEmail(String value) {
    //Pattern pattern = r'^*';
    //r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    //RegExp regex = new RegExp(pattern);
    //if (!regex.hasMatch(value))
    // return 'Enter Valid Email';
    //else
    return null;
  }

  String validateMobile(String value) {
// Indian Mobile number are of 10 digit only
    if (value.length != 10)
      return 'Mobile Number must be of 10 digit';
    else
      return null;
  }

  String validatePassword(String value) {
    if (value.length < 7)
      return 'Password length must be > 7 charaters';
    else
      return null;
  }
}
