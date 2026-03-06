import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../utils/responsive.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    final isMobile = Responsive.isMobile(context);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 100 : 20,
        vertical: 80,
      ),
      child: Column(
        crossAxisAlignment: isMobile
            ? CrossAxisAlignment.center
            : CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '01.',
                style: TextStyle(
                  color: AppColors.primary,
                  fontSize: isMobile ? 20 : 24,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                'Sobre mí',
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
          const SizedBox(height: 48),
          Responsive(
            mobile: _buildContent(context, isMobile: true),
            tablet: _buildContent(context, isMobile: false),
            desktop: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 3,
                  child: _buildContent(context, isMobile: false),
                ),
                const SizedBox(width: 80),
                Expanded(flex: 2, child: _buildInfoCards()),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(BuildContext context, {required bool isMobile}) {
    return Column(
      crossAxisAlignment: isMobile
          ? CrossAxisAlignment.center
          : CrossAxisAlignment.start,
      children: [
        Text(
          'Soy un desarrollador de software enfocado en la creación de aplicaciones móviles, web y backend. Tengo experiencia trabajando con Flutter, Angular y .NET para construir sistemas completos que integran frontend, backend y bases de datos.\n\nMe interesa desarrollar software escalable, con buenas prácticas, arquitectura modular y experiencias de usuario modernas.',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            fontSize: 18,
            height: 1.8,
            color: AppColors.textSecondary,
          ),
          textAlign: isMobile ? TextAlign.center : TextAlign.left,
        ).animate().fadeIn(delay: 200.ms),
        const SizedBox(height: 32),
        if (isMobile) _buildInfoCards(),
      ],
    );
  }

  Widget _buildInfoCards() {
    return Column(
      children: [
        _buildFocusCard(
          icon: FontAwesomeIcons.layerGroup,
          title: 'Arquitectura Limpia',
          desc: 'Sistemas escalables y mantenibles',
        ),
        const SizedBox(height: 16),
        _buildFocusCard(
          icon: FontAwesomeIcons.server,
          title: 'Integración API',
          desc: 'Comunicación fluida cliente-servidor',
        ),
        const SizedBox(height: 16),
        _buildFocusCard(
          icon: FontAwesomeIcons.mobileScreen,
          title: 'UI/UX Moderna',
          desc: 'Interfaces dinámicas y responsivas',
        ),
      ],
    ).animate().fadeIn(delay: 400.ms).slideX(begin: 0.2, end: 0);
  }

  Widget _buildFocusCard({
    required IconData icon,
    required String title,
    required String desc,
  }) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.divider),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: AppColors.primary, size: 24),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  desc,
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 14,
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
