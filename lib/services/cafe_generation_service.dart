// lib/services/cafe_generation_service.dart
import 'dart:io';

import 'package:flutter/foundation.dart';

import '../replicate_nano_banana_service_multi.dart';
import '../safe_prompt_filter.dart';

export '../replicate_nano_banana_service_multi.dart'
    show GenerationConfig, UnsafePromptException, NetworkException;

/// Builds an optimised Imagen / Replicate prompt from the settings that the
/// user selected in [CustomStudioScreen].
class CafePromptBuilder {
  static String build({
    required String styleName,
    required Map<String, dynamic> settings,
  }) {
    final parts = <String>[];

    // ── Preservation prefix ──────────────────────────────────────────────
    parts.add(
      'Transform this existing cafe photo while preserving the '
      'exact same camera angle, perspective, spatial layout, '
      'and surrounding architecture.',
    );

    // ── Style ────────────────────────────────────────────────────────────
    parts.add('Apply a $styleName cafe design style.');

    // ── Ambiance ──────────────────────────────────────────────────────────
    final season = settings['season'] as String?;
    if (season != null && season.isNotEmpty) {
      parts.add('Set the cafe in $season season with appropriate seasonal '
          'plants, colors, and atmosphere.');
    }
    final timeOfDay = settings['timeOfDay'] as String?;
    if (timeOfDay != null && timeOfDay.isNotEmpty) {
      parts.add('Lighting should reflect $timeOfDay ambiance.');
    }
    final sunlight = (settings['sunlight'] as num?)?.toDouble() ?? 0.7;
    final lightDesc = sunlight > 0.6
        ? 'bright, sun-drenched'
        : sunlight > 0.3
            ? 'partially shaded, dappled light'
            : 'softly shaded, cool tones';
    parts.add('Cafe has $lightDesc sunlight conditions.');
    final vibrancy = (settings['colorVibrancy'] as num?)?.toDouble() ?? 0.6;
    if (vibrancy > 0.7) {
      parts.add('Bold, vibrant color palette with high saturation.');
    } else if (vibrancy < 0.3) {
      parts.add('Muted, neutral, and earthy tones throughout.');
    }

    // ── Seating density ────────────────────────────────────────────────────
    final density = (settings['density'] as num?)?.toDouble() ?? 0.5;
    if (density > 0.7) {
      parts.add('Dense, crowded seating arrangement with maximal tables and chairs.');
    } else if (density < 0.3) {
      parts.add('Sparse, spacious seating arrangement with open space and breathing room.');
    } else {
      parts.add('Balanced seating density with well-spaced tables.');
    }

    // ── Table size ─────────────────────────────────────────────────
    final flowers = (settings['flowers'] as num?)?.toDouble() ?? 0.3;
    if (flowers > 0.6) {
      parts.add('Include large communal tables and spacious group seating.');
    } else if (flowers > 0.2) {
      parts.add('Moderate sized tables for typical cafe seating.');
    } else {
      parts.add('Small bistro tables and intimate seating only.');
    }

    // ── Bar scale ────────────────────────────────────────────────────────
    final treeSize = (settings['treeSize'] as num?)?.toDouble() ?? 0.5;
    if (treeSize > 0.7) {
      parts.add('Include a grand, prominent espresso bar and counter area.');
    } else if (treeSize < 0.3) {
      parts.add('Minimalist, compact espresso counter.');
    }

    // ── Decor Scale ────────────────────────────────────────────────────────────
    final water = (settings['water'] as num?)?.toDouble() ?? 0.0;
    if (water > 0.4) {
      parts.add('Include eclectic and prominent cafe decor.');
    }

    // ── Decor Feature Type ────────────────────────────────────────────────────
    final waterFeatureIdx = (settings['waterFeature'] as num?)?.toInt() ?? -1;
    const decorFeatures = [
      'Coffee Roaster',
      'Bookshelves',
      'Hanging Plants',
      'Local Art',
      'Vintage Mirrors',
      'Record Player',
      'Chalkboard Menu',
      'Macrame Wall',
      'Pastry Display',
      'Fireplace',
      'Neon Wall Art',
      'Bicycles',
    ];
    if (waterFeatureIdx >= 0 && waterFeatureIdx < decorFeatures.length) {
      parts.add('Include a decorative ${decorFeatures[waterFeatureIdx]} as a focal point.');
    }

    // ── Flooring ──────────────────────────────────────────────────────────
    final pathwayIdx = (settings['pathway'] as num?)?.toInt() ?? 0;
    const pathways = [
      'checkered tile',
      'polished concrete',
      'vintage wood',
      'terrazzo',
      'herringbone',
      'exposed brick',
      'hexagon tile',
      'marble slab',
      'carpeted',
      'painted wood',
    ];
    if (pathwayIdx < pathways.length) {
      parts.add('Flooring is made of ${pathways[pathwayIdx]} material.');
    }

    // ── Lighting fixture ─────────────────────────────────────────────────
    final lightingIdx = (settings['lighting'] as num?)?.toInt() ?? 0;
    const lightingNames = [
      'edison pendants',
      'track lighting',
      'neon signs',
      'brass chandeliers',
      'wall sconces',
      'natural skylights',
      'library lamps',
      'paper lanterns',
      'industrial domes',
      'fairy string lights',
    ];
    if (lightingIdx < lightingNames.length) {
      parts.add('Cafe lighting uses ${lightingNames[lightingIdx]}.');
    }

    // ── Quality suffix ───────────────────────────────────────────────────
    parts.add(
      'Photorealistic result, professional interior cafe photography, '
      'consistent lighting and shadows, high resolution, 8K quality, '
      'maintaining exact same cafe proportions and surroundings.',
    );

    return parts.join(' ');
  }
}

/// Thin wrapper that loads image bytes from a file path and calls the API.
class CafeGenerationService {
  CafeGenerationService()
      : _api = ReplicateCafeAIService(
          filter: SafePromptFilter(mode: 'strict'),
        );

  final ReplicateCafeAIService _api;

  /// [imagePath] — absolute path of the uploaded cafe photo.
  /// [styleName] — selected style name.
  /// [settings]  — map of all custom-studio slider / picker values.
  Future<String?> generate({
    required String imagePath,
    required String styleName,
    required Map<String, dynamic> settings,
    GenerationConfig config = const GenerationConfig(),
  }) async {
    final bytes = await File(imagePath).readAsBytes();
    final prompt = CafePromptBuilder.build(
      styleName: styleName,
      settings: settings,
    );
    debugPrint('[CafeGeneration] Prompt: \$prompt');

    return _api.generateMultiBytes(
      images: [bytes],
      prompt: prompt,
      config: config,
    );
  }

  void dispose() => _api.dispose();
}
