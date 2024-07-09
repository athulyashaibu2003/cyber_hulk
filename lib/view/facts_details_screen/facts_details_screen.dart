import 'package:cyber_hulk/main.dart';
import 'package:cyber_hulk/utilis/color_constant/color_constant.dart';
import 'package:cyber_hulk/utilis/dummy_db.dart/dummy_db.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class FactsDetailsScreen extends StatelessWidget {
  const FactsDetailsScreen({super.key, required this.index});
  final int index;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFF8E44AD),
      appBar: AppBar(
        backgroundColor: const Color(0XFF8E44AD),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          Expanded(
            child: ListView.separated(
              itemCount: BottomSheetContainer.info[index]['des'].length,
              itemBuilder: (context, check) {
                // int questionLength =
                //     BottomSheetContainer.info[0][check].length;
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: ColorConstant.mainwhite,
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0, 3),
                          blurRadius: 5,
                        )
                      ],
                      // gradient:
                      //     LinearGradient(begin: Alignment.topLeft, colors: [
                      //   // Color(0xff6A0DAD),
                      //   //   Color(0xff8E44AD),
                      //   Color(0xff9B59B6),
                      //   Color(0xffBB8FCE)

                      //   // Color(0XFFEAAFC8),
                      //   // Color(0XFF654EA3),
                      // ]),
                    ),
                    child: ListTile(
                      title: Text(
                          // textAlign: TextAlign.justify,
                          BottomSheetContainer.info[index]['des'][check]
                              ['question'],
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 30,
                                color: Color(0xff6A0DAD)),
                          )),
                      subtitle: Text(
                        textAlign: TextAlign.justify,
                        BottomSheetContainer.info[index]['des'][check]
                            ['answer'],
                        style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                                // color: Provider.of<ThemeProvider>(context)
                                //             .themeMode ==
                                //         ThemeMode.dark
                                //     ? ColorConstant.mainwhite
                                //     : ColorConstant.mainblack,
                                fontSize: 17)),
                      ),
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) => const SizedBox(
                height: 10,
              ),
            ),
          )
        ],
      ),
    );
  }
}
