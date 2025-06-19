import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:iot_halox_app/App_Screens/Home%20Screens/Home%20Screens.dart';
import 'package:iot_halox_app/App_Screens/Home%20Screens/Settings%20Screen.dart';
import 'package:iot_halox_app/App_Screens/Home%20Screens/Statistics%20Screen.dart';
import 'package:iot_halox_app/App_Screens/Home%20Screens/View%20Screen.dart';


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
        floatingActionButton: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 8.0),
          child: FloatingActionButton(
            onPressed: () {
              RoomCard();
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
        ),
      bottomNavigationBar:SafeArea(
            child: Padding(
             padding: const EdgeInsets.only(left: 5, right: 16),
              child: ClipRRect(
               borderRadius: BorderRadius.circular(30),
              child: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        color: const Color(0xff262C52),
        notchMargin: 6,
        child: SizedBox(
          height: 70,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildTabIcon(0, Icons.home),
              SizedBox(width: 10,),
              _buildTabIcon(1, Icons.tv),
              const SizedBox(width: 100), // space for FAB
              _buildTabIcon(3, Icons.bar_chart),
              SizedBox(width: 10,),
              _buildTabIcon(4, Icons.settings),
            ],
          ),
        ),
      ),
    )
    )
      )
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
class RoomCard extends StatelessWidget {
  const RoomCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.pink.shade50,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Circular Icon
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withOpacity(0.4),
            ),
            child: Icon(Icons.desktop_mac, size: 32, color: Colors.pink),
          ),
          const SizedBox(height: 12),

          // Room name
          const Text(
            'Office',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),

          // Devices & Time
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                '5 Devices',
                style: TextStyle(fontSize: 12, color: Colors.black54),
              ),
              Text(
                '10n',
                style: TextStyle(fontSize: 12, color: Colors.black54),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Power Button
          Container(
            decoration: BoxDecoration(
              color: Colors.green.shade100,
              borderRadius: BorderRadius.circular(24),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            child: const Icon(Icons.power_settings_new, color: Colors.green, size: 20),
          ),
        ],
      ),
    );
  }
}
