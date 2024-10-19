import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:carousel_slider_plus/carousel_slider_plus.dart'
    as CarouselSlider1;
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

  bool _isChecked = false;
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

  String applicationid = "";

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
      applicationid = responses;
      //   var res = "SUCCESS";
      //print(response);
      var resp = "error";

      if (responses != resp) {
        print("Record inserted");
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => AlertDialog(actions: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Registered Successfully",
                              style: TextStyle(fontSize: 20),
                            ),
                            Text(
                              "Your Application id is",
                              style: TextStyle(fontSize: 23),
                            ),
                            Text(
                              applicationid,
                              style: TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.w900),
                            )
                          ],
                        ),
                      ),
                    ),
                  ])),
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
    } catch (e) {
      print('Error: $e');
    }
  }

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

  final List<String> imageList = [
    'https://img.freepik.com/free-vector/business-logo_23-2147503133.jpg',
    'https://www.shutterstock.com/image-vector/modern-vector-graphic-leaf-abstrack-600nw-1960180105.jpg',
    'https://static.vecteezy.com/system/resources/thumbnails/011/883/295/small/modern-graphic-troly-colorful-logo-good-for-technology-logo-e-commerce-logo-online-shop-logo-company-logo-dummy-logo-bussiness-logo-free-vector.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //   appBar: AppBar(),
      backgroundColor: ColorConstant.mainwhite,
      // appBar: AppBar(
      //   backgroundColor: ColorConstant.mainwhite,
      // ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: SingleChildScrollView(
            child: Column(
              children: [
                CarouselSlider1.CarouselSlider(
                  options: CarouselSlider1.CarouselOptions(
                    height: 180.0,
                    autoPlay: true,
                    enlargeCenterPage: true,
                    aspectRatio: 16 / 9,
                    enableInfiniteScroll: true,
                    autoPlayInterval: Duration(seconds: 3),
                  ),
                  items: imageList
                      .map((item) => Container(
                            child: Center(
                              child: Image.network(item,
                                  fit: BoxFit.cover, width: 1000),
                            ),
                          ))
                      .toList(),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                    "Volunteering is a voluntary act of an individual or group freely giving time and labor, often for community service. Many volunteers are specifically trained in the areas they work, such as medicine, education, or emergency rescue. Others serve on an as-needed basis, such as in response to a natural disaster.         "),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Yes i want to be an Volunteer"),
                    Checkbox(
                      value: _isChecked,
                      onChanged: (bool? value) {
                        setState(() {
                          _isChecked = value ?? false;
                        });
                      },
                    ),
                  ],
                ),
                if (_isChecked == true)
                  Container(
                    decoration: BoxDecoration(
                        color: ColorConstant.pantonebackground,
                        borderRadius: BorderRadius.circular(30)),
                    child: Padding(
                      padding: const EdgeInsets.all(30),
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
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
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
                                  labelText:
                                      "Enter your ${selectedIdProof} number",
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
                                  hintText:
                                      'Are you part of any other organisation*',
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
                                  labelText:
                                      "How did u come to know about us?*",
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
                                style: const TextStyle(
                                    color: ColorConstant.darkpurple),
                              ),
                            SizedBox(
                              height: 20,
                            ),

                            ElevatedButton(
                                style: ButtonStyle(
                                    fixedSize:
                                        WidgetStateProperty.all(Size(300, 60)),
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
                                        qualification:
                                            selectedQualification ?? "",
                                        enteredQualification:
                                            highestqualificationcontroller.text,
                                        idname: selectedIdProof ?? '',
                                        idno: idproofcontroller.text,
                                        imageFile: _profileImage!,
                                        documentFile: documentFile!,
                                        otherorganization:
                                            otherorganisationscontroller.text,
                                        knowaboutus:
                                            knowaboutuscontroller.text);
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
