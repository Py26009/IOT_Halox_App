import 'package:flutter/material.dart';
import 'package:iot_halox_app/App_Screens/State%20Management/Provider%20State%20Management/Room_Provider.dart';
import 'package:iot_halox_app/App_Screens/UI_Helper/UI_helper.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {

   // final rooms = context.watch<RoomProvider>().rooms;

    return Scaffold(
        backgroundColor: Colors.grey[100],
      appBar:CenterCurvedAppBar(),
      body: Column(
       /* crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,*/
        children: [
          Center(
            child: Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                color: Colors.grey.shade800,
                shape: BoxShape.circle,
                border: Border.all(
                  width: 4,
                  color: Color(0xff4EB3AF)
                )
              ),
              child: ClipOval(
                child: Image.network(
                  'https://imgv3.fotor.com/images/homepage-feature-card/Random-image-generator_5_2023-05-05-070624_svfc.jpg',
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover, // Ensures the image covers the circle
                ),
              )
            ),
          ),
          SizedBox(height: 11,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Hello Thomas", style: mTextStyle18(mFontWeight: FontWeight.w500),),
              SizedBox(width: 5,),
              Image.asset("assets/icons/wave.png", scale: 22,)

            ],
          ),
          SizedBox(height: 6,),
          Text("Welcome to your home", style: mTextStyle14(mFontWeight: FontWeight.w400, mColor: Colors.grey),),
          SizedBox(height: 26,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                featuresContainers(mIcon: Icons.cloud, value: "27 C", title: "New York", mColor: Colors.blue),
                featuresContainers(mIcon: Icons.devices, value: "15", title: "Active Devices", mColor: Colors.purpleAccent),
                featuresContainers(mIcon: Icons.wind_power, value: "312 Kwh", title: "Usage", mColor: Colors.purpleAccent),
              ],
            ),
          ),
          SizedBox(height: 24,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22.0),
            child: Row(
              children: [
                Text("Rooms", style: mTextStyle24(),),
                Spacer(),
                InkWell(
                  onTap: (){},
                    child: Text("View All", style: mTextStyle18(mColor: Colors.grey.shade400),))
              ],
            ),
          ),
          SizedBox(height: 16,),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal:16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    RoomCardWithSwitch(
                      nDevices: "10",
                      onDevices: "3",
                      mIcon: Icons.computer,
                      roomName: "Office",
                      initialValue: true,
                      onChanged: (val) {
                        print("Switch is ON: $val");
                      },
                    )
                  ],
                ),
              ),
              SizedBox(height: 21,),

            ],
          ),


        ],
      ),

                  );
  }
}


Widget featuresContainers({required IconData mIcon, required String value, required String title, required Color mColor}) {
  return Material(
    elevation: 4,
    borderRadius: BorderRadius.circular(16),
    child: Container(
      height: 150,
      width: 110,
      decoration: BoxDecoration(
        gradient: pastelGradient(), // Apply gradient to the outer container
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.white38.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      // Padding creates the border thickness
      child: Padding(
        padding: const EdgeInsets.all(2.5),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white, // Inner container has a solid background
            borderRadius: BorderRadius.circular(13.5), // Slightly smaller radius
          ),
          child: Column(
            children: [
              const SizedBox(height: 11),
              Icon(mIcon, color: mColor),
              const SizedBox(height: 11),
              Text(value, style: mTextStyle18()),
              const SizedBox(height: 21),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 17.0),
                child: Text(title, style: mTextStyle16(mFontWeight: FontWeight.w400)),
              )
            ],
          ),
        ),
      ),
    ),
  );
}


 /// Room Card
class RoomCardWithSwitch extends StatelessWidget {
  final IconData mIcon;
  final String roomName;
  final String nDevices;
  final String onDevices;
  final bool initialValue;
  final ValueChanged<bool> onChanged;

  const RoomCardWithSwitch({
    Key? key,
    required this.mIcon,
    required this.roomName,
    required this.nDevices,
    required this.onDevices,
    required this.initialValue,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      // Allow the switch to be positioned outside the card's bounds
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        // The Room Card itself
        ClipPath(
          clipper: InwardBottomCurveClipper(),
          child: Container(
            height: 180,
            width: 180,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: const LinearGradient(
                colors: [
                  Color(0xffFFE6E6),
                  Color(0xffFFCCCC),
                Color(0xffFFE6E6)
                //  Colors.white,// Vibrant peach gradient
                //  Color(0xFFFFE6A1),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  const SizedBox(height: 11),
                  Container(
                    height: 46,
                    width: 46,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xffFF8994), Colors.white],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      shape: BoxShape.circle,
                      border: Border.all(width: 2.5, color: Colors.white),
                    ),
                    child: Icon(mIcon, color: const Color(0xffFF8994)),
                  ),
                  const SizedBox(height: 11),
                  Text(roomName, style: mTextStyle18(mFontWeight: FontWeight.w400)),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Text("$nDevices Devices"),
                      const Spacer(),
                      Text("$onDevices ON")
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
        // The Switch, positioned perfectly in the curve
        Positioned(
          top: 180, // Adjust this value to move the switch up/down
          child: CustomGradientSwitch(
            initialValue: initialValue,
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}

/// For curve at the bottom in the Room Card
class InwardBottomCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();

    const double curveRadius = 50;

    path.lineTo(0, size.height); // Left side
    path.lineTo(size.width / 2 - curveRadius, size.height);

    // Inward curve
    path.quadraticBezierTo(
      size.width / 2,
      size.height - 40, // height of the inward curve
      size.width / 2 + curveRadius,
      size.height,
    );

    path.lineTo(size.width, size.height); // Right side
    path.lineTo(size.width, 0); // Top right
    path.close(); // Close the path

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

/// For centre dip of app bar
class CenterCurvedAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CenterCurvedAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(100);

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: InwardBottomCurveClipper(), // Using the correct clipper
      child: Container(
        height: 100,
        color: Colors.white,
        padding: const EdgeInsets.only(top: 40, left: 16, right: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Image.asset("assets/images/logo.png", height: 32),
                const SizedBox(width: 10),
                Text("S-Home", style: mTextStyle18(mFontWeight: FontWeight.w600)),
              ],
            ),
            Stack(
              children: [
                IconButton(
                  icon: const Icon(Icons.notifications_none_outlined, color: Colors.black, size: 28),
                  onPressed: () {},
                ),
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    constraints: const BoxConstraints(minWidth: 12, minHeight: 12),
                    child: const Text(
                      '',
                      style: TextStyle(color: Colors.white, fontSize: 8),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


///  Switch Button

class CustomGradientSwitch extends StatefulWidget {
  final bool initialValue;
  final ValueChanged<bool> onChanged;

  const CustomGradientSwitch({
    Key? key,
    required this.initialValue,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<CustomGradientSwitch> createState() => _CustomGradientSwitchState();
}

class _CustomGradientSwitchState extends State<CustomGradientSwitch> {
  late bool isOn;

  @override
  void initState() {
    super.initState();
    isOn = widget.initialValue;
  }

  void toggleSwitch() {
    setState(() {
      isOn = !isOn;
      widget.onChanged(isOn);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: toggleSwitch,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        width: 60,
        height: 30,
        padding: EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: isOn
              ? LinearGradient(
            colors: [Color(0xffCDF0EE),Color(0xffCCEFED ), Colors.white],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          )
              : LinearGradient(
            colors: [Colors.grey.shade300, Colors.grey.shade400],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4,
              offset: Offset(0, 2),
            )
          ],
        ),
        child: AnimatedAlign(
          duration: Duration(milliseconds: 300),
          alignment: isOn ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            width: 22,
            height: 22,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 2,
                  offset: Offset(0, 2),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}


/// Gradient color
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




