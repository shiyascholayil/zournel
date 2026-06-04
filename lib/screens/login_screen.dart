import 'package:flutter/material.dart';
import 'package:zournel/const.dart';
import 'package:zournel/services/auth_services.dart';
import 'package:zournel/widget/custom_input_decoration.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();

  final _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  final AuthServices _auth = AuthServices();

  bool _isLogin = true;
  bool _isLoading = false;
  bool _obscurePassword = true;

  String _errorMessage = '';

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  /// SUBMIT
  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      if (_isLogin) {
        await _auth.sighWithEmail(
          _emailController.text.trim(),
          _passwordController.text.trim(),
        );
      } else {
        await _auth.registerWithEmail(
          _emailController.text.trim(),
          _passwordController.text.trim(),
        );
      }
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
      });
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,

        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [gradientStartColor, gradientEndColor],

            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),

        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),

              child: Container(
                padding: const EdgeInsets.all(28),

                decoration: BoxDecoration(
                  color: secondaryColor.withValues(alpha: 0.95),

                  borderRadius: BorderRadius.circular(28),

                  boxShadow: [
                    BoxShadow(
                      color: blackColor.withValues(alpha: 0.1),

                      blurRadius: 20,

                      offset: const Offset(0, 10),
                    ),
                  ],
                ),

                child: Form(
                  key: _formKey,

                  child: Column(
                    mainAxisSize: MainAxisSize.min,

                    children: [
                      Icon(
                        Icons.lock_outline_rounded,

                        size: 70,

                        color: primaryColor.withValues(alpha: 0.8),
                      ),

                      const SizedBox(height: 20),

                      Text(
                        _isLogin ? "Welcome Back" : "Create Account",

                        style: appBarTitleStyle.copyWith(color: blackColor),
                      ),

                      const SizedBox(height: 10),

                      Text(
                        _isLogin
                            ? "Login to continue"
                            : "Register to get started",

                        style: subtitleStyle,
                      ),

                      const SizedBox(height: 35),

                      /// EMAIL
                      TextFormField(
                        controller: _emailController,

                        style: textFieldTextStyle,

                        keyboardType: TextInputType.emailAddress,

                        decoration: customInputDecoration(
                          label: 'Email',

                          icon: Icons.email_outlined,
                        ),

                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Enter your email";
                          }

                          if (!value.contains('@')) {
                            return "Enter valid email";
                          }

                          return null;
                        },
                      ),

                      const SizedBox(height: 20),

                      /// PASSWORD
                      TextFormField(
                        controller: _passwordController,

                        style: textFieldTextStyle,

                        obscureText: _obscurePassword,

                        decoration: customInputDecoration(
                          label: 'Password',

                          icon: Icons.lock_outline,

                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _obscurePassword = !_obscurePassword;
                              });
                            },

                            icon: Icon(
                              _obscurePassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                          ),
                        ),

                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Enter your password";
                          }

                          if (value.length < 6) {
                            return "Minimum 6 characters";
                          }

                          return null;
                        },
                      ),

                      const SizedBox(height: 25),

                      /// ERROR MESSAGE
                      if (_errorMessage.isNotEmpty)
                        Container(
                          width: double.infinity,

                          padding: const EdgeInsets.all(12),

                          margin: const EdgeInsets.only(bottom: 15),

                          decoration: BoxDecoration(
                            color: redColor.withValues(alpha: 0.1),

                            borderRadius: BorderRadius.circular(14),
                          ),

                          child: Text(
                            _errorMessage,

                            style: TextStyle(
                              color: redColorAccent,

                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),

                      /// BUTTON
                      SizedBox(
                        width: double.infinity,

                        height: 58,

                        child: ElevatedButton(
                          onPressed: _isLoading ? null : _submit,

                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryColor,

                            foregroundColor: secondaryColor,

                            elevation: 0,

                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18),
                            ),
                          ),

                          child: _isLoading
                              ? const SizedBox(
                                  height: 24,
                                  width: 24,

                                  child: CircularProgressIndicator(
                                    strokeWidth: 2.5,

                                    color: secondaryColor,
                                  ),
                                )
                              : Text(
                                  _isLogin ? "Login" : "Register",

                                  style: buttonTextStyle,
                                ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      /// SWITCH LOGIN/REGISTER
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,

                        children: [
                          Text(
                            _isLogin
                                ? "Don't have an account?"
                                : "Already have an account?",

                            style: subtitleStyle,
                          ),

                          TextButton(
                            onPressed: () {
                              setState(() {
                                _isLogin = !_isLogin;

                                _emailController.clear();

                                _passwordController.clear();

                                _errorMessage = '';
                              });
                            },

                            child: Text(
                              _isLogin ? "Register" : "Login",

                              style: const TextStyle(
                                fontWeight: FontWeight.bold,

                                color: primaryColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
