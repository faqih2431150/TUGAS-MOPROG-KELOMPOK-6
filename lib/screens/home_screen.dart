import 'package:flutter/material.dart';
import '../models/energy_source.dart';
import '../widgets/energy_card.dart';
import '../widgets/summary_header.dart';
import '../widgets/zoomable_chart.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<EnergySource> _sources = buildSampleSources();
  final List<EnergySource> _archived = [];

  double get _totalKw => _sources.fold(0, (sum, s) => sum + s.currentKw);
  int get _activeCount => _sources.where((s) => s.isOn).length;

  List<double> get _chartData => List.generate(
        12,
        (i) => _sources
            .where((s) => s.isOn)
            .fold(0.0, (sum, s) => sum + s.profile[i]),
      );

  void _toggle(EnergySource s) => setState(() => s.isOn = !s.isOn);

  void _archive(EnergySource s) {
    setState(() {
      _sources.remove(s);
      _archived.add(s);
    });
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(
        content: Text('${s.name} diarsipkan'),
        action: SnackBarAction(label: 'BATAL', onPressed: () => _restore(s)),
      ));
  }

  void _restore(EnergySource s) {
    setState(() {
      _archived.remove(s);
      _sources.add(s);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('EcoGrid Dashboard'),
        backgroundColor: Colors.transparent,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          SummaryHeader(
            totalKw: _totalKw,
            activeCount: _activeCount,
            totalCount: _sources.length,
          ),
          const SizedBox(height: 12),
          ZoomableChart(data: _chartData),
          const SizedBox(height: 16),
          const Text('Pembangkit',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          for (final s in _sources)
            EnergyCard(
              key: ValueKey(s.id),
              source: s,
              onToggle: () => _toggle(s),
              onArchive: () => _archive(s),
            ),
          if (_archived.isNotEmpty) ...[
            const SizedBox(height: 8),
            const Text('Diarsipkan (ketuk untuk pulihkan)'),
            Wrap(
              spacing: 8,
              children: [
                for (final s in _archived)
                  ActionChip(
                    avatar: Icon(s.icon, size: 18),
                    label: Text(s.name),
                    onPressed: () => _restore(s),
                  ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}