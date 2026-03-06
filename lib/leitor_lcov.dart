import 'dart:io';

import 'package:leitor_lcov_poc/line_report.dart';

String coverage(lcov) {
  final file = File(lcov);
  final fileContent = file.readAsLinesSync();
  final reports = contentToLineReports(fileContent);
  return calculatePercent(reports);
}

String calculatePercent(List<LineReport> reports) {
  int totalLf = 0;
  int totalLh = 0;

  for (var report in reports) {
    totalLf += report.lineFound;
    totalLh += report.lineHit;
  }

  return '${((totalLh / totalLf) * 100).round()}%';
}

List<LineReport> contentToLineReports(List<String> content) {
  final reports = <LineReport>[];
  var sf = '';
  var lf = 0;
  var lh = 0;

  for (var text in content) {
    if (text == 'end_of_record') {
      final report = LineReport(sourceFile: sf, lineFound: lf, lineHit: lh);
      reports.add(report);
      continue;
    }
    final line = text.split(':');
    if (line[0] == 'SF') {
      sf = line[1];
    } else if (line[0] == 'LF') {
      lf = int.parse(line[1]);
    } else if (line[0] == 'LH') {
      lh = int.parse(line[1]);
    }
  }
  return reports;
}
