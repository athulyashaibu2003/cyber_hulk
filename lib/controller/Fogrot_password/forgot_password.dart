import 'package:cyber_hulk/utilis/color_constant/color_constant.dart';
import 'package:cyber_hulk/view/login_screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController loginusernamecontroller = TextEditingController();
  TextEditingController passwordconttroller = TextEditingController();
  TextEditingController conpasswordcontroller = TextEditingController();
  bool passwordVisible = false;
  final _formkey = GlobalKey<FormState>();
  String? validateEmail(String? email) {
    RegExp emailRegex = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    final isEmailvalid = emailRegex.hasMatch(email ?? '');
    if (!isEmailvalid) {
      return 'Please enter a valid email';
    }
    return null;
  }

  Future<void> insertrecord() async {
    if (loginusernamecontroller.text.isNotEmpty ||
        passwordconttroller.text.isNotEmpty ||
        emailcontroller.text.isNotEmpty) {
      try {
        String uri =
            "https://cybot.avanzosolutions.in/cybot/forgetpassword.php";
        var res = await http.post(Uri.parse(uri), body: {
          "loginusernamecontroller": loginusernamecontroller.text,
          "emailcontroller": emailcontroller.text,
          "passwordconttroller": passwordconttroller.text,
        });
        var response = "success";
        //  var resp = "WRONG CREDENTIALS";
        //print("${res.body}${passwordconttroller.text}");
        print("athulya${res.body}");
        if (res.body == response) {
          //  print("Record inserted");
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                "Reset Successful",
                style: TextStyle(color: Colors.green),
              ),
              duration: Duration(seconds: 2),
            ),
          );
          Future.delayed(const Duration(milliseconds: 10), () {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
                (route) => false);
          });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                "Reset UnSuccessful",
                style: TextStyle(color: Colors.red),
              ),
              duration: Duration(seconds: 2),
            ),
          );
          Future.delayed(const Duration(milliseconds: 10), () {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (context) => const ForgotPasswordScreen()),
                (route) => false);
          });
        }
      } catch (e) {
        print(e);
      }
    } else {
      print("please fill all fields");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: ColorConstant.pantonebackground,
        title: const Text(
          "Forgot Password",
          style: TextStyle(
              fontWeight: FontWeight.bold, color: ColorConstant.darkpurple),
        ),
      ),
      body: Form(
        key: _formkey,
        child: SingleChildScrollView(
          child: Column(
            //  mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 60,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 50, right: 50, bottom: 10),
                child: TextFormField(
                    style: const TextStyle(color: Colors.black),
                    controller: loginusernamecontroller,
                    decoration: const InputDecoration(
                        hintText: "User Name",
                        hintStyle: TextStyle(color: Colors.black54),
                        border: OutlineInputBorder()),
                    validator: (value) {
                      if (value != null && value.length >= 5) {
                        return null;
                      } else {
                        return "Please Enter a Valid Username";
                      }
                    }),
              ),
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 50, right: 50, bottom: 10),
                child: TextFormField(
                  style: const TextStyle(color: Colors.black),
                  //   controller: mailidcontroller,
                  decoration: const InputDecoration(
                      hintText: "Email Id",
                      hintStyle: TextStyle(color: Colors.black54),
                      border: OutlineInputBorder()),
                  validator: validateEmail,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 50, right: 50, bottom: 10),
                child: TextFormField(
                  style: const TextStyle(color: Colors.black),
                  obscureText: passwordVisible,
                  controller: passwordconttroller,
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
                      hintStyle: const TextStyle(color: Colors.black54),
                      border: const OutlineInputBorder()),
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
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 50, right: 50, bottom: 10),
                child: TextFormField(
                    style: const TextStyle(color: Colors.black),
                    controller: conpasswordcontroller,
                    decoration: const InputDecoration(
                        hintText: "Confirm Pssword",
                        hintStyle: TextStyle(color: Colors.black54),
                        border: OutlineInputBorder()),
                    validator: (value) {
                      if (value != null && value == passwordconttroller.text) {
                        return null;
                      } else {
                        return "Password is not match";
                      }
                    }),
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                  style: ButtonStyle(
                      fixedSize: WidgetStateProperty.all(const Size(330, 50)),
                      backgroundColor:
                          WidgetStateProperty.all(ColorConstant.darkpurple)),
                  onPressed: () async {
                    // if (_formkey.currentState!.validate()) {
                    //   bool success = await insertrecord();
                    //   if (success) {
                    //     ScaffoldMessenger.of(context).showSnackBar(
                    //       SnackBar(
                    //         content: Text("Reset Successful"),
                    //         duration: Duration(seconds: 2),
                    //       ),
                    //     );
                    //     Future.delayed(Duration(seconds: 2), () {
                    //       Navigator.pushAndRemoveUntil(
                    //           context,
                    //           MaterialPageRoute(
                    //               builder: (context) => LoginScreen()),
                    //           (route) => false);
                    //     });
                    //   } else {
                    //     ScaffoldMessenger.of(context).showSnackBar(
                    //       SnackBar(content: Text("Reset failed")),
                    //     );
                    //   }
                    // }
                    _formkey.currentState!.validate();
                    insertrecord();
                  },
                  child: const Text(
                    "Reset",
                    style:
                        TextStyle(fontSize: 15, color: ColorConstant.mainwhite),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
