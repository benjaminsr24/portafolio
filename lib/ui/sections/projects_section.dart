import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../utils/responsive.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    final isMobile = Responsive.isMobile(context);

    final projects = [
      _ProjectData(
        title: 'Sistema de gestión con Flutter + .NET',
        description:
            'Aplicación móvil desarrollada en Flutter conectada a un backend en .NET que permite gestionar información, documentos y usuarios dentro de un sistema administrativo. Incluye consumo de APIs REST, autenticación, y arquitectura cliente-servidor.',
        techs: ['Flutter', '.NET', 'REST API', 'Database'],
        githubUrl: 'https://github.com/blass',
      ),
      _ProjectData(
        title: 'Sistema de chat con manejo de archivos',
        description:
            'Aplicación de chat desarrollada con Flutter que permite el envío de mensajes y archivos en tiempo real, integrando backend y almacenamiento mediante Firebase y gestión de estados moderna.',
        techs: ['Flutter', 'REST API', 'Firebase', 'State Management'],
        githubUrl: 'https://github.com/blass',
      ),
      _ProjectData(
        title: 'Dashboard web con Angular',
        description:
            'Aplicación web desarrollada con Angular para visualizar y administrar información desde un backend. Panel administrativo completo con interfaces dinámicas, consumo de APIs y arquitectura modular.',
        techs: ['Angular', 'TypeScript', 'REST API', 'Dashboard'],
        githubUrl: 'https://github.com/blass',
      ),
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
                '03.',
                style: TextStyle(
                  color: AppColors.primary,
                  fontSize: isMobile ? 20 : 24,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                'Proyectos',
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
          ...projects.map(
            (p) => Padding(
              padding: const EdgeInsets.only(bottom: 40),
              child: _buildProjectCard(context, p, isMobile),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProjectCard(
    BuildContext context,
    _ProjectData project,
    bool isMobile,
  ) {
    return _ProjectCardAnimated(project: project, isMobile: isMobile);
  }
}

class _ProjectCardAnimated extends StatefulWidget {
  final _ProjectData project;
  final bool isMobile;

  const _ProjectCardAnimated({required this.project, required this.isMobile});

  @override
  State<_ProjectCardAnimated> createState() => _ProjectCardAnimatedState();
}

class _ProjectCardAnimatedState extends State<_ProjectCardAnimated> {
  bool _isHovered = false;

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => _launchUrl(widget.project.githubUrl),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOutCubic,
          transform: Matrix4.identity()..scale(_isHovered ? 1.02 : 1.0),
          width: double.infinity,
          padding: EdgeInsets.all(widget.isMobile ? 24 : 40),
          decoration: BoxDecoration(
            color: _isHovered
                ? AppColors.card.withOpacity(0.8)
                : AppColors.card,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: _isHovered
                  ? AppColors.primary.withOpacity(0.5)
                  : AppColors.divider,
            ),
            boxShadow: [
              BoxShadow(
                color: _isHovered
                    ? AppColors.primary.withOpacity(0.2)
                    : Colors.black.withOpacity(0.2),
                blurRadius: _isHovered ? 30 : 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      widget.project.title,
                      style: Theme.of(context).textTheme.headlineLarge
                          ?.copyWith(
                            color: _isHovered
                                ? AppColors.primary
                                : AppColors.textPrimary,
                            fontSize: widget.isMobile ? 24 : 28,
                          ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(FontAwesomeIcons.github, size: 28),
                    color: _isHovered
                        ? AppColors.primary
                        : AppColors.textSecondary,
                    onPressed: () => _launchUrl(widget.project.githubUrl),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Text(
                widget.project.description,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppColors.textSecondary,
                  height: 1.6,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 32),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: widget.project.techs
                    .map((tech) => _buildTechChip(tech))
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.1, end: 0);
  }

  Widget _buildTechChip(String tech) {
    return Text(
      tech,
      style: const TextStyle(
        color: AppColors.primary,
        fontFamily: 'monospace',
        fontSize: 14,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}

class _ProjectData {
  final String title;
  final String description;
  final List<String> techs;
  final String githubUrl;

  _ProjectData({
    required this.title,
    required this.description,
    required this.techs,
    required this.githubUrl,
  });
}
