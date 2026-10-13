import 'package:flutter/material.dart';

class EnergySource {
  static const int currentSlot = 6;

  final String id;
  final String name;
  final IconData icon;
  final Color color;
  final double capacityKw;
  final List<double> profile;
  bool isOn;

  EnergySource({
    required this.id,
    required this.name,
    required this.icon,
    required this.color,
    required this.capacityKw,
    required this.profile,
    this.isOn = true,
  });

  double get currentKw => isOn ? profile[currentSlot] : 0;
}

List<EnergySource> buildSampleSources() => [
      EnergySource(
        id: 'solar',
        name: 'PLTS Atap',
        icon: Icons.wb_sunny_rounded,
        color: Colors.orange,
        capacityKw: 50,
        profile: [0, 0, 5, 22, 40, 48, 50, 42, 25, 8, 0, 0],
      ),
      EnergySource(
        id: 'wind',
        name: 'PLTB Angin',
        icon: Icons.air_rounded,
        color: Colors.blue,
        capacityKw: 40,
        profile: [30, 28, 22, 18, 20, 25, 32, 36, 38, 35, 32, 30],
      ),
      EnergySource(
        id: 'hydro',
        name: 'PLTMH Hidro',
        icon: Icons.water_drop_rounded,
        color: Colors.teal,
        capacityKw: 30,
        profile: [24, 24, 25, 25, 26, 26, 27, 27, 26, 25, 24, 24],
      ),
      EnergySource(
        id: 'bio',
        name: 'PLTBm Biomassa',
        icon: Icons.eco_rounded,
        color: Colors.brown,
        capacityKw: 20,
        profile: [12, 12, 14, 16, 18, 18, 18, 18, 16, 14, 12, 12],
      ),
    ];