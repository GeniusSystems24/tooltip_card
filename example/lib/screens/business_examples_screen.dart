import 'package:flutter/material.dart';
import 'package:tooltip_card/tooltip_card.dart';

/// Business & Enterprise examples screen
class BusinessExamplesScreen extends StatefulWidget {
  const BusinessExamplesScreen({super.key});

  @override
  State<BusinessExamplesScreen> createState() => _BusinessExamplesScreenState();
}

class _BusinessExamplesScreenState extends State<BusinessExamplesScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _publicState = TooltipCardPublicState();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
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
        title: const Text('Business & Enterprise'),
        backgroundColor: const Color(0xFF3B82F6).withValues(alpha: 0.1),
        foregroundColor: const Color(0xFF1D4ED8), // Blue 700
        elevation: 0,
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          labelColor: const Color(0xFF1D4ED8),
          unselectedLabelColor: colorScheme.onSurface.withValues(alpha: 0.6),
          indicatorColor: const Color(0xFF3B82F6), // Blue 500
          indicatorSize: TabBarIndicatorSize.label,
          dividerColor: Colors.transparent,
          tabs: const [
            Tab(
              text: 'Data Grid',
              icon: Icon(Icons.table_chart_rounded, size: 20),
            ),
            Tab(
              text: 'Invoice',
              icon: Icon(Icons.receipt_long_rounded, size: 20),
            ),
            Tab(text: 'Employees', icon: Icon(Icons.people_rounded, size: 20)),
            Tab(
              text: 'Calendar',
              icon: Icon(Icons.calendar_month_rounded, size: 20),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _DataGridTab(publicState: _publicState),
          _InvoiceTab(publicState: _publicState),
          _EmployeesTab(publicState: _publicState),
          _CalendarTab(publicState: _publicState),
        ],
      ),
    );
  }
}

// =============================================================================
// Data Grid Tab
// =============================================================================

class _DataGridTab extends StatelessWidget {
  const _DataGridTab({required this.publicState});
  final TooltipCardPublicState publicState;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final projects = [
      _Project(
        'Website Redesign',
        'In Progress',
        0.75,
        'Ahmed',
        Colors.blue,
        'High',
        ['Sara', 'Mohamed'],
      ),
      _Project(
        'Mobile App v2',
        'Review',
        0.90,
        'Sara',
        Colors.orange,
        'Critical',
        ['Ahmed', 'Layla', 'Youssef'],
      ),
      _Project(
        'API Integration',
        'Planning',
        0.25,
        'Mohamed',
        Colors.purple,
        'Medium',
        ['Youssef'],
      ),
      _Project(
        'Dashboard Analytics',
        'Completed',
        1.0,
        'Layla',
        Colors.green,
        'Low',
        ['Ahmed', 'Sara', 'Nour'],
      ),
      _Project(
        'Security Audit',
        'In Progress',
        0.60,
        'Youssef',
        Colors.red,
        'Critical',
        ['Mohamed'],
      ),
    ];

    return Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 900),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _SectionHeader(
                title: 'Project Management',
                subtitle:
                    'Hover over cells for details, click actions for options',
                icon: Icons.folder_special_rounded,
                color: Color(0xFF3B82F6), // Blue
              ),
              const SizedBox(height: 16),
              Container(
                decoration: BoxDecoration(
                  color: colorScheme.surface,
                  border: Border.all(
                    color: colorScheme.outline.withValues(alpha: 0.1),
                  ),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: colorScheme.shadow.withValues(alpha: 0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // Header
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                      decoration: BoxDecoration(
                        color: colorScheme.surfaceContainerHighest.withValues(
                          alpha: 0.5,
                        ),
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(11),
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Text(
                              'Project',
                              style: _headerStyle(context),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Text('Status', style: _headerStyle(context)),
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(
                              'Progress',
                              style: _headerStyle(context),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Text('Team', style: _headerStyle(context)),
                          ),
                          const SizedBox(width: 50),
                        ],
                      ),
                    ),
                    // Rows
                    ...projects.map(
                      (p) => _ProjectRow(project: p, publicState: publicState),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  TextStyle _headerStyle(BuildContext context) => TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 12,
    color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
  );
}

class _Project {
  final String name, status, owner, priority;
  final double progress;
  final Color color;
  final List<String> teamMembers;
  _Project(
    this.name,
    this.status,
    this.progress,
    this.owner,
    this.color,
    this.priority,
    this.teamMembers,
  );
}

class _ProjectRow extends StatelessWidget {
  const _ProjectRow({required this.project, required this.publicState});
  final _Project project;
  final TooltipCardPublicState publicState;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: colorScheme.outline.withValues(alpha: 0.1)),
        ),
      ),
      child: Row(
        children: [
          // Project Name with tooltip
          Expanded(
            flex: 3,
            child: TooltipCard.builder(
              publicState: publicState,
              placementSide: TooltipCardPlacementSide.topStart,
              beakEnabled: true,
              whenContentVisible: WhenContentVisible.hoverButton,
              hoverOpenDelay: const Duration(milliseconds: 400),
              builder: (ctx, close) => _ProjectDetailsTooltip(project: project),
              child: Row(
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: project.color,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      project.name,
                      style: const TextStyle(fontWeight: FontWeight.w500),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Status
          Expanded(
            flex: 2,
            child: _StatusBadge(status: project.status, color: project.color),
          ),
          // Progress
          Expanded(
            flex: 2,
            child: TooltipCard.builder(
              publicState: publicState,
              placementSide: TooltipCardPlacementSide.top,
              beakEnabled: true,
              whenContentVisible: WhenContentVisible.hoverButton,
              builder: (ctx, close) => Padding(
                padding: const EdgeInsets.all(12),
                child: Text('${(project.progress * 100).toInt()}% complete'),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: project.progress,
                      backgroundColor: colorScheme.surfaceContainerHighest,
                      color: project.color,
                      minHeight: 6,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Team
          Expanded(
            flex: 2,
            child: SizedBox(
              height: 30,
              child: Stack(
                children: [
                  for (
                    int i = 0;
                    i < project.teamMembers.length.clamp(0, 3);
                    i++
                  )
                    Positioned(
                      left: i * 18.0,
                      child: TooltipCard.builder(
                        publicState: publicState,
                        placementSide: TooltipCardPlacementSide.top,
                        beakEnabled: true,
                        whenContentVisible: WhenContentVisible.hoverButton,
                        builder: (ctx, close) => Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          child: Text(
                            project.teamMembers[i],
                            style: const TextStyle(fontSize: 12),
                          ),
                        ),
                        child: CircleAvatar(
                          radius: 14,
                          backgroundColor: Colors.white,
                          child: CircleAvatar(
                            radius: 12,
                            backgroundColor: project.color.withValues(
                              alpha: 0.2,
                            ),
                            child: Text(
                              project.teamMembers[i][0],
                              style: TextStyle(
                                fontSize: 10,
                                color: project.color,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  if (project.teamMembers.length > 3)
                    Positioned(
                      left: 3 * 18.0,
                      child: CircleAvatar(
                        radius: 14,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                          radius: 12,
                          backgroundColor: colorScheme.surfaceContainerHighest,
                          child: Text(
                            '+${project.teamMembers.length - 3}',
                            style: TextStyle(
                              fontSize: 9,
                              color: colorScheme.onSurface,
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
          // Actions
          SizedBox(
            width: 50,
            child: TooltipCard.builder(
              publicState: publicState,
              placementSide: TooltipCardPlacementSide.bottomEnd,
              beakEnabled: true,
              whenContentVisible: WhenContentVisible.pressButton,
              builder: (ctx, close) => _ActionsMenu(onClose: close),
              child: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Icon(
                  Icons.more_horiz_rounded,
                  size: 18,
                  color: colorScheme.onSurface.withValues(alpha: 0.6),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ProjectDetailsTooltip extends StatelessWidget {
  const _ProjectDetailsTooltip({required this.project});
  final _Project project;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return SizedBox(
      width: 280,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: project.color.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    Icons.folder_rounded,
                    color: project.color,
                    size: 22,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        project.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                        ),
                      ),
                      Text(
                        'Priority: ${project.priority}',
                        style: TextStyle(
                          fontSize: 12,
                          color: colorScheme.onSurface.withValues(alpha: 0.6),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _DetailRow(
              label: 'Status',
              value: project.status,
              color: project.color,
            ),
            _DetailRow(
              label: 'Progress',
              value: '${(project.progress * 100).toInt()}%',
              color: project.color,
            ),
            _DetailRow(
              label: 'Owner',
              value: project.owner,
              color: project.color,
            ),
            const SizedBox(height: 12),
            Text(
              'Last updated 2 hours ago',
              style: TextStyle(
                fontSize: 11,
                color: colorScheme.onSurface.withValues(alpha: 0.5),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({
    required this.label,
    required this.value,
    required this.color,
  });
  final String label, value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: colorScheme.onSurface.withValues(alpha: 0.6),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              value,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: color,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  const _StatusBadge({required this.status, required this.color});
  final String status;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        status,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: color,
        ),
      ),
    );
  }
}

class _ActionsMenu extends StatelessWidget {
  const _ActionsMenu({required this.onClose});
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 160,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _MenuItem(icon: Icons.edit_rounded, label: 'Edit', onTap: onClose),
          _MenuItem(icon: Icons.share_rounded, label: 'Share', onTap: onClose),
          _MenuItem(
            icon: Icons.archive_rounded,
            label: 'Archive',
            onTap: onClose,
          ),
          const Divider(height: 1),
          _MenuItem(
            icon: Icons.delete_rounded,
            label: 'Delete',
            onTap: onClose,
            isDestructive: true,
          ),
        ],
      ),
    );
  }
}

class _MenuItem extends StatelessWidget {
  const _MenuItem({
    required this.icon,
    required this.label,
    required this.onTap,
    this.isDestructive = false,
  });
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool isDestructive;

  @override
  Widget build(BuildContext context) {
    final color = isDestructive
        ? Colors.red
        : Theme.of(context).colorScheme.onSurface;
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: Row(
          children: [
            Icon(icon, size: 18, color: color),
            const SizedBox(width: 10),
            Text(label, style: TextStyle(fontSize: 13, color: color)),
          ],
        ),
      ),
    );
  }
}

// =============================================================================
// Invoice Tab
// =============================================================================

class _InvoiceTab extends StatelessWidget {
  const _InvoiceTab({required this.publicState});
  final TooltipCardPublicState publicState;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final items = [
      _InvoiceItem(
        'Website Development',
        'Full stack web application',
        45,
        150.0,
      ),
      _InvoiceItem(
        'UI/UX Design',
        'User interface design & prototyping',
        20,
        120.0,
      ),
      _InvoiceItem('API Integration', 'Third-party API setup', 15, 140.0),
      _InvoiceItem('Testing & QA', 'Quality assurance & bug fixes', 10, 100.0),
    ];

    final total = items.fold<double>(
      0,
      (sum, item) => sum + item.hours * item.rate,
    );

    return Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 800),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _SectionHeader(
                title: 'Invoice #INV-2024-001',
                subtitle: 'Tap on items for detailed breakdown',
                icon: Icons.receipt_long_rounded,
                color: Color(0xFF10B981), // Emerald
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: colorScheme.surface,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: colorScheme.outline.withValues(alpha: 0.1),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: colorScheme.shadow.withValues(alpha: 0.05),
                      blurRadius: 12,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // Header info
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TooltipCard.builder(
                              publicState: publicState,
                              placementSide: TooltipCardPlacementSide.end,
                              beakEnabled: true,
                              whenContentVisible:
                                  WhenContentVisible.hoverButton,
                              builder: (ctx, close) => _CompanyTooltip(),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.business_rounded,
                                    color: const Color(0xFF3B82F6),
                                    size: 24,
                                  ),
                                  const SizedBox(width: 8),
                                  const Text(
                                    'Acme Corporation',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 18,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Client since 2022',
                              style: TextStyle(
                                fontSize: 13,
                                color: colorScheme.onSurface.withValues(
                                  alpha: 0.5,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(
                              0xFFF59E0B,
                            ).withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Text(
                            'Pending',
                            style: TextStyle(
                              color: Color(0xFFF59E0B),
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Divider(height: 40),
                    // Items
                    ...items.map(
                      (item) =>
                          _InvoiceItemRow(item: item, publicState: publicState),
                    ),
                    const Divider(height: 40),
                    // Total
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Total',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                          ),
                        ),
                        TooltipCard.builder(
                          publicState: publicState,
                          placementSide: TooltipCardPlacementSide.start,
                          beakEnabled: true,
                          whenContentVisible: WhenContentVisible.hoverButton,
                          builder: (ctx, close) => Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Invoice Summary',
                                  style: TextStyle(fontWeight: FontWeight.w600),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Total Hours: ${items.fold<int>(0, (sum, i) => sum + i.hours)}h',
                                ),
                                Text(
                                  'Average Rate: \$${(total / items.fold<int>(0, (sum, i) => sum + i.hours)).toStringAsFixed(2)}/h',
                                ),
                              ],
                            ),
                          ),
                          child: Text(
                            '\$${total.toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 28,
                              color: Color(0xFF10B981),
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
        ),
      ),
    );
  }
}

class _InvoiceItem {
  final String name, description;
  final int hours;
  final double rate;
  _InvoiceItem(this.name, this.description, this.hours, this.rate);
}

class _InvoiceItemRow extends StatelessWidget {
  const _InvoiceItemRow({required this.item, required this.publicState});
  final _InvoiceItem item;
  final TooltipCardPublicState publicState;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TooltipCard.builder(
        publicState: publicState,
        placementSide: TooltipCardPlacementSide.end,
        beakEnabled: true,
        whenContentVisible: WhenContentVisible.pressButton,
        builder: (ctx, close) =>
            _InvoiceItemDetails(item: item, onClose: close),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: colorScheme.surface,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: colorScheme.outline.withValues(alpha: 0.1),
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.name,
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                    Text(
                      item.description,
                      style: TextStyle(
                        fontSize: 12,
                        color: colorScheme.onSurface.withValues(alpha: 0.5),
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '\$${(item.hours * item.rate).toStringAsFixed(2)}',
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  Text(
                    '${item.hours}h @ \$${item.rate.toInt()}/h',
                    style: TextStyle(
                      fontSize: 11,
                      color: colorScheme.onSurface.withValues(alpha: 0.5),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _InvoiceItemDetails extends StatelessWidget {
  const _InvoiceItemDetails({required this.item, required this.onClose});
  final _InvoiceItem item;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 260,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              item.name,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
            ),
            const SizedBox(height: 8),
            Text(
              item.description,
              style: TextStyle(
                fontSize: 13,
                color: Theme.of(
                  context,
                ).colorScheme.onSurface.withValues(alpha: 0.7),
              ),
            ),
            const SizedBox(height: 16),
            _DetailRow(
              label: 'Hours',
              value: '${item.hours}h',
              color: Colors.blue,
            ),
            _DetailRow(
              label: 'Rate',
              value: '\$${item.rate.toInt()}/h',
              color: Colors.green,
            ),
            _DetailRow(
              label: 'Subtotal',
              value: '\$${(item.hours * item.rate).toStringAsFixed(2)}',
              color: Colors.orange,
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: onClose,
                child: const Text('Close'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CompanyTooltip extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 240,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Acme Corporation',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
            ),
            SizedBox(height: 8),
            _InfoRow(icon: Icons.email_rounded, text: 'contact@acme.com'),
            _InfoRow(icon: Icons.phone_rounded, text: '+1 (555) 123-4567'),
            _InfoRow(
              icon: Icons.location_on_rounded,
              text: 'San Francisco, CA',
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.icon, required this.text});
  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, size: 14, color: Theme.of(context).colorScheme.primary),
          const SizedBox(width: 8),
          Text(text, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}

// =============================================================================
// Employees Tab
// =============================================================================

class _EmployeesTab extends StatelessWidget {
  const _EmployeesTab({required this.publicState});
  final TooltipCardPublicState publicState;

  @override
  Widget build(BuildContext context) {
    final employees = [
      _Employee(
        'Ahmed Hassan',
        'Senior Developer',
        'Engineering',
        'ahmed@company.com',
        Colors.blue,
        true,
      ),
      _Employee(
        'Sara Ali',
        'Product Manager',
        'Product',
        'sara@company.com',
        Colors.purple,
        true,
      ),
      _Employee(
        'Mohamed Nour',
        'UI/UX Designer',
        'Design',
        'mohamed@company.com',
        Colors.pink,
        false,
      ),
      _Employee(
        'Layla Ahmed',
        'QA Engineer',
        'Engineering',
        'layla@company.com',
        Colors.teal,
        true,
      ),
      _Employee(
        'Youssef Ibrahim',
        'DevOps Engineer',
        'Infrastructure',
        'youssef@company.com',
        Colors.orange,
        true,
      ),
      _Employee(
        'Nour Khaled',
        'Marketing Lead',
        'Marketing',
        'nour@company.com',
        Colors.green,
        false,
      ),
    ];

    return Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 800),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _SectionHeader(
                title: 'Team Directory',
                subtitle: 'Click on employees for quick actions',
                icon: Icons.people_rounded,
                color: Color(0xFF8B5CF6), // Violet
              ),
              const SizedBox(height: 16),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 1.5,
                ),
                itemCount: employees.length,
                itemBuilder: (ctx, i) => _EmployeeCard(
                  employee: employees[i],
                  publicState: publicState,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Employee {
  final String name, role, department, email;
  final Color color;
  final bool isOnline;
  _Employee(
    this.name,
    this.role,
    this.department,
    this.email,
    this.color,
    this.isOnline,
  );
}

class _EmployeeCard extends StatelessWidget {
  const _EmployeeCard({required this.employee, required this.publicState});
  final _Employee employee;
  final TooltipCardPublicState publicState;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return TooltipCard.builder(
      publicState: publicState,
      placementSide: TooltipCardPlacementSide.bottom,
      beakEnabled: true,
      whenContentVisible: WhenContentVisible.pressButton,
      modalBarrierEnabled: true,
      barrierBlur: 3,
      builder: (ctx, close) =>
          _EmployeeActions(employee: employee, onClose: close),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: colorScheme.outline.withValues(alpha: 0.1)),
          boxShadow: [
            BoxShadow(
              color: colorScheme.shadow.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: employee.color.withValues(alpha: 0.2),
                      child: Text(
                        employee.name.split(' ').map((n) => n[0]).join(),
                        style: TextStyle(
                          color: employee.color,
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                        ),
                      ),
                    ),
                    if (employee.isOnline)
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          width: 12,
                          height: 12,
                          decoration: BoxDecoration(
                            color: Colors.green,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: colorScheme.surface,
                              width: 2,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: employee.color.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    employee.department,
                    style: TextStyle(
                      fontSize: 10,
                      color: employee.color,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            const Spacer(),
            Text(
              employee.name,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
            ),
            const SizedBox(height: 2),
            Text(
              employee.role,
              style: TextStyle(
                fontSize: 11,
                color: colorScheme.onSurface.withValues(alpha: 0.6),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _EmployeeActions extends StatelessWidget {
  const _EmployeeActions({required this.employee, required this.onClose});
  final _Employee employee;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return SizedBox(
      width: 220,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundColor: employee.color.withValues(alpha: 0.2),
                  child: Text(
                    employee.name.split(' ').map((n) => n[0]).join(),
                    style: TextStyle(
                      color: employee.color,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        employee.name,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      Text(
                        employee.role,
                        style: TextStyle(
                          fontSize: 12,
                          color: colorScheme.onSurface.withValues(alpha: 0.6),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Divider(height: 1, color: colorScheme.outline.withValues(alpha: 0.2)),
          _MenuItem(
            icon: Icons.email_rounded,
            label: 'Send Email',
            onTap: onClose,
          ),
          _MenuItem(
            icon: Icons.chat_rounded,
            label: 'Send Message',
            onTap: onClose,
          ),
          _MenuItem(
            icon: Icons.calendar_today_rounded,
            label: 'Schedule Meeting',
            onTap: onClose,
          ),
          _MenuItem(
            icon: Icons.person_rounded,
            label: 'View Profile',
            onTap: onClose,
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// Calendar Tab
// =============================================================================

class _CalendarTab extends StatelessWidget {
  const _CalendarTab({required this.publicState});
  final TooltipCardPublicState publicState;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final events = [
      _Event(
        'Team Standup',
        '9:00 AM - 9:30 AM',
        'Daily sync',
        Colors.blue,
        Icons.groups_rounded,
      ),
      _Event(
        'Sprint Planning',
        '10:00 AM - 11:30 AM',
        'Plan next sprint',
        Colors.purple,
        Icons.dashboard_rounded,
      ),
      _Event(
        'Design Review',
        '2:00 PM - 3:00 PM',
        'Review new features',
        Colors.pink,
        Icons.palette_rounded,
      ),
      _Event(
        'Client Call',
        '4:00 PM - 5:00 PM',
        'Quarterly review',
        Colors.green,
        Icons.call_rounded,
      ),
    ];

    return Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 800),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _SectionHeader(
                title: 'Today\'s Schedule',
                subtitle: 'Wednesday, Dec 25, 2024',
                icon: Icons.calendar_today_rounded,
                color: Color(0xFFF59E0B), // Amber
              ),
              const SizedBox(height: 16),
              Align(
                alignment: Alignment.centerRight,
                child: TooltipCard.builder(
                  publicState: publicState,
                  placementSide: TooltipCardPlacementSide.bottomEnd,
                  beakEnabled: true,
                  whenContentVisible: WhenContentVisible.pressButton,
                  modalBarrierEnabled: true,
                  barrierBlur: 2,
                  builder: (ctx, close) => Container(
                    width: 280,
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'New Event',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 16),
                        TextField(
                          decoration: InputDecoration(
                            labelText: 'Title',
                            filled: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 12,
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        TextField(
                          decoration: InputDecoration(
                            labelText: 'Time',
                            filled: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 12,
                            ),
                            suffixIcon: const Icon(
                              Icons.access_time_rounded,
                              size: 20,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: OutlinedButton(
                                onPressed: close,
                                child: const Text('Cancel'),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: FilledButton(
                                onPressed: close,
                                child: const Text('Add'),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  child: FilledButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.add_rounded, size: 18),
                    label: const Text('Add Event'),
                    style: FilledButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),
                      backgroundColor: const Color(0xFF3B82F6), // Blue 500
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: colorScheme.surface,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: colorScheme.outline.withValues(alpha: 0.1),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: colorScheme.shadow.withValues(alpha: 0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: events
                      .map((e) => _EventRow(event: e, publicState: publicState))
                      .toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Event {
  final String title, time, description;
  final Color color;
  final IconData icon;
  _Event(this.title, this.time, this.description, this.color, this.icon);
}

class _EventRow extends StatelessWidget {
  const _EventRow({required this.event, required this.publicState});
  final _Event event;
  final TooltipCardPublicState publicState;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TooltipCard.builder(
        publicState: publicState,
        placementSide: TooltipCardPlacementSide.end,
        beakEnabled: true,
        whenContentVisible: WhenContentVisible.pressButton,
        modalBarrierEnabled: true,
        barrierBlur: 4,
        builder: (ctx, close) => _EventDetails(event: event, onClose: close),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: colorScheme.surface,
            borderRadius: BorderRadius.circular(10),
            border: Border(
              left: BorderSide(width: 4, color: event.color),
              top: BorderSide(
                color: colorScheme.outline.withValues(alpha: 0.1),
              ),
              bottom: BorderSide(
                color: colorScheme.outline.withValues(alpha: 0.1),
              ),
              right: BorderSide(
                color: colorScheme.outline.withValues(alpha: 0.1),
              ),
            ),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: event.color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(event.icon, color: event.color, size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      event.title,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    Text(
                      event.time,
                      style: TextStyle(
                        fontSize: 12,
                        color: colorScheme.onSurface.withValues(alpha: 0.6),
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.chevron_right_rounded,
                color: colorScheme.onSurface.withValues(alpha: 0.4),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _EventDetails extends StatelessWidget {
  const _EventDetails({required this.event, required this.onClose});
  final _Event event;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 280,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: event.color.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(event.icon, color: event.color, size: 24),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        event.title,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        event.time,
                        style: TextStyle(
                          fontSize: 13,
                          color: Theme.of(
                            context,
                          ).colorScheme.onSurface.withValues(alpha: 0.6),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(event.description, style: const TextStyle(fontSize: 14)),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: onClose,
                    child: const Text('Dismiss'),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: FilledButton(
                    onPressed: onClose,
                    style: FilledButton.styleFrom(backgroundColor: event.color),
                    child: const Text('Join'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
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
