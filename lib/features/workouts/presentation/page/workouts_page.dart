import 'package:fitness_tracker_app/shared/path/app_images.dart';
import 'package:fitness_tracker_app/shared/theme/app_colors.dart';
import 'package:fitness_tracker_app/shared/theme/app_font.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class WorkoutsPage extends StatelessWidget {
  const WorkoutsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            pinned: true,
            elevation: 0,
            floating: false,
            titleSpacing: 24,
            toolbarHeight: 53,
            scrolledUnderElevation: 0,
            automaticallyImplyLeading: false,
            surfaceTintColor: Colors.transparent,
            backgroundColor: AppColors.background,
            title: Row(
              children: [
                const Text(
                  'Workouts',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                    fontFamily: AppFont.spaceGrotesk,
                  ),
                ),
              ],
            ),
          ),
          SliverToBoxAdapter(child: SizedBox(height: 7)),

          // Search
          SliverToBoxAdapter(child: _SearchBar()),
          SliverToBoxAdapter(child: SizedBox(height: 20)),

          // Tabs
          SliverToBoxAdapter(child: _CategoryTabs()),
          SliverToBoxAdapter(child: SizedBox(height: 16)),
        ],
        body: SingleChildScrollView(
          padding: const EdgeInsets.only(top: 17, bottom: 120),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Resume
              _ResumeCard(),
              SizedBox(height: 32),

              // Recommended
              _RecommendedSection(),
              SizedBox(height: 32),

              // Library
              _LibrarySection(),
              SizedBox(height: 24),

              // Favorites
              _FavoritesSection(),
            ],
          ),
        ),
      ),
    );
  }
}

class _SearchBar extends StatelessWidget {
  const _SearchBar();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      margin: EdgeInsets.symmetric(horizontal: 24),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.backgroundDark,
        borderRadius: BorderRadius.circular(24),
      ),
      child: const Row(
        children: [
          Icon(LucideIcons.search, size: 18, color: AppColors.textSecondary),
          SizedBox(width: 7),
          Text(
            'Search routines, exercises...',
            style: TextStyle(
              fontSize: 14,
              fontFamily: AppFont.inter,
              fontWeight: FontWeight.w400,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}

class _CategoryTabs extends StatelessWidget {
  const _CategoryTabs();

  @override
  Widget build(BuildContext context) {
    const tabs = ['All', 'Strength', 'Cardio', 'Yoga', 'HIIT'];

    return SizedBox(
      height: 40,
      child: ListView.separated(
        itemCount: tabs.length,
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 24),
        itemBuilder: (_, i) {
          final active = i == 0;

          return Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(vertical: 8.5, horizontal: 19),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(111),
              color: active ? AppColors.primary : AppColors.white,
            ),
            child: Text(
              tabs[i],
              style: TextStyle(
                fontSize: 12,
                fontFamily: AppFont.inter,
                fontWeight: FontWeight.w700,
                color: active ? AppColors.white : AppColors.textPrimary,
              ),
            ),
          );
        },
        separatorBuilder: (_, _) => const SizedBox(width: 8),
      ),
    );
  }
}

class _ResumeCard extends StatelessWidget {
  const _ResumeCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
        color: AppColors.accentLime,
        borderRadius: BorderRadius.circular(32),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            right: -30,
            child: Icon(
              LucideIcons.dumbbell,
              size: 111,
              color: AppColors.textPrimary.withValues(alpha: 0.10),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'RESUME LAST',
                        style: TextStyle(
                          fontSize: 10,
                          letterSpacing: 2.0,
                          fontFamily: AppFont.inter,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 4),

                      Text(
                        'Upper Body',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                          fontFamily: AppFont.spaceGrotesk,
                        ),
                      ),
                      Text(
                        'Hypertrophy',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                          fontFamily: AppFont.spaceGrotesk,
                        ),
                      ),
                      const SizedBox(height: 11.5),

                      // START NOW button
                      Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 16,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(111),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'START NOW',
                              style: TextStyle(
                                fontSize: 12,
                                color: AppColors.white,
                                fontFamily: AppFont.inter,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(width: 10.92),
                            Icon(
                              LucideIcons.playDir,
                              size: 14,
                              color: AppColors.white,
                            ),
                          ],
                        ),
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

class _RecommendedSection extends StatelessWidget {
  const _RecommendedSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Recommended for you',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                  fontFamily: AppFont.spaceGrotesk,
                ),
              ),
              const Text(
                'See all',
                style: TextStyle(
                  fontSize: 12,
                  fontFamily: AppFont.inter,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        SizedBox(
          height: 240,
          child: ListView.separated(
            itemCount: 2,
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 24),
            itemBuilder: (_, i) {
              final images = [
                AppImages.recommendedImg1,
                AppImages.recommendedImg2,
              ];
              final titles = ['Advanced Powerlifting', 'Metabolic Fire'];
              final subs = [
                'Focus on deadlifts and overhead press',
                'Full body explosive movements',
              ];
              final tags = ['Strength', 'HIIT'];
              final times = ['45 min', '25 min'];

              return SizedBox(
                width: 288,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(32),
                        child: Stack(
                          children: [
                            Positioned.fill(
                              child: Image.asset(
                                images[i],
                                fit: BoxFit.cover,
                                alignment: Alignment.center,
                              ),
                            ),
                            Positioned.fill(
                              child: Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      AppColors.black.withValues(alpha: 0.00),
                                      AppColors.black.withValues(alpha: 0.60),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 0,
                              right: 0,
                              bottom: 0,
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    _miniTag(tags[i]),
                                    const SizedBox(width: 8),
                                    Text(
                                      times[i],
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: AppColors.white,
                                        fontFamily: AppFont.inter,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 12),
                    Text(
                      titles[i],
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                        fontFamily: AppFont.spaceGrotesk,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subs[i],
                      style: const TextStyle(
                        fontSize: 12,
                        fontFamily: AppFont.inter,
                        fontWeight: FontWeight.w400,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              );
            },
            separatorBuilder: (_, _) => const SizedBox(width: 16),
          ),
        ),
        const SizedBox(height: 8),
      ],
    );
  }

  Widget _miniTag(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4.5, horizontal: 7),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: AppColors.white.withValues(alpha: 0.20),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 12,
          color: AppColors.white,
          fontFamily: AppFont.inter,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

class _LibrarySection extends StatelessWidget {
  const _LibrarySection();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Library',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
              fontFamily: AppFont.spaceGrotesk,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _libraryCard('Yoga & Flow', AppImages.libraryImg1),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _libraryCard('Pure Cardio', AppImages.libraryImg2),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _libraryCard(String title, String image) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(32),
          ),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: Image.asset(image, width: 139, height: 139),
              ),
              SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                      fontFamily: AppFont.spaceGrotesk,
                    ),
                  ),
                  Icon(
                    LucideIcons.arrowRight,
                    size: 16,
                    color: AppColors.textSecondary,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _FavoritesSection extends StatelessWidget {
  const _FavoritesSection();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Favorites',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                  fontFamily: AppFont.spaceGrotesk,
                ),
              ),
              Icon(LucideIcons.heart, size: 18, color: AppColors.accentOrange),
            ],
          ),
          const SizedBox(height: 16),
          _favoriteTile('Morning Mobility A', '15 mins · Light', 12),
          const SizedBox(height: 12),
          _favoriteTile('Full Body Burn', '45 mins · Advanced', 45),
        ],
      ),
    );
  }

  Widget _favoriteTile(String title, String subtitle, int index) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: [
          // Number badge
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppColors.backgroundDark,
              borderRadius: BorderRadius.circular(20),
            ),
            alignment: Alignment.center,
            child: Text(
              '$index',
              style: const TextStyle(
                fontSize: 16,
                fontFamily: AppFont.inter,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                    fontFamily: AppFont.spaceGrotesk,
                  ),
                ),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 10,
                    fontFamily: AppFont.inter,
                    fontWeight: FontWeight.w400,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.backgroundDark,
            ),
            child: Icon(
              LucideIcons.play,
              size: 20,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
