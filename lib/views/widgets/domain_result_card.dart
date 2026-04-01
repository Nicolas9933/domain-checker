import 'package:flutter/material.dart';
import '../../models/domain_model.dart';
import 'status_badge.dart';

class DomainResultCard extends StatelessWidget {
  final DomainModel domain;

  const DomainResultCard({super.key, required this.domain});

  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(width: 150,
              child: Text(label, style: const TextStyle(fontWeight: FontWeight.w600, color: Colors.black54))),
          Expanded(child: Text(value, style: const TextStyle(fontWeight: FontWeight.w500))),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              const Icon(Icons.language, color: Colors.indigo, size: 28),
              const SizedBox(width: 10),
              Expanded(child: Text(domain.fqdn,
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.indigo))),
            ]),
            const Divider(height: 24),
            StatusBadge(statusCode: domain.statusCode),
            const SizedBox(height: 16),
            if (domain.expiresAt != null) _infoRow('Expira em:', domain.expiresAt!),
            if (domain.publicationStatus != null) _infoRow('Publicação:', domain.publicationStatus!),
            _infoRow('Código de status:', domain.statusCode.toString()),
            if (domain.hosts.isNotEmpty) ...[
              const Divider(height: 24),
              const Text('Hosts:', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              ...domain.hosts.map((h) => Padding(
                padding: const EdgeInsets.only(left: 8, bottom: 4),
                child: Row(children: [
                  const Icon(Icons.dns, size: 16, color: Colors.grey),
                  const SizedBox(width: 6),
                  Text(h),
                ]),
              )),
            ],
            if (domain.suggestions.isNotEmpty) ...[
              const Divider(height: 24),
              const Text('Sugestões disponíveis:', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Wrap(spacing: 8, runSpacing: 6,
                children: domain.suggestions.map((s) => Chip(
                  label: Text(s),
                  backgroundColor: Colors.green.shade50,
                  side: BorderSide(color: Colors.green.shade200),
                )).toList(),
              ),
            ],
            if (domain.reasons.isNotEmpty) ...[
              const Divider(height: 24),
              const Text('Motivos:', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              ...domain.reasons.map((r) => Padding(
                padding: const EdgeInsets.only(left: 8, bottom: 4),
                child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  const Icon(Icons.info_outline, size: 16, color: Colors.orange),
                  const SizedBox(width: 6),
                  Expanded(child: Text(r)),
                ]),
              )),
            ],
          ],
        ),
      ),
    );
  }
}