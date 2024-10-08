import 'package:localies_app/models/product.dart';
import 'package:localies_app/models/store.dart';

class DbService {
  static Future<List<Store>> getStores() async {
    await Future.delayed(const Duration(seconds: 2));
    return [
      Store(
        name: 'Phoenix Helmet Shop',
        address: 'Parda Bagh, Daryaganj, Delhi, 110002',
        contactNumber: '4342312312',
        description: 'Phoenix Helmet Shop, Buy Helmets at best price',
        openingHours: '9:00 AM - 6:00 PM',
        latitude: 28.648258,
        longitude: 77.242599,
        products: [
          Product(name: "Cobra 232", price: 4609.0, availability: true),
          Product(name: "Beta Visor pro", price: 8210.0, availability: false),
        ],
      ),
      Store(
        name: 'Extreme Helmets',
        address: 'M6H4+G4M, Kamla Nagar, Delhi, 110007',
        contactNumber: '1234567890',
        description: 'Extreme Helmets: Bike Enthusiasts, this is for you',
        openingHours: '9:00 AM - 6:00 PM',
        latitude: 28.677893,
        longitude: 77.205075,
        products: [
          Product(name: "ZX 470", price: 3200.0, availability: true),
          Product(name: "Knine 41 fifty", price: 5200.0, availability: false),
        ],
      ),
      Store(
        name: 'Helmet Junction',
        address: 'Cannaught Place, New Delhi',
        contactNumber: '7868686878',
        description:
            'Helmet Junction is a place where you can find all types of Helmet and accessories',
        openingHours: '9:00 AM - 6:00 PM',
        latitude: 28.631211,
        longitude: 77.222852,
        products: [
          Product(name: "Axor F1", price: 4500.0, availability: true),
          Product(name: "Cobra 67", price: 6700.0, availability: false),
        ],
      ),
      Store(
        name: 'Kishore Helmets',
        address: 'Block A, Motia Khan, Sadar Bazaar, Delhi, 110055',
        contactNumber: '23232323232',
        description: 'Kishore Helmets: Helmets for everyone',
        openingHours: '9:00 AM - 6:00 PM',
        latitude: 28.650583,
        longitude: 77.205371,
        products: [
          Product(name: "Adonis zhe2", price: 7003.0, availability: true),
          Product(name: "Thunderbolt 24s", price: 2300.0, availability: false),
        ],
      ),
      Store(
        name: 'AZ Helmets',
        address:
            'Block E 4, Jhandewalan Extension, Karol Bagh, New Delhi, Delhi 110005',
        contactNumber: '5454545454',
        description:
            'AZ Helmets is helmet world full of helmets. Come and visit us',
        openingHours: '9:00 AM - 6:00 PM',
        latitude: 28.646223,
        longitude: 77.205004,
        products: [
          Product(name: "SteelBird SBA 2", price: 2000.0, availability: true),
          Product(name: "Studd 4969", price: 4200.0, availability: false),
        ],
      ),
      Store(
        name: 'Helmet World',
        address: 'Block 4, Karol Bagh, New Delhi, Delhi 110005',
        contactNumber: '7878787878',
        description: 'Helmet World: Helmets for all',
        openingHours: '9:00 AM - 6:00 PM',
        latitude: 28.656943,
        longitude: 77.205704,
        products: [
          Product(name: "SteelBird SBA 2", price: 2000.0, availability: true),
          Product(name: "Studd 4969", price: 4200.0, availability: false),
        ],
      ),
    ];
  }
}
