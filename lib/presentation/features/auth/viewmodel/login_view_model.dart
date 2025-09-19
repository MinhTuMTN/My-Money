import 'package:flutter/material.dart';
import 'package:my_money/presentation/features/auth/service/auth_service.dart';
import 'package:my_money/service_locator.dart';

class LoginViewModel extends ChangeNotifier {
  final _authService = getIt.get<AuthService>();
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  LoginViewModel() {
    emailController.text = 'nguyenminhtu0010@gmail.com';
    passwordController.text = 'MinhTu@123!';
  }

  Future<void> login() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    _isLoading = true;
    notifyListeners();

    final email = emailController.text;
    final password = passwordController.text;
    String? message = await _authService.login(email, password);
    if (message != null) {
      _errorMessage = message;
    } else {
      _errorMessage = '';
    }

    _isLoading = false;
    notifyListeners();
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }

    if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
      return 'Please enter a valid email address';
    }

    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }

    return null;
  }
}