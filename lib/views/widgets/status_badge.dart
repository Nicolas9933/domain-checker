import 'package:flutter/material.dart';
import '../../models/domain_model.dart';

class StatusBadge extends StatelessWidget {
  final int statusCode;

  const StatusBadge({super.key, required this.statusCode});

  Color _getColor() {
    switch (statusCode) {
      case 0: case 1: return Colors.green;
      case 2: return Colors.blue;
      case 3: case 4: return Colors.red;
      case 5: case 6: case 7: case 9: return Colors.orange;
      case 8: return Colors.red.shade900;
      default: return Colors.grey;
    }
  }

  IconData _getIcon() {
    switch (statusCode) {
      case 0: case 1: return Icons.check_circle;
      case 2: return Icons.lock;
      case 3: case 4: return Icons.cancel;
      case 5: case 6: case 7: case 9: return Icons.hourglass_empty;
      case 8: return Icons.error;
      default: return Icons.help;
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = _getColor();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color, width: 1.5),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(_getIcon(), color: color, size: 18),
          const SizedBox(width: 6),
          Text(DomainModel.statusDescription(statusCode),
              style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 14)),
        ],
      ),
    );
  }
}