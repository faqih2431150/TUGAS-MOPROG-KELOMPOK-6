import 'package:flutter/material.dart';
import '../models/energy_source.dart';

/// Kartu pembangkit.
/// - Double Tap            : ON/OFF pembangkit (warna & daya berubah)
/// - Horizontal Drag/Swipe : geser kartu; lewat ambang -> diarsipkan
class EnergyCard extends StatefulWidget {
  final EnergySource source;
  final VoidCallback onToggle;
  final VoidCallback onArchive;

  const EnergyCard({
    super.key,
    required this.source,
    required this.onToggle,
    required this.onArchive,
  });

  @override
  State<EnergyCard> createState() => _EnergyCardState();
}

class _EnergyCardState extends State<EnergyCard> {
  static const double _threshold = 120;
  double _dx = 0; // offset horizontal kartu saat di-swipe

  void _onDragUpdate(DragUpdateDetails d) => setState(() => _dx += d.delta.dx);

  void _onDragEnd(DragEndDetails d) {
    if (_dx.abs() > _threshold) {
      widget.onArchive();
    } else {
      setState(() => _dx = 0); // kembali ke posisi awal
    }
  }

  @override
  Widget build(BuildContext context) {
    final s = widget.source;
    final on = s.isOn;
    final swipeProgress = (_dx.abs() / _threshold).clamp(0.0, 1.0);

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: GestureDetector(
        onDoubleTap: widget.onToggle,
        onHorizontalDragUpdate: _onDragUpdate,
        onHorizontalDragEnd: _onDragEnd,
        child: Stack(
          children: [
            // Latar saat kartu digeser (petunjuk arsip)
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.15 + 0.5 * swipeProgress),
                  borderRadius: BorderRadius.circular(16),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                alignment:
                    _dx >= 0 ? Alignment.centerLeft : Alignment.centerRight,
                child: const Icon(Icons.archive_rounded, color: Colors.white),
              ),
            ),
            // Kartu utama yang ikut bergeser
            Transform.translate(
              offset: Offset(_dx, 0),
              child: Card(
                margin: EdgeInsets.zero,
                elevation: on ? 3 : 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: on ? s.color.withOpacity(0.15) : Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: on ? s.color : Colors.grey,
                            child: Icon(s.icon, color: Colors.white),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(s.name,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16)),
                                Text(on ? 'AKTIF' : 'MATI',
                                    style: TextStyle(
                                        color: on
                                            ? Colors.green.shade700
                                            : Colors.red.shade700,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12)),
                              ],
                            ),
                          ),
                          Text('${s.currentKw.toStringAsFixed(1)} kW',
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                        ],
                      ),
                      const SizedBox(height: 12),
                      LinearProgressIndicator(
                        value: s.currentKw / s.capacityKw,
                        minHeight: 8,
                        borderRadius: BorderRadius.circular(4),
                        color: s.color,
                        backgroundColor: Colors.white,
                      ),
                      const SizedBox(height: 6),
                      Text('Ketuk 2x: ON/OFF  •  Geser: arsipkan',
                          style: TextStyle(
                              fontSize: 11, color: Colors.grey.shade600)),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}