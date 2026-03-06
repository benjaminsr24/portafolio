import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../theme/app_colors.dart';
import '../../utils/responsive.dart';
import '../../widgets/custom_buttons.dart';
import 'package:url_launcher/url_launcher.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    final isMobile = Responsive.isMobile(context);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 100 : 20,
        vertical: isDesktop ? 100 : 60,
      ),
      child: Column(
        crossAxisAlignment: isMobile
            ? CrossAxisAlignment.center
            : CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '¡Hola! Soy',
            style: TextStyle(
              color: AppColors.primary,
              fontSize: isMobile ? 18 : 24,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.5,
            ),
          ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.3, end: 0),
          const SizedBox(height: 16),
          Text(
                'Benjamin Ramirez',
                style: Theme.of(context).textTheme.displayLarge?.copyWith(
                  fontSize: isMobile ? 42 : 72,
                  height: 1.1,
                  color: AppColors.textPrimary,
                ),
                textAlign: isMobile ? TextAlign.center : TextAlign.left,
              )
              .animate()
              .fadeIn(delay: 200.ms, duration: 600.ms)
              .slideY(begin: 0.3, end: 0),
          const SizedBox(height: 20),
          Text(
                'Software Developer | Mobile & Web Applications',
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  fontSize: isMobile ? 24 : 36,
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: isMobile ? TextAlign.center : TextAlign.left,
              )
              .animate()
              .fadeIn(delay: 400.ms, duration: 600.ms)
              .slideY(begin: 0.3, end: 0),
          const SizedBox(height: 32),
          SizedBox(
            width: isDesktop ? 600 : double.infinity,
            child:
                Text(
                      'Desarrollo de aplicaciones móviles y web enfocadas en arquitectura limpia, integración de APIs y experiencias modernas de usuario. Especializado en Flutter, Angular y .NET Backend.',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontSize: isMobile ? 16 : 18,
                        height: 1.6,
                        color: AppColors.textSecondary,
                      ),
                      textAlign: isMobile ? TextAlign.center : TextAlign.left,
                    )
                    .animate()
                    .fadeIn(delay: 600.ms, duration: 600.ms)
                    .slideY(begin: 0.3, end: 0),
          ),
          const SizedBox(height: 48),
          Wrap(
                spacing: 16,
                runSpacing: 16,
                alignment: isMobile
                    ? WrapAlignment.center
                    : WrapAlignment.start,
                children: [
                  PrimaryButton(
                    text: 'Ver Proyectos',
                    onPressed: () {
                      // Scrolling handled in parent via ScrollController later
                    },
                  ),
                  SecondaryButton(
                    text: 'GitHub',
                    icon: FontAwesomeIcons.github,
                    onPressed: () =>
                        _launchUrl('https://github.com/BenjaminSR15'),
                  ),
                  SecondaryButton(
                    text: 'LinkedIn',
                    icon: FontAwesomeIcons.linkedin,
                    onPressed: () => _launchUrl(
                      'https://www.linkedin.com/in/benjamin-ramirez-2175822a8/',
                    ),
                  ),
                  SecondaryButton(
                    text: 'Descargar CV',
                    icon: FontAwesomeIcons.filePdf,
                    onPressed: () => _launchUrl('/cv_placeholder.pdf'),
                  ),
                ],
              )
              .animate()
              .fadeIn(delay: 800.ms, duration: 600.ms)
              .slideY(begin: 0.3, end: 0),
          const SizedBox(height: 60),
          if (!isMobile)
            _buildTechStacksHighlight().animate().fadeIn(
              delay: 1000.ms,
              duration: 600.ms,
            ),
        ],
      ),
    );
  }

  Widget _buildTechStacksHighlight() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Tech Stack Principal',
          style: TextStyle(
            color: AppColors.textSecondary,
            fontSize: 14,
            fontWeight: FontWeight.w600,
            letterSpacing: 2,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            _iconWithLabel(
              FontAwesomeIcons.mobileScreen,
              'Flutter',
              AppColors.primary,
            ),
            const SizedBox(width: 32),
            _iconWithLabel(
              FontAwesomeIcons.angular,
              'Angular',
              Colors.redAccent,
            ),
            const SizedBox(width: 32),
            _iconWithLabel(FontAwesomeIcons.server, '.NET', AppColors.accent),
            const SizedBox(width: 32),
            _iconWithLabel(
              FontAwesomeIcons.database,
              'Databases',
              Colors.green,
            ),
          ],
        ),
      ],
    );
  }

  Widget _iconWithLabel(IconData icon, String label, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: color, size: 24),
        const SizedBox(width: 8),
        Text(
          label,
          style: const TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
