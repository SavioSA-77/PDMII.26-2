import 'dart:convert';
class Dependente {
  late String _nome;

  Dependente(String nome) {
    this._nome = nome;
  }

  Map<String, dynamic> toJson() {
    return {'nome': _nome};
  }
}

class Funcionario {
  late String _nome;
  late List<Dependente> _dependentes;

  Funcionario(String nome, List<Dependente> dependentes) {
    this._nome = nome;
    this._dependentes = dependentes;
  }

  Map<String, dynamic> toJson() {
    return {
      'nome': _nome,
      'dependentes': _dependentes.map((dependente) => dependente.toJson()).toList(),
    };
  }
}

class EquipeProjeto {
  late String _nomeProjeto;
  late List<Funcionario> _funcionarios;

  EquipeProjeto(String nomeprojeto, List<Funcionario> funcionarios) {
    _nomeProjeto = nomeprojeto;
    _funcionarios = funcionarios;
  }

  Map<String, dynamic> toJson() {
    return {
      'nomeProjeto': _nomeProjeto,
      'funcionarios': _funcionarios.map((funcionario) => funcionario.toJson()).toList(),
    };
  }
}

void main() {
  // 1. Criar varios objetos Dependentes
  Dependente dep1 = Dependente("João");
  Dependente dep2 = Dependente("Maria");
  Dependente dep3 = Dependente("Pedro");  
  // 2. Criar varios objetos Funcionario
  // 3. Associar os Dependentes criados aos respectivos funcionarios
  Funcionario func1 = Funcionario("Carlos", [dep1, dep2]);
  Funcionario func2 = Funcionario("Ana", [dep3]);
  // 4. Criar uma lista de Funcionarios
  List<Funcionario> listaFuncionarios = [func1, func2];
  // 5. criar um objeto Equipe Projeto chamando o metodo
  //    contrutor que da nome ao projeto e insere uma
  //    coleção de funcionario
  EquipeProjeto equipe = EquipeProjeto("Projeto X", listaFuncionarios);
  // 6. Printar no formato JSON o objeto Equipe Projeto.
   String jsonStr = JsonEncoder.withIndent('  ').convert(equipe.toJson());
   print(jsonStr);
}
