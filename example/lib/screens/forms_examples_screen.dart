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
        backgroundColor: Colors.pink.withValues(alpha: 0.1),
        foregroundColor: Colors.pink.shade700,
        elevation: 0,
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.pink.shade700,
          unselectedLabelColor: colorScheme.onSurface.withValues(alpha: 0.6),
          indicatorColor: Colors.pink,
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
          _SectionHeader(
            title: 'Form with Help Tooltips',
            subtitle: 'Hover over info icons for guidance',
            icon: Icons.help_outline_rounded,
            color: Colors.pink,
          ),
          const SizedBox(height: 20),
          _FormCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Email field
                _FormFieldWithHelp(
                  label: 'Email Address',
                  hint: 'Enter your email',
                  icon: Icons.email_rounded,
                  helpTitle: 'Email Format',
                  helpContent:
                      'Enter a valid email address (e.g., user@example.com). This will be used for account verification and notifications.',
                  publicState: publicState,
                ),
                const SizedBox(height: 20),
                // Password field
                _FormFieldWithHelp(
                  label: 'Password',
                  hint: 'Create a strong password',
                  icon: Icons.lock_rounded,
                  isPassword: true,
                  helpTitle: 'Password Requirements',
                  helpContent:
                      '• At least 8 characters\n• One uppercase letter\n• One lowercase letter\n• One number\n• One special character (!@#\$%)',
                  publicState: publicState,
                ),
                const SizedBox(height: 20),
                // Phone field
                _FormFieldWithHelp(
                  label: 'Phone Number',
                  hint: '+1 (555) 000-0000',
                  icon: Icons.phone_rounded,
                  helpTitle: 'Phone Format',
                  helpContent:
                      'Enter your phone number with country code. We may use this for two-factor authentication.',
                  publicState: publicState,
                ),
                const SizedBox(height: 20),
                // Card number field
                _FormFieldWithHelp(
                  label: 'Credit Card',
                  hint: '0000 0000 0000 0000',
                  icon: Icons.credit_card_rounded,
                  helpTitle: 'Payment Security',
                  helpContent:
                      'Your card information is encrypted and securely processed. We never store your full card number.',
                  publicState: publicState,
                  isSecure: true,
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: () {},
                    style: FilledButton.styleFrom(
                      backgroundColor: Colors.pink,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: const Text('Submit'),
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
  });

  final String label, hint, helpTitle, helpContent;
  final IconData icon;
  final TooltipCardPublicState publicState;
  final bool isPassword, isSecure;

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
                size: 16,
                color: colorScheme.primary,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: colorScheme.outline.withValues(alpha: 0.2),
            ),
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Icon(
                  icon,
                  size: 20,
                  color: colorScheme.onSurface.withValues(alpha: 0.5),
                ),
              ),
              Expanded(
                child: TextField(
                  obscureText: isPassword,
                  decoration: InputDecoration(
                    hintText: hint,
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(vertical: 14),
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
                    whenContentVisible: WhenContentVisible.hoverButton,
                    builder: (ctx, close) => const Padding(
                      padding: EdgeInsets.all(10),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.lock_rounded,
                            size: 14,
                            color: Colors.green,
                          ),
                          SizedBox(width: 6),
                          Text(
                            'Secure & Encrypted',
                            style: TextStyle(fontSize: 11),
                          ),
                        ],
                      ),
                    ),
                    child: Icon(
                      Icons.verified_user_rounded,
                      size: 18,
                      color: Colors.green,
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
                Icon(Icons.lightbulb_rounded, size: 18, color: Colors.amber),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              content,
              style: TextStyle(
                fontSize: 13,
                height: 1.5,
                color: colorScheme.onSurface.withValues(alpha: 0.8),
              ),
            ),
            if (isSecure) ...[
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.green.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(Icons.security_rounded, size: 16, color: Colors.green),
                    const SizedBox(width: 8),
                    const Expanded(
                      child: Text(
                        '256-bit SSL encryption',
                        style: TextStyle(fontSize: 11, color: Colors.green),
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
          _SectionHeader(
            title: 'Real-time Validation',
            subtitle: 'See validation feedback with helpful tooltips',
            icon: Icons.check_circle_outline_rounded,
            color: Colors.green,
          ),
          const SizedBox(height: 20),
          _FormCard(
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
                      backgroundColor: Colors.green,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: const Text('Create Account'),
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
        TooltipCard.builder(
          publicState: publicState,
          placementSide: TooltipCardPlacementSide.end,
          beakEnabled: true,
          // whenContentVisible: WhenContentVisible.manual,
          // visibleDeterminer: hasInput && !isValid,
          builder: (ctx, close) =>
              _ValidationRulesTooltip(rules: validationRules),
          child: Container(
            decoration: BoxDecoration(
              color: colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: hasInput
                    ? (isValid ? Colors.green : Colors.red)
                    : colorScheme.outline.withValues(alpha: 0.2),
                width: hasInput ? 1.5 : 1,
              ),
            ),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Icon(
                    icon,
                    size: 20,
                    color: colorScheme.onSurface.withValues(alpha: 0.5),
                  ),
                ),
                Expanded(
                  child: TextField(
                    controller: controller,
                    obscureText: isPassword,
                    onChanged: onChanged,
                    decoration: InputDecoration(
                      hintText: hint,
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                  ),
                ),
                if (hasInput)
                  Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: Icon(
                      isValid
                          ? Icons.check_circle_rounded
                          : Icons.error_rounded,
                      size: 20,
                      color: isValid ? Colors.green : Colors.red,
                    ),
                  ),
              ],
            ),
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
                Icon(Icons.rule_rounded, size: 16, color: Colors.orange),
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
                          : Icons.circle_outlined,
                      size: 14,
                      color: rule.passed ? Colors.green : Colors.grey,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        rule.text,
                        style: TextStyle(
                          fontSize: 12,
                          color: rule.passed
                              ? Colors.green
                              : Theme.of(
                                  context,
                                ).colorScheme.onSurface.withValues(alpha: 0.7),
                          decoration: rule.passed
                              ? TextDecoration.lineThrough
                              : null,
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
        color = Colors.red;
        break;
      case 2:
        label = 'Fair';
        color = Colors.orange;
        break;
      case 3:
        label = 'Good';
        color = Colors.amber;
        break;
      case 4:
        label = 'Strong';
        color = Colors.lightGreen;
        break;
      default:
        label = 'Very Strong';
        color = Colors.green;
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
      Colors.blue,
    ),
    _WizardStep(
      'Contact',
      'Email & phone',
      Icons.contact_mail_rounded,
      Colors.green,
    ),
    _WizardStep(
      'Address',
      'Shipping address',
      Icons.location_on_rounded,
      Colors.orange,
    ),
    _WizardStep(
      'Payment',
      'Payment method',
      Icons.payment_rounded,
      Colors.purple,
    ),
    _WizardStep(
      'Review',
      'Confirm order',
      Icons.check_circle_rounded,
      Colors.teal,
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
          _SectionHeader(
            title: 'Multi-Step Wizard',
            subtitle: 'Hover over steps for navigation help',
            icon: Icons.linear_scale_rounded,
            color: Colors.indigo,
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
    return Column(
      children: [
        _SimpleField(
          label: 'First Name',
          hint: 'Enter first name',
          icon: Icons.person_outline_rounded,
        ),
        const SizedBox(height: 16),
        _SimpleField(
          label: 'Last Name',
          hint: 'Enter last name',
          icon: Icons.person_outline_rounded,
        ),
        const SizedBox(height: 16),
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
    return Column(
      children: [
        _SimpleField(
          label: 'Email',
          hint: 'Enter email',
          icon: Icons.email_rounded,
        ),
        const SizedBox(height: 16),
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
    return Column(
      children: [
        _SimpleField(
          label: 'Street Address',
          hint: 'Enter street address',
          icon: Icons.home_rounded,
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _SimpleField(
                label: 'City',
                hint: 'City',
                icon: Icons.location_city_rounded,
              ),
            ),
            const SizedBox(width: 12),
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
    return Column(
      children: [
        _SimpleField(
          label: 'Card Number',
          hint: '0000 0000 0000 0000',
          icon: Icons.credit_card_rounded,
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _SimpleField(
                label: 'Expiry',
                hint: 'MM/YY',
                icon: Icons.date_range_rounded,
              ),
            ),
            const SizedBox(width: 12),
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
    final colorScheme = Theme.of(context).colorScheme;

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
                decoration: BoxDecoration(
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
                    hintStyle: TextStyle(fontSize: 13),
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
  const _FormCard({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(16),
      ),
      child: child,
    );
  }
}
