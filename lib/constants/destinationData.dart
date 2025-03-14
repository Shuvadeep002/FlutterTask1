import 'destination_data_model.dart';

final List<Destination> mostViewDestinations = [
  Destination(
    id: 1,
    title: 'Mount Fuji, Tokyo',
    location: 'Tokyo, Japan',
    rating: '4.8',
    imagePath: 'assets/images/picture1.png',
    overview: 'Mount Fuji is an iconic volcanic mountain known for its symmetrical cone shape and spiritual significance.',
    details: 'Mount Fuji is Japan\'s tallest mountain at 3,776 meters. It is considered sacred and is a popular destination for climbers and tourists. The best time to visit is during the summer months when the weather is stable.',
    temperature: '10°C',
    travelTime: '2 hours',
    minimumPrice: '\$150', // Added dollar sign
  ),
  Destination(
    id: 2,
    title: 'Andes Mountain',
    location: 'South America',
    rating: '4.5',
    imagePath: 'assets/images/picture2.png',
    overview: 'The Andes is the longest continental mountain range in the world, stretching over 7,000 km.',
    details: 'The Andes are home to diverse ecosystems, including rainforests and high-altitude deserts. Popular spots include Machu Picchu, Cusco, and Patagonia. The region offers excellent trekking and climbing opportunities.',
    temperature: '-5°C',
    travelTime: '1.5 hours',
    minimumPrice: '\$230', // Added dollar sign
  ),
  Destination(
    id: 3,
    title: 'Grand Canyon',
    location: 'Arizona, USA',
    rating: '4.9',
    imagePath: 'assets/images/picture3.jpg',
    overview: 'A massive canyon carved by the Colorado River, known for its layered red rock formations.',
    details: 'The Grand Canyon is 446 km long and over 1.6 km deep. It offers breathtaking views, hiking trails, and rafting opportunities. The South Rim is the most visited part of the canyon.',
    temperature: '15°C',
    travelTime: '4 hours',
    minimumPrice: '\$120', // Added dollar sign
  ),
  Destination(
    id: 4,
    title: 'Mount Everest',
    location: 'Nepal',
    rating: '5.0',
    imagePath: 'assets/images/picture4.jpg',
    overview: 'The tallest mountain in the world, standing at 8,848 meters above sea level.',
    details: 'Mount Everest is located in the Himalayas and attracts climbers from all over the world. Climbing season is typically from late April to early June. The journey includes acclimatization at base camps and navigating challenging weather and terrain.',
    temperature: '-20°C',
    travelTime: '6 hours',
    minimumPrice: '\$500', // Added dollar sign
  ),
];

final List<Destination> nearestDestinations = [
  Destination(
    id: 4,
    title: 'Mount Everest',
    location: 'Nepal',
    rating: '5.0',
    imagePath: 'assets/images/picture4.jpg',
    overview: 'The tallest mountain in the world, standing at 8,848 meters above sea level.',
    details: 'Mount Everest is located in the Himalayas and attracts climbers from all over the world. Climbing season is typically from late April to early June. The journey includes acclimatization at base camps and navigating challenging weather and terrain.',
    temperature: '-20°C',
    travelTime: '6 hours',
    minimumPrice: '\$500', // Added dollar sign
  ),
];

final List<Destination> latestDestinations = [
  Destination(
    id: 3,
    title: 'Grand Canyon',
    location: 'Arizona, USA',
    rating: '4.9',
    imagePath: 'assets/images/picture3.jpg',
    overview: 'A massive canyon carved by the Colorado River, known for its layered red rock formations.',
    details: 'The Grand Canyon is 446 km long and over 1.6 km deep. It offers breathtaking views, hiking trails, and rafting opportunities. The South Rim is the most visited part of the canyon.',
    temperature: '15°C',
    travelTime: '4 hours',
    minimumPrice: '\$120', // Added dollar sign
  ),
  Destination(
    id: 4,
    title: 'Mount Everest',
    location: 'Nepal',
    rating: '5.0',
    imagePath: 'assets/images/picture4.jpg',
    overview: 'The tallest mountain in the world, standing at 8,848 meters above sea level.',
    details: 'Mount Everest is located in the Himalayas and attracts climbers from all over the world. Climbing season is typically from late April to early June. The journey includes acclimatization at base camps and navigating challenging weather and terrain.',
    temperature: '-20°C',
    travelTime: '6 hours',
    minimumPrice: '\$500', // Added dollar sign
  ),
];
