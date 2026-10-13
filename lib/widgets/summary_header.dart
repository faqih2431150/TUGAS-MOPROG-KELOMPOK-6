import 'package:flutter/material.dart';

class SummaryHeader extends StatelessWidget {
  final double totalKw;
  final int activeCount;
  final int totalCount;

  const SummaryHeader({
    super.key,
    required this.totalKw,
    required this.activeCount,
    required this.totalCount,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        height: 150,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF2E7D32), Color(0xFF66BB6A)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              right: -20,
              bottom: -25,
              child: Icon(Icons.bolt_rounded,
                  size: 160, color: Colors.white.withOpacity(0.18)),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Total Produksi Saat Ini',
                      style: TextStyle(color: Colors.white70)),
                  Text('${totalKw.toStringAsFixed(1)} kW',
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 38,
                          fontWeight: FontWeight.bold)),
                  Row(
                    children: [
                      const Icon(Icons.power, color: Colors.white, size: 18),
                      const SizedBox(width: 6),
                      Text('$activeCount dari $totalCount pembangkit aktif',
                          style: const TextStyle(color: Colors.white)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}