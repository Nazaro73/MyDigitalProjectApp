import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/activite.dart';

final activiteProvider = StateNotifierProvider<ActiviteNotifier, List<Activite>>((ref) {
  return ActiviteNotifier();
});

class ActiviteNotifier extends StateNotifier<List<Activite>> {
  ActiviteNotifier() : super([]);

  // Ajoute un nouveau activite
  void addActivite(Activite activite) {
    state = [...state, activite];
  }

  // Retire un activite par son ID
  void removeActivite(int activiteId) {
    state = state.where((v) => v.id != activiteId).toList();
  }

  // Met à jour un activite
  void updateActivite(Activite updatedActivite) {
    state = state.map((v) => v.id == updatedActivite.id ? updatedActivite : v).toList();
  }


}
