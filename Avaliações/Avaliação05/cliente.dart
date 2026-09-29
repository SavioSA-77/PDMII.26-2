import 'dart:convert';
import 'dart:io';

Future<void> main(List<String> arguments) async {
  final endpoint = Uri.parse(
    arguments.isEmpty ? 'http://localhost:8080/api/alunos' : arguments.first,
  );
  final client = HttpClient();

  try {
    final request = await client.getUrl(endpoint);
    final response = await request.close();
    final responseBody = await response.transform(utf8.decoder).join();

    if (response.statusCode != HttpStatus.ok) {
      throw HttpException(
        'Falha ao consultar alunos (HTTP ${response.statusCode}).',
        uri: endpoint,
      );
    }

    final payload = jsonDecode(responseBody) as Map<String, dynamic>;
    final alunos = payload['dados'] as List<dynamic>;

    for (final item in alunos) {
      final aluno = item as Map<String, dynamic>;
      final media = (aluno['media'] as num).toDouble();
      final faltas = aluno['faltas'] as int;
      final situacao = faltas > 20
          ? 'Reprovado por Faltas'
          : media < 6.0
          ? 'Reprovado'
          : 'Aprovado';

      print(
        'ID: ${aluno['id']} | Nome: ${aluno['nome']} | '
        'Disciplina: ${aluno['disciplina']} | Média: $media | '
        'Faltas: $faltas | Situação: $situacao',
      );
    }
  } finally {
    client.close();
  }
}
