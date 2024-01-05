
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Shared/styles/colors.dart';
import '../modules/user/cart_Screen/Cart_Screen.dart';
import '../modules/user/home/home_Screen.dart';
import '../modules/user/setting_Screen/Setting_Screen.dart';
import '../modules/user/user_Screen/User_Screen.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class UserBottomNavBar extends StatefulWidget {
  const UserBottomNavBar({super.key});

  @override
  State<UserBottomNavBar> createState() => _UserBottomNavBarState();
}

class _UserBottomNavBarState extends State<UserBottomNavBar> {
  PersistentTabController controller = PersistentTabController(initialIndex: 0);

  List<Widget> _buildScreens() {
    return [
      const HomeScreen(),
      const ProfileScreen(),
      const CartScreen(),
      const MenuScreen()
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.home),
        title: "Home",
        activeColorPrimary: teal,
        inactiveColorPrimary: black,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.person),
        title: "You",
        activeColorPrimary: teal,
        inactiveColorPrimary: black,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.cart),
        title: "Cart",
        activeColorPrimary: teal,
        inactiveColorPrimary: black,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.menu),
        title: "Menu",
        activeColorPrimary: teal,
        inactiveColorPrimary: black,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: Colors.white,
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: true,
      stateManagement: true,
      hideNavigationBarWhenKeyboardShows: true,
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Colors.white,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: const ItemAnimationProperties(
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: const ScreenTransitionAnimation(
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle: NavBarStyle.style3,
    );
  }
}