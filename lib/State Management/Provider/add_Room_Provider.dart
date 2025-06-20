import 'package:flutter/cupertino.dart';
import 'package:iot_halox_app/App_Screens/State%20Management/Provider%20State%20Management/Room_Provider.dart';

class RoomProvider with ChangeNotifier {
  final List<Room> _rooms = [];

  List<Room> get rooms => _rooms;

  void addRoom(Room newRoom) {
    if (!_rooms.any((room) => room.roomName == newRoom.roomName)) {
      _rooms.add(newRoom);
      notifyListeners();
    }
  }

  void toggleRoomSwitch(String roomName, bool newValue) {
    try {
      final room = _rooms.firstWhere((r) => r.roomName == roomName);
      room.isOn = newValue;
      notifyListeners();
    } catch (e) {
      print("Error: Could not find room '$roomName' to toggle switch.");
    }
  }
}