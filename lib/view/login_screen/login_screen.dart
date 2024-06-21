import 'package:cyber_hulk/controller/Fogrot_password/forgot_password.dart';
import 'package:cyber_hulk/utilis/Authentication.dart';
import 'package:cyber_hulk/utilis/color_constant/color_constant.dart';
import 'package:cyber_hulk/view/bottom_navigationbar_screens/bottom_navigation_screen.dart';
import 'package:cyber_hulk/view/signup_screen/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController loginusernamecontroller = TextEditingController();
  TextEditingController loginpasswordcontroller = TextEditingController();
  TextEditingController usernamecontroller = TextEditingController();
  bool passwordVisible = false;
  final _formkey = GlobalKey<FormState>();
  final _bioFormKey = GlobalKey<FormState>();
  bool isChecked = false;
  late Box box1;

  @override
  void initState() {
    super.initState();
    createOpenBox();
    passwordVisible = true;
  }

  void createOpenBox() async {
    box1 = await Hive.openBox('logindata');
    checkLoginStatus();
  }

  void checkLoginStatus() {
    if (box1.get('isLoggedIn') == true) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => BottomNavigationScreen()),
      );
    } else {
      getdata();
    }
  }

  void getdata() async {
    if (box1.get('email') != null) {
      loginusernamecontroller.text = box1.get('email');
      isChecked = true;
      setState(() {});
    }
    if (box1.get('pass') != null) {
      loginpasswordcontroller.text = box1.get('pass');
      isChecked = true;
      setState(() {});
    }
  }

  Future<void> insertrecord() async {
    if (loginusernamecontroller.text.isNotEmpty &&
        loginpasswordcontroller.text.isNotEmpty) {
      try {
        String uri =
            "https://cybot.avanzosolutions.in/cybot/insert_recordtest.php";
        var res = await http.post(Uri.parse(uri), body: {
          "loginusernamecontroller": loginusernamecontroller.text,
          "loginpasswordcontroller": loginpasswordcontroller.text
        });
        var response = "success";
        var resp = "WRONG CREDENTIALS";

        if (res.body == response) {
          print("Record inserted");
          // Save the login state and credentials
          box1.put('isLoggedIn', true);
          if (isChecked) {
            box1.put('email', loginusernamecontroller.text);
            box1.put('pass', loginpasswordcontroller.text);
          }
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                "Login Successfully",
                style: TextStyle(color: Colors.green),
              ),
              duration: Duration(milliseconds: 1500),
            ),
          );
          Future.delayed(Duration(milliseconds: 1500), () {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (context) => BottomNavigationScreen()),
                (route) => false);
          });
          loginpasswordcontroller.clear();
          loginusernamecontroller.clear();
        } else if (res.body == resp) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                "Login Unsuccessful",
                style: TextStyle(color: Colors.red),
              ),
              duration: Duration(seconds: 2),
            ),
          );
        }
      } catch (e) {
        print(e);
      }
    } else {
      print("Please fill all fields");
    }
  }

  Future<void> biometricAuth() async {
    if (usernamecontroller.text.isNotEmpty) {
      try {
        String uri =
            "https://cybot.avanzosolutions.in/cybot/insert_recordfinger.php";
        var res = await http.post(Uri.parse(uri), body: {
          "usernamecontroller": usernamecontroller.text.trim(),
        });
        var response = "success";
        var resp = "WRONG CREDENTIALS";

        if (res.body == response) {
          bool auth = await Authentication.authentication();
          print("can Authenticate :$auth");
          if (auth) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => BottomNavigationScreen(),
              ),
            );
          }
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                "Login Successfully",
                style: TextStyle(color: Colors.green),
              ),
              duration: Duration(milliseconds: 1500),
            ),
          );
          Future.delayed(Duration(milliseconds: 1500), () {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (context) => BottomNavigationScreen()),
                (route) => false);
          });
          usernamecontroller.clear();
        } else if (res.body == resp) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                "Login Unsuccessful",
                style: TextStyle(color: Colors.red),
              ),
              duration: Duration(seconds: 2),
            ),
          );
        }
      } catch (e) {
        print(e);
      }
    } else {
      print("Please fill all fields");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: ColorConstant.pantonebackground,
        actions: [Text("Version 1.0.0")],
      ),
      body: SingleChildScrollView(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Form(
          key: _formkey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Image.asset(
                    "assets/images/CH green final.png",
                    height: 200,
                  ),
                  // Text(
                  //   "WELCOME",
                  //   style: TextStyle(
                  //       color: Colorconstant.darkpurple,
                  //       fontWeight: FontWeight.w900,
                  //       fontSize: 40),
                  // ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: TextFormField(
                        style: TextStyle(color: Colors.black),
                        controller: loginusernamecontroller,
                        decoration: InputDecoration(
                            hintText: "Username",
                            hintStyle: TextStyle(color: Colors.black54),
                            border: OutlineInputBorder()),
                        validator: (value) {
                          if (value != null && value.length >= 5) {
                            return null;
                          } else {
                            return "Username is Required";
                          }
                        }),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: TextFormField(
                      style: TextStyle(color: Colors.black),
                      obscureText: passwordVisible,
                      controller: loginpasswordcontroller,
                      decoration: InputDecoration(
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                passwordVisible = !passwordVisible;
                              });
                            },
                            icon: Icon(passwordVisible
                                ? Icons.visibility
                                : Icons.visibility_off),
                          ),
                          hintText: "Password",
                          hintStyle: TextStyle(color: Colors.black54),
                          border: OutlineInputBorder()),
                      validator: (value) {
                        if (value != null && value.length >= 7) {
                          return null;
                        } else {
                          return "Password is Required";
                        }
                      },
                      keyboardType: TextInputType.visiblePassword,
                      textInputAction: TextInputAction.done,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Remember Me",
                        style: TextStyle(color: ColorConstant.mainblack),
                      ),
                      Checkbox(
                        value: isChecked,
                        onChanged: (value) {
                          isChecked = value!;
                          setState(() {});
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 60),
                        child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ForgotPasswordScreen()));
                            },
                            child: Text(
                              "Forgot Password",
                              style: TextStyle(
                                  color: ColorConstant.darkpurple,
                                  decoration: TextDecoration.underline),
                            )),
                      ),
                    ],
                  ),
                  ElevatedButton(
                      style: ButtonStyle(
                          fixedSize: WidgetStateProperty.all(Size(330, 50)),
                          backgroundColor: WidgetStateProperty.all(
                              ColorConstant.darkpurple)),
                      onPressed: () {
                        if (_formkey.currentState!.validate()) {
                          insertrecord();
                        }
                      },
                      child: Text(
                        "Login",
                        style: TextStyle(
                            fontSize: 15, color: ColorConstant.mainwhite),
                      )),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Login with Biometrics",
                    style: TextStyle(color: ColorConstant.mainblack),
                  ),
                  IconButton(
                      onPressed: () async {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Form(
                              key: _bioFormKey,
                              child: TextFormField(
                                  controller: usernamecontroller,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: "Username",
                                  ),
                                  validator: (value) {
                                    if (value != null && value.length >= 5) {
                                      return null;
                                    } else {
                                      return "Enter a valid username for login";
                                    }
                                  }),
                            ),
                            actions: [
                              IconButton(
                                  onPressed: () async {
                                    if (_bioFormKey.currentState!.validate()) {
                                      biometricAuth();
                                    }
                                  },
                                  icon: Icon(
                                    Icons.fingerprint,
                                    color: ColorConstant.mainblack,
                                    size: 50,
                                  )),
                            ],
                          ),
                        );
                        // Box box = await Hive.openBox('logindata');
                        // bool isLoggedIn = box.get('termsAccepted');
                        // if (isLoggedIn) {
                      },
                      icon: Icon(
                        Icons.fingerprint,
                        color: ColorConstant.mainblack,
                        size: 50,
                      )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account?",
                        style: TextStyle(color: ColorConstant.mainblack),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignUpScreen()));
                          },
                          child: Text(
                            "Signup",
                            style: TextStyle(
                                color: ColorConstant.darkpurple,
                                decoration: TextDecoration.underline),
                          ))
                    ],
                  ),
                  SizedBox(
                    height: 28,
                  ),
                ],
              ),
              Container(
                color: ColorConstant.mainblack,
                height: 50,
                width: double.infinity,
                child: Center(
                  child: Text(
                    "Developed by Avanzo Cyber Security Solutions",
                    style:
                        TextStyle(fontSize: 10, color: ColorConstant.mainwhite),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
