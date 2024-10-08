import 'package:flutter/material.dart';
import 'package:localies_app/screens/store_details_page.dart';
import '../models/store.dart';

class StoreListCard extends StatelessWidget {
  final Store store;
  final List<double> rating = [3.7, 4.2, 4.4, 3.2, 4.3, 4.9];

  final List<IconData> _icons = [
    Icons.pedal_bike,
    Icons.directions_bike_outlined,
    Icons.motorcycle_outlined,
    Icons.score_outlined,
    Icons.shopping_bag_outlined,
  ];

  IconData _getIcons() {
    int index = store.longitude.hashCode % _icons.length;
    return _icons[index];
  }

  StoreListCard({super.key, required this.store});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
              builder: (context) => StoreDetailsScreen(store: store)),
        );
      },
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Container(
          height: 120,
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Icon(
                  _getIcons(),
                  size: 60,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      store.name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      store.address,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.location_on,
                                size: 16, color: Colors.blue),
                            SizedBox(width: 4),
                            Text(
                              "0.0 km",
                              // '${distance.toStringAsFixed(1)} km',
                              style: TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(Icons.star, size: 16, color: Colors.amber),
                            SizedBox(width: 4),
                            Text(
                              // //randomizer in decimal which will give a rating between 3.0 to 5.0
                              '${rating[store.longitude.hashCode % rating.length]}',
                              style: TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
