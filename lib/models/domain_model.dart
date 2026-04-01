class DomainModel {
  final String fqdn;
  final String status;
  final int statusCode;
  final String? expiresAt;
  final String? publicationStatus;
  final List<String> hosts;
  final List<String> suggestions;
  final List<String> reasons;

  DomainModel({
    required this.fqdn,
    required this.status,
    required this.statusCode,
    this.expiresAt,
    this.publicationStatus,
    this.hosts = const [],
    this.suggestions = const [],
    this.reasons = const [],
  });

  factory DomainModel.fromJson(Map<String, dynamic> json) {
    return DomainModel(
      fqdn: json['fqdn'] ?? '',
      status: json['status'] ?? '',
      statusCode: json['status-code'] ?? json['statusCode'] ?? 10,
      expiresAt: json['expires-at'],
      publicationStatus: json['publication-status'],
      hosts: List<String>.from(json['hosts'] ?? []),
      suggestions: List<String>.from(json['suggestions'] ?? []),
      reasons: List<String>.from(json['reasons'] ?? []),
    );
  }

  static String statusDescription(int code) {
    const map = {
      0: 'Disponível',
      1: 'Disponível (com tickets concorrentes)',
      2: 'Já registrado',
      3: 'Indisponível',
      4: 'Inválido',
      5: 'Aguardando processo de liberação',
      6: 'Em processo de liberação',
      7: 'Em processo de liberação (com tickets concorrentes)',
      8: 'Erro',
      9: 'Processo competitivo de liberação',
      10: 'Desconhecido',
    };
    return map[code] ?? 'Desconhecido';
  }
}