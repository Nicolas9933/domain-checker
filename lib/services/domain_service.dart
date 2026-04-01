import 'package:dio/dio.dart';
import '../models/domain_model.dart';

class DomainService {
  final Dio _dio;

  DomainService()
      : _dio = Dio(BaseOptions(
          baseUrl: 'https://brasilapi.com.br/api',
          connectTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 10),
        ));

  Future<DomainModel> fetchDomain(String domain) async {
    try {
      final response = await _dio.get('/registrobr/v1/$domain');
      return DomainModel.fromJson(response.data);
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        throw Exception('Domínio não encontrado.');
      } else if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        throw Exception('Tempo de conexão esgotado. Tente novamente.');
      } else {
        throw Exception('Erro na requisição: ${e.message}');
      }
    } catch (e) {
      throw Exception('Erro inesperado: $e');
    }
  }
}