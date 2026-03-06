import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../utils/responsive.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TechStackSection extends StatelessWidget {
  const TechStackSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    final isMobile = Responsive.isMobile(context);

    // Categories
    final mobileStack = [
      _Tech('Flutter', FontAwesomeIcons.mobileScreen),
      _Tech('Dart', FontAwesomeIcons.code),
      _Tech('Firebase', FontAwesomeIcons.fire),
    ];

    final frontendStack = [
      _Tech('Angular', FontAwesomeIcons.angular),
      _Tech('TypeScript', FontAwesomeIcons.js),
      _Tech('JavaScript', FontAwesomeIcons.js),
      _Tech('HTML/CSS', FontAwesomeIcons.html5),
    ];

    final backendStack = [
      _Tech('.NET', FontAwesomeIcons.server),
      _Tech('ASP.NET', FontAwesomeIcons.server),
      _Tech('C#', FontAwesomeIcons.c),
    ];

    final dbStack = [
      _Tech('SQL', FontAwesomeIcons.database),
      _Tech('NoSQL', FontAwesomeIcons.database),
    ];

    final toolsStack = [
      _Tech('Git', FontAwesomeIcons.gitAlt),
      _Tech('GitHub', FontAwesomeIcons.github),
      _Tech('Postman', FontAwesomeIcons.networkWired),
      _Tech('Figma', FontAwesomeIcons.figma),
    ];

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 100 : 20,
        vertical: 80,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '02.',
                style: TextStyle(
                  color: AppColors.primary,
                  fontSize: isMobile ? 20 : 24,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                'Tech Stack',
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                  fontSize: isMobile ? 28 : 36,
                  color: AppColors.textPrimary,
                ),
              ),
              if (!isMobile) ...[
                const SizedBox(width: 20),
                Expanded(child: Container(height: 1, color: AppColors.divider)),
              ],
            ],
          ).animate().fadeIn(duration: 600.ms),
          const SizedBox(height: 60),
          Wrap(
            spacing: 24,
            runSpacing: 24,
            alignment: WrapAlignment.center,
            children: [
              _buildCategory('Mobile Development', mobileStack),
              _buildCategory('Frontend', frontendStack),
              _buildCategory('Backend', backendStack),
              _buildCategory('Databases', dbStack),
              _buildCategory('Tools', toolsStack),
            ],
          ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.1, end: 0),
        ],
      ),
    );
  }

  Widget _buildCategory(String title, List<_Tech> techs) {
    return Container(
      width: 300,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.divider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: AppColors.primary,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 24),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: techs.map((t) => _buildChip(t)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildChip(_Tech tech) {
    return _HoverChip(tech: tech);
  }
}

class _HoverChip extends StatefulWidget {
  final _Tech tech;

  const _HoverChip({required this.tech});

  @override
  State<_HoverChip> createState() => _HoverChipState();
}

class _HoverChipState extends State<_HoverChip> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        transform: Matrix4.identity()..scale(_isHovered ? 1.05 : 1.0),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: _isHovered
              ? AppColors.primary.withOpacity(0.1)
              : AppColors.background,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: _isHovered ? AppColors.primary : AppColors.divider,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              widget.tech.icon,
              size: 16,
              color: _isHovered ? AppColors.primary : AppColors.textSecondary,
            ),
            const SizedBox(width: 8),
            Text(
              widget.tech.name,
              style: TextStyle(
                color: _isHovered ? AppColors.primary : AppColors.textPrimary,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Tech {
  final String name;
  final IconData icon;

  _Tech(this.name, this.icon);
}
