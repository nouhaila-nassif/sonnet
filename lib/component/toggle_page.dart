import 'package:flutter/material.dart';
import 'package:sonnet/PublicScreen.dart';
import 'package:sonnet/home_screen.dart';
import 'package:sonnet/prompt_screen.dart';
import 'package:sonnet/sign_up_screen.dart';
import 'package:sonnet/login_screen.dart';

class TogglePage extends StatefulWidget {
  const TogglePage({super.key});

  @override
  State<TogglePage> createState() => _TogglePageState();
}

class _TogglePageState extends State<TogglePage> {
  // Variable to track the current screen
  String _currentScreen = 'home';

  // Methods to toggle screens
  void _toggleToPromptScreen() {
    setState(() {
      _currentScreen = 'prompt';
    });
  }

  void _toggleToLoginScreen() {
    setState(() {
      _currentScreen = 'login';
    });
  }

  void _toggleToSignUpScreen() {
    setState(() {
      _currentScreen = 'signup';
    });
  }

  void _toggleToPublicScreen() {
    setState(() {
      _currentScreen = 'public';
    });
  }

  void _toggleToHomeScreen() {
    setState(() {
      _currentScreen = 'home';
    });
  }

  @override
  Widget build(BuildContext context) {
    switch (_currentScreen) {
      case 'prompt':
        return PromptScreen(
          showHomeScreen: _toggleToHomeScreen,
        );
      case 'signup':
        return SignUpScreen(
          showHomeScreen: _toggleToHomeScreen,
          showLoginScreen: _toggleToLoginScreen,
        );
      case 'login':
        return LoginScreen(
          onLoginSuccess: _toggleToPromptScreen,
          showSignUpScreen: _toggleToSignUpScreen,
          showPublicScreen: _toggleToPublicScreen, // Transmettre le callback
        );
      case 'public':
        return PublicScreen(
          showHomeScreen: _toggleToHomeScreen,
          showLoginScreen: _toggleToLoginScreen,
        );
      case 'home':
      default:
        return HomeScreen(
          showPromptScreen: _toggleToPromptScreen,
          showSignUpScreen: _toggleToSignUpScreen,
          showLoginScreen: _toggleToLoginScreen,
          showPublicScreen: _toggleToPublicScreen, // Pass the required argument
        );
    }
  }
}
