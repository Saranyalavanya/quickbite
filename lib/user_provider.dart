import 'package:flutter/material.dart';

class RegisteredUser {
  final String name;
  final String email;
  final String phone;
  final String password;

  RegisteredUser({
    required this.name,
    required this.email,
    required this.phone,
    required this.password,
  });
}

class UserProvider extends ChangeNotifier {
  final List<RegisteredUser> _registeredUsers = [];
  RegisteredUser? _currentUser;

  RegisteredUser? get currentUser => _currentUser;
  String get name => _currentUser?.name ?? '';
  String get email => _currentUser?.email ?? '';
  String get phone => _currentUser?.phone ?? '';

  void updateProfile({required String name, required String phone}) {
    if (_currentUser == null) return;

    final updatedUser = RegisteredUser(
      name: name,
      email: _currentUser!.email,
      phone: phone,
      password: _currentUser!.password,
    );

    // update in the registered users list too, so it persists across future logins
    final index = _registeredUsers.indexWhere((u) => u.email == _currentUser!.email);
    if (index >= 0) {
      _registeredUsers[index] = updatedUser;
    }

    _currentUser = updatedUser;
    notifyListeners();
  }

  bool isEmailTaken(String email) {
    return _registeredUsers.any((user) => user.email.toLowerCase() == email.toLowerCase());
  }

  void registerUser({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) {
    _registeredUsers.add(
      RegisteredUser(name: name, email: email, phone: phone, password: password),
    );
    notifyListeners();
  }

  // returns null if login is successful, or an error message if not
  String? login(String email, String password) {
    RegisteredUser? match;
    for (var user in _registeredUsers) {
      if (user.email.toLowerCase() == email.toLowerCase()) {
        match = user;
        break;
      }
    }

    if (match == null) {
      return 'Account not found. Please register first.';
    }
    if (match.password != password) {
      return 'Invalid password. Please try again.';
    }

    _currentUser = match;
    notifyListeners();
    return null;
  }

  void logout() {
    _currentUser = null;
    notifyListeners();
  }
}