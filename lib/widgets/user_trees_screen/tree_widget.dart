import 'package:breathe_green_final/services/date_time.dart';
import 'package:flutter/material.dart';

import '../../services/models.dart';

class TreeWidget extends StatelessWidget {
  const TreeWidget({required this.tree, super.key});

  final Tree tree;

  @override
  Widget build(BuildContext context) {
    final Map<String, Color?> statusColorIndex = {
      "Under review": Colors.grey[400],
      "Approved": Colors.green[400],
      "Denied": Colors.red[400],
    };
    return Column(
      children: [
        const Divider(color: Colors.black),
        Padding(
          padding: const EdgeInsets.all(10),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  DateTimeService().formatDateTime(tree.date),
                  style: const TextStyle(
                      fontWeight: FontWeight.w800, fontSize: 20),
                ),
                const SizedBox(height: 8),
                Text(
                  "Coordinates: ${tree.coord.lat}, ${tree.coord.lon}",
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
                const SizedBox(height: 8),
                Container(
                  decoration: BoxDecoration(
                    color: statusColorIndex[tree.status],
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    child: Text(
                      tree.status,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              ],
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                tree.imageObject.url,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return SizedBox(
                    width: 100,
                    height: 100,
                    child: Center(
                      child: CircularProgressIndicator(
                        valueColor: const AlwaysStoppedAnimation(Colors.green),
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                            : null,
                      ),
                    ),
                  );
                },
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
            )
          ]),
        ),
      ],
    );
  }
}
