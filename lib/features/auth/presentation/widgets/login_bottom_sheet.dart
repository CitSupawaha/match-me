import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import '../providers/auth_provider.dart';

class LoginBottomSheet extends ConsumerStatefulWidget {
  const LoginBottomSheet({super.key});

  static Future<void> show(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => const LoginBottomSheet(),
    );
  }

  @override
  ConsumerState<LoginBottomSheet> createState() => _LoginBottomSheetState();
}

class _LoginBottomSheetState extends ConsumerState<LoginBottomSheet> {
  bool _showEmailForm = false;
  bool _isSignUpMode = false;
  bool _isLoading = false;
  String? _errorMessage;

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  String _getReadableErrorMessage(dynamic e) {
    final errorStr = e.toString();
    if (errorStr.contains('provider is not enabled') || errorStr.contains('Unsupported provider')) {
      return 'Facebook Login is currently disabled. Please use Email Login.';
    }
    if (errorStr.contains('PlatformException') || errorStr.contains('Error while launching')) {
      return 'Could not open the login page. Please check your internet connection.';
    }
    if (errorStr.contains('network') || errorStr.contains('connection lost')) {
      return 'Network connection lost. Please check your internet connection.';
    }
    if (errorStr.contains('Invalid login credentials')) {
      return 'Invalid email or password. Please try again.';
    }
    if (errorStr.contains('User already exists')) {
      return 'An account with this email already exists.';
    }
    if (errorStr.contains('Password should be')) {
      return 'Password must be at least 6 characters long.';
    }
    
    // Fallback: clean up standard exception prefixes
    return errorStr
        .replaceAll('Exception: ', '')
        .replaceAll('AuthException: ', '')
        .split('\n')
        .first;
  }

  Future<void> _handleEmailLogin() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      setState(() {
        _errorMessage = 'Please enter both email and password';
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final authService = ref.read(authServiceProvider);
      if (_isSignUpMode) {
        await authService.signUpWithEmail(email, password);
      } else {
        await authService.signInWithEmail(email, password);
      }
      if (mounted) {
        Navigator.pop(context);
      }
    } catch (e) {
      setState(() {
        _errorMessage = _getReadableErrorMessage(e);
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final authService = ref.read(authServiceProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final accentColor = isDark ? const Color(0xFFcafd00) : const Color(0xFF006A3C);
    final primaryTextColor = isDark ? const Color(0xFFf9f5f8) : const Color(0xFF131315);
    final secondaryTextColor = isDark ? const Color(0xFFadaaad) : const Color(0xFF595C5D);
    final surfaceColor = isDark ? const Color(0xFF0e0e10).withOpacity(0.7) : const Color(0xFFFFFFFF).withOpacity(0.75);
    final borderColor = isDark ? const Color(0xFF262528) : const Color(0xFFE0E3E4);
    final dividerColor = isDark ? const Color(0xFF262528) : const Color(0xFFE0E3E4);
    final ringBg = isDark ? const Color(0xFF19191c) : const Color(0xFFF5F6F7);

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(40)),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 40),
            decoration: BoxDecoration(
              color: surfaceColor,
              border: Border(
                top: BorderSide(
                  color: borderColor,
                  width: 1,
                ),
              ),
            ),
            child: AnimatedSize(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Header Back Button & Title if showing form
                  if (_showEmailForm)
                    Align(
                      alignment: Alignment.centerLeft,
                      child: IconButton(
                        icon: Icon(Icons.arrow_back_ios_new_rounded, color: primaryTextColor),
                        onPressed: () {
                          setState(() {
                            _showEmailForm = false;
                            _errorMessage = null;
                          });
                        },
                      ),
                    ),

                  // Energy Ring Logo
                  if (!_showEmailForm)
                    Container(
                      width: 80,
                      height: 80,
                      margin: const EdgeInsets.only(bottom: 20),
                      decoration: BoxDecoration(
                        color: ringBg,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: accentColor.withOpacity(0.3),
                          width: 2,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: accentColor.withOpacity(isDark ? 0.4 : 0.15),
                            blurRadius: 25,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Icon(
                          Icons.sports_tennis,
                          color: accentColor,
                          size: 40,
                        ),
                      ),
                    ),

                  // Title
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: TextStyle(
                        fontFamily: 'Lexend',
                        fontSize: 28,
                        fontWeight: FontWeight.w900,
                        fontStyle: FontStyle.italic,
                        color: primaryTextColor,
                        letterSpacing: -1,
                      ),
                      children: [
                        TextSpan(
                          text: _showEmailForm
                              ? (_isSignUpMode ? 'EMAIL SIGNUP ' : 'EMAIL ')
                              : 'MATCH ',
                        ),
                        TextSpan(
                          text: _showEmailForm ? (_isSignUpMode ? 'UP' : 'LOGIN') : 'ME',
                          style: TextStyle(color: accentColor),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _showEmailForm
                        ? (_isSignUpMode ? 'Enter details to create an account.' : 'Enter your credentials to continue.')
                        : 'Join the court, level up your game.',
                    style: TextStyle(
                      fontFamily: 'Lexend',
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                      color: secondaryTextColor,
                      letterSpacing: 0.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32),

                  if (_errorMessage != null) ...[
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      decoration: BoxDecoration(
                        color: Colors.red.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.red.withOpacity(0.3)),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.error_outline, color: Colors.red, size: 18),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              _errorMessage!,
                              style: const TextStyle(color: Colors.red, fontSize: 13),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],

                  if (!_showEmailForm) ...[
                    // Sign in with Facebook
                    _SocialButton(
                      title: 'SIGN IN WITH FACEBOOK',
                      icon: const Icon(
                        Icons.facebook,
                        color: Color(0xFF1877F2),
                        size: 24,
                      ),
                      onPressed: () async {
                        setState(() => _isLoading = true);
                        try {
                          await authService.signInWithFacebook();
                          if (mounted) Navigator.pop(context);
                        } catch (e) {
                          setState(() {
                            _errorMessage = _getReadableErrorMessage(e);
                            _isLoading = false;
                          });
                        }
                      },
                    ),
                    const SizedBox(height: 16),

                    // Sign in with Email Button
                    _SocialButton(
                      title: 'SIGN IN WITH EMAIL',
                      icon: Icon(
                        Iconsax.sms_copy,
                        color: accentColor,
                        size: 24,
                      ),
                      onPressed: () {
                        setState(() {
                          _showEmailForm = true;
                        });
                      },
                    ),
                    const SizedBox(height: 32),

                    // Guest Option
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text(
                        'EXPLORE AS GUEST',
                        style: TextStyle(
                          fontFamily: 'Lexend',
                          fontSize: 12,
                          color: secondaryTextColor,
                          letterSpacing: 1.5,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ] else ...[
                    // Email Field
                    TextField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      style: TextStyle(color: primaryTextColor),
                      decoration: InputDecoration(
                        prefixIcon: Icon(Iconsax.sms_copy, color: secondaryTextColor),
                        hintText: 'Email Address',
                        hintStyle: TextStyle(color: secondaryTextColor.withOpacity(0.5)),
                        filled: true,
                        fillColor: isDark ? Colors.black26 : Colors.black.withOpacity(0.02),
                        contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: borderColor),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: accentColor, width: 2),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Password Field
                    TextField(
                      controller: _passwordController,
                      obscureText: true,
                      style: TextStyle(color: primaryTextColor),
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock_outline_rounded, color: secondaryTextColor),
                        hintText: 'Password',
                        hintStyle: TextStyle(color: secondaryTextColor.withOpacity(0.5)),
                        filled: true,
                        fillColor: isDark ? Colors.black26 : Colors.black.withOpacity(0.02),
                        contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: borderColor),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: accentColor, width: 2),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Submit Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : _handleEmailLogin,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: accentColor,
                          foregroundColor: isDark ? const Color(0xFF131315) : Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          elevation: 0,
                        ),
                        child: _isLoading
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2.5,
                                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                ),
                              )
                            : Text(
                                _isSignUpMode ? 'REGISTER' : 'SUBMIT',
                                style: TextStyle(
                                  fontFamily: 'Lexend',
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: isDark ? const Color(0xFF131315) : Colors.white,
                                  letterSpacing: 1.5,
                                ),
                              ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Toggle Sign Up / Log In
                    TextButton(
                      onPressed: () {
                        setState(() {
                          _isSignUpMode = !_isSignUpMode;
                          _errorMessage = null;
                        });
                      },
                      child: Text(
                        _isSignUpMode
                            ? 'Already have an account? Log In'
                            : "Don't have an account? Sign Up",
                        style: TextStyle(
                          fontFamily: 'Lexend',
                          fontSize: 13,
                          color: accentColor,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  ],

                  const SizedBox(height: 24),
                  Divider(color: dividerColor),
                  const SizedBox(height: 24),
                  Text(
                    'SECURE ACCESS PLATFORM',
                    style: TextStyle(
                      fontFamily: 'Lexend',
                      fontSize: 10,
                      color: isDark ? const Color(0xFF767577) : const Color(0xFFBBBFC7),
                      letterSpacing: 2.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SocialButton extends StatelessWidget {
  final String title;
  final Widget icon;
  final VoidCallback onPressed;

  const _SocialButton({
    required this.title,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final accentColor = isDark ? const Color(0xFFcafd00) : const Color(0xFF006A3C);
    final buttonBg = isDark ? const Color(0xFF0e0e10) : const Color(0xFFF5F6F7);
    final borderCol = isDark ? const Color(0xFFcafd00) : const Color(0xFF006A3C).withOpacity(0.5);
    final textColor = isDark ? const Color(0xFFf9f5f8) : const Color(0xFF131315);

    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(30),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        decoration: BoxDecoration(
          color: buttonBg,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: borderCol,
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: accentColor.withOpacity(isDark ? 0.4 : 0.1),
              blurRadius: 25,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon,
            const SizedBox(width: 16),
            Text(
              title,
              style: TextStyle(
                fontFamily: 'Lexend',
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: textColor,
                letterSpacing: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
