import 'package:flutter/material.dart';

/// Grafik batang produksi daya 24 jam.
/// Pinch (Scale) memperbesar/memperkecil grafik 1x - 3x.
class ZoomableChart extends StatefulWidget {
  final List<double> data;
  const ZoomableChart({super.key, required this.data});

  @override
  State<ZoomableChart> createState() => _ZoomableChartState();
}

class _ZoomableChartState extends State<ZoomableChart> {
  double _scale = 1.0;
  double _baseScale = 1.0;

  void _onScaleStart(ScaleStartDetails d) => _baseScale = _scale;

  void _onScaleUpdate(ScaleUpdateDetails d) {
    setState(() => _scale = (_baseScale * d.scale).clamp(1.0, 3.0));
  }

  @override
  Widget build(BuildContext context) {
    final maxV = widget.data.fold<double>(1, (m, v) => v > m ? v : m);

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Produksi Daya 24 Jam',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                Chip(
                  label: Text('Zoom ${_scale.toStringAsFixed(1)}x'),
                  backgroundColor: _scale > 1
                      ? Colors.green.shade200
                      : Colors.grey.shade200,
                ),
              ],
            ),
            const SizedBox(height: 8),
            GestureDetector(
              onScaleStart: _onScaleStart,
              onScaleUpdate: _onScaleUpdate,
              child: Container(
                height: 180,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Transform.scale(
                    scale: _scale,
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          for (int i = 0; i < widget.data.length; i++)
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 2),
                                    height: 130 * (widget.data[i] / maxV),
                                    decoration: BoxDecoration(
                                      color: i == 6
                                          ? Colors.orange
                                          : Colors.green,
                                      borderRadius: BorderRadius.circular(3),
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text('${i * 2}',
                                      style: const TextStyle(fontSize: 8)),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 6),
            Text('Cubit dua jari untuk zoom (jam, sumbu X)',
                style: TextStyle(fontSize: 11, color: Colors.grey.shade600)),
          ],
        ),
      ),
    );
  }
}