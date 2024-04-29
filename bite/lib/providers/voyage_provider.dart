import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/Voyage.dart';
import '../models/user.dart';
import '../models/activite.dart';

final voyageProvider = StateNotifierProvider<VoyageNotifier, List<Voyage>>((ref) {
  return VoyageNotifier();
});

class VoyageNotifier extends StateNotifier<List<Voyage>> {
  VoyageNotifier() : super([]);

  // Ajoute un nouveau voyage
  void addVoyage(Voyage voyage) {
    state = [...state, voyage];
  }

  // Retire un voyage par son ID
  void removeVoyage(int voyageId) {
    state = state.where((v) => v.id != voyageId).toList();
  }

  // Met à jour un voyage
  void updateVoyage(Voyage updatedVoyage) {
    state = state.map((v) => v.id == updatedVoyage.id ? updatedVoyage : v).toList();
  }

  // Ajoute un invité à un voyage
  void addGuestToVoyage(int voyageId, User guest) {
    state = state.map((v) {
      if (v.id == voyageId) {
        return v.copyWith(guests: [...v.guests, guest]);
      }
      return v;
    }).toList();
  }

  // Retire un invité d'un voyage
  void removeGuestFromVoyage(int voyageId, int guestId) {
    state = state.map((v) {
      if (v.id == voyageId) {
        return v.copyWith(guests: v.guests.where((g) => g.id != guestId).toList());
      }
      return v;
    }).toList();
  }

  // Ajoute une activité à un voyage
  void addActiviteToVoyage(int voyageId, Activite activite) {
    state = state.map((v) {
      if (v.id == voyageId) {
        return v.copyWith(activites: [...v.activites, activite]);
      }
      return v;
    }).toList();
  }

  // Retire une activité d'un voyage
  void removeActiviteFromVoyage(int voyageId, int activiteId) {
    state = state.map((v) {
      if (v.id == voyageId) {
        return v.copyWith(activites: v.activites.where((a) => a.id != activiteId).toList());
      }
      return v;
    }).toList();
  }
}
