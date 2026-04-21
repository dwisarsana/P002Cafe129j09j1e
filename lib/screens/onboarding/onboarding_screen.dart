// lib/screens/onboarding/onboarding_screen.dart
// Cafe AI — Onboarding Screen (Enhanced Survey for User Retention)
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../theme/app_theme.dart';
import '../main/home_screen.dart';
import '../../src/constant.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  // Answers map
  final Map<String, String> _answers = {};

  // ── 7 Survey questions for cafe personalization ──
  final List<_Question> _questions = [
    _Question(
      keyName: 'q_space',
      title: 'What type of cafe space?',
      subtitle: 'We\'ll tailor AI designs to fit your landscape.',
      icon: Icons.storefront_rounded,
      options: [
        _Option('Coffee Shop', Icons.coffee_rounded),
        _Option('Bakery Cafe', Icons.bakery_dining_rounded),
        _Option('Bistro', Icons.restaurant_rounded),
        _Option('Rooftop Lounge', Icons.deck_rounded),
        _Option('Cyber Cafe', Icons.computer_rounded),
      ],
    ),
    _Question(
      keyName: 'q_goal',
      title: 'What\'s your cafe type?',
      subtitle: 'Pick the vibe you want to achieve.',
      icon: Icons.flag_rounded,
      options: [
        _Option('Modern Sanctuary', Icons.spa_rounded),
        _Option('Industrial Roastery', Icons.factory_rounded),
        _Option('Zen Cafe', Icons.self_improvement_rounded),
        _Option('Cozy Book Cafe', Icons.book_rounded),
        _Option('Entertaining Space', Icons.groups_rounded),
      ],
    ),
    _Question(
      keyName: 'q_style',
      title: 'Choose your style',
      subtitle: 'Pick the aesthetic that excites you most.',
      icon: Icons.brush_rounded,
      options: [
        _Option('Tropical Oasis', Icons.wb_sunny_rounded),
        _Option('Minimalist Cafe', Icons.local_cafe_rounded),
        _Option('Mediterranean', Icons.sunny_snowing),
        _Option('Vintage Bakery', Icons.cake_rounded),
        _Option('Geometric Modern', Icons.architecture_rounded),
      ],
    ),
    _Question(
      keyName: 'q_budget',
      title: 'What\'s your budget range?',
      subtitle: 'Helps us suggest realistic materials and plants.',
      icon: Icons.account_balance_wallet_rounded,
      options: [
        _Option('Under \$1k', Icons.savings_rounded),
        _Option('\$1k – \$5k', Icons.credit_card_rounded),
        _Option('\$5k – \$15k', Icons.trending_up_rounded),
        _Option('\$15k+', Icons.workspace_premium_rounded),
        _Option('Just exploring', Icons.search_rounded),
      ],
    ),
    _Question(
      keyName: 'q_timeline',
      title: 'When do you want to start?',
      subtitle: 'Helps us plan the generated sequences.',
      icon: Icons.calendar_month_rounded,
      options: [
        _Option('Immediately', Icons.flash_on_rounded),
        _Option('Next season', Icons.timelapse_rounded),
        _Option('Within 6 months', Icons.schedule_rounded),
        _Option('Next year', Icons.hourglass_empty_rounded),
        _Option('No set plans', Icons.explore_rounded),
      ],
    ),
    _Question(
      keyName: 'q_challenge',
      title: 'Biggest current challenge?',
      subtitle: 'What do you want the AI to fix?',
      icon: Icons.build_rounded,
      options: [
        _Option('Lack of seating', Icons.chair_rounded),
        _Option('Lack of privacy', Icons.visibility_off_rounded),
        _Option('High maintenance', Icons.build_circle_rounded),
        _Option('Poor lighting', Icons.lightbulb_outline_rounded),
        _Option('Small space', Icons.zoom_in_map_rounded),
      ],
    ),
    _Question(
      keyName: 'q_usage',
      title: 'Main cafe usage?',
      subtitle: 'How will you spend time here?',
      icon: Icons.favorite_rounded,
      options: [
        _Option('Relaxation', Icons.weekend_rounded),
        _Option('Family & Kids', Icons.child_care_rounded),
        _Option('Socializing', Icons.people_rounded),
        _Option('Working', Icons.laptop_mac_rounded),
        _Option('Visual decor', Icons.auto_awesome_rounded),
      ],
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentIndex < _questions.length) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeOutCubic,
      );
    } else {
      _finishOnboarding();
    }
  }

  Future<void> _finishOnboarding() async {
    HapticFeedback.heavyImpact();

    // Save onboarding state and answers
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('onboarding_done', true);
    for (final e in _answers.entries) {
      await prefs.setString(e.key, e.value);
    }

    // Wait slightly, then route and optionally show paywall
    await Future.delayed(const Duration(milliseconds: 400));

    if (!mounted) return;

    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) {
          // Open paywall on the new screen after transition
          Future.delayed(const Duration(milliseconds: 900), () {
            if (context.mounted) {
              openPaywallFromUserAction(context);
            }
          });
          return const HomeScreen();
        },
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
        transitionDuration: const Duration(milliseconds: 800),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Total pages = questions + 1 (the final pitch)
    final totalPages = _questions.length + 1;

    return Scaffold(
      backgroundColor: AppTheme.mistWhite,
      body: Stack(
        children: [
          // Background Gradient Element
          Positioned(
            top: -150,
            right: -100,
            child: Container(
              width: 400,
              height: 400,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    AppTheme.mossGreen.withValues(alpha: 0.1),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),

          SafeArea(
            child: Column(
              children: [
                // ── Header (Progress + Skip) ──
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Progress Indicators
                      Row(
                        children: List.generate(totalPages, (index) {
                          final isActive = index == _currentIndex;
                          final isPast = index < _currentIndex;
                          return AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            margin: const EdgeInsets.only(right: 6),
                            height: 4,
                            width: isActive ? 24 : 12,
                            decoration: BoxDecoration(
                              color: isActive || isPast
                                  ? AppTheme.mossGreen
                                  : AppTheme.slate.withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(2),
                            ),
                          );
                        }),
                      ),
                      // Skip Button
                      if (_currentIndex < _questions.length)
                        TextButton(
                          onPressed: _finishOnboarding,
                          style: TextButton.styleFrom(
                            foregroundColor: AppTheme.slate.withValues(alpha: 0.5),
                          ),
                          child: const Text(
                            'Skip',
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ),
                    ],
                  ),
                ),

                // ── Page Content ──
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    physics: const NeverScrollableScrollPhysics(), // Disable swipe
                    onPageChanged: (idx) {
                      setState(() => _currentIndex = idx);
                    },
                    itemCount: totalPages,
                    itemBuilder: (context, index) {
                      if (index < _questions.length) {
                        return _buildQuestionPage(_questions[index]);
                      } else {
                        return _buildFinalPitchPage();
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================
  // QUESTION PAGE
  // ==========================================
  Widget _buildQuestionPage(_Question q) {
    final selectedOption = _answers[q.keyName];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          // Icon & Title
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppTheme.mossGreen.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(q.icon, color: AppTheme.mossGreen, size: 28),
          ).animate().scale(delay: 100.ms, duration: 400.ms, curve: Curves.easeOutBack),

          const SizedBox(height: 24),
          Text(
            q.title,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w800,
              color: AppTheme.charcoal,
              height: 1.2,
              letterSpacing: -0.5,
            ),
          ).animate().fadeIn(duration: 400.ms).slideY(begin: 0.1),

          const SizedBox(height: 8),
          Text(
            q.subtitle,
            style: TextStyle(
              fontSize: 16,
              color: AppTheme.slate.withValues(alpha: 0.8),
              height: 1.4,
            ),
          ).animate().fadeIn(delay: 100.ms, duration: 400.ms).slideY(begin: 0.1),

          const SizedBox(height: 40),

          // Options List
          Expanded(
            child: ListView.separated(
              itemCount: q.options.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final option = q.options[index];
                final isSelected = selectedOption == option.label;

                return GestureDetector(
                  onTap: () {
                    HapticFeedback.selectionClick();
                    setState(() {
                      _answers[q.keyName] = option.label;
                    });
                    // Auto-advance after a short delay
                    Future.delayed(const Duration(milliseconds: 350), _nextPage);
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                    decoration: BoxDecoration(
                      color: isSelected ? AppTheme.mossGreen : Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: isSelected
                            ? AppTheme.mossGreen
                            : AppTheme.slate.withValues(alpha: 0.1),
                        width: isSelected ? 2 : 1,
                      ),
                      boxShadow: [
                        if (isSelected)
                          BoxShadow(
                            color: AppTheme.mossGreen.withValues(alpha: 0.3),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          )
                        else
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.02),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Icon(
                          option.icon,
                          color: isSelected ? Colors.white : AppTheme.slate,
                          size: 24,
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Text(
                            option.label,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                              color: isSelected ? Colors.white : AppTheme.charcoal,
                            ),
                          ),
                        ),
                        if (isSelected)
                          const Icon(Icons.check_circle_rounded, color: Colors.white, size: 22)
                              .animate()
                              .scale(duration: 200.ms, curve: Curves.easeOutBack),
                      ],
                    ),
                  ),
                ).animate().fadeIn(delay: (200 + index * 100).ms).slideX(begin: 0.05);
              },
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================
  // FINAL PITCH PAGE
  // ==========================================
  Widget _buildFinalPitchPage() {
    return Stack(
      children: [
        // Fake background blur of their future cafe
        Positioned.fill(
          child: Opacity(
            opacity: 0.15,
            child: Image.asset(
              'assets/images/AI Cafe Transformation.jpeg',
              fit: BoxFit.cover,
            ),
          ),
        ),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(),

              // Logo & Text
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppTheme.mossGreen.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Icon(CupertinoIcons.leaf_arrow_circlepath,
                    color: AppTheme.mossGreen, size: 36),
              ).animate().scale(duration: 500.ms, curve: Curves.easeOutBack),

              const SizedBox(height: 24),
              const Text(
                'Redesign Your\nCafe with AI',
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.w800,
                  color: AppTheme.charcoal,
                  height: 1.1,
                  letterSpacing: -1,
                ),
              ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.1),

              const SizedBox(height: 16),
              Text(
                'Upload a photo and let AI instantly redesign your cafe — from tropical jungle to zen sanctuary.',
                style: TextStyle(
                  fontSize: 16,
                  color: AppTheme.slate.withValues(alpha: 0.8),
                  height: 1.5,
                ),
              ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.1),

              const SizedBox(height: 40),

              // Value Props
              _buildValueProp(CupertinoIcons.wand_stars, 'AI generates stunning designs'),
              const SizedBox(height: 16),
              _buildValueProp(CupertinoIcons.tree, '10+ cafe styles to explore'),
              const SizedBox(height: 16),
              _buildValueProp(CupertinoIcons.slider_horizontal_3, 'Customize every detail'),

              const Spacer(flex: 2),

              // Final CTA
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _finishOnboarding,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.mossGreen,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text(
                    'Get Started',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                  ),
                ),
              ).animate().fadeIn(delay: 1000.ms).slideY(begin: 0.2),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildValueProp(IconData icon, String text) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.03),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Icon(icon, color: AppTheme.mossGreen, size: 20),
        ),
        const SizedBox(width: 16),
        Text(
          text,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: AppTheme.charcoal,
          ),
        ),
      ],
    ).animate().fadeIn(delay: 600.ms).slideX(begin: 0.1);
  }
}

// ── Models ──
class _Question {
  final String keyName;
  final String title;
  final String subtitle;
  final IconData icon;
  final List<_Option> options;

  const _Question({
    required this.keyName,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.options,
  });
}

class _Option {
  final String label;
  final IconData icon;

  const _Option(this.label, this.icon);
}
