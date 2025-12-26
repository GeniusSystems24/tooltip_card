import 'package:flutter/material.dart';
import 'package:tooltip_card/tooltip_card.dart';

/// Forms & Validation examples screen
class FormsExamplesScreen extends StatefulWidget {
  const FormsExamplesScreen({super.key});

  @override
  State<FormsExamplesScreen> createState() => _FormsExamplesScreenState();
}

class _FormsExamplesScreenState extends State<FormsExamplesScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _publicState = TooltipCardPublicState();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _publicState.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Forms & Validation'),
        backgroundColor: const Color(0xFF6366F1).withValues(alpha: 0.1),
        foregroundColor: const Color(0xFF4338CA), // Indigo 700
        elevation: 0,
        bottom: TabBar(
          controller: _tabController,
          labelColor: const Color(0xFF4338CA),
          unselectedLabelColor: colorScheme.onSurface.withValues(alpha: 0.6),
          indicatorColor: const Color(0xFF6366F1), // Indigo 500
          indicatorSize: TabBarIndicatorSize.label,
          dividerColor: Colors.transparent,
          tabs: const [
            Tab(
              text: 'Input Help',
              icon: Icon(Icons.help_outline_rounded, size: 20),
            ),
            Tab(
              text: 'Validation',
              icon: Icon(Icons.check_circle_outline_rounded, size: 20),
            ),
            Tab(
              text: 'Wizard',
              icon: Icon(Icons.linear_scale_rounded, size: 20),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _InputHelpTab(publicState: _publicState),
          _ValidationTab(publicState: _publicState),
          _WizardTab(publicState: _publicState),
        ],
      ),
    );
  }
}

// =============================================================================
// Input Help Tab
// =============================================================================

class _InputHelpTab extends StatelessWidget {
  const _InputHelpTab({required this.publicState});
  final TooltipCardPublicState publicState;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _SectionHeader(
            title: 'Smart Form Assistance',
            subtitle: 'Contextual help where you need it most',
            icon: Icons.lightbulb_circle_rounded,
            color: Color(0xFFEC4899), // Pink 500
          ),
          const SizedBox(height: 24),
          _FormCard(
            title: 'Account Registration',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Email field
                _FormFieldWithHelp(
                  label: 'Email Address',
                  hint: 'name@example.com',
                  icon: Icons.email_outlined,
                  helpTitle: 'Email Format',
                  helpContent:
                      'We\'ll send a verification link to this address. Ensure you have access to it.',
                  publicState: publicState,
                  accentColor: const Color(0xFFEC4899),
                ),
                const SizedBox(height: 24),

                // Password field
                _FormFieldWithHelp(
                  label: 'Password',
                  hint: 'Create a strong password',
                  icon: Icons.lock_outline_rounded,
                  isPassword: true,
                  helpTitle: 'Secure Password',
                  helpContent:
                      '• Min 8 chars\n• uppercase & lowercase\n• 1+ number\n• 1+ symbol (!@#\$)',
                  publicState: publicState,
                  accentColor: const Color(0xFF8B5CF6), // Violet
                ),
                const SizedBox(height: 24),

                // Date of Birth (New Example)
                _DatePickerField(
                  label: 'Date of Birth',
                  hint: 'Select date',
                  publicState: publicState,
                ),
                const SizedBox(height: 24),

                // Payment Section Header
                Row(
                  children: [
                    Text(
                      'Payment Details',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Expanded(child: Divider(height: 1)),
                  ],
                ),
                const SizedBox(height: 16),

                // Card Number with CVV Help
                _FormFieldWithHelp(
                  label: 'Card Number',
                  hint: '0000 0000 0000 0000',
                  icon: Icons.credit_card_rounded,
                  helpTitle: 'Bank Security',
                  helpContent:
                      'We use bank-level encryption. Your card details are never stored on our servers.',
                  publicState: publicState,
                  isSecure: true,
                  accentColor: const Color(0xFF059669), // Emerald
                ),
                const SizedBox(height: 24),

                Row(
                  children: [
                    Expanded(
                      child: _CurrencyInputField(
                        label: 'Monthly Limit',
                        publicState: publicState,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(child: _CVVInputField(publicState: publicState)),
                  ],
                ),

                const SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: () {},
                    style: FilledButton.styleFrom(
                      backgroundColor: const Color(0xFF6366F1), // Indigo 500
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 4,
                      shadowColor: const Color(
                        0xFF6366F1,
                      ).withValues(alpha: 0.4),
                    ),
                    child: const Text(
                      'Create Account',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _FormFieldWithHelp extends StatelessWidget {
  const _FormFieldWithHelp({
    required this.label,
    required this.hint,
    required this.icon,
    required this.helpTitle,
    required this.helpContent,
    required this.publicState,
    this.isPassword = false,
    this.isSecure = false,
    this.accentColor = const Color(0xFF6366F1),
  });

  final String label, hint, helpTitle, helpContent;
  final IconData icon;
  final TooltipCardPublicState publicState;
  final bool isPassword, isSecure;
  final Color accentColor;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 13),
            ),
            const SizedBox(width: 8),
            TooltipCard.builder(
              publicState: publicState,
              placementSide: TooltipCardPlacementSide.topEnd,
              beakEnabled: true,
              whenContentVisible: WhenContentVisible.hoverButton,
              builder: (ctx, close) => _HelpTooltip(
                title: helpTitle,
                content: helpContent,
                isSecure: isSecure,
              ),
              child: Icon(
                Icons.info_outline_rounded,
                size: 18,
                color: colorScheme.onSurface.withValues(alpha: 0.4),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: colorScheme.surface, // Cleaner white/dark bg
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: colorScheme.outline.withValues(alpha: 0.15),
            ),
            boxShadow: [
              BoxShadow(
                color: colorScheme.shadow.withValues(alpha: 0.03),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 14, right: 10),
                child: Icon(icon, size: 20, color: accentColor),
              ),
              Expanded(
                child: TextField(
                  obscureText: isPassword,
                  style: const TextStyle(fontSize: 14),
                  decoration: InputDecoration(
                    hintText: hint,
                    hintStyle: TextStyle(
                      color: colorScheme.onSurface.withValues(alpha: 0.4),
                      fontWeight: FontWeight.w400,
                    ),
                    border: InputBorder.none, // Removes default underline
                    contentPadding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                ),
              ),
              if (isSecure)
                Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: TooltipCard.builder(
                    publicState: publicState,
                    placementSide: TooltipCardPlacementSide.start,
                    beakEnabled: true,
                    // shadowColor: const Color(0xFF10B981).withValues(alpha: 0.2), // Defined property
                    builder: (ctx, close) => const Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.lock_rounded,
                            size: 14,
                            color: Color(0xFF10B981), // Emerald
                          ),
                          SizedBox(width: 6),
                          Text(
                            'TLS Encrypted',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF065F46), // Dark Emerald
                            ),
                          ),
                        ],
                      ),
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: const Color(0xFF10B981).withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.verified_user_rounded,
                        size: 16,
                        color: Color(0xFF10B981),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}

class _HelpTooltip extends StatelessWidget {
  const _HelpTooltip({
    required this.title,
    required this.content,
    this.isSecure = false,
  });
  final String title, content;
  final bool isSecure;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return SizedBox(
      width: 260,
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.lightbulb_circle,
                  size: 24,
                  color: Color(0xFFF59E0B),
                ), // Amber 500
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              content,
              style: TextStyle(
                fontSize: 13,
                height: 1.5,
                color: colorScheme.onSurface.withValues(alpha: 0.85),
              ),
            ),
            if (isSecure) ...[
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFF10B981).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: const Color(0xFF10B981).withValues(alpha: 0.2),
                  ),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.security_rounded,
                      size: 20,
                      color: Color(0xFF059669),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Encrypted Connection',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF065F46),
                            ),
                          ),
                          Text(
                            '256-bit SSL encryption active',
                            style: TextStyle(
                              fontSize: 11,
                              color: const Color(
                                0xFF065F46,
                              ).withValues(alpha: 0.8),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

// =============================================================================
// Validation Tab
// =============================================================================

class _ValidationTab extends StatefulWidget {
  const _ValidationTab({required this.publicState});
  final TooltipCardPublicState publicState;

  @override
  State<_ValidationTab> createState() => _ValidationTabState();
}

class _ValidationTabState extends State<_ValidationTab> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _usernameController = TextEditingController();

  bool _emailValid = false;
  bool _passwordValid = false;
  bool _usernameValid = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _SectionHeader(
            title: 'Real-time Validation',
            subtitle: 'Instant feedback with intelligent suggestions',
            icon: Icons.verified_user_rounded,
            color: Color(0xFF059669), // Emerald 600
          ),
          const SizedBox(height: 20),
          _FormCard(
            title: 'Sign Up Form',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Username field
                _ValidationField(
                  controller: _usernameController,
                  label: 'Username',
                  hint: 'Choose a username',
                  icon: Icons.person_rounded,
                  isValid: _usernameValid,
                  onChanged: (value) {
                    setState(() {
                      _usernameValid =
                          value.length >= 3 &&
                          RegExp(r'^[a-zA-Z0-9_]+$').hasMatch(value);
                    });
                  },
                  validationRules: const [
                    _ValidationRule('At least 3 characters', true),
                    _ValidationRule(
                      'Only letters, numbers, and underscores',
                      true,
                    ),
                    _ValidationRule('No spaces allowed', true),
                  ],
                  publicState: widget.publicState,
                ),
                const SizedBox(height: 20),
                // Email field
                _ValidationField(
                  controller: _emailController,
                  label: 'Email',
                  hint: 'Enter your email',
                  icon: Icons.email_rounded,
                  isValid: _emailValid,
                  onChanged: (value) {
                    setState(() {
                      _emailValid = RegExp(
                        r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                      ).hasMatch(value);
                    });
                  },
                  validationRules: const [
                    _ValidationRule('Valid email format', true),
                    _ValidationRule('Contains @ symbol', true),
                    _ValidationRule('Has domain extension', true),
                  ],
                  publicState: widget.publicState,
                ),
                const SizedBox(height: 20),
                // Password field
                _ValidationField(
                  controller: _passwordController,
                  label: 'Password',
                  hint: 'Create a password',
                  icon: Icons.lock_rounded,
                  isPassword: true,
                  isValid: _passwordValid,
                  onChanged: (value) {
                    setState(() {
                      _passwordValid =
                          value.length >= 8 &&
                          RegExp(r'[A-Z]').hasMatch(value) &&
                          RegExp(r'[a-z]').hasMatch(value) &&
                          RegExp(r'[0-9]').hasMatch(value);
                    });
                  },
                  validationRules: [
                    _ValidationRule(
                      'At least 8 characters',
                      _passwordController.text.length >= 8,
                    ),
                    _ValidationRule(
                      'One uppercase letter',
                      RegExp(r'[A-Z]').hasMatch(_passwordController.text),
                    ),
                    _ValidationRule(
                      'One lowercase letter',
                      RegExp(r'[a-z]').hasMatch(_passwordController.text),
                    ),
                    _ValidationRule(
                      'One number',
                      RegExp(r'[0-9]').hasMatch(_passwordController.text),
                    ),
                  ],
                  publicState: widget.publicState,
                ),
                const SizedBox(height: 24),
                // Password strength indicator
                _PasswordStrengthIndicator(password: _passwordController.text),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: (_usernameValid && _emailValid && _passwordValid)
                        ? () {}
                        : null,
                    style: FilledButton.styleFrom(
                      backgroundColor: const Color(0xFF059669), // Emerald 600
                      disabledBackgroundColor: const Color(
                        0xFFE5E7EB,
                      ), // Gray 200
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Create Account',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ValidationRule {
  final String text;
  final bool passed;
  const _ValidationRule(this.text, this.passed);
}

class _ValidationField extends StatelessWidget {
  const _ValidationField({
    required this.controller,
    required this.label,
    required this.hint,
    required this.icon,
    required this.isValid,
    required this.onChanged,
    required this.validationRules,
    required this.publicState,
    this.isPassword = false,
  });

  final TextEditingController controller;
  final String label, hint;
  final IconData icon;
  final bool isValid, isPassword;
  final Function(String) onChanged;
  final List<_ValidationRule> validationRules;
  final TooltipCardPublicState publicState;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final hasInput = controller.text.isNotEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 13),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: colorScheme.surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: hasInput
                  ? (isValid
                        ? const Color(0xFF059669)
                        : const Color(0xFFEF4444))
                  : colorScheme.outline.withValues(alpha: 0.15),
              width: hasInput ? 1.5 : 1,
            ),
            boxShadow: hasInput
                ? [
                    BoxShadow(
                      color:
                          (isValid
                                  ? const Color(0xFF059669)
                                  : const Color(0xFFEF4444))
                              .withValues(alpha: 0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : null,
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: Icon(
                  icon,
                  size: 20,
                  color: hasInput
                      ? (isValid
                            ? const Color(0xFF059669)
                            : const Color(0xFFEF4444))
                      : colorScheme.onSurface.withValues(alpha: 0.4),
                ),
              ),
              Expanded(
                child: TextField(
                  controller: controller,
                  obscureText: isPassword,
                  onChanged: onChanged,
                  style: const TextStyle(fontSize: 14),
                  decoration: InputDecoration(
                    hintText: hint,
                    hintStyle: TextStyle(
                      color: colorScheme.onSurface.withValues(alpha: 0.4),
                      fontWeight: FontWeight.w400,
                    ),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                ),
              ),
              TooltipCard.builder(
                publicState: publicState,
                placementSide: TooltipCardPlacementSide.start,
                beakEnabled: true,
                whenContentVisible: WhenContentVisible.pressButton,
                builder: (ctx, close) =>
                    _ValidationRulesTooltip(rules: validationRules),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(8, 8, 14, 8),
                  child: Icon(
                    hasInput
                        ? (isValid
                              ? Icons.check_circle_rounded
                              : Icons.error_rounded)
                        : Icons
                              .info_outline_rounded, // Improved: Always show an icon
                    size: 20,
                    color: hasInput
                        ? (isValid
                              ? const Color(0xFF059669)
                              : const Color(0xFFEF4444))
                        : colorScheme.onSurface.withValues(alpha: 0.2),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ValidationRulesTooltip extends StatelessWidget {
  const _ValidationRulesTooltip({required this.rules});
  final List<_ValidationRule> rules;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 220,
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.rule_rounded, size: 16, color: Color(0xFFF59E0B)),
                SizedBox(width: 8),
                Text(
                  'Requirements',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ],
            ),
            const SizedBox(height: 10),
            ...rules.map(
              (rule) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 3),
                child: Row(
                  children: [
                    Icon(
                      rule.passed
                          ? Icons.check_circle_rounded
                          : Icons
                                .cancel_outlined, // Changed icon to clearer error state
                      size: 16,
                      color: rule.passed
                          ? const Color(0xFF059669)
                          : const Color(
                              0xFFEF4444,
                            ).withValues(alpha: 0.5), // Faint red
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        rule.text,
                        style: TextStyle(
                          fontSize: 13,
                          color: rule.passed
                              ? const Color(0xFF059669)
                              : const Color(
                                  0xFFEF4444,
                                ).withValues(alpha: 0.7), // Faint, readable red
                          decoration: rule.passed
                              ? TextDecoration.lineThrough
                              : null,
                          decorationColor: const Color(
                            0xFF059669,
                          ).withValues(alpha: 0.5),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PasswordStrengthIndicator extends StatelessWidget {
  const _PasswordStrengthIndicator({required this.password});
  final String password;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    int strength = 0;
    if (password.length >= 8) strength++;
    if (RegExp(r'[A-Z]').hasMatch(password)) strength++;
    if (RegExp(r'[a-z]').hasMatch(password)) strength++;
    if (RegExp(r'[0-9]').hasMatch(password)) strength++;
    if (RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password)) strength++;

    String label;
    Color color;
    switch (strength) {
      case 0:
      case 1:
        label = 'Weak';
        color = const Color(0xFFEF4444); // Red 500
        break;
      case 2:
        label = 'Fair';
        color = const Color(0xFFF59E0B); // Amber 500
        break;
      case 3:
        label = 'Good';
        color = const Color(0xFF84CC16); // Lime 500
        break;
      case 4:
        label = 'Strong';
        color = const Color(0xFF10B981); // Emerald 500
        break;
      default:
        label = 'Very Strong';
        color = const Color(0xFF059669); // Emerald 600
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Password Strength',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
            ),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: List.generate(
            5,
            (i) => Expanded(
              child: Container(
                height: 4,
                margin: EdgeInsets.only(right: i < 4 ? 4 : 0),
                decoration: BoxDecoration(
                  color: i < strength
                      ? color
                      : colorScheme.outline.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// =============================================================================
// Wizard Tab
// =============================================================================

class _WizardTab extends StatefulWidget {
  const _WizardTab({required this.publicState});
  final TooltipCardPublicState publicState;

  @override
  State<_WizardTab> createState() => _WizardTabState();
}

class _WizardTabState extends State<_WizardTab> {
  int _currentStep = 0;

  final steps = [
    _WizardStep(
      'Personal Info',
      'Basic details',
      Icons.person_rounded,
      const Color(0xFF2563EB), // Blue 600
    ),
    _WizardStep(
      'Contact',
      'Email & phone',
      Icons.contact_mail_rounded,
      const Color(0xFF059669), // Emerald 600
    ),
    _WizardStep(
      'Address',
      'Shipping address',
      Icons.location_on_rounded,
      const Color(0xFFF59E0B), // Amber 500
    ),
    _WizardStep(
      'Payment',
      'Payment method',
      Icons.payment_rounded,
      const Color(0xFF8B5CF6), // Violet 500
    ),
    _WizardStep(
      'Review',
      'Confirm order',
      Icons.check_circle_rounded,
      const Color(0xFF0F766E), // Teal 700
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _SectionHeader(
            title: 'Multi-Step Wizard',
            subtitle: 'Hover over steps for navigation help',
            icon: Icons.linear_scale_rounded,
            color: Color(0xFF6366F1), // Indigo 500
          ),
          const SizedBox(height: 20),
          // Stepper
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Column(
              children: [
                Row(
                  children: steps.asMap().entries.map((entry) {
                    final i = entry.key;
                    final step = entry.value;
                    final isActive = i == _currentStep;
                    final isCompleted = i < _currentStep;

                    return Expanded(
                      child: Row(
                        children: [
                          TooltipCard.builder(
                            publicState: widget.publicState,
                            placementSide: TooltipCardPlacementSide.top,
                            beakEnabled: true,
                            whenContentVisible: WhenContentVisible.hoverButton,
                            builder: (ctx, close) => _StepTooltip(
                              step: step,
                              stepNumber: i + 1,
                              isCompleted: isCompleted,
                              isActive: isActive,
                            ),
                            child: GestureDetector(
                              onTap: isCompleted
                                  ? () => setState(() => _currentStep = i)
                                  : null,
                              child: Container(
                                width: 36,
                                height: 36,
                                decoration: BoxDecoration(
                                  color: isCompleted
                                      ? step.color
                                      : (isActive
                                            ? step.color.withValues(alpha: 0.2)
                                            : colorScheme
                                                  .surfaceContainerHighest),
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: isActive || isCompleted
                                        ? step.color
                                        : colorScheme.outline.withValues(
                                            alpha: 0.3,
                                          ),
                                    width: 2,
                                  ),
                                ),
                                child: Center(
                                  child: isCompleted
                                      ? const Icon(
                                          Icons.check_rounded,
                                          size: 18,
                                          color: Colors.white,
                                        )
                                      : Text(
                                          '${i + 1}',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            color: isActive
                                                ? step.color
                                                : colorScheme.onSurface
                                                      .withValues(alpha: 0.5),
                                          ),
                                        ),
                                ),
                              ),
                            ),
                          ),
                          if (i < steps.length - 1)
                            Expanded(
                              child: Container(
                                height: 2,
                                color: isCompleted
                                    ? step.color
                                    : colorScheme.outline.withValues(
                                        alpha: 0.2,
                                      ),
                              ),
                            ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: steps.asMap().entries.map((entry) {
                    final i = entry.key;
                    final step = entry.value;
                    final isActive = i == _currentStep;

                    return Expanded(
                      child: Text(
                        step.title,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: isActive
                              ? FontWeight.w600
                              : FontWeight.w400,
                          color: isActive
                              ? step.color
                              : colorScheme.onSurface.withValues(alpha: 0.5),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          // Current step content
          _FormCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: steps[_currentStep].color.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(
                        steps[_currentStep].icon,
                        color: steps[_currentStep].color,
                        size: 22,
                      ),
                    ),
                    const SizedBox(width: 14),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Step ${_currentStep + 1} of ${steps.length}',
                          style: TextStyle(
                            fontSize: 12,
                            color: colorScheme.onSurface.withValues(alpha: 0.5),
                          ),
                        ),
                        Text(
                          steps[_currentStep].title,
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                _getStepContent(_currentStep),
                const SizedBox(height: 24),
                Row(
                  children: [
                    if (_currentStep > 0)
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => setState(() => _currentStep--),
                          child: const Text('Back'),
                        ),
                      ),
                    if (_currentStep > 0) const SizedBox(width: 12),
                    Expanded(
                      child: FilledButton(
                        onPressed: () {
                          if (_currentStep < steps.length - 1) {
                            setState(() => _currentStep++);
                          }
                        },
                        style: FilledButton.styleFrom(
                          backgroundColor: steps[_currentStep].color,
                        ),
                        child: Text(
                          _currentStep == steps.length - 1
                              ? 'Complete'
                              : 'Continue',
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _getStepContent(int step) {
    switch (step) {
      case 0:
        return _PersonalInfoStep(publicState: widget.publicState);
      case 1:
        return _ContactStep(publicState: widget.publicState);
      case 2:
        return _AddressStep(publicState: widget.publicState);
      case 3:
        return _PaymentStep(publicState: widget.publicState);
      default:
        return _ReviewStep(publicState: widget.publicState);
    }
  }
}

class _WizardStep {
  final String title, subtitle;
  final IconData icon;
  final Color color;
  _WizardStep(this.title, this.subtitle, this.icon, this.color);
}

class _StepTooltip extends StatelessWidget {
  const _StepTooltip({
    required this.step,
    required this.stepNumber,
    required this.isCompleted,
    required this.isActive,
  });
  final _WizardStep step;
  final int stepNumber;
  final bool isCompleted, isActive;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(step.icon, size: 16, color: step.color),
              const SizedBox(width: 8),
              Text(
                'Step $stepNumber: ${step.title}',
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            step.subtitle,
            style: TextStyle(
              fontSize: 12,
              color: Theme.of(
                context,
              ).colorScheme.onSurface.withValues(alpha: 0.7),
            ),
          ),
          const SizedBox(height: 6),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: isCompleted
                  ? Colors.green.withValues(alpha: 0.1)
                  : (isActive
                        ? step.color.withValues(alpha: 0.1)
                        : Colors.grey.withValues(alpha: 0.1)),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              isCompleted
                  ? 'Completed'
                  : (isActive ? 'Current Step' : 'Pending'),
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: isCompleted
                    ? Colors.green
                    : (isActive ? step.color : Colors.grey),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PersonalInfoStep extends StatelessWidget {
  const _PersonalInfoStep({required this.publicState});
  final TooltipCardPublicState publicState;

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        _SimpleField(
          label: 'First Name',
          hint: 'Enter first name',
          icon: Icons.person_outline_rounded,
        ),
        SizedBox(height: 16),
        _SimpleField(
          label: 'Last Name',
          hint: 'Enter last name',
          icon: Icons.person_outline_rounded,
        ),
        SizedBox(height: 16),
        _SimpleField(
          label: 'Date of Birth',
          hint: 'MM/DD/YYYY',
          icon: Icons.cake_rounded,
        ),
      ],
    );
  }
}

class _ContactStep extends StatelessWidget {
  const _ContactStep({required this.publicState});
  final TooltipCardPublicState publicState;

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        _SimpleField(
          label: 'Email',
          hint: 'Enter email',
          icon: Icons.email_rounded,
        ),
        SizedBox(height: 16),
        _SimpleField(
          label: 'Phone',
          hint: 'Enter phone number',
          icon: Icons.phone_rounded,
        ),
      ],
    );
  }
}

class _AddressStep extends StatelessWidget {
  const _AddressStep({required this.publicState});
  final TooltipCardPublicState publicState;

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        _SimpleField(
          label: 'Street Address',
          hint: 'Enter street address',
          icon: Icons.home_rounded,
        ),
        SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _SimpleField(
                label: 'City',
                hint: 'City',
                icon: Icons.location_city_rounded,
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: _SimpleField(
                label: 'ZIP',
                hint: 'ZIP Code',
                icon: Icons.pin_drop_rounded,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _PaymentStep extends StatelessWidget {
  const _PaymentStep({required this.publicState});
  final TooltipCardPublicState publicState;

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        _SimpleField(
          label: 'Card Number',
          hint: '0000 0000 0000 0000',
          icon: Icons.credit_card_rounded,
        ),
        SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _SimpleField(
                label: 'Expiry',
                hint: 'MM/YY',
                icon: Icons.date_range_rounded,
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: _SimpleField(
                label: 'CVV',
                hint: '123',
                icon: Icons.lock_rounded,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _ReviewStep extends StatelessWidget {
  const _ReviewStep({required this.publicState});
  final TooltipCardPublicState publicState;

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.green.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                  color: Colors.green,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check_rounded,
                  color: Colors.white,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Ready to Complete',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'All steps have been completed. Review your information and click Complete to finish.',
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _SimpleField extends StatelessWidget {
  const _SimpleField({
    required this.label,
    required this.hint,
    required this.icon,
  });
  final String label, hint;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 12),
        ),
        const SizedBox(height: 6),
        Container(
          decoration: BoxDecoration(
            color: colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: colorScheme.outline.withValues(alpha: 0.2),
            ),
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Icon(
                  icon,
                  size: 18,
                  color: colorScheme.onSurface.withValues(alpha: 0.5),
                ),
              ),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: hint,
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(vertical: 12),
                    hintStyle: const TextStyle(fontSize: 13),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// =============================================================================
// Shared Components
// =============================================================================

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
  });
  final String title, subtitle;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: color, size: 22),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                ),
              ),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 13,
                  color: colorScheme.onSurface.withValues(alpha: 0.6),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _FormCard extends StatelessWidget {
  const _FormCard({required this.child, this.title});
  final Widget child;
  final String? title;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: colorScheme.outline.withValues(alpha: 0.1)),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withValues(alpha: 0.05),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: colorScheme.outline.withValues(alpha: 0.1),
                  ),
                ),
              ),
              child: Text(
                title!,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          Padding(padding: const EdgeInsets.all(24), child: child),
        ],
      ),
    );
  }
}

// NEW EXAMPLES
class _DatePickerField extends StatelessWidget {
  const _DatePickerField({
    required this.label,
    required this.hint,
    required this.publicState,
  });

  final String label, hint;
  final TooltipCardPublicState publicState;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 13),
        ),
        const SizedBox(height: 8),
        TooltipCard.builder(
          publicState: publicState,
          placementSide: TooltipCardPlacementSide.bottom,
          beakEnabled: true,
          whenContentVisible:
              WhenContentVisible.pressButton, // Show on interaction
          builder: (context, close) => _DateSelectionTooltip(
            onClose: close,
            onSelect: (date) {
              close();
            },
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
            decoration: BoxDecoration(
              color: colorScheme.surface,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: colorScheme.outline.withValues(alpha: 0.15),
              ),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.calendar_today_rounded,
                  size: 18,
                  color: Color(0xFF6366F1),
                ),
                const SizedBox(width: 12),
                Text(
                  hint,
                  style: TextStyle(
                    color: colorScheme.onSurface.withValues(alpha: 0.5),
                  ),
                ),
                const Spacer(),
                Icon(
                  Icons.arrow_drop_down_rounded,
                  color: colorScheme.onSurface.withValues(alpha: 0.4),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _DateSelectionTooltip extends StatelessWidget {
  const _DateSelectionTooltip({required this.onClose, required this.onSelect});
  final VoidCallback onClose;
  final Function(DateTime) onSelect;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      width: 280,
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Select Date',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              IconButton(
                icon: const Icon(Icons.close, size: 18),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                onPressed: onClose,
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Mock Calendar Grid for Visuals
          GridView.builder(
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
            ),
            itemCount: 28, // Just a few days
            itemBuilder: (context, index) {
              final day = index + 1;
              final isSelected = day == 15;
              return InkWell(
                onTap: () => onSelect(DateTime(2025, 1, day)),
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: isSelected
                        ? const Color(0xFF6366F1)
                        : Colors.transparent,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    '$day',
                    style: TextStyle(
                      color: isSelected ? Colors.white : colorScheme.onSurface,
                      fontSize: 12,
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _CVVInputField extends StatelessWidget {
  const _CVVInputField({required this.publicState});
  final TooltipCardPublicState publicState;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text(
              'CVV / CVC',
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 13),
            ),
            const SizedBox(width: 8),
            TooltipCard.builder(
              publicState: publicState,
              placementSide: TooltipCardPlacementSide.topEnd,
              beakEnabled: true,
              whenContentVisible: WhenContentVisible.hoverButton,
              builder: (ctx, close) => Container(
                width: 200,
                padding: const EdgeInsets.all(12),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      height: 100,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.grey.shade300, Colors.grey.shade400],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            top: 20,
                            left: 0,
                            right: 0,
                            child: Container(height: 20, color: Colors.black12),
                          ),
                          Positioned(
                            top: 50,
                            right: 20,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 4,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.red, width: 2),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: const Text(
                                '123',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'The 3-digit number on the back of your card.',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ),
              child: Icon(
                Icons.help_outline,
                size: 16,
                color: colorScheme.primary,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: colorScheme.surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: colorScheme.outline.withValues(alpha: 0.15),
            ),
          ),
          child: const TextField(
            decoration: InputDecoration(
              hintText: '123',
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(
                vertical: 14,
                horizontal: 16,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _CurrencyInputField extends StatelessWidget {
  const _CurrencyInputField({required this.label, required this.publicState});
  final String label;
  final TooltipCardPublicState publicState;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 13),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: colorScheme.surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: colorScheme.outline.withValues(alpha: 0.15),
            ),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
                decoration: BoxDecoration(
                  color: colorScheme.surfaceContainerHighest.withValues(
                    alpha: 0.5,
                  ),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    bottomLeft: Radius.circular(12),
                  ),
                ),
                child: const Text(
                  '\$',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              const Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: '1,000.00',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
