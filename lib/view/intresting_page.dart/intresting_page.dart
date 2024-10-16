import 'package:cyber_hulk/view/intresting_page.dart/joincybervolunteerscreen.dart';
import 'package:cyber_hulk/view/reach_to_us_screen/reach_to_us_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:stacked_card_carousel/stacked_card_carousel.dart';
import 'package:cyber_hulk/utilis/color_constant/color_constant.dart';
import 'package:cyber_hulk/utilis/dummy_db.dart/dummy_db.dart';
import 'package:cyber_hulk/view/facts_details_screen/facts_details_screen.dart';

class InterestingPage extends StatefulWidget {
  const InterestingPage({super.key});

  @override
  State<InterestingPage> createState() => _InterestingPageState();
}

class _InterestingPageState extends State<InterestingPage> {
  @override
  Widget build(BuildContext context) {
    List<Widget> homepageList = [
      const FancyCard(
        image:
            "https://media.geeksforgeeks.org/wp-content/uploads/20230622121746/global-data-security-personal-data-security-cyber-data-security-online-concept-illustration-internet-security-information-privacy-protection_1150-37368.webp",
        title: "Phishing",
        index: 0,
      ),
      const FancyCard(
        image:
            "https://media.licdn.com/dms/image/D5612AQFZFNLPMuCSrQ/article-cover_image-shrink_720_1280/0/1681719119695?e=2147483647&v=beta&t=Dd8RvdVNoMCnWr7mMiSTF-w05kjzeiiWL-dTw9pUTK0",
        title: "Encryption",
        index: 1,
      ),
      const FancyCard(
        image:
            "https://imageio.forbes.com/specials-images/imageserve/64b5825a5b9b4d3225e9bd15/0x0.jpg?format=jpg&height=900&width=1600&fit=bounds",
        title: "AI",
        index: 2,
      ),
      const FancyCard(
        image:
            "https://www.shutterstock.com/image-vector/malware-icon-vector-isolated-on-260nw-1177007695.jpg",
        title: "Malware",
        index: 3,
      ),
      const FancyCard(
        image:
            "https://media.istockphoto.com/id/1383553886/vector/abstract-banner-cyber-security-in-3d-style-communication-technology-database-system.jpg?s=612x612&w=0&k=20&c=H_EGuMLGF8qTCp_aqYHIyYgUUz-V66gSGffmHV8elOw=",
        title: "Cyber Security",
        index: 4,
      ),
      const FancyCard(
        image:
            "https://www.niet.co.in/blog/wp-content/uploads/2020/09/robotics_Blog-1.jpg",
        title: "Robotics",
        index: 5,
      ),
    ];

    return Scaffold(
      //   appBar: AppBar(),
      body: Column(
        children: [
          //  const SizedBox(height: 15),
          Expanded(
            child: StackedCardCarousel(
              pageController: PageController(),
              type: StackedCardCarouselType.fadeOutStack,
              items: List.generate(
                BottomSheetContainer.info.length,
                (index) => FancyCard(
                  image: BottomSheetContainer.info[index]['details'][0]['img'],
                  title: BottomSheetContainer.info[index]['details'][0]['name'],
                  index: index,
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: FloatingActionButton(
              tooltip: "Chat with Us",
              heroTag: 'fab1    ',
              child: Icon(
                Icons.chat,
                color: ColorConstant.darkpurple,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChatScreen(),
                  ),
                );
              },

              backgroundColor: ColorConstant
                  .pantonebackground, // Customize background color if needed
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: FloatingActionButton.extended(
              heroTag: 'fab2',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => JoinCyberVolunteerScreen(),
                  ),
                );
              },
              icon: Icon(
                Icons.volunteer_activism,
                color: ColorConstant.darkpurple,
              ),
              label: const Text(
                "Join as Volunteer",
                style: TextStyle(
                  color: Colors.black, // Customize text color if needed
                  fontSize: 12,
                ),
              ),
              tooltip: "Join as Cyber Volunteer",
              backgroundColor: ColorConstant
                  .pantonebackground, // Customize background color if needed
            ),
          ),
        ],
      ),
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
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  bottomRight: Radius.circular(100),
                ),
              ),
              child: Image.asset(
                image,
                fit: BoxFit.cover,
              ),
            ),
            Text(
              title,
              style: GoogleFonts.poppins(
                textStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            OutlinedButton(
              child: const Text("Learn more"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FactsDetailsScreen(index: index),
                  ),
                );
                print("Button was tapped");
              },
            ),
          ],
        ),
      ),
    );
  }
}
