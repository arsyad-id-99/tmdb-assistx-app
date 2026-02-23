import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CarouselShimmer extends StatelessWidget {
  final bool isDarkMode;
  const CarouselShimmer({super.key, required this.isDarkMode});

  @override
  Widget build(BuildContext context) {
    final baseColor = isDarkMode ? Colors.grey[800]! : Colors.grey[300]!;
    final highlightColor = isDarkMode ? Colors.grey[700]! : Colors.grey[100]!;

    return SizedBox(
      height: 200,
      child: PageView.builder(
        controller: PageController(viewportFraction: 0.85),
        itemCount: 2,
        itemBuilder: (_, index) => Shimmer.fromColors(
          baseColor: baseColor,
          highlightColor: highlightColor,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 8.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ),
      ),
    );
  }
}

class HorizontalListShimmer extends StatelessWidget {
  final bool isDarkMode;
  const HorizontalListShimmer({super.key, required this.isDarkMode});

  @override
  Widget build(BuildContext context) {
    final baseColor = isDarkMode ? Colors.grey[800]! : Colors.grey[300]!;
    final highlightColor = isDarkMode ? Colors.grey[700]! : Colors.grey[100]!;

    return SizedBox(
      height: 220,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        itemCount: 4,
        itemBuilder: (_, index) => Container(
          width: 120,
          margin: const EdgeInsets.symmetric(horizontal: 4.0),
          child: Shimmer.fromColors(
            baseColor: baseColor,
            highlightColor: highlightColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Container(width: 100, height: 12, color: Colors.white),
                const SizedBox(height: 4),
                Container(width: 60, height: 12, color: Colors.white),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
