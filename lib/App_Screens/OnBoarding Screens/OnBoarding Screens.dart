import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iot_halox_app/App_Screens/Bottom_Nav_Bar/Bottom_nav_bar.dart';
import 'package:iot_halox_app/App_Screens/Home%20Screens/Home%20Screens.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> with TickerProviderStateMixin{
  final PageController _controller = PageController();
  int _currentPage = 0;
  Timer? _pageTimer;
  double _dragPosition = 0.0;
  bool _isConfirmed = false;

  final List<OnboardData> pages = [
    OnboardData(
      image: "assets/images/young-woman-with-mobile-phone-outside-stylish-businesswoman-background-office-buildings_307890-6735.jpg",
      title: "Full Control for your Smart Home",
      subtitle: "Control your smart home easier with our better features.",
    ),
    OnboardData(
      image: "assets/images/onBoarding2.jpg",
      title: "Easier Life with a Smart Home.",
      subtitle: "Welcome to a home that adapts seamlessly to your needs.",
    ),
    OnboardData(
      image: "assets/images/smart-home-mobile-app-wide-586x375.jpg",
      title: "Smart Fan,Air Conditioner control",
      subtitle: "Control your smart air conditioner and fan for ultimate comfort anywhere..",
    ),
  ];

  @override
  void initState() {
    super.initState();
    _startAutoScroll();
  }

  void _startAutoScroll() {
    _pageTimer = Timer.periodic(const Duration(seconds: 10), (Timer timer) {
      if (_currentPage < pages.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _controller.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _pageTimer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _controller,
            itemCount: pages.length,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemBuilder: (context, index) {
              return OnboardingPage(data: pages[index]);
            },
          ),

          /// Bottom overlay controls
          Align(
            alignment: Alignment.bottomCenter,
            child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              child: BackdropFilter(filter: ImageFilter.blur(sigmaX: 11, sigmaY: 11),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 45),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.3),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Page indicators
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      pages.length,
                          (index) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: IndicatorDot(isActive: _currentPage == index),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Title and subtitle
                  Text(
                    pages[_currentPage].title,
                    style: TextStyle(
                      fontSize: 32,
                      color: Color(0xffFEFEFE),
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    pages[_currentPage].subtitle,
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.white70,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 30),

                  /// Get Started Button
                Container(
                  height: 45,
                  width: 250,
                  decoration: BoxDecoration(
                    color: Colors.black38,
                    borderRadius: BorderRadius.circular(22),
                  ),
                  child: Stack(
                    children: [
                      // Background label (e.g., "Get Started")
                      Center(
                        child: Text(
                          " Get Started",
                          style: TextStyle(color: Color(0xffAAAAAA), fontSize: 16),
                        ),
                      ),
                      Positioned(
                        top: 0,
                          bottom: 0,
                          right: -5,
                          child:  Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Transform.translate(
                                  offset: const Offset(0, 0),
                                  child: Icon(Icons.arrow_forward_ios, size: 16, color: Colors.white38),
                                ),
                                Transform.translate(
                                  offset: const Offset(-8, 0),
                                  child: Icon(Icons.arrow_forward_ios, size: 16, color: Colors.white60),
                                ),
                                Transform.translate(
                                  offset: const Offset(-16, 0),
                                  child: Icon(Icons.arrow_forward_ios, size: 16, color: Colors.white),
                                ),
                              ],
                            ),
                          ),

                      ///  Swipe-able button
                      Positioned(
                        left: _dragPosition,
                        top: 0,
                        bottom: 0,
                        child: GestureDetector(
                          onHorizontalDragUpdate: (details) {
                            setState(() {
                              _dragPosition += details.delta.dx;
                              _dragPosition = _dragPosition.clamp(0.0, 250.0 - 45.0); // Max width - button size
                            });
                          },
                          onHorizontalDragEnd: (details) {
                            if (_dragPosition > 250 - 70) {
                              // Success trigger
                              setState(() {
                                _isConfirmed = true;
                              });

                              if (_currentPage < pages.length - 1) {
                                _controller.nextPage(
                                  duration: Duration(milliseconds: 300),
                                  curve: Curves.easeInOut,
                                );
                              }

                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => BottomNavBar()),
                              );

                              /// Optionally reset
                              Future.delayed(Duration(milliseconds: 300), () {
                                setState(() => _dragPosition = 0.0);
                              });

                            } else {
                              // Snap back if not far enough
                              setState(() => _dragPosition = 0.0);
                            }
                          },
                          child: SizedBox(
                            width: 45,
                            height: 45,
                            child: ElevatedButton(
                              onPressed: () {}, // Optional tap handler
                              style: ElevatedButton.styleFrom(
                                shape: CircleBorder(),
                                backgroundColor: Colors.lime,
                                padding: EdgeInsets.zero,
                              ),
                              child: Icon(Icons.arrow_forward, color: Colors.black),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                ],
              ),
            ),
          ),
            )
          )
            ],

      ),
    );
  }
}

class OnboardingPage extends StatelessWidget {
  final OnboardData data;

  const OnboardingPage({required this.data, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Image.asset(
        data.image,
        fit: BoxFit.cover,
      ),
    );
  }
}

class IndicatorDot extends StatelessWidget {
  final bool isActive;

  const IndicatorDot({this.isActive = false, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: isActive ? 16 : 10,
      height: isActive ? 16 : 10,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.black12,
        border: Border.all(color: Colors.lime, width: 2)
      ),
    );
  }
}

class OnboardData {
  final String image;
  final String title;
  final String subtitle;

  OnboardData({
    required this.image,
    required this.title,
    required this.subtitle,
  });
}
