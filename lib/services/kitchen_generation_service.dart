// lib/services/kitchen_generation_service.dart
import 'dart:io';

import 'package:flutter/foundation.dart';

import '../replicate_nano_banana_service_multi.dart';
import '../safe_prompt_filter.dart';

export '../replicate_nano_banana_service_multi.dart'
    show GenerationConfig, UnsafePromptException, NetworkException;

/// Builds an optimised Imagen / Replicate prompt from the settings that the
/// user selected in [CustomStudioScreen].
class KitchenPromptBuilder {
  static String build({
    required String styleName,
    required Map<String, dynamic> settings,
  }) {
    final parts = <String>[];

    // ── Preservation prefix ──────────────────────────────────────────────
    parts.add(
      'Transform this existing indoor kitchen photo while preserving the '
      'exact same camera angle, perspective, spatial layout, '
      'and surrounding structural elements.',
    );

    // ── Style ────────────────────────────────────────────────────────────
    parts.add('Apply a $styleName design aesthetic to the kitchen interior.');

    // ── Season ───────────────────────────────────────────────────────────
    final season = settings['season'] as String?;
    if (season != null && season.isNotEmpty) {
      parts.add('Set the kitchen in $season season with appropriate seasonal '
          'appliances, colors, and layout.');
    }

    // ── Time of Day ──────────────────────────────────────────────────────
    final timeOfDay = settings['timeOfDay'] as String?;
    if (timeOfDay != null && timeOfDay.isNotEmpty) {
      parts.add('Lighting should reflect $timeOfDay ambiance.');
    }

    // ── Counter space ────────────────────────────────────────────────────
    final density = (settings['density'] as num?)?.toDouble() ?? 0.5;
    if (density > 0.7) {
      parts.add('Maximised counter space with ample room for prep.');
    } else if (density < 0.3) {
      parts.add('Minimalist counters with tucked away appliances.');
    } else {
      parts.add('Balanced counter space with dedicated prep areas.');
    }

    // ── Feature Highlights ───────────────────────────────────────────────
    final flowers = (settings['flowers'] as num?)?.toDouble() ?? 0.3;
    if (flowers > 0.6) {
      parts.add('Bold statement appliances and distinctive backsplash patterns.');
    } else if (flowers > 0.2) {
      parts.add('Subtle hardware accents and elegant kitchen accessories.');
    }

    // ── Sink / Plumbing ──────────────────────────────────────────────────
    final water = (settings['water'] as num?)?.toDouble() ?? 0.0;
    if (water > 0.4) {
      parts.add('Include high-end plumbing fixtures and a premium undermount sink.');
    }

    // ── Sunlight ─────────────────────────────────────────────────────────
    final sunlight = (settings['sunlight'] as num?)?.toDouble() ?? 0.7;
    final lightDesc = sunlight > 0.6
        ? 'bright, sun-drenched'
        : sunlight > 0.3
            ? 'partially shaded, dappled light'
            : 'softly shaded, cool tones';
    parts.add('Kitchen has $lightDesc sunlight conditions.');

    // ── Cabinet size ────────────────────────────────────────────────────────
    final cabinetSize = (settings['cabinetSize'] as num?)?.toDouble() ?? 0.5;
    if (cabinetSize > 0.7) {
      parts.add('Include tall cabinets for maximum storage.');
    } else if (cabinetSize < 0.3) {
      parts.add('Low-profile cabinets to keep the space open.');
    }

    // ── Color vibrancy ───────────────────────────────────────────────────
    final vibrancy = (settings['colorVibrancy'] as num?)?.toDouble() ?? 0.6;
    if (vibrancy > 0.7) {
      parts.add('Bold, vibrant color palette with high saturation.');
    } else if (vibrancy < 0.3) {
      parts.add('Muted, neutral, and earthy tones throughout.');
    }

    // ── Flooring ─────────────────────────────────────────────────────────
    final pathwayIdx = (settings['pathway'] as num?)?.toInt() ?? 0;
    const houseFloors = [
      'polished hardwood',
      'rustic oak planks',
      'marble tiles',
      'ceramic slate',
      'polished concrete',
      'terracotta stones',
    ];
    if (pathwayIdx < houseFloors.length) {
      parts.add('Flooring is made of ${houseFloors[pathwayIdx]}.');
    }

    // ── Cabinet Finish ───────────────────────────────────────────────────
    final finishIdx = (settings['cabinetFinish'] as num?)?.toInt() ?? 0;
    const cabinetFinishes = [
      'matte finish',
      'high-gloss finish',
      'natural wood grain',
      'classic shaker style',
    ];
    if (finishIdx < cabinetFinishes.length) {
      parts.add(
          'Cabinetry features a ${cabinetFinishes[finishIdx]}.');
    }

    // ── Hardware Style ───────────────────────────────────────────────────
    final hardwareIdx = (settings['hardwareStyle'] as num?)?.toInt() ?? 0;
    const hardwareStyles = [
      'antique brass handles',
      'matte black minimalist hardware',
      'polished brushed nickel pulls',
      'modern integrated handle-less design',
    ];
    if (hardwareIdx < hardwareStyles.length) {
      parts.add(
          'Kitchen hardware consists of ${hardwareStyles[hardwareIdx]}.');
    }

    // ── Backsplash Design ────────────────────────────────────────────────
    final backsplashIdx = (settings['backsplashStyle'] as num?)?.toInt() ?? 0;
    const backsplashStyles = [
      'classic white subway tiles',
      'seamless marble slab',
      'intricate hexagon mosaic',
      'rustic exposed red brick',
    ];
    if (backsplashIdx < backsplashStyles.length) {
      parts.add(
          'The backsplash is designed with ${backsplashStyles[backsplashIdx]}.');
    }

    // ── Lighting fixture ─────────────────────────────────────────────────
    final lightingIdx = (settings['lighting'] as num?)?.toInt() ?? 0;
    const lightingNames = [
      'warm ambient lamps',
      'moonlight-style cool lighting',
      'fairy string lights',
      'directional spotlights',
      'decorative lanterns',
      'solar path lights',
    ];
    if (lightingIdx < lightingNames.length) {
      parts.add('Kitchen lighting uses ${lightingNames[lightingIdx]}.');
    }

    // ── Focal Point Appliance ────────────────────────────────────────────
    final waterFeatureIdx = (settings['waterFeature'] as num?)?.toInt() ?? -1;
    const focalAppliances = [
      'professional double oven',
      'modern French-door refrigerator',
      'commercial-grade range hood',
      'built-in espresso station',
      'integrated wine cooler',
      'luxury island workstation',
    ];
    if (waterFeatureIdx >= 0 && waterFeatureIdx < focalAppliances.length) {
      parts.add(
          'Include a decorative ${focalAppliances[waterFeatureIdx]} as a focal point.');
    }

    // ── Quality suffix ───────────────────────────────────────────────────
    parts.add(
      'Photorealistic result, professional interior photography, '
      'consistent lighting and realistic shadows, high resolution, 8K quality, '
      'maintaining exact same cabinetry proportions and room surroundings.',
    );

    return parts.join(' ');
  }
}

/// Thin wrapper that loads image bytes from a file path and calls the API.
class KitchenGenerationService {
  KitchenGenerationService()
      : _api = ReplicateKitchenAIService(
          filter: SafePromptFilter(mode: 'strict'),
        );

  final ReplicateKitchenAIService _api;

  /// [imagePath] — absolute path of the uploaded kitchen photo.
  /// [styleName] — selected style name.
  /// [settings]  — map of all custom-studio slider / picker values.
  Future<String?> generate({
    required String imagePath,
    required String styleName,
    required Map<String, dynamic> settings,
    GenerationConfig config = const GenerationConfig(),
  }) async {
    final bytes = await File(imagePath).readAsBytes();
    final prompt = KitchenPromptBuilder.build(
      styleName: styleName,
      settings: settings,
    );
    debugPrint('[KitchenGeneration] Prompt: $prompt');

    return _api.generateMultiBytes(
      images: [bytes],
      prompt: prompt,
      config: config,
    );
  }

  void dispose() => _api.dispose();
}
