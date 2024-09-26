import 'package:bullbear/core/utils/app_colors.dart';
import 'package:bullbear/features/presentation/pages/home_page.dart';
import 'package:bullbear/features/presentation/pages/watchlist_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class UserBottomNavigation extends StatefulWidget {
  const UserBottomNavigation({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<UserBottomNavigation> {
  final ValueNotifier<bool> bottomNavBarVisible = ValueNotifier(true);

  int _currentIndex = 0;
  final List<Widget> _children = [
   HomePage(),
  const WatchlistPage()
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBody: true,
        body: NotificationListener<UserScrollNotification>(
          onNotification: (notification) {
            if (notification.direction == ScrollDirection.reverse) {
              bottomNavBarVisible.value = false;
            } else if (notification.direction == ScrollDirection.forward) {
              bottomNavBarVisible.value = true;
            }
            return true;
          },
          child: _children[_currentIndex],
        ),
        bottomNavigationBar: ValueListenableBuilder<bool>(
          valueListenable: bottomNavBarVisible,
          builder: (context, isVisible, child) {
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              height: isVisible ? kBottomNavigationBarHeight + 20 : 0,
              child: isVisible ? child : const SizedBox.shrink(),
            );
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 70, right: 70, bottom: 16),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: AppColors.seconderyColor,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: GNav(
                haptic: true,
                tabBackgroundColor: AppColors.thirdColor,
                activeColor: AppColors.seconderyColor,
                gap: 8,
                color: AppColors.thirdColor,
                hoverColor: Colors.green,
                padding: const EdgeInsets.all(18),
                tabs: const [
                  GButton(
                    icon: Icons.home_outlined,
                    text: 'Home',
                  ),
                  GButton(
                    icon: Icons.bookmark_border,
                    text: 'Watchlist',
                  ),
                ],
                selectedIndex: _currentIndex,
                onTabChange: onTabTapped,
              ),
            ),
          ),
        ));
  }
}
