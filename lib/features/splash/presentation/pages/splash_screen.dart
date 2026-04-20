import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../features/shell/main_shell_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _progressAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.5, curve: Curves.easeIn),
      ),
    );

    _scaleAnimation = Tween<double>(begin: 0.85, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.6, curve: Curves.easeOutCubic),
      ),
    );

    _progressAnimation = Tween<double>(begin: 0.0, end: 0.33).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.4, 1.0, curve: Curves.easeInOut),
      ),
    );

    _controller.repeat(
      reverse: true,
    ); // For the pulsing effect if needed, but we want a sequence
    _controller.forward();

    _navigateToHome();
  }

  void _navigateToHome() async {
    await Future.delayed(const Duration(seconds: 4));
    if (!mounted) return;
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const MainShellScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
        transitionDuration: const Duration(milliseconds: 1000),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // --- Stitch Design Constants ---
    final primaryColor = isDark
        ? const Color(0xFF65FB9E)
        : const Color(0xFF004D2C);
    final secondaryFixed = const Color(0xFFCCFF00);
    final onSurfaceVariant = isDark
        ? const Color(0xFFA2ABAE)
        : const Color(0xFF595C5D);

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.center,
            radius: 1.0,
            colors: isDark
                ? [const Color(0xFF1A1A1A), Colors.black]
                : [Colors.white, const Color(0xFFF2F3F4)],
          ),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Ambient Glow (from HTML)
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    center: Alignment.center,
                    radius: 0.6,
                    colors: [
                      secondaryFixed.withOpacity(isDark ? 0.08 : 0.04),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),

            // Main Content
            FadeTransition(
              opacity: _fadeAnimation,
              child: ScaleTransition(
                scale: _scaleAnimation,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // --- Athletic Logo Structure ---
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        // Decorative Outer Rings
                        Container(
                          width: 250,
                          height: 250,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: primaryColor.withOpacity(0.05),
                              width: 1,
                            ),
                          ),
                        ),
                        Container(
                          width: 215,
                          height: 215,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: primaryColor.withOpacity(0.1),
                              width: 1,
                            ),
                          ),
                        ),
                        // Main Logo Container
                        Container(
                          width: 192, // w-48
                          height: 192,
                          decoration: BoxDecoration(
                            color: isDark
                                ? const Color(0xFF0A0A0A)
                                : primaryColor,
                            shape: BoxShape.circle,
                            border: isDark
                                ? Border.all(
                                    color: secondaryFixed.withOpacity(0.2),
                                  )
                                : null,
                            boxShadow: [
                              BoxShadow(
                                color: isDark
                                    ? secondaryFixed.withOpacity(0.15)
                                    : Colors.black.withOpacity(0.15),
                                blurRadius: 48,
                                offset: const Offset(0, 24),
                              ),
                            ],
                          ),
                          clipBehavior: Clip.antiAlias,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              // Glass/Skew decoration (from HTML)
                              Positioned(
                                top: -20,
                                left: 0,
                                right: 0,
                                child: Transform(
                                  transform: Matrix4.skewY(-0.17), // ~10deg
                                  child: Container(
                                    height: 96,
                                    color: Colors.white.withOpacity(0.05),
                                  ),
                                ),
                              ),
                              Icon(
                                Icons
                                    .sports_tennis, // material-symbols-outlined sports_tennis
                                size: 112,
                                color: secondaryFixed,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 48),
                    // --- Typography ---
                    Text(
                      'MATCH ME',
                      style: GoogleFonts.ibmPlexSansThai(
                        fontSize: 42, // text-4xl
                        fontWeight: FontWeight.w900,
                        fontStyle: FontStyle.italic,
                        letterSpacing: -1.0,
                        height: 1.0,
                        color: isDark ? Colors.white : primaryColor,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'ตบสบัด จนเน็ตไหม้!',
                      style: GoogleFonts.ibmPlexSansThai(
                        fontSize: 12,
                        fontWeight: FontWeight.w300,

                        color: onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // --- Bottom Initializing Bar ---
            Positioned(
              bottom: 60,
              child: Column(
                children: [
                  Container(
                    width: 300,
                    height: 3,
                    decoration: BoxDecoration(
                      color: (isDark ? Colors.white : Colors.black).withOpacity(
                        0.1,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Stack(
                      children: [
                        AnimatedBuilder(
                          animation: _progressAnimation,
                          builder: (context, child) {
                            return FractionallySizedBox(
                              widthFactor: _progressAnimation.value,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: secondaryFixed,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: secondaryFixed.withOpacity(
                                        isDark ? 0.8 : 0.5,
                                      ),
                                      blurRadius: 10,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'INITIALIZING PRO SHOP',
                    style: GoogleFonts.ibmPlexSansThai(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 3,
                      color: onSurfaceVariant.withOpacity(0.7),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
