import '../models/kitchen_style.dart';
import '../models/kitchen_model.dart';

class MockData {
  static const List<KitchenStyle> styles = [
    KitchenStyle(
      id: '1',
      name: 'Minimalist Kitchen',
      description: 'Clean lines, hidden appliances, and a minimalist aesthetic with sleek cabinetry and natural light.',
      imagePath: 'assets/images/style_minimalist.jpeg',
      category: 'Minimal',
      tags: ['Sleek', 'Modern', 'Clean'],
      popularity: 4.8,
      difficulty: 'Easy',
      estimatedTime: '1-2 hours',
      keyFeatures: ['Sleek countertops', 'Hidden appliances', 'Handleless cabinets', 'Recessed lighting'],
      moodDescription: 'Find clarity in simplicity',
    ),
    KitchenStyle(
      id: '2',
      name: 'Farmhouse Kitchen',
      description: 'Rustic and cozy kitchen with a large apron sink, open shelving, and warm wood tones.',
      imagePath: 'assets/images/style_farmhouse.jpeg',
      category: 'Classic',
      tags: ['Cozy', 'Rustic', 'Heritage'],
      popularity: 4.6,
      difficulty: 'Medium',
      estimatedTime: '3-4 hours',
      keyFeatures: ['Apron sink', 'Open shelving', 'Butcher block', 'Vintage fixtures'],
      moodDescription: 'Step into a cozy, rustic home',
    ),
    KitchenStyle(
      id: '3',
      name: 'Industrial Kitchen',
      description: 'Edgy and urban kitchen featuring exposed brick, stainless steel, and concrete elements.',
      imagePath: 'assets/images/style_industrial.jpeg',
      category: 'Modern',
      tags: ['Urban', 'Metal', 'Loft'],
      popularity: 4.7,
      difficulty: 'Hard',
      estimatedTime: '4-6 hours',
      keyFeatures: ['Exposed brick', 'Stainless steel', 'Concrete counters', 'Pendant lights'],
      moodDescription: 'Your personal urban culinary space',
    ),
    KitchenStyle(
      id: '6',
      name: 'Mediterranean Kitchen',
      description: 'Warm colors, textured walls, and intricate tile work inspired by coastal European homes.',
      imagePath: 'assets/images/style_mediterranean.jpeg',
      category: 'Classic',
      tags: ['Warm', 'Ceramic', 'European'],
      popularity: 4.7,
      difficulty: 'Medium',
      estimatedTime: '3-4 hours',
      keyFeatures: ['Terracotta tiles', 'Textured walls', 'Arched doorways', 'Copper accents'],
      moodDescription: 'Tuscan warmth in your home',
    ),
    KitchenStyle(
      id: '7',
      name: 'Scandinavian Kitchen',
      description: 'Light, airy, and functional kitchen with light woods, white palettes, and simple forms.',
      imagePath: 'assets/images/style_scandinavian.jpeg',
      category: 'Modern',
      tags: ['Light', 'Functional', 'Nordic'],
      popularity: 4.3,
      difficulty: 'Easy',
      estimatedTime: '2-3 hours',
      keyFeatures: ['Light woods', 'White palette', 'Simple forms', 'Natural light'],
      moodDescription: 'Beauty in functional design',
    ),
    KitchenStyle(
      id: '11',
      name: 'Mid-Century Modern Kitchen',
      description: 'Retro-inspired kitchen with flat-panel cabinets, geometric shapes, and vibrant pops of color.',
      imagePath: 'assets/images/style_midcentury.jpeg',
      category: 'Modern',
      tags: ['Retro', 'Pop', 'Geometric'],
      popularity: 4.8,
      difficulty: 'Hard',
      estimatedTime: '4-5 hours',
      keyFeatures: ['Flat panels', 'Geometric shapes', 'Vibrant colors', 'Retro fixtures'],
      moodDescription: 'Retro style with modern function',
    ),
    KitchenStyle(
      id: '12',
      name: 'Tropical Kitchen',
      description: 'Breezy and relaxing kitchen with soft blues, whites, and natural textures like rattan and jute.',
      imagePath: 'assets/images/style_tropical.jpeg',
      category: 'Lush',
      tags: ['Breezy', 'Exotic', 'Natural'],
      popularity: 4.4,
      difficulty: 'Easy',
      estimatedTime: '2-3 hours',
      keyFeatures: ['Teak wood', 'Rattan accents', 'Lush greenery', 'Open air'],
      moodDescription: 'Breezy relaxation at home',
    ),
  ];

  static const List<Map<String, dynamic>> kitchenCategories = [
    {'name': 'Cabinets', 'icon': '🚪', 'count': 24},
    {'name': 'Countertops', 'icon': '🪨', 'count': 48},
    {'name': 'Appliances', 'icon': '🍳', 'count': 32},
    {'name': 'Flooring', 'icon': '🪵', 'count': 16},
    {'name': 'Lighting', 'icon': '💡', 'count': 12},
    {'name': 'Sinks', 'icon': '🚰', 'count': 20},
    {'name': 'Backsplash', 'icon': '🧱', 'count': 18},
    {'name': 'Hardware', 'icon': '🔩', 'count': 8},
  ];

  static const List<Map<String, dynamic>> materialOptions = [
    {'name': 'Granite', 'icon': '🪨'},
    {'name': 'Hardwood', 'icon': '🪵'},
    {'name': 'Marble', 'icon': '⚪'},
    {'name': 'Ceramic', 'icon': '🧱'},
    {'name': 'Quartz', 'icon': '⬜'},
    {'name': 'Laminate', 'icon': '🔲'},
  ];

  static const List<Map<String, dynamic>> lightingOptions = [
    {'name': 'Warm Ambient', 'icon': '💡', 'temp': '2700K'},
    {'name': 'Moonlight', 'icon': '🌙', 'temp': '4000K'},
    {'name': 'Fairy Lights', 'icon': '✨', 'temp': '2200K'},
    {'name': 'Spotlights', 'icon': '🔦', 'temp': '3000K'},
    {'name': 'Lanterns', 'icon': '🏮', 'temp': '2500K'},
    {'name': 'Solar Path', 'icon': '☀️', 'temp': '3500K'},
  ];

  static const List<Map<String, dynamic>> applianceFeatures = [
    {'name': 'Double Oven', 'icon': '🔥'},
    {'name': 'French Door Fridge', 'icon': '❄️'},
    {'name': 'Range Hood', 'icon': '💨'},
    {'name': 'Espresso Station', 'icon': '☕'},
    {'name': 'Wine Cooler', 'icon': '🍷'},
    {'name': 'Island Workstation', 'icon': '🏗️'},
  ];

  static const List<Map<String, dynamic>> cabinetFinishes = [
    {'name': 'Matte', 'icon': '⬜'},
    {'name': 'Glossy', 'icon': '✨'},
    {'name': 'Natural Wood', 'icon': '🪵'},
    {'name': 'Shaker Style', 'icon': '🖼️'},
  ];

  static const List<Map<String, dynamic>> hardwareStyles = [
    {'name': 'Antique Brass', 'icon': '🟡'},
    {'name': 'Matte Black', 'icon': '⚫'},
    {'name': 'Brushed Nickel', 'icon': '⚪'},
    {'name': 'Integrated', 'icon': '➖'},
  ];

  static const List<Map<String, dynamic>> backsplashStyles = [
    {'name': 'Subway Tile', 'icon': '🧱'},
    {'name': 'Marble Slab', 'icon': '⚪'},
    {'name': 'Hexagon Mosaic', 'icon': '💠'},
    {'name': 'Exposed Brick', 'icon': '🧱'},
  ];

  // Empty initial history — real history comes from storage
  static List<KitchenModel> get initialHistory => [];
}
