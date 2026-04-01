import 'package:flutter/foundation.dart';
import '../models/domain_model.dart';
import '../services/domain_service.dart';

enum DomainState { idle, loading, success, error }

class DomainViewModel extends ChangeNotifier {
  final DomainService _service = DomainService();

  DomainState _state = DomainState.idle;
  DomainModel? _domain;
  String _errorMessage = '';
  List<String> _history = [];

  DomainState get state => _state;
  DomainModel? get domain => _domain;
  String get errorMessage => _errorMessage;
  List<String> get history => List.unmodifiable(_history);

  bool isValidDomain(String domain) {
    final regex = RegExp(
      r'^(?:[a-zA-Z0-9](?:[a-zA-Z0-9\-]{0,61}[a-zA-Z0-9])?\.)+[a-zA-Z]{2,}$',
    );
    return regex.hasMatch(domain.trim());
  }

  Future<void> searchDomain(String domain) async {
    final trimmed = domain.trim().toLowerCase();

    if (!isValidDomain(trimmed)) {
      _state = DomainState.error;
      _errorMessage = 'Domínio inválido. Exemplo: meusite.com.br';
      notifyListeners();
      return;
    }

    _state = DomainState.loading;
    _domain = null;
    _errorMessage = '';
    notifyListeners();

    try {
      _domain = await _service.fetchDomain(trimmed);
      _state = DomainState.success;

      if (!_history.contains(trimmed)) {
        _history.insert(0, trimmed);
        if (_history.length > 10) _history = _history.sublist(0, 10);
      }
    } catch (e) {
      _state = DomainState.error;
      _errorMessage = e.toString().replaceFirst('Exception: ', '');
    }

    notifyListeners();
  }

  void reset() {
    _state = DomainState.idle;
    _domain = null;
    _errorMessage = '';
    notifyListeners();
  }
}