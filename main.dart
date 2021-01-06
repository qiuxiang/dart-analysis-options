// @dart=2.9
import 'package:yaml/yaml.dart';
import 'package:http/http.dart';

Future<List<String>> getRules(String url) async {
  final yaml = loadYaml((await get(url)).body);
  return List<String>.from(yaml['linter']['rules']);
}

main() async {
  var rules = await getRules(
      'https://raw.githubusercontent.com/tenhobi/effective_dart/master/lib/analysis_options.1.3.0.yaml');
  rules.addAll(await getRules(
      'https://raw.githubusercontent.com/google/pedantic/master/lib/analysis_options.1.9.0.yaml'));
  rules = rules.toSet().toList();
  rules.remove('public_member_api_docs');
  rules.addAll(['prefer_const_constructors', 'prefer_const_declarations']);
  rules.sort();
  print('linter:');
  print('  rules:');
  for (final r in rules) {
    print('    $r: true');
  }
}
