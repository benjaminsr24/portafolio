import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../utils/responsive.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MethodologySection extends StatelessWidget {
  const MethodologySection({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    final isMobile = Responsive.isMobile(context);

    final methodologies = [
      'Clean Architecture',
      'REST API Design',
      'Version Control (Git)',
      'Component-based architecture',
      'Responsive UI design',
      'API testing with Postman',
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
                '04.',
                style: TextStyle(
                  color: AppColors.primary,
                  fontSize: isMobile ? 20 : 24,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                'Metodología y Flujo',
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
          Responsive(
            mobile: Column(
              children: [
                _buildMethodologyGrid(methodologies, isMobile),
                const SizedBox(height: 60),
                _buildWorkflowDiagram(context),
              ],
            ),
            desktop: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: _buildMethodologyGrid(methodologies, isMobile)),
                const SizedBox(width: 80),
                Expanded(child: _buildWorkflowDiagram(context)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMethodologyGrid(List<String> items, bool isMobile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: items
          .map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Row(
                children: [
                  const Icon(
                    Icons.check_circle_outline,
                    color: AppColors.primary,
                    size: 20,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      item,
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: isMobile ? 16 : 18,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
          .toList(),
    ).animate().fadeIn(delay: 200.ms).slideX(begin: -0.1, end: 0);
  }

  Widget _buildWorkflowDiagram(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.divider),
      ),
      child: Column(
        children: [
          _buildWorkflowNode('Diseño', 'Figma', FontAwesomeIcons.figma),
          _buildArrow(),
          _buildWorkflowNode(
            'Frontend',
            'Flutter / Angular',
            FontAwesomeIcons.mobileScreen,
          ),
          _buildArrow(),
          _buildWorkflowNode(
            'Backend',
            '.NET / ASP.NET',
            FontAwesomeIcons.server,
          ),
          _buildArrow(),
          _buildWorkflowNode('Testing', 'Postman', FontAwesomeIcons.vial),
          _buildArrow(),
          _buildWorkflowNode(
            'Control Version',
            'Git / GitHub',
            FontAwesomeIcons.github,
          ),
        ],
      ),
    ).animate().fadeIn(delay: 400.ms).slideX(begin: 0.1, end: 0);
  }

  Widget _buildWorkflowNode(String title, String subtitle, IconData icon) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.background,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.primary.withOpacity(0.5)),
          ),
          child: Icon(icon, color: AppColors.primary, size: 20),
        ),
        const SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            Text(
              subtitle,
              style: const TextStyle(
                color: AppColors.textSecondary,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildArrow() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Icon(Icons.arrow_downward, color: AppColors.divider, size: 20),
      ),
    );
  }
}
