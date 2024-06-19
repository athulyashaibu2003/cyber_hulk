import 'package:cyber_hulk/utilis/color_constant/color_constant.dart';
import 'package:cyber_hulk/view/terms_and_conditions_screen/terms_and_conditions_screen.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController firstnamecontroller = TextEditingController();
  TextEditingController lastnamecontroller = TextEditingController();
  TextEditingController phnumbercontroller = TextEditingController();
  TextEditingController mailidcontroller = TextEditingController();
  TextEditingController usernamecontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController conpasswordcontroller = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  bool passwordObscure = true;

  String? validateEmail(String? email) {
    RegExp emailRegex = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    final isEmailvalid = emailRegex.hasMatch(email ?? '');
    if (!isEmailvalid) {
      return 'Please enter a valid email';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      backgroundColor: ColorConstant.mainwhite,
      appBar: AppBar(
        backgroundColor: ColorConstant.pantonemessage,
        actions: [const Text("Version 1.0.0")],
      ),
      body: SingleChildScrollView(
        // physics: BouncingScrollPhysics(),
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Form(
              key: _formkey,
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "Sign Up",
                    style: TextStyle(
                        color: ColorConstant.darkpurple,
                        fontWeight: FontWeight.w900,
                        fontSize: 40),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 50, right: 50, bottom: 10),
                    child: TextFormField(
                      style: TextStyle(color: Colors.black),
                      controller: firstnamecontroller,
                      decoration: const InputDecoration(
                        hintText: "First name",
                        hintStyle: TextStyle(
                            color: Colors
                                .black54), // Changed hint text color to black
                        border: OutlineInputBorder(),
                      ),
                      validator: (name) => name!.length < 3
                          ? "Name should be at least 3 characters"
                          : null,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 50, right: 50, bottom: 10),
                    child: TextFormField(
                      style: TextStyle(color: Colors.black),
                      controller: lastnamecontroller,
                      decoration: const InputDecoration(
                        hintText: "Last Name",
                        hintStyle: TextStyle(
                            color: Colors
                                .black54), // Changed hint text color to black
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 50, right: 50, bottom: 10),
                    child: TextFormField(
                        style: TextStyle(color: Colors.black),
                        controller: phnumbercontroller,
                        decoration: const InputDecoration(
                          hintText: "Phone Number",
                          hintStyle: TextStyle(
                              color: Colors
                                  .black54), // Changed hint text color to black
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value != null && value.length >= 7) {
                            return null;
                          } else {
                            return "Mobile number is required";
                          }
                        }),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 50, right: 50, bottom: 10),
                    child: TextFormField(
                      style: TextStyle(color: Colors.black),
                      controller: mailidcontroller,
                      decoration: const InputDecoration(
                        hintText: "Email Id",
                        hintStyle: TextStyle(
                            color: Colors
                                .black54), // Changed hint text color to black
                        border: OutlineInputBorder(),
                      ),
                      validator: validateEmail,
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 50, right: 50, bottom: 10),
                    child: TextFormField(
                        style: TextStyle(color: Colors.black),
                        controller: usernamecontroller,
                        decoration: const InputDecoration(
                          hintText: "User Name",
                          hintStyle: TextStyle(
                              color: Colors
                                  .black54), // Changed hint text color to black
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value != null && value.length >= 5) {
                            return null;
                          } else {
                            return "Please Enter a Valid Username";
                          }
                        }),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 50, right: 50, bottom: 10),
                    child: TextFormField(
                      style: TextStyle(color: Colors.black),
                      obscureText: passwordObscure,
                      controller: passwordcontroller,
                      decoration: InputDecoration(
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                passwordObscure = !passwordObscure;
                              });
                            },
                            icon: Icon(passwordObscure
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
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 50, right: 50, bottom: 10),
                    child: TextFormField(
                        style: TextStyle(color: Colors.black),
                        obscureText: passwordObscure,
                        controller: conpasswordcontroller,
                        decoration: const InputDecoration(
                          hintText: "Confirm Password",
                          hintStyle: TextStyle(
                              color: Colors
                                  .black54), // Changed hint text color to black
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value != null &&
                              value == passwordcontroller.text) {
                            return null;
                          } else {
                            return "Password does not match";
                          }
                        }),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  ElevatedButton(
                      style: ButtonStyle(
                          fixedSize:
                              WidgetStateProperty.all(const Size(330, 50)),
                          backgroundColor: WidgetStateProperty.all(
                              ColorConstant.darkpurple)),
                      onPressed: () {
                        if (_formkey.currentState!.validate()) {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => TermsConditionsScreen(
                                        firstName:
                                            firstnamecontroller.text.trim(),
                                        lastName:
                                            lastnamecontroller.text.trim(),
                                        mailid: mailidcontroller.text.trim(),
                                        phnumber:
                                            phnumbercontroller.text.trim(),
                                        username:
                                            usernamecontroller.text.trim(),
                                        password:
                                            passwordcontroller.text.trim(),
                                      )),
                              (route) => false);
                        }
                      },
                      child: const Text(
                        "Submit",
                        style: TextStyle(
                            fontSize: 20,
                            color: ColorConstant.pantonebackground),
                      )),
                  const SizedBox(
                    height: 53,
                  ),
                ],
              ),
            ),
            Container(
              color: ColorConstant.mainblack,
              height: 50,
              width: double.infinity,
              child: const Center(
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
    );
  }
}
