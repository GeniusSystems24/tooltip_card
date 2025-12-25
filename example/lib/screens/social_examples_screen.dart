import 'package:flutter/material.dart';
import 'package:tooltip_card/tooltip_card.dart';

/// Social & Communication examples screen
class SocialExamplesScreen extends StatefulWidget {
  const SocialExamplesScreen({super.key});

  @override
  State<SocialExamplesScreen> createState() => _SocialExamplesScreenState();
}

class _SocialExamplesScreenState extends State<SocialExamplesScreen>
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
        title: const Text('Social & Communication'),
        backgroundColor: Colors.purple.withValues(alpha: 0.1),
        foregroundColor: Colors.purple.shade700,
        elevation: 0,
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          labelColor: Colors.purple.shade700,
          unselectedLabelColor: colorScheme.onSurface.withValues(alpha: 0.6),
          indicatorColor: Colors.purple,
          tabs: const [
            Tab(text: 'Chat', icon: Icon(Icons.chat_rounded, size: 20)),
            Tab(text: 'Profiles', icon: Icon(Icons.person_rounded, size: 20)),
            Tab(text: 'Feed', icon: Icon(Icons.dynamic_feed_rounded, size: 20)),
            Tab(text: 'Notifications', icon: Icon(Icons.notifications_rounded, size: 20)),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _ChatTab(publicState: _publicState),
          _ProfilesTab(publicState: _publicState),
          _FeedTab(publicState: _publicState),
          _NotificationsTab(publicState: _publicState),
        ],
      ),
    );
  }
}

// =============================================================================
// Chat Tab
// =============================================================================

class _ChatTab extends StatelessWidget {
  const _ChatTab({required this.publicState});
  final TooltipCardPublicState publicState;

  @override
  Widget build(BuildContext context) {
    final messages = [
      _Message('Hey! How is the project going?', 'Ahmed', '10:30 AM', true, []),
      _Message('Going great! Just finished the new feature.', 'Sara', '10:32 AM', false, ['thumbsUp']),
      _Message('Awesome work! Can you share a demo?', 'Ahmed', '10:33 AM', true, []),
      _Message('Sure, I will send a video shortly.', 'Sara', '10:35 AM', false, []),
      _Message('Also, the client meeting is at 2 PM today.', 'Sara', '10:36 AM', false, ['calendar']),
      _Message('Thanks for the reminder!', 'Ahmed', '10:37 AM', true, ['heart']),
    ];

    return Column(
      children: [
        // Chat header
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
          ),
          child: Row(
            children: [
              Stack(
                children: [
                  CircleAvatar(
                    radius: 22,
                    backgroundColor: Colors.purple.shade100,
                    child: Text('S', style: TextStyle(color: Colors.purple.shade700, fontWeight: FontWeight.w600)),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 14,
                      height: 14,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                        border: Border.all(color: Theme.of(context).colorScheme.surface, width: 2),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Sara Ali', style: TextStyle(fontWeight: FontWeight.w600)),
                    Row(
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(color: Colors.green, shape: BoxShape.circle),
                        ),
                        const SizedBox(width: 6),
                        Text('Online', style: TextStyle(fontSize: 12, color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6))),
                      ],
                    ),
                  ],
                ),
              ),
              TooltipCard.builder(
                publicState: publicState,
                placementSide: TooltipCardPlacementSide.bottomEnd,
                beakEnabled: true,
                whenContentVisible: WhenContentVisible.pressButton,
                builder: (ctx, close) => _ChatOptionsMenu(onClose: close),
                child: Icon(Icons.more_vert_rounded, color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6)),
              ),
            ],
          ),
        ),
        // Messages
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: messages.length,
            itemBuilder: (ctx, i) => _MessageBubble(message: messages[i], publicState: publicState),
          ),
        ),
        // Input
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
          ),
          child: Row(
            children: [
              TooltipCard.builder(
                publicState: publicState,
                placementSide: TooltipCardPlacementSide.topStart,
                beakEnabled: true,
                whenContentVisible: WhenContentVisible.pressButton,
                builder: (ctx, close) => _AttachmentMenu(onClose: close),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(Icons.add_rounded, color: Colors.purple),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Text('Type a message...', style: TextStyle(color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.5))),
                ),
              ),
              const SizedBox(width: 10),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.purple,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.send_rounded, color: Colors.white, size: 20),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _Message {
  final String text, sender, time;
  final bool isMe;
  final List<String> reactions;
  _Message(this.text, this.sender, this.time, this.isMe, this.reactions);
}

class _MessageBubble extends StatelessWidget {
  const _MessageBubble({required this.message, required this.publicState});
  final _Message message;
  final TooltipCardPublicState publicState;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: message.isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!message.isMe) ...[
            CircleAvatar(
              radius: 14,
              backgroundColor: Colors.purple.shade100,
              child: Text(message.sender[0], style: TextStyle(fontSize: 11, color: Colors.purple.shade700, fontWeight: FontWeight.w600)),
            ),
            const SizedBox(width: 8),
          ],
          TooltipCard.builder(
            publicState: publicState,
            placementSide: message.isMe ? TooltipCardPlacementSide.start : TooltipCardPlacementSide.end,
            beakEnabled: true,
            // whenContentVisible: WhenContentVisible.longPressButton,
            builder: (ctx, close) => _MessageActionsMenu(message: message, onClose: close),
            child: Container(
              constraints: const BoxConstraints(maxWidth: 260),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                color: message.isMe ? Colors.purple : colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(18),
                  topRight: const Radius.circular(18),
                  bottomLeft: Radius.circular(message.isMe ? 18 : 4),
                  bottomRight: Radius.circular(message.isMe ? 4 : 18),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    message.text,
                    style: TextStyle(color: message.isMe ? Colors.white : colorScheme.onSurface),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        message.time,
                        style: TextStyle(
                          fontSize: 10,
                          color: message.isMe ? Colors.white.withValues(alpha: 0.7) : colorScheme.onSurface.withValues(alpha: 0.5),
                        ),
                      ),
                      if (message.reactions.isNotEmpty) ...[
                        const SizedBox(width: 8),
                        ...message.reactions.map((r) => _reactionIcon(r)),
                      ],
                    ],
                  ),
                ],
              ),
            ),
          ),
          if (message.isMe) const SizedBox(width: 8),
        ],
      ),
    );
  }

  Widget _reactionIcon(String reaction) {
    switch (reaction) {
      case 'thumbsUp': return const Text('👍', style: TextStyle(fontSize: 12));
      case 'heart': return const Text('❤️', style: TextStyle(fontSize: 12));
      case 'calendar': return const Text('📅', style: TextStyle(fontSize: 12));
      default: return const SizedBox();
    }
  }
}

class _MessageActionsMenu extends StatelessWidget {
  const _MessageActionsMenu({required this.message, required this.onClose});
  final _Message message;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return SizedBox(
      width: 200,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Reactions
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: ['👍', '❤️', '😂', '😮', '😢', '🎉'].map((e) =>
                InkWell(
                  onTap: onClose,
                  borderRadius: BorderRadius.circular(20),
                  child: Padding(
                    padding: const EdgeInsets.all(6),
                    child: Text(e, style: const TextStyle(fontSize: 20)),
                  ),
                ),
              ).toList(),
            ),
          ),
          Divider(height: 1, color: colorScheme.outline.withValues(alpha: 0.2)),
          _ActionItem(icon: Icons.reply_rounded, label: 'Reply', onTap: onClose),
          _ActionItem(icon: Icons.copy_rounded, label: 'Copy', onTap: onClose),
          _ActionItem(icon: Icons.forward_rounded, label: 'Forward', onTap: onClose),
          if (message.isMe) ...[
            Divider(height: 1, color: colorScheme.outline.withValues(alpha: 0.2)),
            _ActionItem(icon: Icons.edit_rounded, label: 'Edit', onTap: onClose),
            _ActionItem(icon: Icons.delete_rounded, label: 'Delete', onTap: onClose, isDestructive: true),
          ],
        ],
      ),
    );
  }
}

class _ChatOptionsMenu extends StatelessWidget {
  const _ChatOptionsMenu({required this.onClose});
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 180,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _ActionItem(icon: Icons.search_rounded, label: 'Search', onTap: onClose),
          _ActionItem(icon: Icons.volume_off_rounded, label: 'Mute', onTap: onClose),
          _ActionItem(icon: Icons.person_rounded, label: 'View Profile', onTap: onClose),
          _ActionItem(icon: Icons.block_rounded, label: 'Block', onTap: onClose, isDestructive: true),
        ],
      ),
    );
  }
}

class _AttachmentMenu extends StatelessWidget {
  const _AttachmentMenu({required this.onClose});
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _AttachmentOption(icon: Icons.image_rounded, label: 'Photo', color: Colors.green, onTap: onClose),
                _AttachmentOption(icon: Icons.videocam_rounded, label: 'Video', color: Colors.red, onTap: onClose),
                _AttachmentOption(icon: Icons.insert_drive_file_rounded, label: 'File', color: Colors.blue, onTap: onClose),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _AttachmentOption(icon: Icons.location_on_rounded, label: 'Location', color: Colors.orange, onTap: onClose),
                _AttachmentOption(icon: Icons.person_rounded, label: 'Contact', color: Colors.purple, onTap: onClose),
                _AttachmentOption(icon: Icons.poll_rounded, label: 'Poll', color: Colors.teal, onTap: onClose),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _AttachmentOption extends StatelessWidget {
  const _AttachmentOption({required this.icon, required this.label, required this.color, required this.onTap});
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color, size: 22),
            ),
            const SizedBox(height: 4),
            Text(label, style: TextStyle(fontSize: 10, color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7))),
          ],
        ),
      ),
    );
  }
}

// =============================================================================
// Profiles Tab
// =============================================================================

class _ProfilesTab extends StatelessWidget {
  const _ProfilesTab({required this.publicState});
  final TooltipCardPublicState publicState;

  @override
  Widget build(BuildContext context) {
    final users = [
      _User('Ahmed Hassan', '@ahmed_h', 'Senior Developer', 1234, 567, Colors.blue, true),
      _User('Sara Ali', '@sara_ali', 'Product Designer', 2345, 890, Colors.purple, true),
      _User('Mohamed Nour', '@m_nour', 'Startup Founder', 5678, 1234, Colors.green, false),
      _User('Layla Ahmed', '@layla_a', 'Tech Writer', 890, 456, Colors.pink, true),
      _User('Youssef Ibrahim', '@youssef_i', 'Full Stack Dev', 3456, 789, Colors.orange, false),
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: users.length,
      itemBuilder: (ctx, i) => _UserCard(user: users[i], publicState: publicState),
    );
  }
}

class _User {
  final String name, handle, bio;
  final int followers, following;
  final Color color;
  final bool isFollowing;
  _User(this.name, this.handle, this.bio, this.followers, this.following, this.color, this.isFollowing);
}

class _UserCard extends StatelessWidget {
  const _UserCard({required this.user, required this.publicState});
  final _User user;
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
        whenContentVisible: WhenContentVisible.hoverButton,
        hoverOpenDelay: const Duration(milliseconds: 500),
        builder: (ctx, close) => _UserProfileCard(user: user, onClose: close),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 28,
                backgroundColor: user.color.withValues(alpha: 0.2),
                child: Text(
                  user.name.split(' ').map((n) => n[0]).join(),
                  style: TextStyle(color: user.color, fontWeight: FontWeight.w600, fontSize: 16),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(user.name, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15)),
                        const SizedBox(width: 6),
                        Icon(Icons.verified_rounded, size: 16, color: Colors.blue),
                      ],
                    ),
                    Text(user.handle, style: TextStyle(fontSize: 13, color: colorScheme.onSurface.withValues(alpha: 0.6))),
                    const SizedBox(height: 4),
                    Text(user.bio, style: TextStyle(fontSize: 12, color: colorScheme.onSurface.withValues(alpha: 0.7))),
                  ],
                ),
              ),
              FilledButton(
                onPressed: () {},
                style: FilledButton.styleFrom(
                  backgroundColor: user.isFollowing ? colorScheme.surfaceContainerHighest : user.color,
                  foregroundColor: user.isFollowing ? colorScheme.onSurface : Colors.white,
                  side: user.isFollowing ? BorderSide(color: colorScheme.outline.withValues(alpha: 0.3)) : null,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                ),
                child: Text(user.isFollowing ? 'Following' : 'Follow', style: const TextStyle(fontSize: 12)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _UserProfileCard extends StatelessWidget {
  const _UserProfileCard({required this.user, required this.onClose});
  final _User user;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return SizedBox(
      width: 300,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Cover & Avatar
          Container(
            height: 80,
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [user.color, user.color.withValues(alpha: 0.5)]),
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            ),
          ),
          Transform.translate(
            offset: const Offset(0, -30),
            child: CircleAvatar(
              radius: 36,
              backgroundColor: colorScheme.surface,
              child: CircleAvatar(
                radius: 32,
                backgroundColor: user.color.withValues(alpha: 0.2),
                child: Text(
                  user.name.split(' ').map((n) => n[0]).join(),
                  style: TextStyle(color: user.color, fontWeight: FontWeight.w600, fontSize: 20),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Column(
              children: [
                Transform.translate(
                  offset: const Offset(0, -16),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(user.name, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 17)),
                          const SizedBox(width: 6),
                          Icon(Icons.verified_rounded, size: 18, color: Colors.blue),
                        ],
                      ),
                      Text(user.handle, style: TextStyle(fontSize: 13, color: colorScheme.onSurface.withValues(alpha: 0.6))),
                      const SizedBox(height: 8),
                      Text(user.bio, style: const TextStyle(fontSize: 13), textAlign: TextAlign.center),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _StatItem(value: user.followers.toString(), label: 'Followers'),
                          Container(width: 1, height: 24, color: colorScheme.outline.withValues(alpha: 0.2), margin: const EdgeInsets.symmetric(horizontal: 20)),
                          _StatItem(value: user.following.toString(), label: 'Following'),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(onPressed: onClose, child: const Text('Message')),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: FilledButton(
                              onPressed: onClose,
                              style: FilledButton.styleFrom(backgroundColor: user.color),
                              child: Text(user.isFollowing ? 'Following' : 'Follow'),
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
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  const _StatItem({required this.value, required this.label});
  final String value, label;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
        Text(label, style: TextStyle(fontSize: 12, color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6))),
      ],
    );
  }
}

// =============================================================================
// Feed Tab
// =============================================================================

class _FeedTab extends StatelessWidget {
  const _FeedTab({required this.publicState});
  final TooltipCardPublicState publicState;

  @override
  Widget build(BuildContext context) {
    final posts = [
      _Post('Ahmed Hassan', '@ahmed_h', 'Just launched our new product! Super excited to share this with everyone. Check it out!', '2h', 234, 56, 12, Colors.blue),
      _Post('Sara Ali', '@sara_ali', 'Design tip: Always test your UI with real content, not lorem ipsum. The difference is huge!', '4h', 567, 123, 45, Colors.purple),
      _Post('Mohamed Nour', '@m_nour', 'Building in public is the best way to learn. Share your progress, get feedback, and grow!', '6h', 890, 234, 67, Colors.green),
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: posts.length,
      itemBuilder: (ctx, i) => _PostCard(post: posts[i], publicState: publicState),
    );
  }
}

class _Post {
  final String name, handle, content, time;
  final int likes, comments, shares;
  final Color color;
  _Post(this.name, this.handle, this.content, this.time, this.likes, this.comments, this.shares, this.color);
}

class _PostCard extends StatelessWidget {
  const _PostCard({required this.post, required this.publicState});
  final _Post post;
  final TooltipCardPublicState publicState;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                TooltipCard.builder(
                  publicState: publicState,
                  placementSide: TooltipCardPlacementSide.bottomStart,
                  beakEnabled: true,
                  whenContentVisible: WhenContentVisible.hoverButton,
                  hoverOpenDelay: const Duration(milliseconds: 400),
                  builder: (ctx, close) => _MiniProfile(name: post.name, handle: post.handle, color: post.color),
                  child: CircleAvatar(
                    radius: 22,
                    backgroundColor: post.color.withValues(alpha: 0.2),
                    child: Text(
                      post.name.split(' ').map((n) => n[0]).join(),
                      style: TextStyle(color: post.color, fontWeight: FontWeight.w600, fontSize: 13),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(post.name, style: const TextStyle(fontWeight: FontWeight.w600)),
                          const SizedBox(width: 4),
                          Icon(Icons.verified_rounded, size: 14, color: Colors.blue),
                        ],
                      ),
                      Text('${post.handle} · ${post.time}', style: TextStyle(fontSize: 12, color: colorScheme.onSurface.withValues(alpha: 0.5))),
                    ],
                  ),
                ),
                TooltipCard.builder(
                  publicState: publicState,
                  placementSide: TooltipCardPlacementSide.bottomEnd,
                  beakEnabled: true,
                  whenContentVisible: WhenContentVisible.pressButton,
                  builder: (ctx, close) => _PostOptionsMenu(onClose: close),
                  child: Icon(Icons.more_horiz_rounded, color: colorScheme.onSurface.withValues(alpha: 0.5)),
                ),
              ],
            ),
            const SizedBox(height: 12),
            // Content
            Text(post.content, style: const TextStyle(fontSize: 14, height: 1.4)),
            const SizedBox(height: 14),
            // Actions
            Row(
              children: [
                _PostAction(icon: Icons.favorite_border_rounded, label: post.likes.toString(), color: Colors.red, publicState: publicState),
                const SizedBox(width: 24),
                _PostAction(icon: Icons.chat_bubble_outline_rounded, label: post.comments.toString(), color: Colors.blue, publicState: publicState),
                const SizedBox(width: 24),
                _PostAction(icon: Icons.repeat_rounded, label: post.shares.toString(), color: Colors.green, publicState: publicState),
                const Spacer(),
                TooltipCard.builder(
                  publicState: publicState,
                  placementSide: TooltipCardPlacementSide.topEnd,
                  beakEnabled: true,
                  whenContentVisible: WhenContentVisible.pressButton,
                  builder: (ctx, close) => _ShareMenu(onClose: close),
                  child: Icon(Icons.share_outlined, size: 20, color: colorScheme.onSurface.withValues(alpha: 0.6)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _MiniProfile extends StatelessWidget {
  const _MiniProfile({required this.name, required this.handle, required this.color});
  final String name, handle;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: color.withValues(alpha: 0.2),
            child: Text(
              name.split(' ').map((n) => n[0]).join(),
              style: TextStyle(color: color, fontWeight: FontWeight.w600),
            ),
          ),
          const SizedBox(width: 10),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name, style: const TextStyle(fontWeight: FontWeight.w600)),
              Text(handle, style: TextStyle(fontSize: 12, color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6))),
            ],
          ),
        ],
      ),
    );
  }
}

class _PostAction extends StatelessWidget {
  const _PostAction({required this.icon, required this.label, required this.color, required this.publicState});
  final IconData icon;
  final String label;
  final Color color;
  final TooltipCardPublicState publicState;

  @override
  Widget build(BuildContext context) {
    return TooltipCard.builder(
      publicState: publicState,
      placementSide: TooltipCardPlacementSide.top,
      beakEnabled: true,
      whenContentVisible: WhenContentVisible.hoverButton,
      hoverOpenDelay: const Duration(milliseconds: 600),
      builder: (ctx, close) => Padding(
        padding: const EdgeInsets.all(8),
        child: Text(_getTooltipText(), style: const TextStyle(fontSize: 12)),
      ),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6)),
          const SizedBox(width: 6),
          Text(label, style: TextStyle(fontSize: 13, color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6))),
        ],
      ),
    );
  }

  String _getTooltipText() {
    if (icon == Icons.favorite_border_rounded) return 'Like this post';
    if (icon == Icons.chat_bubble_outline_rounded) return 'View comments';
    return 'Repost';
  }
}

class _PostOptionsMenu extends StatelessWidget {
  const _PostOptionsMenu({required this.onClose});
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 180,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _ActionItem(icon: Icons.bookmark_border_rounded, label: 'Save', onTap: onClose),
          _ActionItem(icon: Icons.link_rounded, label: 'Copy Link', onTap: onClose),
          _ActionItem(icon: Icons.volume_off_rounded, label: 'Mute', onTap: onClose),
          _ActionItem(icon: Icons.flag_rounded, label: 'Report', onTap: onClose, isDestructive: true),
        ],
      ),
    );
  }
}

class _ShareMenu extends StatelessWidget {
  const _ShareMenu({required this.onClose});
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _ActionItem(icon: Icons.send_rounded, label: 'Send via DM', onTap: onClose),
          _ActionItem(icon: Icons.copy_rounded, label: 'Copy Link', onTap: onClose),
          _ActionItem(icon: Icons.share_rounded, label: 'Share to...', onTap: onClose),
        ],
      ),
    );
  }
}

// =============================================================================
// Notifications Tab
// =============================================================================

class _NotificationsTab extends StatelessWidget {
  const _NotificationsTab({required this.publicState});
  final TooltipCardPublicState publicState;

  @override
  Widget build(BuildContext context) {
    final notifications = [
      _Notification('Sara Ali liked your post', 'Just now', Icons.favorite_rounded, Colors.red, 'like'),
      _Notification('Mohamed Nour started following you', '2m ago', Icons.person_add_rounded, Colors.blue, 'follow'),
      _Notification('Layla Ahmed commented on your photo', '15m ago', Icons.chat_rounded, Colors.green, 'comment'),
      _Notification('Your post reached 1000 views!', '1h ago', Icons.visibility_rounded, Colors.purple, 'milestone'),
      _Notification('Ahmed Hassan mentioned you in a story', '2h ago', Icons.alternate_email_rounded, Colors.orange, 'mention'),
      _Notification('System update available', '3h ago', Icons.system_update_rounded, Colors.teal, 'system'),
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: notifications.length,
      itemBuilder: (ctx, i) => _NotificationCard(notification: notifications[i], publicState: publicState),
    );
  }
}

class _Notification {
  final String message, time, type;
  final IconData icon;
  final Color color;
  _Notification(this.message, this.time, this.icon, this.color, this.type);
}

class _NotificationCard extends StatelessWidget {
  const _NotificationCard({required this.notification, required this.publicState});
  final _Notification notification;
  final TooltipCardPublicState publicState;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TooltipCard.builder(
        publicState: publicState,
        placementSide: TooltipCardPlacementSide.end,
        beakEnabled: true,
        whenContentVisible: WhenContentVisible.secondaryTapButton,
        builder: (ctx, close) => _NotificationActions(notification: notification, onClose: close),
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(12),
            border: Border(left: BorderSide(width: 3, color: notification.color)),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: notification.color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(notification.icon, color: notification.color, size: 20),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(notification.message, style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 13)),
                    const SizedBox(height: 2),
                    Text(notification.time, style: TextStyle(fontSize: 11, color: colorScheme.onSurface.withValues(alpha: 0.5))),
                  ],
                ),
              ),
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: notification.color,
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NotificationActions extends StatelessWidget {
  const _NotificationActions({required this.notification, required this.onClose});
  final _Notification notification;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 180,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _ActionItem(icon: Icons.check_rounded, label: 'Mark as read', onTap: onClose),
          _ActionItem(icon: Icons.notifications_off_rounded, label: 'Turn off', onTap: onClose),
          _ActionItem(icon: Icons.delete_rounded, label: 'Delete', onTap: onClose, isDestructive: true),
        ],
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
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        child: Row(
          children: [
            Icon(icon, size: 18, color: color),
            const SizedBox(width: 12),
            Text(label, style: TextStyle(fontSize: 14, color: color)),
          ],
        ),
      ),
    );
  }
}
