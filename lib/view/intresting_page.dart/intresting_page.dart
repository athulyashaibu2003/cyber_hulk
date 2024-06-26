import 'package:cyber_hulk/main.dart';
import 'package:cyber_hulk/utilis/color_constant/color_constant.dart';
import 'package:cyber_hulk/utilis/dummy_db.dart/dummy_db.dart';
import 'package:cyber_hulk/view/facts_details_screen/facts_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:stacked_card_carousel/stacked_card_carousel.dart';

class InterestingPage extends StatefulWidget {
  const InterestingPage({super.key});

  @override
  State<InterestingPage> createState() => _InterestingPageState();
}

class _InterestingPageState extends State<InterestingPage> {
  @override
  Widget build(BuildContext context) {
    List<Widget> homepageList = [
      FancyCard(
        image:
            "https://media.geeksforgeeks.org/wp-content/uploads/20230622121746/global-data-security-personal-data-security-cyber-data-security-online-concept-illustration-internet-security-information-privacy-protection_1150-37368.webp",
        title: "Phishing",
        index: 0,
      ),
      FancyCard(
        image:
            "https://media.licdn.com/dms/image/D5612AQFZFNLPMuCSrQ/article-cover_image-shrink_720_1280/0/1681719119695?e=2147483647&v=beta&t=Dd8RvdVNoMCnWr7mMiSTF-w05kjzeiiWL-dTw9pUTK0",
        title: "Encryption",
        index: 1,
      ),
      FancyCard(
        image:
            "https://imageio.forbes.com/specials-images/imageserve/64b5825a5b9b4d3225e9bd15/0x0.jpg?format=jpg&height=900&width=1600&fit=bounds",
        title: "AI",
        index: 2,
      ),
      FancyCard(
        image:
            "https://www.shutterstock.com/image-vector/malware-icon-vector-isolated-on-260nw-1177007695.jpg",
        title: "Malware",
        index: 3,
      ),
      FancyCard(
        image:
            "https://media.istockphoto.com/id/1383553886/vector/abstract-banner-cyber-security-in-3d-style-communication-technology-database-system.jpg?s=612x612&w=0&k=20&c=H_EGuMLGF8qTCp_aqYHIyYgUUz-V66gSGffmHV8elOw=",
        title: "Cyber Security",
        index: 4,
      ),
      FancyCard(
        image:
            "https://www.niet.co.in/blog/wp-content/uploads/2020/09/robotics_Blog-1.jpg",
        title: "Robotics",
        index: 5,
      ),
    ];
    return Scaffold(

        // backgroundColor: Colors.purple,
        body: Column(
      children: [
        SizedBox(
          height: 15,
        ),
        // Text(
        //   'Peculiar Findings',
        //   style: TextStyle(
        //     fontSize: 25,
        //     fontWeight: FontWeight.bold,
        //   ),
        // ),
        Expanded(
          child: StackedCardCarousel(
            //   pageController: PageController(),
            type: StackedCardCarouselType.fadeOutStack,
            items: List.generate(
              BottomSheetContainer.info.length,
              (index) => FancyCard(
                  image: BottomSheetContainer.info[index]['details'][0]['img'],
                  title: BottomSheetContainer.info[index]['details'][0]['name'],
                  index: index),
            ),
          ),
        ),
      ],
    )
        //Padding(
//         padding: const EdgeInsets.all(11),
//         child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
//           SizedBox(
//             height: 10,
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Container(
//                 height: 50,
//                 width: 50,
//                 decoration: BoxDecoration(
//                     image: DecorationImage(
//                         image: NetworkImage(
//                             "https://static.vecteezy.com/system/resources/previews/023/751/040/non_2x/isolated-cute-happy-brain-cartoon-character-with-an-idea-illustration-vector.jpg"))),
//               ),
//               Text("Interesting Facts",
//                   style: TextStyle(
//                       color: ColorConstant.darkpurple,
//                       fontSize: 30,
//                       fontWeight: FontWeight.bold)),
//             ],
//           ),
//           SizedBox(
//             height: 10,
//           ),
//           Expanded(
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 20),
//               child: GridView.builder(
//                 itemCount: BottomSheetContainer.info.length,
//                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: 2,
//                     mainAxisSpacing: 30,
//                     crossAxisSpacing: 30,
//                     mainAxisExtent: MediaQuery.sizeOf(context).height * .2),
//                 itemBuilder: (context, index) => InkWell(
//                   onTap: () {
//                     FactsBottomSheet(context, index);
//                   },
//                   child: ContainerWidget(
//                     image: BottomSheetContainer.info[index]['details'][0]
//                         ['img'],
//                     insidetext: BottomSheetContainer.info[index]['details'][0]
//                         ['name'],
//                     index: index,
//                     width: MediaQuery.sizeOf(context).width * .22,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ]),
//       ),
//     );
//   }
// }

        );
  }
}

class FancyCard extends StatelessWidget {
  const FancyCard({
    super.key,
    required this.image,
    required this.title,
    required this.index,
  });

  final String image;
  final String title;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Container(
              width: 250,
              height: 250,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                  // border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      bottomRight: Radius.circular(100))),
              child: Image.network(
                image,
                fit: BoxFit.cover,
              ),
            ),
            Text(
              title,
              style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              )),
            ),
            OutlinedButton(
                child: const Text("Learn more"),
                onPressed: () {
                  // FactsBottomSheet(context, index);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FactsDetailsScreen(index: index),
                      ));

                  print("Button was tapped");
                }),
          ],
        ),
      ),
    );
  }
}

Future<dynamic> FactsBottomSheet(BuildContext context, int index) {
  return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (context) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: ListView.separated(
                itemCount: BottomSheetContainer.info[index]['des'].length,
                itemBuilder: (context, check) {
                  // int questionLength =
                  //     BottomSheetContainer.info[0][check].length;
                  return ListTile(
                    title: Text(
                      // textAlign: TextAlign.justify,
                      BottomSheetContainer.info[index]['des'][check]
                          ['question'],
                      style: TextStyle(fontSize: 30, color: Colors.purple),
                    ),
                    subtitle: Text(
                      textAlign: TextAlign.justify,
                      BottomSheetContainer.info[index]['des'][check]['answer'],
                      style: TextStyle(
                          color:
                              Provider.of<ThemeProvider>(context).themeMode ==
                                      ThemeMode.dark
                                  ? ColorConstant.mainwhite
                                  : ColorConstant.mainblack,
                          fontSize: 17),
                    ),
                  );
                },
                separatorBuilder: (context, index) => SizedBox(
                  height: 10,
                ),
              ),
            )
          ],
        );
      });
}
