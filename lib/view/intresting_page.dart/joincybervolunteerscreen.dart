import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:cyber_hulk/utilis/color_constant/color_constant.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class JoinCyberVolunteerScreen extends StatefulWidget {
  const JoinCyberVolunteerScreen({super.key});

  @override
  State<JoinCyberVolunteerScreen> createState() =>
      _JoinCyberVolunteerScreenState();
}

class _JoinCyberVolunteerScreenState extends State<JoinCyberVolunteerScreen> {
  TextEditingController firstnamecontroller = TextEditingController();
  TextEditingController lastnamecontroller = TextEditingController();
  TextEditingController mailidcontroller = TextEditingController();
  TextEditingController phnumbercontroller = TextEditingController();
  TextEditingController agecontroller = TextEditingController();
  final TextEditingController highestqualificationcontroller =
      TextEditingController();
  TextEditingController highestqualificationnamecontroller =
      TextEditingController();
  TextEditingController idproofcontroller = TextEditingController();
  TextEditingController knowaboutuscontroller = TextEditingController();
  TextEditingController otherorganisationscontroller = TextEditingController();
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

  String? selectedQualification;
  String? selectedIdProof;
  String? uploadedFilePath;
  String? imageName;

  // List of education qualifications
  List<String> qualifications = [
    "High School",
    "Bachelor's Degree",
    "Master's Degree",
    "PhD",
    "Other",
  ];

  // List of ID Proofs
  List<String> idProofs = [
    "Aadhaar Card",
    "Passport",
    "Driving License",
    "Voter ID",
    "Other",
  ];

  File? documentFile;
  // Function to pick a file
  Future<void> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      setState(() {
        documentFile = File(result.files.single.path!);
        uploadedFilePath = result.files.single.path;
      });
    }
  }

  Future<void> insertrecord(
      {required String fname,
      required String lname,
      required String mail,
      required String phn,
      required String age,
      required String qualification,
      required String enteredQualification,
      required String idname,
      required String idno,
      required File imageFile,
      required File documentFile,
      required String otherorganization,
      required String knowaboutus}) async {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('https://cybot.avanzosolutions.in/cybot/cyber_volunteers.php'),
    );

    // Add form fields
    request.fields['firstnamecontroller'] = fname;
    request.fields['lastnamecontroller'] = lname;
    request.fields['mailidcontroller'] = mail;
    request.fields['phnumbercontroller'] = phn;
    request.fields['agecontroller'] = age;
    request.fields['qualificationcontroller'] = qualification;
    request.fields['enteredqualificationcontroller'] = enteredQualification;
    request.fields['idnamecontroller'] = idname;
    request.fields['idnocontroller'] = idno;
    request.fields['otherorganisationscontroller'] = otherorganization;
    request.fields['knowaboutuscontroller'] = knowaboutus;

    // Add the file as multipart
    request.files.add(await http.MultipartFile.fromPath(
      'image',
      imageFile.path,
    ));

    request.files.add(await http.MultipartFile.fromPath(
      'files',
      documentFile.path,
    ));

    // Send the request
    try {
      var response = await request.send();

      log(response.statusCode.toString());
      var responses = await response.stream.bytesToString();
      log(responses);
      var res = "SUCCESS";
      // print(response);
      var resp = "error";

      if (responses == res) {
        print("Record inserted");
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => AlertDialog(
                    content: Text("Registered Successfully"),
                  )),
        );
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => AlertDialog(
                    content: Text("Please try again"),
                  )),
        );
      }

      // if (response.statusCode == 200) {
      //   var responseBody = await response.stream.bytesToString();
      //   var jsonResponse = jsonDecode(responseBody);
      //   log(responseBody);
      //   log(jsonResponse);
      //   // print('Response: $jsonResponse');

      //   // if (jsonResponse['status'] == 'SUCCESS') {
      //   //   print('Data uploaded successfully');
      //   // } else {
      //   //   print('Failed: ${jsonResponse['message']}');
      //   // }
      // } else {
      //   print('Failed to send request');
      // }
    } catch (e) {
      print('Error: $e');
    }
  }

  // Future<void> insertrecord() async {
  //   if (firstnamecontroller.text != "" ||
  //       lastnamecontroller.text != "" ||
  //       mailidcontroller.text != "" ||
  //       phnumbercontroller.text != "" ||
  //       agecontroller.text != "" ||
  //       selectedQualification != "" ||
  //       highestqualificationnamecontroller.text != "" ||
  //       selectedIdProof != "" ||
  //       idproofcontroller.text != "" ||
  //       uploadedFilePath != "") {
  //     try {
  //       String uri =
  //           "https://cybot.avanzosolutions.in/cybot/cyber_volunteers.php";
  //       var res = await http.post(Uri.parse(uri), body: {
  //         "firstnamecontroller": firstnamecontroller.text,
  //         "lastnamecontroller": lastnamecontroller.text,
  //         "mailidcontroller": mailidcontroller.text,
  //         "phnumbercontroller": phnumbercontroller.text,
  //         "agecontroller": agecontroller.text,
  //         "qualificationcontroller": selectedQualification,
  //         "enteredqualificationcontroller":
  //             highestqualificationnamecontroller.text,
  //         "idnamecontroller": selectedIdProof,
  //         "idnocontroller": idproofcontroller.text,
  //         "documentnamecontroller": uploadedFilePath?.split('/').last,
  //       });
  //       print(firstnamecontroller.text);
  //       print(lastnamecontroller.text);
  //       print(mailidcontroller.text);
  //       print(phnumbercontroller.text);
  //       print(agecontroller.text);
  //       print(selectedQualification);
  //       print(highestqualificationcontroller.text);
  //       print(selectedIdProof);
  //       print(idproofcontroller.text);
  //       print(uploadedFilePath?.split('/').last);
  //       log(res.body);
  //   var response = "SUCCESS";
  //   // print(response);
  //   var resp = "error";

  //   if (res.body == response) {
  //     print(res.body);
  //     print("Record inserted");
  //     Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //           builder: (context) => AlertDialog(
  //                 content: Text("Registered Successfully"),
  //               )),
  //     );
  //   }
  //   if (res.body == resp) {
  //     Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //           builder: (context) => AlertDialog(
  //                 content: Text("Please try again"),
  //               )),
  //     );
  //   }
  // } catch (e) {
  //       print(e);
  //     }
  //   } else {
  //     print("please fill all fields");
  //   }
  // }

  File? _profileImage;
  final ImagePicker _picker = ImagePicker();
  File? files;
  Future<void> pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _profileImage = File(image.path);
      });
    }
    imageName = _profileImage?.path.split('/').last;
    print(_profileImage?.path.split('/').last);
  }

  Future<void> uploadImage(File image) async {
    final uri = Uri.parse(
        "https://cybot.avanzosolutions.in/cybot/cyber_volunteers_upload.php");
    var request = http.MultipartRequest('POST', uri);

    var pic = await http.MultipartFile.fromPath("image", image.path);
    request.files.add(pic);

    var response = await request.send();
    print(response.statusCode);
    log(response.stream.toString());
    if (response.statusCode == 200) {
      print('Image Uploaded');
    } else {
      print('Image Not Uploaded');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: ColorConstant.mainwhite,
      // appBar: AppBar(
      //   backgroundColor: ColorConstant.mainwhite,
      // ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Container(
            decoration: BoxDecoration(
                color: ColorConstant.pantonebackground,
                borderRadius: BorderRadius.circular(30)),
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: SingleChildScrollView(
                //width: 500,
                child: Form(
                  key: _formkey,
                  child: Column(
                    children: [
                      Text(
                        "Volunteer Registration",
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Center(
                        child: GestureDetector(
                          onTap: pickImage,
                          child: CircleAvatar(
                            radius: 50,
                            backgroundColor: Colors.grey.shade300,
                            backgroundImage: _profileImage != null
                                ? FileImage(_profileImage!)
                                : null,
                            child: _profileImage == null
                                ? const Icon(
                                    Icons.add_a_photo,
                                    color: Colors.white,
                                    size: 50,
                                  )
                                : null,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        controller: firstnamecontroller,
                        decoration: InputDecoration(
                            hintText: 'Enter your First name',
                            labelText: "First Name*",
                            fillColor: Colors.grey[200],
                            focusColor: Colors.grey,
                            filled: true,
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(15),
                            )),
                        validator: (name) => name!.length < 3
                            ? "Name should be at least 3 characters"
                            : null,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: lastnamecontroller,
                        decoration: InputDecoration(
                            labelText: 'Last Name',
                            hintText: 'Enter your last name',
                            fillColor: Colors.grey[200],
                            focusColor: Colors.grey,
                            filled: true,
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(15),
                            )),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: mailidcontroller,
                        decoration: InputDecoration(
                            hintText: 'Enter your Mail Id',
                            labelText: "Mail Id*",
                            fillColor: Colors.grey[200],
                            focusColor: Colors.grey,
                            filled: true,
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(15),
                            )),
                        validator: validateEmail,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                          controller: phnumbercontroller,
                          decoration: InputDecoration(
                              hintText: 'Enter your Phone Number',
                              labelText: "Phone Number*",
                              fillColor: Colors.grey[200],
                              focusColor: Colors.grey,
                              filled: true,
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(15),
                              )),
                          validator: (value) {
                            if (value != null && value.length == 10) {
                              return null;
                            } else {
                              return "Please give correct number";
                            }
                          }),

                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                          controller: agecontroller,
                          decoration: InputDecoration(
                              hintText: 'Enter your Age',
                              labelText: "Age*",
                              fillColor: Colors.grey[200],
                              focusColor: Colors.grey,
                              filled: true,
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(15),
                              )),
                          validator: (value) {
                            if (value != null && value.isNotEmpty) {
                              return null;
                            } else {
                              return "Please Enter your Age";
                            }
                          }),

                      SizedBox(
                        height: 20,
                      ),
                      DropdownButtonFormField<String>(
                        validator: (value) {
                          if (value != null) {
                            return null;
                          } else {
                            return "Field is required";
                          }
                        },
                        decoration: InputDecoration(
                          labelText: "Highest Education Qualification*",
                          fillColor: Colors.grey[200],
                          focusColor: Colors.grey,
                          filled: true,
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        value: selectedQualification,
                        items: qualifications.map((String qualification) {
                          return DropdownMenuItem<String>(
                            value: qualification,
                            child: Text(qualification),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          setState(() {
                            selectedQualification = newValue;
                            if (selectedQualification != "Other") {
                              highestqualificationnamecontroller.clear();
                            }
                          });
                        },
                      ),
                      const SizedBox(height: 20),

                      // Show text field if "Other" is selected
                      if (selectedQualification == "Other")
                        TextFormField(
                          validator: (value) {
                            if (value != null) {
                              return null;
                            } else {
                              return "Field is required";
                            }
                          },
                          controller: highestqualificationnamecontroller,
                          decoration: InputDecoration(
                            labelText: "Please specify",
                            fillColor: Colors.grey[200],
                            focusColor: Colors.grey,
                            filled: true,
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        ),
                      SizedBox(
                        height: 20,
                      ),
                      DropdownButtonFormField<String>(
                        validator: (value) {
                          if (value != null) {
                            return null;
                          } else {
                            return "Field is required";
                          }
                        },
                        decoration: InputDecoration(
                          labelText: "Select ID Proof*",
                          fillColor: Colors.grey[200],
                          focusColor: Colors.grey,
                          filled: true,
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        value: selectedIdProof,
                        items: idProofs.map((String idProof) {
                          return DropdownMenuItem<String>(
                            value: idProof,
                            child: Text(idProof),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          setState(() {
                            selectedIdProof = newValue;
                          });
                        },
                      ),
                      const SizedBox(height: 20),

                      // Show text field to enter ID number
                      if (selectedIdProof != null)
                        TextFormField(
                          validator: (value) {
                            if (value != null) {
                              return null;
                            } else {
                              return "Field is required";
                            }
                          },
                          controller: idproofcontroller,
                          decoration: InputDecoration(
                            labelText: "Enter your ${selectedIdProof} number",
                            fillColor: Colors.grey[200],
                            focusColor: Colors.grey,
                            filled: true,
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: otherorganisationscontroller,
                        decoration: InputDecoration(
                            hintText: 'Are you part of any other organisation*',
                            labelText:
                                "Are you part of any other organisation*",
                            fillColor: Colors.grey[200],
                            focusColor: Colors.grey,
                            filled: true,
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(15),
                            )),
                        //     validator: validateEmail,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: knowaboutuscontroller,
                        decoration: InputDecoration(
                            hintText: 'How did u come to know about us?*',
                            labelText: "How did u come to know about us?*",
                            fillColor: Colors.grey[200],
                            focusColor: Colors.grey,
                            filled: true,
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(15),
                            )),
                        //  validator: validateEmail,
                      ),
                      SizedBox(
                        height: 20,
                      ),

                      // Button to upload the ID file
                      ElevatedButton.icon(
                        onPressed: pickFile,
                        icon: const Icon(Icons.upload_file),
                        label: const Text("Upload ID Document*"),
                      ),

                      const SizedBox(height: 10),

                      // Show the uploaded file path
                      if (uploadedFilePath != null)
                        Text(
                          "Uploaded File: ${uploadedFilePath?.split('/').last}",
                          style:
                              const TextStyle(color: ColorConstant.darkpurple),
                        ),
                      SizedBox(
                        height: 20,
                      ),

                      ElevatedButton(
                          style: ButtonStyle(
                              fixedSize: WidgetStateProperty.all(Size(300, 60)),
                              backgroundColor: WidgetStateProperty.all(
                                  ColorConstant.darkpurple)),
                          onPressed: () async {
                            // bool profile = false;
                            if (_formkey.currentState!.validate()) {
                              insertrecord(
                                  fname: firstnamecontroller.text,
                                  lname: lastnamecontroller.text,
                                  mail: mailidcontroller.text,
                                  phn: phnumbercontroller.text,
                                  age: agecontroller.text,
                                  qualification: selectedQualification ?? "",
                                  enteredQualification:
                                      highestqualificationcontroller.text,
                                  idname: selectedIdProof ?? '',
                                  idno: idproofcontroller.text,
                                  imageFile: _profileImage!,
                                  documentFile: documentFile!,
                                  otherorganization:
                                      otherorganisationscontroller.text,
                                  knowaboutus: knowaboutuscontroller.text);
                              // if (_profileImage != null) {
                              //   profile = true;
                              // } else {
                              //   profile = false;
                              //   imageName = "0";
                              // }
                              // await insertrecord();
                              // if (profile) {
                              //   await uploadImage(_profileImage!);
                              // }
                              //  print("Form submitted");
                            } else {
                              print("Form is invalid");
                            }
                          },
                          child: Text(
                            "Submit",
                            style: TextStyle(
                                fontSize: 20,
                                color: ColorConstant.pantonebackground),
                          ))
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
