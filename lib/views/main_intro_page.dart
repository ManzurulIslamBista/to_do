import 'package:flutter/material.dart';
import 'package:to_do/repositories/sub_intro_page.dart';
import 'package:to_do/views/welcome_page.dart';

class MainIntroPage extends StatefulWidget {
  const MainIntroPage({Key? key}) : super(key: key);

  @override
  State<MainIntroPage> createState() => _MainIntroPageState();
}

class _MainIntroPageState extends State<MainIntroPage> {
  final PageController _controller = PageController();
  int _currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFF121212),
        body: Column(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                // height: 50,
                // width: double.infinity,
                child: Stack(
                  children: [
                    Positioned(
                      top: 20,
                      left: 20,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const WelcomePage()));
      
                        },
                        child: const Center(
                          child: Text(
                            "SKIP",
                            style: TextStyle(
                              color: Color(0x6FFFFFFF),fontSize: 18,decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // SizedBox(height: MediaQuery.of(context).size.height/130),
            Expanded(
              flex: 13,
              child: Container(
                // height: MediaQuery.of(context).size.height/1.5,
                // width: double.infinity,
                child: PageView(
                  controller: _controller,
                  onPageChanged: (index) {
                    setState(() {
                      _currentPageIndex = index;
                    });
                  },
                  children: [
                    SubIntroPage(
                      asset_location: 'assets/images/Frame 161.svg',
                      title: 'Manage your tasks',
                      subTitle:
                      "You can easily manage all of your daily tasks in DoMe for free",
                      currentPageIndex: _currentPageIndex,
                    ),
                    SubIntroPage(
                      asset_location: 'assets/images/Frame 162.svg',
                      title: 'Create daily routine',
                      subTitle:
                      "In Uptodo you can create your personalized routine to stay productive",
                      currentPageIndex: _currentPageIndex,
                    ),
                    SubIntroPage(
                      asset_location: 'assets/images/Group 182.svg',
                      title: 'Organize your tasks',
                      subTitle:
                      "You can organize your daily tasks by adding your tasks into separate categories",
                      currentPageIndex: _currentPageIndex,
                    ),
                  ],
                ),
              ),
            ),
            // SizedBox(height: MediaQuery.of(context).size.height > 500 ? MediaQuery.of(context).size.height/6.5 : MediaQuery.of(context).size.height/25),
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (_currentPageIndex >= 0)
                      GestureDetector(
                        onTap: (){
                          _controller.previousPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.ease);
                          print(MediaQuery.of(context).size.height);
                        },
                        child: Container(
                          // height: 50,
                          width: 100,
                          // width: MediaQuery.of(context).size.width / 4,
                          decoration: BoxDecoration(
                            color: const Color(0xFF121212),
                            borderRadius: BorderRadius.circular(10),
                        ),
                          child: const Center(child: Text('BACK',style: TextStyle(color: Color(0xFFFFFFFF)),)),
                      ),),
      
                    // const SizedBox(width: 10),
                    if (_currentPageIndex < 2)
                      GestureDetector(
                        onTap: (){
                          _controller.nextPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.ease);
                        },
                        child: Container(
                          height: 50,
                          width: 100,
                          // width: MediaQuery.of(context).size.width / 4,
                          decoration: BoxDecoration(
                            color: const Color(0xFF8875FF),
                            borderRadius: BorderRadius.circular(10),
      
                          ),
                          child: const Center(child: Text('NEXT',style: TextStyle(color: Color(0xFFFFFFFF)),)),
                        ),),
                    if (_currentPageIndex == 2) // Change 2 to the index of the last page
                      GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) =>  WelcomePage()));
                        },
                        child: Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width / 3,
                          // width: MediaQuery.of(context).size.width / 4,
                          decoration: BoxDecoration(
                            color: const Color(0xFF8875FF),
                            borderRadius: BorderRadius.circular(10),

                          ),
                          child: const Center(child: Text('GET STARTED',style: TextStyle(color: Color(0xFFFFFFFF)),)),
                        ),),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
