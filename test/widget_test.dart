import 'package:flutter_test/flutter_test.dart';
import 'package:leitor_lcov_poc/leitor_lcov.dart';
import 'package:leitor_lcov_poc/line_report.dart';

void main() {
  test('Deve encontrar a porcentagem de cobertura', () {
    final result = coverage('./coverage/lcov.info');
    expect(result, '100%');
  });

  test('Deve calcular a porcentagem de cobertura', () {
    final result = calculatePercent([
      LineReport(sourceFile: '', lineFound: 18, lineHit: 9),
      LineReport(sourceFile: '', lineFound: 64, lineHit: 32)
    ]);
    expect(result, '50%');
  });
}
