import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:insta_code/screens/create_screen.dart';
import 'package:insta_code/screens/home_screen.dart';
import 'package:insta_code/utils/tab_items.dart';
import 'package:line_icons/line_icons.dart';
import 'package:scroll_app_bar/scroll_app_bar.dart';

class Navigation extends StatefulWidget {
  @override
  _NavigationState createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  final ScrollController controller = ScrollController();

  int _selectedPage = 0;
  List<Widget> pageList = [];

  @override
  void initState() {
    super.initState();
    pageList = [
      HomeScreen(controller: controller),
      const Text('Likes'),
      CreateScreen(),
      const Text('Profile'),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ScrollAppBar(
        controller: controller,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          pages[_selectedPage],
          style: const TextStyle(
            color: Colors.black,
            fontSize: 22,
          ),
        ),
      ),
      body: IndexedStack(
        index: _selectedPage,
        children: pageList,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(blurRadius: 20, color: Colors.black.withOpacity(.1))
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
              tabActiveBorder: Border.all(),
              gap: 10,
              color: Colors.grey[600],
              activeColor: Colors.black,
              rippleColor: Colors.grey[300],
              hoverColor: Colors.grey[100],
              iconSize: 20,
              textStyle: const TextStyle(fontSize: 16, color: Colors.black),
              padding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 14.5),
              duration: const Duration(milliseconds: 400),
              tabs: const [
                GButton(
                  icon: LineIcons.home,
                  text: 'Home',
                ),
                GButton(
                  icon: LineIcons.heart,
                  text:
                      'Likes', //https://github.com/sooxt98/google_nav_bar/blob/master/example/lib/main_gallery.dart#L151
                ),
                GButton(
                  icon: LineIcons.plus,
                  text: 'Create',
                ),
                GButton(
                  icon: LineIcons.user,
                  text: 'Profile',
                  leading: CircleAvatar(
                    backgroundColor: Colors.black,
                    radius: 12,
                    backgroundImage: NetworkImage(
                        "https://sooxt98.space/content/images/size/w100/2019/01/profile.png"),
                  ),
                ),
              ],
              selectedIndex: _selectedPage,
              onTabChange: _onItemTapped,
            ),
          ),
        ),
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedPage = index;
    });
  }
}
