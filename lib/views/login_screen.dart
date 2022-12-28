import 'package:flutter/material.dart';
import 'package:prouctapp/views/registration_screen.dart';

import 'home_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                height: 410,
                width: 430,
                color: Colors.purple,
              ),
              SingleChildScrollView(
                  child: Container(
                    child: Form(
                      child: Padding(
                        padding: EdgeInsets.only(top: 180.0, bottom: 45, left: 10, right: 10),
                        child: Card(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                            child: SizedBox(
                              width: 400,
                              height: 400,
                              child: Column(
                                children: [
                                  SizedBox(height: 30),
                                  Text("Login",
                                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900),),

                                  SizedBox(height: 10),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: 20, right: 14, left: 14, bottom: 8),
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                          hintText: "Email",
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(Radius.circular(15)),
                                          )
                                      ),
                                    ),),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: 20, right: 14, left: 14, bottom: 8),
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                          hintText: "Password",
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(Radius.circular(15)),
                                          )
                                      ),
                                    ),),
                                  SizedBox(height: 30),
                                  GestureDetector(
                                    onTap: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=> HomeScreen()));
                                    },
                                    child: Container(
                                      height: 40,
                                      width: 250,
                                      decoration: BoxDecoration(
                                          color: Colors.black,
                                          borderRadius: BorderRadius.circular(20)
                                      ),
                                      child: Center(
                                        child: Text('Login',
                                          style: TextStyle(color: Colors.white),),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  GestureDetector(
                                    onTap: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=> RegistraionScreen()));
                                    },
                                    child: Text("Don't have account register",
                                    style: TextStyle(fontWeight: FontWeight.w900),),
                                  )
                                ],
                              ),
                            )
                        ),
                      ),
                    ),
                  )
              )
            ],
          ),
        ),
      ),
    );
  }
}
