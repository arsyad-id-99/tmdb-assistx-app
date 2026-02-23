import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class MovieDetailShimmer extends StatelessWidget {
  final bool isDarkMode;

  const MovieDetailShimmer({super.key, required this.isDarkMode});

  @override
  Widget build(BuildContext context) {
    final baseColor = isDarkMode ? Colors.grey[800]! : Colors.grey[300]!;
    final highlightColor = isDarkMode ? Colors.grey[700]! : Colors.grey[100]!;

    return Shimmer.fromColors(
      baseColor: baseColor,
      highlightColor: highlightColor,
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(color: Colors.white),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(width: 250, height: 30, color: Colors.white),
                  const SizedBox(height: 16),

                  Row(
                    children: [
                      Container(width: 40, height: 20, color: Colors.white),
                      const SizedBox(width: 16),
                      Container(width: 100, height: 20, color: Colors.white),
                    ],
                  ),
                  const SizedBox(height: 16),

                  Row(
                    children: [
                      Container(
                        width: 60,
                        height: 30,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        width: 80,
                        height: 30,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  Container(width: 100, height: 24, color: Colors.white),
                  const SizedBox(height: 12),

                  Container(
                    width: double.infinity,
                    height: 16,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 8),
                  Container(
                    width: double.infinity,
                    height: 16,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 8),
                  Container(
                    width: double.infinity,
                    height: 16,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 8),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.7,
                    height: 16,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
