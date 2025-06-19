import 'package:flutter/cupertino.dart';

class Room {
  final String name;
  final int devices;
  final String time;
  final IconData icon;

  Room({required this.name, required this.devices, required this.time, required this.icon});
}

class RoomProvider with ChangeNotifier {
  final List<Room> _rooms = [];

  List<Room> get rooms => _rooms;

  void addRoom(Room room) {
    _rooms.add(room);
    notifyListeners();
  }
}