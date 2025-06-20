import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:iot_halox_app/App_Screens/Home%20Screens/Home%20Screens.dart';
import 'package:iot_halox_app/App_Screens/Home%20Screens/Settings%20Screen.dart';
import 'package:iot_halox_app/App_Screens/Home%20Screens/Statistics%20Screen.dart';
import 'package:iot_halox_app/App_Screens/Home%20Screens/View%20Screen.dart';
import 'package:iot_halox_app/App_Screens/UI_Helper/UI_helper.dart';


class BottomNavBar extends StatefulWidget {
  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;

  final List<Widget> navTo = [
    HomeScreen(),
    ViewScreen(),
    Placeholder(),
    StatisticsScreen(),
    SettingsScreen(),
  ];

  void _onTabTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: navTo[_selectedIndex],
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      // 1. The FloatingActionButton no longer needs extra Padding
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showSelectAreaBottomSheet(context);
        },
        backgroundColor: Colors.transparent,
        elevation: 0,
        shape: const CircleBorder(),
        child: Container(
          height: 68,
          width: 68,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: pastelGradient(),
          ),
          child: const Icon(Icons.add, color: Colors.black, size: 22),
        ),
      ),

      // 2. The BottomAppBar is now structured for perfect symmetry
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        color: const Color(0xff262C52),
        notchMargin: 8.0, // Provides a nice gap around the FAB
        child: SizedBox(
          height: 70,
          child: Row(
            children: <Widget>[
              // Group of icons on the left side
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    _buildTabIcon(0, Icons.home),
                    _buildTabIcon(1, Icons.tv),
                  ],
                ),
              ),
              // This SizedBox creates the space for the notch
              const SizedBox(width: 60),
              // Group of icons on the right side
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    _buildTabIcon(3, Icons.bar_chart),
                    _buildTabIcon(4, Icons.settings),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTabIcon(int index, IconData icon) {
    final bool isSelected = _selectedIndex == index;
    return GestureDetector(
      onTap: () => _onTabTapped(index),
      child: bottomIcons(mIcon: icon, isSelected: isSelected),
    );
  }
}


Widget bottomIcons({required IconData mIcon, required bool isSelected}) {
  return Stack(
    alignment: Alignment.center,
    children: [
      if (isSelected)
        Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            gradient: pastelGradient(),
            shape: BoxShape.circle,
          ),
        ),
      Container(
        height: 34,
        width: 34,
        decoration: BoxDecoration(
          color: Color(0xff41456A),
          shape: BoxShape.circle,
        ),
        child: ShaderMask(
          shaderCallback: (bounds) => pastelGradient().createShader(bounds),
          child: Icon(
            mIcon,
            size: 24,
            color: isSelected ? Colors.white : Colors.grey.shade600,
          ),
        ),
      ),
    ],
  );
}


/// Gradient Color
Gradient pastelGradient() {
  return  LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
    colors: [
      Color(0xFFF8BDE),
      Colors.purple.shade200,// light pink
      Colors.blue.shade200, // soft blue
      Colors.greenAccent.shade100,
      Colors.yellowAccent.shade100, // soft yellow
     // Color(0xFFFFCCBC), // soft peach
    ],
  );
}

/// Gradient to use in Box Decoration
BoxDecoration pastelBoxDecoration({double radius = 20}) {
  return BoxDecoration(
    gradient: pastelGradient(),
    borderRadius: BorderRadius.circular(radius),
  );
}


/// Room Card
void _showSelectAreaBottomSheet(BuildContext context) {
  // We've added a 'color' to each area in the list
  final List<Map<String, dynamic>> areas = [
    {'icon': Icons.kitchen_outlined, 'name': 'Kitchen', 'color': Colors.orange.shade300},
    {'icon': Icons.meeting_room_outlined, 'name': 'Lobby', 'color': Colors.brown.shade300},
    {'icon': Icons.bed_outlined, 'name': 'Bedroom', 'color': Colors.purple.shade200},
    {'icon': Icons.bathtub_outlined, 'name': 'Washroom', 'color': Colors.blue.shade200},
    {'icon': Icons.living_outlined, 'name': 'Living Room', 'color': Colors.green.shade300},
    {'icon': Icons.business_center_outlined, 'name': 'Office', 'color': Colors.indigo.shade200},
    {'icon': Icons.person_outline, 'name': 'Guest Room', 'color': Colors.pink.shade200},
    {'icon': Icons.balcony_outlined, 'name': 'Balcony', 'color': Colors.teal.shade200},
  ];

  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (context) {
      return SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Select Your Area", style: mTextStyle24()),
              const SizedBox(height: 24),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.9,
                ),
                itemCount: areas.length,
                itemBuilder: (context, index) {
                  // Pass the new color to our helper widget
                  return _buildAreaGridItem(
                    context,
                    areas[index]['icon'],
                    areas[index]['name'],
                    areas[index]['color'],
                  );
                },
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      );
    },
  );
}

// Replace the existing helper widget as well
Widget _buildAreaGridItem(BuildContext context, IconData icon, String name, Color color) {
  return InkWell(
    onTap: () {
      print("$name selected");
      Navigator.pop(context);
    },
    borderRadius: BorderRadius.circular(16),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // This container now uses the specific color for its background
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: color, // Use the passed-in color
            borderRadius: BorderRadius.circular(16),
          ),
          // The icon color is set to white for good contrast
          child: Icon(icon, size: 28, color: Colors.white),
        ),
        const SizedBox(height: 8),
        Text(
          name,
          style: mTextStyle14(mColor: Colors.grey.shade700),
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    ),
  );
}

// Add this helper widget inside _BottomNavBarState as well
/*
Widget _buildAreaGridItem(BuildContext context, IconData icon, String name) {
  return InkWell(
    onTap: () {
      print("$name selected");
      Navigator.pop(context);
    },
    borderRadius: BorderRadius.circular(16),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Icon(icon, size: 28, color: Colors.grey.shade800),
        ),
        const SizedBox(height: 6), // Reduced spacing
        Text(
          name,
          style: mTextStyle14(mColor: Colors.grey.shade700),
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    ),
  );
}*/
