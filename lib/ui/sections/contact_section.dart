import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../utils/responsive.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../widgets/custom_buttons.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 120, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            '05. ¿Qué sigue?',
            style: TextStyle(
              color: AppColors.primary,
              fontSize: 16,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.2,
            ),
          ).animate().fadeIn(duration: 600.ms),
          const SizedBox(height: 20),
          Text(
            'Ponte en Contacto',
            style: Theme.of(context).textTheme.displayMedium?.copyWith(
              fontSize: isMobile ? 36 : 48,
              color: AppColors.textPrimary,
            ),
            textAlign: TextAlign.center,
          ).animate().fadeIn(delay: 200.ms),
          const SizedBox(height: 24),
          SizedBox(
            width: 600,
            child: Text(
              'Actualmente estoy abierto a nuevas oportunidades. Ya sea que tengas una pregunta o simplemente quieras saludar, ¡intentaré responderte lo antes posible!',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: AppColors.textSecondary,
                height: 1.6,
                fontSize: 18,
              ),
              textAlign: TextAlign.center,
            ),
          ).animate().fadeIn(delay: 400.ms),
          const SizedBox(height: 48),
          PrimaryButton(
            text: '¡Di Hola!',
            icon: FontAwesomeIcons.paperPlane,
            onPressed: () => _launchUrl('mailto:tu-email@example.com'),
          ).animate().fadeIn(delay: 600.ms).slideY(begin: 0.2, end: 0),
          const SizedBox(height: 100),
          // Footer mini
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(FontAwesomeIcons.github),
                color: AppColors.textSecondary,
                onPressed: () => _launchUrl('https://github.com/BenjaminSR15'),
              ),
              IconButton(
                icon: const Icon(FontAwesomeIcons.linkedin),
                color: AppColors.textSecondary,
                onPressed: () => _launchUrl(
                  'https://www.linkedin.com/in/benjamin-ramirez-2175822a8/',
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            'Diseñado y construido por Benjamin Ramirez',
            style: TextStyle(
              color: AppColors.textSecondary.withOpacity(0.5),
              fontSize: 14,
              fontFamily: 'monospace',
            ),
          ),
        ],
      ),
    );
  }
}
