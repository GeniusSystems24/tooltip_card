import 'package:flutter/material.dart';
import 'package:tooltip_card/tooltip_card.dart';

/// Dashboard & Analytics examples screen
class DashboardExamplesScreen extends StatefulWidget {
  const DashboardExamplesScreen({super.key});

  @override
  State<DashboardExamplesScreen> createState() => _DashboardExamplesScreenState();
}

class _DashboardExamplesScreenState extends State<DashboardExamplesScreen>
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
        title: const Text('Dashboard & Analytics'),
        backgroundColor: Colors.teal.withValues(alpha: 0.1),
        foregroundColor: Colors.teal.shade700,
        elevation: 0,
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.teal.shade700,
          unselectedLabelColor: colorScheme.onSurface.withValues(alpha: 0.6),
          indicatorColor: Colors.teal,
          tabs: const [
            Tab(text: 'KPIs', icon: Icon(Icons.speed_rounded, size: 20)),
            Tab(text: 'Charts', icon: Icon(Icons.bar_chart_rounded, size: 20)),
            Tab(text: 'Reports', icon: Icon(Icons.assessment_rounded, size: 20)),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _KPIsTab(publicState: _publicState),
          _ChartsTab(publicState: _publicState),
          _ReportsTab(publicState: _publicState),
        ],
      ),
    );
  }
}

// =============================================================================
// KPIs Tab
// =============================================================================

class _KPIsTab extends StatelessWidget {
  const _KPIsTab({required this.publicState});
  final TooltipCardPublicState publicState;

  @override
  Widget build(BuildContext context) {
    final kpis = [
      _KPI('Total Revenue', '\$124,500', '+12.5%', true, Icons.attach_money_rounded, Colors.green, [65, 72, 80, 75, 90, 95, 100]),
      _KPI('Active Users', '8,421', '+8.2%', true, Icons.people_rounded, Colors.blue, [40, 50, 55, 60, 58, 70, 75]),
      _KPI('Orders', '1,284', '-3.1%', false, Icons.shopping_cart_rounded, Colors.orange, [80, 75, 70, 65, 68, 62, 60]),
      _KPI('Conversion', '3.2%', '+0.5%', true, Icons.trending_up_rounded, Colors.purple, [25, 28, 30, 32, 31, 34, 38]),
      _KPI('Avg. Order Value', '\$97.50', '+5.2%', true, Icons.receipt_rounded, Colors.teal, [85, 88, 90, 92, 91, 95, 97]),
      _KPI('Bounce Rate', '42.3%', '-2.1%', true, Icons.exit_to_app_rounded, Colors.red, [50, 48, 46, 45, 44, 43, 42]),
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionHeader(
            title: 'Key Performance Indicators',
            subtitle: 'Last 30 days overview',
            icon: Icons.speed_rounded,
            color: Colors.teal,
          ),
          const SizedBox(height: 16),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 1.1,
            ),
            itemCount: kpis.length,
            itemBuilder: (ctx, i) => _KPICard(kpi: kpis[i], publicState: publicState),
          ),
        ],
      ),
    );
  }
}

class _KPI {
  final String name, value, change;
  final bool isPositive;
  final IconData icon;
  final Color color;
  final List<int> sparkline;
  _KPI(this.name, this.value, this.change, this.isPositive, this.icon, this.color, this.sparkline);
}

class _KPICard extends StatelessWidget {
  const _KPICard({required this.kpi, required this.publicState});
  final _KPI kpi;
  final TooltipCardPublicState publicState;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return TooltipCard.builder(
      publicState: publicState,
      placementSide: TooltipCardPlacementSide.bottom,
      beakEnabled: true,
      whenContentVisible: WhenContentVisible.pressButton,
      borderColor: kpi.color.withValues(alpha: 0.3),
      borderWidth: 1,
      builder: (ctx, close) => _KPIDetails(kpi: kpi, onClose: close),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: kpi.color.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(kpi.icon, color: kpi.color, size: 18),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: (kpi.isPositive ? Colors.green : Colors.red).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        kpi.isPositive ? Icons.arrow_upward_rounded : Icons.arrow_downward_rounded,
                        size: 10,
                        color: kpi.isPositive ? Colors.green : Colors.red,
                      ),
                      const SizedBox(width: 2),
                      Text(
                        kpi.change,
                        style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: kpi.isPositive ? Colors.green : Colors.red),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Spacer(),
            Text(kpi.value, style: TextStyle(fontWeight: FontWeight.w700, fontSize: 22, color: kpi.color)),
            const SizedBox(height: 2),
            Text(kpi.name, style: TextStyle(fontSize: 12, color: colorScheme.onSurface.withValues(alpha: 0.6))),
            const SizedBox(height: 8),
            SizedBox(
              height: 24,
              child: CustomPaint(
                size: const Size(double.infinity, 24),
                painter: _SparklinePainter(kpi.sparkline, kpi.color),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SparklinePainter extends CustomPainter {
  final List<int> data;
  final Color color;
  _SparklinePainter(this.data, this.color);

  @override
  void paint(Canvas canvas, Size size) {
    if (data.isEmpty) return;
    final paint = Paint()
      ..color = color
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final maxVal = data.reduce((a, b) => a > b ? a : b).toDouble();
    final minVal = data.reduce((a, b) => a < b ? a : b).toDouble();
    final range = maxVal - minVal;

    final path = Path();
    for (int i = 0; i < data.length; i++) {
      final x = (i / (data.length - 1)) * size.width;
      final y = size.height - ((data[i] - minVal) / range) * size.height;
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _KPIDetails extends StatelessWidget {
  const _KPIDetails({required this.kpi, required this.onClose});
  final _KPI kpi;
  final VoidCallback onClose;

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
                    color: kpi.color.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(kpi.icon, color: kpi.color, size: 22),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(kpi.name, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15)),
                      Text('Last 7 days', style: TextStyle(fontSize: 12, color: colorScheme.onSurface.withValues(alpha: 0.6))),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Current', style: TextStyle(fontSize: 11, color: colorScheme.onSurface.withValues(alpha: 0.5))),
                    Text(kpi.value, style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20, color: kpi.color)),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text('Change', style: TextStyle(fontSize: 11, color: colorScheme.onSurface.withValues(alpha: 0.5))),
                    Row(
                      children: [
                        Icon(
                          kpi.isPositive ? Icons.arrow_upward_rounded : Icons.arrow_downward_rounded,
                          size: 16,
                          color: kpi.isPositive ? Colors.green : Colors.red,
                        ),
                        Text(
                          kpi.change,
                          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, color: kpi.isPositive ? Colors.green : Colors.red),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              height: 60,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(8),
              ),
              child: CustomPaint(
                size: const Size(double.infinity, 44),
                painter: _SparklinePainter(kpi.sparkline, kpi.color),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(child: OutlinedButton(onPressed: onClose, child: const Text('Export'))),
                const SizedBox(width: 10),
                Expanded(child: FilledButton(onPressed: onClose, style: FilledButton.styleFrom(backgroundColor: kpi.color), child: const Text('Details'))),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// =============================================================================
// Charts Tab
// =============================================================================

class _ChartsTab extends StatelessWidget {
  const _ChartsTab({required this.publicState});
  final TooltipCardPublicState publicState;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionHeader(
            title: 'Revenue Chart',
            subtitle: 'Monthly breakdown with interactive data points',
            icon: Icons.bar_chart_rounded,
            color: Colors.blue,
          ),
          const SizedBox(height: 16),
          _BarChartSection(publicState: publicState),
          const SizedBox(height: 24),
          _SectionHeader(
            title: 'Traffic Sources',
            subtitle: 'Hover over segments for details',
            icon: Icons.pie_chart_rounded,
            color: Colors.purple,
          ),
          const SizedBox(height: 16),
          _PieChartSection(publicState: publicState),
        ],
      ),
    );
  }
}

class _BarChartSection extends StatelessWidget {
  const _BarChartSection({required this.publicState});
  final TooltipCardPublicState publicState;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final data = [
      _ChartData('Jan', 12500, Colors.blue),
      _ChartData('Feb', 18200, Colors.blue),
      _ChartData('Mar', 15800, Colors.blue),
      _ChartData('Apr', 22100, Colors.blue),
      _ChartData('May', 19400, Colors.blue),
      _ChartData('Jun', 24500, Colors.blue),
    ];

    final maxValue = data.map((d) => d.value).reduce((a, b) => a > b ? a : b);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          SizedBox(
            height: 180,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: data.map((d) => Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  child: TooltipCard.builder(
                    publicState: publicState,
                    placementSide: TooltipCardPlacementSide.top,
                    beakEnabled: true,
                    whenContentVisible: WhenContentVisible.hoverButton,
                    builder: (ctx, close) => _BarTooltip(data: d),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          height: (d.value / maxValue) * 140,
                          decoration: BoxDecoration(
                            color: d.color,
                            borderRadius: const BorderRadius.vertical(top: Radius.circular(6)),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(d.label, style: TextStyle(fontSize: 11, color: colorScheme.onSurface.withValues(alpha: 0.6))),
                      ],
                    ),
                  ),
                ),
              )).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class _ChartData {
  final String label;
  final double value;
  final Color color;
  _ChartData(this.label, this.value, this.color);
}

class _BarTooltip extends StatelessWidget {
  const _BarTooltip({required this.data});
  final _ChartData data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(data.label, style: const TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(height: 4),
          Text('\$${data.value.toStringAsFixed(0)}', style: TextStyle(color: data.color, fontWeight: FontWeight.w700, fontSize: 16)),
        ],
      ),
    );
  }
}

class _PieChartSection extends StatelessWidget {
  const _PieChartSection({required this.publicState});
  final TooltipCardPublicState publicState;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final sources = [
      _TrafficSource('Direct', 35.2, Colors.blue),
      _TrafficSource('Organic Search', 28.5, Colors.green),
      _TrafficSource('Social Media', 18.3, Colors.purple),
      _TrafficSource('Referral', 12.0, Colors.orange),
      _TrafficSource('Email', 6.0, Colors.teal),
    ];

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          // Pie chart placeholder
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: SweepGradient(
                colors: sources.map((s) => s.color).toList(),
              ),
            ),
            child: Center(
              child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: colorScheme.surfaceContainerHighest,
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Text('100%', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
                ),
              ),
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              children: sources.map((s) => _TrafficSourceRow(source: s, publicState: publicState)).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class _TrafficSource {
  final String name;
  final double percentage;
  final Color color;
  _TrafficSource(this.name, this.percentage, this.color);
}

class _TrafficSourceRow extends StatelessWidget {
  const _TrafficSourceRow({required this.source, required this.publicState});
  final _TrafficSource source;
  final TooltipCardPublicState publicState;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: TooltipCard.builder(
        publicState: publicState,
        placementSide: TooltipCardPlacementSide.start,
        beakEnabled: true,
        whenContentVisible: WhenContentVisible.hoverButton,
        hoverOpenDelay: const Duration(milliseconds: 400),
        builder: (ctx, close) => _TrafficTooltip(source: source),
        child: Row(
          children: [
            Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(color: source.color, shape: BoxShape.circle),
            ),
            const SizedBox(width: 8),
            Expanded(child: Text(source.name, style: const TextStyle(fontSize: 12))),
            Text('${source.percentage}%', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: source.color)),
          ],
        ),
      ),
    );
  }
}

class _TrafficTooltip extends StatelessWidget {
  const _TrafficTooltip({required this.source});
  final _TrafficSource source;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(source.name, style: const TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(height: 4),
          Text('${source.percentage}% of total traffic', style: TextStyle(fontSize: 12, color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7))),
          const SizedBox(height: 4),
          Text('~${(source.percentage * 84.21).toInt()} visitors', style: TextStyle(fontSize: 12, color: source.color, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}

// =============================================================================
// Reports Tab
// =============================================================================

class _ReportsTab extends StatelessWidget {
  const _ReportsTab({required this.publicState});
  final TooltipCardPublicState publicState;

  @override
  Widget build(BuildContext context) {
    final reports = [
      _Report('Sales Report', 'Monthly sales performance', 'Dec 2024', 'PDF', Colors.red, Icons.picture_as_pdf_rounded),
      _Report('User Analytics', 'User behavior analysis', 'Q4 2024', 'Excel', Colors.green, Icons.table_chart_rounded),
      _Report('Marketing ROI', 'Campaign performance', 'Nov 2024', 'PDF', Colors.blue, Icons.campaign_rounded),
      _Report('Inventory Report', 'Stock levels & turnover', 'Dec 2024', 'CSV', Colors.orange, Icons.inventory_rounded),
      _Report('Financial Summary', 'P&L and balance sheet', 'Q4 2024', 'PDF', Colors.purple, Icons.account_balance_rounded),
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: reports.length,
      itemBuilder: (ctx, i) => _ReportCard(report: reports[i], publicState: publicState),
    );
  }
}

class _Report {
  final String name, description, period, format;
  final Color color;
  final IconData icon;
  _Report(this.name, this.description, this.period, this.format, this.color, this.icon);
}

class _ReportCard extends StatelessWidget {
  const _ReportCard({required this.report, required this.publicState});
  final _Report report;
  final TooltipCardPublicState publicState;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: report.color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(report.icon, color: report.color, size: 24),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(report.name, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15)),
                  const SizedBox(height: 2),
                  Text(report.description, style: TextStyle(fontSize: 12, color: colorScheme.onSurface.withValues(alpha: 0.6))),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: colorScheme.surfaceContainerHighest,
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(color: colorScheme.outline.withValues(alpha: 0.2)),
                        ),
                        child: Text(report.period, style: TextStyle(fontSize: 10, color: colorScheme.onSurface.withValues(alpha: 0.7))),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: report.color.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(report.format, style: TextStyle(fontSize: 10, color: report.color, fontWeight: FontWeight.w600)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Column(
              children: [
                TooltipCard.builder(
                  publicState: publicState,
                  placementSide: TooltipCardPlacementSide.start,
                  beakEnabled: true,
                  whenContentVisible: WhenContentVisible.hoverButton,
                  builder: (ctx, close) => const Padding(
                    padding: EdgeInsets.all(8),
                    child: Text('Download report', style: TextStyle(fontSize: 11)),
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: report.color,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.download_rounded, size: 18, color: Colors.white),
                  ),
                ),
                const SizedBox(height: 8),
                TooltipCard.builder(
                  publicState: publicState,
                  placementSide: TooltipCardPlacementSide.bottomEnd,
                  beakEnabled: true,
                  whenContentVisible: WhenContentVisible.pressButton,
                  builder: (ctx, close) => _ReportActions(onClose: close),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: colorScheme.surface,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: colorScheme.outline.withValues(alpha: 0.2)),
                    ),
                    child: Icon(Icons.more_vert_rounded, size: 18, color: colorScheme.onSurface.withValues(alpha: 0.6)),
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

class _ReportActions extends StatelessWidget {
  const _ReportActions({required this.onClose});
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 160,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _ActionItem(icon: Icons.visibility_rounded, label: 'Preview', onTap: onClose),
          _ActionItem(icon: Icons.share_rounded, label: 'Share', onTap: onClose),
          _ActionItem(icon: Icons.schedule_rounded, label: 'Schedule', onTap: onClose),
          _ActionItem(icon: Icons.delete_rounded, label: 'Delete', onTap: onClose, isDestructive: true),
        ],
      ),
    );
  }
}

// =============================================================================
// Shared Components
// =============================================================================

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title, required this.subtitle, required this.icon, required this.color});
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
              Text(title, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 18)),
              Text(subtitle, style: TextStyle(fontSize: 13, color: colorScheme.onSurface.withValues(alpha: 0.6))),
            ],
          ),
        ),
      ],
    );
  }
}

class _ActionItem extends StatelessWidget {
  const _ActionItem({required this.icon, required this.label, required this.onTap, this.isDestructive = false});
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool isDestructive;

  @override
  Widget build(BuildContext context) {
    final color = isDestructive ? Colors.red : Theme.of(context).colorScheme.onSurface;
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
