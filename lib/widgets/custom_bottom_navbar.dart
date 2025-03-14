import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomBottomNavBar extends StatefulWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemSelected;

  const CustomBottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onItemSelected,
  });

  @override
  _CustomBottomNavBarState createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: widget.selectedIndex,
      onTap: widget.onItemSelected,
      backgroundColor: Colors.white,
      type: BottomNavigationBarType.fixed,
      elevation: 10,
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.grey,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      items: [
        _buildNavItem("assets/icons/home_icon.svg","assets/icons/home_icon_selected.svg", 0),
        _buildNavItem("assets/icons/clock_icon.svg","assets/icons/clock_icon_selected.svg", 1),
        _buildNavItem("assets/icons/fav_icon.svg","assets/icons/fav_icon_selected.svg", 2),
        _buildNavItem("assets/icons/profile_icon.svg","assets/icons/profile_icon_selected.svg", 3),
      ],
    );
  }

  BottomNavigationBarItem _buildNavItem(String icon,String selectedIcon, int index) {
    return BottomNavigationBarItem(
      icon: Column(
        children: [
        SvgPicture.asset(
          widget.selectedIndex == index ? selectedIcon:icon ,
          ),
          SizedBox(
            height: 3,
            width: 3,
          ),
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: widget.selectedIndex == index ? Colors.red : Colors.white,
              shape: BoxShape.circle,
            ),
          ),
        ],
      ),
      label: "",
    );
  }
}
