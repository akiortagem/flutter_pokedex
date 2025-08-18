import 'package:flutter/material.dart';
import 'package:flutter_pokedex/src/shared/themes/pkmn_color_theme.dart';

class PKMNDetailLoading extends StatelessWidget {
  const PKMNDetailLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PKMNColors.skeletonBg,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Metadata skeleton
              Padding(
                padding: const EdgeInsets.only(top: 15, left: 16, right: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Name and type skeleton
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _skeletonBox(width: 120, height: 24),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            _skeletonBox(width: 60, height: 20),
                            const SizedBox(width: 4),
                            _skeletonBox(width: 60, height: 20),
                          ],
                        ),
                      ],
                    ),
                    _skeletonBox(width: 50, height: 20),
                  ],
                ),
              ),

              // Pokemon art skeleton
              SizedBox(
                height: 200,
                child: Center(
                  child: _skeletonBox(width: 200, height: 200, radius: 100),
                ),
              ),

              // Tabs skeleton
              Container(
                decoration: const BoxDecoration(
                  color: PKMNColors.skeletonBg,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(50),
                  ),
                ),
                height: 350,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(8, 32, 8, 16),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _skeletonBox(width: 60, height: 20),
                          _skeletonBox(width: 60, height: 20),
                          _skeletonBox(width: 60, height: 20),
                          _skeletonBox(width: 60, height: 20),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Expanded(
                        child: _skeletonBox(
                          width: double.infinity,
                          height: double.infinity,
                          radius: 16,
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
    );
  }

  Widget _skeletonBox({
    double? width,
    double? height,
    double radius = 8,
  }) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: PKMNColors.skeletonFg,
        borderRadius: BorderRadius.circular(radius),
      ),
    );
  }
}
