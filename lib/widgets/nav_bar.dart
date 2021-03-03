import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:insta_code/screens/create_screen.dart';
import 'package:insta_code/screens/home_screen.dart';
import 'package:line_icons/line_icons.dart';
import 'package:scroll_app_bar/scroll_app_bar.dart';

class NavBar extends StatefulWidget {
  const NavBar({
    Key key,
  }) : super(key: key);

  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  final ScrollController controller = ScrollController();

  int _selectedIndex = 0;

  String appBarText;

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.w600);
  static List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _screens = <Widget>[
      HomeScreen(
        controller: controller,
      ),
      Text(
        'Likes',
        style: optionStyle,
      ),
      // Text(
      //   'Create',
      //   style: optionStyle,
      // ),
      CreateScreen(),
      Text(
        'Profile',
        style: optionStyle,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    switch (_selectedIndex) {
      case 0:
        appBarText = "Home";
        break;
      case 1:
        appBarText = "Liked";
        break;
      case 2:
        appBarText = "Create";
        break;
      case 3:
        appBarText = "Profile";
        break;
      default:
        appBarText = "Home";
    }
    // TODO: https://medium.com/coding-with-flutter/flutter-case-study-multiple-navigators-with-bottomnavigationbar-90eb6caa6dbf
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: ScrollAppBar(
        controller: controller,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          appBarText,
          style: TextStyle(
            color: Colors.black,
            fontSize: 22,
            //fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Center(
        child: _screens.elementAt(_selectedIndex),
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
                tabActiveBorder: Border.all(
                  color: Colors.black,
                  width: 1.0,
                ),
                gap: 10,
                color: Colors.grey[600],
                activeColor: Colors.black,
                rippleColor: Colors.grey[300],
                hoverColor: Colors.grey[100],
                iconSize: 20,
                textStyle: TextStyle(fontSize: 16, color: Colors.black),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 14.5),
                duration: Duration(milliseconds: 400),
                tabs: [
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
                selectedIndex: _selectedIndex,
                onTabChange: (index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                }),
          ),
        ),
      ),
    );
  }
}
