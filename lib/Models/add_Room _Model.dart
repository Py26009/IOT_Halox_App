import 'package:flutter/cupertino.dart';

class Room{
  String roomName;
  IconData mIcon;
  Color mColor;
  int nDevices;   // Total number of devices
  int onDevices;  // Number of devices that are ON
  bool isOn;


  Room({
    required this.roomName,
    required this.mIcon,
    required this.mColor,
  this.nDevices = 0,
  this.onDevices = 0,
  this.isOn = false});
}