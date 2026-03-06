import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../utils/responsive.dart';
import '../widgets/animated_background.dart';
import 'sections/hero_section.dart';
import 'sections/about_section.dart';
import 'sections/tech_stack_section.dart';
import 'sections/projects_section.dart';
import 'sections/methodology_section.dart';
import 'sections/contact_section.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();

  // Claves para el scroll a secciones
  final GlobalKey _heroKey = GlobalKey();
  final GlobalKey _aboutKey = GlobalKey();
  final GlobalKey _stackKey = GlobalKey();
  final GlobalKey _projectsKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();

  void _scrollTo(GlobalKey key) {
    if (key.currentContext != null) {
      Scrollable.ensureVisible(
        key.currentContext!,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar:
          true, // Allow content to flow under transparent appbar
      appBar: _buildAppBar(context),
      drawer: Responsive.isDesktop(context) ? null : _buildDrawer(),
      body: SelectionArea(
        child: Stack(
          children: [
            const Positioned.fill(child: AnimatedBackground()),
            SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                children: [
                  Container(key: _heroKey, child: const HeroSection()),
                  Container(key: _aboutKey, child: const AboutSection()),
                  Container(key: _stackKey, child: const TechStackSection()),
                  Container(key: _projectsKey, child: const ProjectsSection()),
                  const MethodologySection(), // No specific navbar link
                  Container(key: _contactKey, child: const ContactSection()),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.arrow_upward, color: AppColors.background),
        onPressed: () => _scrollTo(_heroKey),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.background.withOpacity(0.9),
      elevation: 0,
      centerTitle: false,
      title: Padding(
        padding: Responsive.isDesktop(context)
            ? const EdgeInsets.only(left: 100)
            : const EdgeInsets.only(left: 16),
        child: Text(
          '<BR/>',
          style: TextStyle(
            color: AppColors.primary,
            fontWeight: FontWeight.bold,
            fontSize: 24,
            letterSpacing: 1.5,
          ),
        ),
      ),
      actions: [
        if (Responsive.isDesktop(context)) ...[
          _NavBarItem(title: 'Inicio', onTap: () => _scrollTo(_heroKey)),
          _NavBarItem(title: 'Sobre mí', onTap: () => _scrollTo(_aboutKey)),
          _NavBarItem(title: 'Stack', onTap: () => _scrollTo(_stackKey)),
          _NavBarItem(title: 'Proyectos', onTap: () => _scrollTo(_projectsKey)),
          _NavBarItem(title: 'Contacto', onTap: () => _scrollTo(_contactKey)),
          const SizedBox(width: 100),
        ] else ...[
          Builder(
            builder: (context) => IconButton(
              icon: const Icon(Icons.menu, color: AppColors.textPrimary),
              onPressed: () => Scaffold.of(context).openDrawer(),
            ),
          ),
          const SizedBox(width: 16),
        ],
      ],
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      backgroundColor: AppColors.card,
      child: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 50),
            _DrawerItem(
              title: 'Inicio',
              onTap: () {
                Navigator.pop(context);
                _scrollTo(_heroKey);
              },
            ),
            _DrawerItem(
              title: 'Sobre mí',
              onTap: () {
                Navigator.pop(context);
                _scrollTo(_aboutKey);
              },
            ),
            _DrawerItem(
              title: 'Stack',
              onTap: () {
                Navigator.pop(context);
                _scrollTo(_stackKey);
              },
            ),
            _DrawerItem(
              title: 'Proyectos',
              onTap: () {
                Navigator.pop(context);
                _scrollTo(_projectsKey);
              },
            ),
            _DrawerItem(
              title: 'Contacto',
              onTap: () {
                Navigator.pop(context);
                _scrollTo(_contactKey);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _NavBarItem extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const _NavBarItem({required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: TextButton(
        onPressed: onTap,
        child: Text(
          title,
          style: const TextStyle(
            color: AppColors.textPrimary,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

class _DrawerItem extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const _DrawerItem({required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: const TextStyle(
          color: AppColors.textPrimary,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
    );
  }
}
