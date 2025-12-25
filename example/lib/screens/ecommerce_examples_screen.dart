import 'package:flutter/material.dart';
import 'package:tooltip_card/tooltip_card.dart';

/// E-Commerce examples screen
class EcommerceExamplesScreen extends StatefulWidget {
  const EcommerceExamplesScreen({super.key});

  @override
  State<EcommerceExamplesScreen> createState() => _EcommerceExamplesScreenState();
}

class _EcommerceExamplesScreenState extends State<EcommerceExamplesScreen>
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
        title: const Text('E-Commerce'),
        backgroundColor: Colors.orange.withValues(alpha: 0.1),
        foregroundColor: Colors.orange.shade700,
        elevation: 0,
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          labelColor: Colors.orange.shade700,
          unselectedLabelColor: colorScheme.onSurface.withValues(alpha: 0.6),
          indicatorColor: Colors.orange,
          tabs: const [
            Tab(text: 'Products', icon: Icon(Icons.inventory_2_rounded, size: 20)),
            Tab(text: 'Cart', icon: Icon(Icons.shopping_cart_rounded, size: 20)),
            Tab(text: 'Orders', icon: Icon(Icons.local_shipping_rounded, size: 20)),
            Tab(text: 'Wishlist', icon: Icon(Icons.favorite_rounded, size: 20)),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _ProductsTab(publicState: _publicState),
          _CartTab(publicState: _publicState),
          _OrdersTab(publicState: _publicState),
          _WishlistTab(publicState: _publicState),
        ],
      ),
    );
  }
}

// =============================================================================
// Products Tab
// =============================================================================

class _ProductsTab extends StatelessWidget {
  const _ProductsTab({required this.publicState});
  final TooltipCardPublicState publicState;

  @override
  Widget build(BuildContext context) {
    final products = [
      _Product('Wireless Headphones', 'Premium noise-canceling headphones', 299.99, 4.8, 256, 'Electronics', Colors.blue, true),
      _Product('Smart Watch Pro', 'Advanced fitness & health tracking', 449.99, 4.9, 189, 'Wearables', Colors.purple, false),
      _Product('Laptop Stand', 'Ergonomic aluminum stand', 79.99, 4.6, 423, 'Accessories', Colors.grey, true),
      _Product('Mechanical Keyboard', 'RGB backlit mechanical keys', 149.99, 4.7, 312, 'Electronics', Colors.green, true),
      _Product('USB-C Hub', '7-in-1 multiport adapter', 59.99, 4.5, 567, 'Accessories', Colors.orange, false),
      _Product('Wireless Mouse', 'Ergonomic design, long battery', 49.99, 4.4, 789, 'Electronics', Colors.teal, true),
    ];

    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 0.7,
      ),
      itemCount: products.length,
      itemBuilder: (ctx, i) => _ProductCard(product: products[i], publicState: publicState),
    );
  }
}

class _Product {
  final String name, description, category;
  final double price, rating;
  final int reviews;
  final Color color;
  final bool inStock;
  _Product(this.name, this.description, this.price, this.rating, this.reviews, this.category, this.color, this.inStock);
}

class _ProductCard extends StatelessWidget {
  const _ProductCard({required this.product, required this.publicState});
  final _Product product;
  final TooltipCardPublicState publicState;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image placeholder
          Stack(
            children: [
              Container(
                height: 120,
                decoration: BoxDecoration(
                  color: product.color.withValues(alpha: 0.1),
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                ),
                child: Center(
                  child: Icon(Icons.image_rounded, size: 48, color: product.color.withValues(alpha: 0.5)),
                ),
              ),
              // Quick actions
              Positioned(
                top: 8,
                right: 8,
                child: TooltipCard.builder(
                  publicState: publicState,
                  placementSide: TooltipCardPlacementSide.bottomEnd,
                  beakEnabled: true,
                  whenContentVisible: WhenContentVisible.pressButton,
                  builder: (ctx, close) => _QuickActions(product: product, onClose: close),
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: colorScheme.surface,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(color: Colors.black.withValues(alpha: 0.1), blurRadius: 4),
                      ],
                    ),
                    child: Icon(Icons.more_vert_rounded, size: 16, color: colorScheme.onSurface.withValues(alpha: 0.7)),
                  ),
                ),
              ),
              // Stock badge
              if (!product.inStock)
                Positioned(
                  top: 8,
                  left: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text('Out of Stock', style: TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.w600)),
                  ),
                ),
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Category
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: product.color.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(product.category, style: TextStyle(fontSize: 9, color: product.color, fontWeight: FontWeight.w500)),
                  ),
                  const SizedBox(height: 6),
                  // Name
                  TooltipCard.builder(
                    publicState: publicState,
                    placementSide: TooltipCardPlacementSide.top,
                    beakEnabled: true,
                    whenContentVisible: WhenContentVisible.hoverButton,
                    hoverOpenDelay: const Duration(milliseconds: 500),
                    builder: (ctx, close) => _ProductTooltip(product: product),
                    child: Text(
                      product.name,
                      style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const Spacer(),
                  // Rating
                  Row(
                    children: [
                      Icon(Icons.star_rounded, size: 14, color: Colors.amber),
                      const SizedBox(width: 4),
                      Text('${product.rating}', style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 12)),
                      Text(' (${product.reviews})', style: TextStyle(fontSize: 10, color: colorScheme.onSurface.withValues(alpha: 0.5))),
                    ],
                  ),
                  const SizedBox(height: 6),
                  // Price
                  Text('\$${product.price.toStringAsFixed(2)}', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16, color: product.color)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ProductTooltip extends StatelessWidget {
  const _ProductTooltip({required this.product});
  final _Product product;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return SizedBox(
      width: 240,
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(product.name, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
            const SizedBox(height: 6),
            Text(product.description, style: TextStyle(fontSize: 12, color: colorScheme.onSurface.withValues(alpha: 0.7))),
            const SizedBox(height: 10),
            Row(
              children: [
                Icon(Icons.star_rounded, size: 16, color: Colors.amber),
                const SizedBox(width: 4),
                Text('${product.rating} (${product.reviews} reviews)', style: const TextStyle(fontSize: 12)),
              ],
            ),
            const SizedBox(height: 6),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('\$${product.price.toStringAsFixed(2)}', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16, color: product.color)),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: product.inStock ? Colors.green.withValues(alpha: 0.1) : Colors.red.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    product.inStock ? 'In Stock' : 'Out of Stock',
                    style: TextStyle(fontSize: 10, color: product.inStock ? Colors.green : Colors.red, fontWeight: FontWeight.w600),
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

class _QuickActions extends StatelessWidget {
  const _QuickActions({required this.product, required this.onClose});
  final _Product product;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 160,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _ActionItem(icon: Icons.add_shopping_cart_rounded, label: 'Add to Cart', onTap: onClose),
          _ActionItem(icon: Icons.favorite_border_rounded, label: 'Add to Wishlist', onTap: onClose),
          _ActionItem(icon: Icons.compare_arrows_rounded, label: 'Compare', onTap: onClose),
          _ActionItem(icon: Icons.share_rounded, label: 'Share', onTap: onClose),
        ],
      ),
    );
  }
}

// =============================================================================
// Cart Tab
// =============================================================================

class _CartTab extends StatelessWidget {
  const _CartTab({required this.publicState});
  final TooltipCardPublicState publicState;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final cartItems = [
      _CartItem('Wireless Headphones', 299.99, 1, Colors.blue),
      _CartItem('Mechanical Keyboard', 149.99, 2, Colors.green),
      _CartItem('USB-C Hub', 59.99, 1, Colors.orange),
    ];

    final subtotal = cartItems.fold<double>(0, (sum, item) => sum + item.price * item.quantity);
    const shipping = 9.99;
    final total = subtotal + shipping;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Cart items
          ...cartItems.map((item) => _CartItemCard(item: item, publicState: publicState)),
          const SizedBox(height: 20),
          // Promo code
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TooltipCard.builder(
                    publicState: publicState,
                    placementSide: TooltipCardPlacementSide.top,
                    beakEnabled: true,
                    whenContentVisible: WhenContentVisible.hoverButton,
                    builder: (ctx, close) => const Padding(
                      padding: EdgeInsets.all(12),
                      child: Text('Enter a promo code to get discounts', style: TextStyle(fontSize: 12)),
                    ),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                      decoration: BoxDecoration(
                        color: colorScheme.surface,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.local_offer_rounded, size: 18, color: colorScheme.onSurface.withValues(alpha: 0.5)),
                          const SizedBox(width: 10),
                          Text('Enter promo code', style: TextStyle(color: colorScheme.onSurface.withValues(alpha: 0.5))),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                FilledButton(
                  onPressed: () {},
                  style: FilledButton.styleFrom(backgroundColor: Colors.orange),
                  child: const Text('Apply'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          // Order summary
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Order Summary', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
                const SizedBox(height: 16),
                _SummaryRow(label: 'Subtotal', value: '\$${subtotal.toStringAsFixed(2)}'),
                TooltipCard.builder(
                  publicState: publicState,
                  placementSide: TooltipCardPlacementSide.start,
                  beakEnabled: true,
                  whenContentVisible: WhenContentVisible.hoverButton,
                  builder: (ctx, close) => const Padding(
                    padding: EdgeInsets.all(12),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Shipping Options', style: TextStyle(fontWeight: FontWeight.w600)),
                        SizedBox(height: 8),
                        Text('Standard: \$9.99 (5-7 days)', style: TextStyle(fontSize: 12)),
                        Text('Express: \$19.99 (2-3 days)', style: TextStyle(fontSize: 12)),
                        Text('Next Day: \$29.99', style: TextStyle(fontSize: 12)),
                      ],
                    ),
                  ),
                  child: _SummaryRow(label: 'Shipping', value: '\$$shipping', hasInfo: true),
                ),
                const Divider(height: 24),
                _SummaryRow(label: 'Total', value: '\$${total.toStringAsFixed(2)}', isBold: true),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: () {},
                    style: FilledButton.styleFrom(
                      backgroundColor: Colors.orange,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: const Text('Proceed to Checkout'),
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

class _CartItem {
  final String name;
  final double price;
  final int quantity;
  final Color color;
  _CartItem(this.name, this.price, this.quantity, this.color);
}

class _CartItemCard extends StatelessWidget {
  const _CartItemCard({required this.item, required this.publicState});
  final _CartItem item;
  final TooltipCardPublicState publicState;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            // Image
            Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                color: item.color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(Icons.image_rounded, color: item.color.withValues(alpha: 0.5)),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.name, style: const TextStyle(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 4),
                  Text('\$${item.price.toStringAsFixed(2)}', style: TextStyle(color: item.color, fontWeight: FontWeight.w600)),
                ],
              ),
            ),
            // Quantity controls
            Row(
              children: [
                TooltipCard.builder(
                  publicState: publicState,
                  placementSide: TooltipCardPlacementSide.top,
                  beakEnabled: true,
                  whenContentVisible: WhenContentVisible.hoverButton,
                  builder: (ctx, close) => const Padding(
                    padding: EdgeInsets.all(8),
                    child: Text('Decrease quantity', style: TextStyle(fontSize: 11)),
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: colorScheme.surface,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Icon(Icons.remove_rounded, size: 18, color: colorScheme.onSurface.withValues(alpha: 0.6)),
                  ),
                ),
                Container(
                  width: 36,
                  alignment: Alignment.center,
                  child: Text('${item.quantity}', style: const TextStyle(fontWeight: FontWeight.w600)),
                ),
                TooltipCard.builder(
                  publicState: publicState,
                  placementSide: TooltipCardPlacementSide.top,
                  beakEnabled: true,
                  whenContentVisible: WhenContentVisible.hoverButton,
                  builder: (ctx, close) => const Padding(
                    padding: EdgeInsets.all(8),
                    child: Text('Increase quantity', style: TextStyle(fontSize: 11)),
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: colorScheme.surface,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Icon(Icons.add_rounded, size: 18, color: colorScheme.onSurface.withValues(alpha: 0.6)),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 10),
            // Remove
            TooltipCard.builder(
              publicState: publicState,
              placementSide: TooltipCardPlacementSide.bottomEnd,
              beakEnabled: true,
              whenContentVisible: WhenContentVisible.pressButton,
              builder: (ctx, close) => _RemoveConfirmation(onClose: close, itemName: item.name),
              child: Icon(Icons.delete_outline_rounded, size: 20, color: Colors.red.withValues(alpha: 0.7)),
            ),
          ],
        ),
      ),
    );
  }
}

class _RemoveConfirmation extends StatelessWidget {
  const _RemoveConfirmation({required this.onClose, required this.itemName});
  final VoidCallback onClose;
  final String itemName;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 220,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.warning_rounded, color: Colors.orange, size: 32),
            const SizedBox(height: 12),
            const Text('Remove Item?', style: TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 6),
            Text('Remove $itemName from cart?', textAlign: TextAlign.center, style: const TextStyle(fontSize: 12)),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(child: OutlinedButton(onPressed: onClose, child: const Text('Cancel'))),
                const SizedBox(width: 10),
                Expanded(
                  child: FilledButton(
                    onPressed: onClose,
                    style: FilledButton.styleFrom(backgroundColor: Colors.red),
                    child: const Text('Remove'),
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

class _SummaryRow extends StatelessWidget {
  const _SummaryRow({required this.label, required this.value, this.isBold = false, this.hasInfo = false});
  final String label, value;
  final bool isBold, hasInfo;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(label, style: TextStyle(fontWeight: isBold ? FontWeight.w700 : FontWeight.w400, fontSize: isBold ? 16 : 14)),
              if (hasInfo) ...[
                const SizedBox(width: 4),
                Icon(Icons.info_outline_rounded, size: 14, color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.5)),
              ],
            ],
          ),
          Text(value, style: TextStyle(fontWeight: isBold ? FontWeight.w700 : FontWeight.w500, fontSize: isBold ? 18 : 14)),
        ],
      ),
    );
  }
}

// =============================================================================
// Orders Tab
// =============================================================================

class _OrdersTab extends StatelessWidget {
  const _OrdersTab({required this.publicState});
  final TooltipCardPublicState publicState;

  @override
  Widget build(BuildContext context) {
    final orders = [
      _Order('#ORD-2024-001', 'Dec 20, 2024', 459.97, 'Delivered', Colors.green, ['Wireless Headphones', 'USB-C Hub']),
      _Order('#ORD-2024-002', 'Dec 22, 2024', 299.98, 'Shipped', Colors.blue, ['Mechanical Keyboard x2']),
      _Order('#ORD-2024-003', 'Dec 24, 2024', 79.99, 'Processing', Colors.orange, ['Laptop Stand']),
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: orders.length,
      itemBuilder: (ctx, i) => _OrderCard(order: orders[i], publicState: publicState),
    );
  }
}

class _Order {
  final String id, date, status;
  final double total;
  final Color color;
  final List<String> items;
  _Order(this.id, this.date, this.total, this.status, this.color, this.items);
}

class _OrderCard extends StatelessWidget {
  const _OrderCard({required this.order, required this.publicState});
  final _Order order;
  final TooltipCardPublicState publicState;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TooltipCard.builder(
        publicState: publicState,
        placementSide: TooltipCardPlacementSide.bottom,
        beakEnabled: true,
        whenContentVisible: WhenContentVisible.pressButton,
        modalBarrierEnabled: true,
        barrierBlur: 3,
        builder: (ctx, close) => _OrderDetails(order: order, onClose: close),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(order.id, style: const TextStyle(fontWeight: FontWeight.w600)),
                        Text(order.date, style: TextStyle(fontSize: 12, color: colorScheme.onSurface.withValues(alpha: 0.5))),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: order.color.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        Icon(_statusIcon(order.status), size: 14, color: order.color),
                        const SizedBox(width: 6),
                        Text(order.status, style: TextStyle(fontSize: 12, color: order.color, fontWeight: FontWeight.w600)),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      order.items.join(', '),
                      style: TextStyle(fontSize: 13, color: colorScheme.onSurface.withValues(alpha: 0.7)),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text('\$${order.total.toStringAsFixed(2)}', style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  IconData _statusIcon(String status) {
    switch (status) {
      case 'Delivered': return Icons.check_circle_rounded;
      case 'Shipped': return Icons.local_shipping_rounded;
      case 'Processing': return Icons.hourglass_top_rounded;
      default: return Icons.info_rounded;
    }
  }
}

class _OrderDetails extends StatelessWidget {
  const _OrderDetails({required this.order, required this.onClose});
  final _Order order;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return SizedBox(
      width: 300,
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
                    color: order.color.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(Icons.receipt_long_rounded, color: order.color, size: 22),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(order.id, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15)),
                      Text(order.date, style: TextStyle(fontSize: 12, color: colorScheme.onSurface.withValues(alpha: 0.6))),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Timeline
            _TimelineItem(title: 'Order Placed', subtitle: order.date, isCompleted: true, isLast: false),
            _TimelineItem(title: 'Processing', subtitle: 'Dec 21, 2024', isCompleted: order.status != 'Processing', isLast: false),
            _TimelineItem(title: 'Shipped', subtitle: 'Dec 22, 2024', isCompleted: order.status == 'Shipped' || order.status == 'Delivered', isLast: false),
            _TimelineItem(title: 'Delivered', subtitle: 'Dec 24, 2024', isCompleted: order.status == 'Delivered', isLast: true),
            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 12),
            ...order.items.map((item) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                children: [
                  Icon(Icons.check_circle_rounded, size: 16, color: order.color),
                  const SizedBox(width: 8),
                  Text(item, style: const TextStyle(fontSize: 13)),
                ],
              ),
            )),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Total', style: TextStyle(fontWeight: FontWeight.w600)),
                Text('\$${order.total.toStringAsFixed(2)}', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18, color: order.color)),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(child: OutlinedButton(onPressed: onClose, child: const Text('Track'))),
                const SizedBox(width: 10),
                Expanded(child: FilledButton(onPressed: onClose, style: FilledButton.styleFrom(backgroundColor: order.color), child: const Text('Details'))),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _TimelineItem extends StatelessWidget {
  const _TimelineItem({required this.title, required this.subtitle, required this.isCompleted, required this.isLast});
  final String title, subtitle;
  final bool isCompleted, isLast;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 16,
              height: 16,
              decoration: BoxDecoration(
                color: isCompleted ? Colors.green : colorScheme.surfaceContainerHighest,
                shape: BoxShape.circle,
                border: Border.all(color: isCompleted ? Colors.green : colorScheme.outline.withValues(alpha: 0.3), width: 2),
              ),
              child: isCompleted ? const Icon(Icons.check_rounded, size: 10, color: Colors.white) : null,
            ),
            if (!isLast)
              Container(
                width: 2,
                height: 24,
                color: isCompleted ? Colors.green : colorScheme.outline.withValues(alpha: 0.3),
              ),
          ],
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: TextStyle(fontWeight: FontWeight.w500, color: isCompleted ? colorScheme.onSurface : colorScheme.onSurface.withValues(alpha: 0.5))),
              Text(subtitle, style: TextStyle(fontSize: 11, color: colorScheme.onSurface.withValues(alpha: 0.5))),
              if (!isLast) const SizedBox(height: 8),
            ],
          ),
        ),
      ],
    );
  }
}

// =============================================================================
// Wishlist Tab
// =============================================================================

class _WishlistTab extends StatelessWidget {
  const _WishlistTab({required this.publicState});
  final TooltipCardPublicState publicState;

  @override
  Widget build(BuildContext context) {
    final wishlistItems = [
      _WishlistItem('Smart Watch Pro', 449.99, 4.9, Colors.purple, true),
      _WishlistItem('Wireless Mouse', 49.99, 4.4, Colors.teal, true),
      _WishlistItem('Gaming Monitor', 599.99, 4.7, Colors.blue, false),
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: wishlistItems.length,
      itemBuilder: (ctx, i) => _WishlistItemCard(item: wishlistItems[i], publicState: publicState),
    );
  }
}

class _WishlistItem {
  final String name;
  final double price, rating;
  final Color color;
  final bool inStock;
  _WishlistItem(this.name, this.price, this.rating, this.color, this.inStock);
}

class _WishlistItemCard extends StatelessWidget {
  const _WishlistItemCard({required this.item, required this.publicState});
  final _WishlistItem item;
  final TooltipCardPublicState publicState;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: item.color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(Icons.image_rounded, size: 32, color: item.color.withValues(alpha: 0.5)),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.name, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15)),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(Icons.star_rounded, size: 14, color: Colors.amber),
                      const SizedBox(width: 4),
                      Text('${item.rating}', style: const TextStyle(fontSize: 12)),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text('\$${item.price.toStringAsFixed(2)}', style: TextStyle(fontWeight: FontWeight.w700, color: item.color)),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: item.inStock ? Colors.green.withValues(alpha: 0.1) : Colors.red.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          item.inStock ? 'In Stock' : 'Out of Stock',
                          style: TextStyle(fontSize: 9, color: item.inStock ? Colors.green : Colors.red, fontWeight: FontWeight.w600),
                        ),
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
                    child: Text('Add to cart', style: TextStyle(fontSize: 11)),
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: item.inStock ? item.color : colorScheme.outline.withValues(alpha: 0.3),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(Icons.add_shopping_cart_rounded, size: 20, color: item.inStock ? Colors.white : colorScheme.onSurface.withValues(alpha: 0.5)),
                  ),
                ),
                const SizedBox(height: 8),
                TooltipCard.builder(
                  publicState: publicState,
                  placementSide: TooltipCardPlacementSide.start,
                  beakEnabled: true,
                  whenContentVisible: WhenContentVisible.hoverButton,
                  builder: (ctx, close) => const Padding(
                    padding: EdgeInsets.all(8),
                    child: Text('Remove from wishlist', style: TextStyle(fontSize: 11)),
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.red.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(Icons.delete_outline_rounded, size: 20, color: Colors.red),
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
