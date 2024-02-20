import 'package:flutter/material.dart';
import '../data/schedule_data.dart';

void main() => runApp(VitaBellyApp());

class VitaBellyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VitaBelly',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: PregnancyTestScheduleScreen(),
    );
  }
}

class CustomDataCell extends StatelessWidget {
  final String text;
  final TextStyle? textStyle;

  const CustomDataCell({
    required this.text,
    this.textStyle,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextStyle effectiveTextStyle = textStyle?.copyWith(fontSize: 11) ??
        TextStyle(
          fontSize: 11,
        );

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
      child: Text(
        text,
        style: effectiveTextStyle,
        softWrap: true,
      ),
    );
  }
}

class PregnancyTestScheduleScreen extends StatelessWidget {
  final int currentWeek = 17;

  bool isCurrentWeekInRange(String period) {
    final RegExp regExp = RegExp(r'(\d+)~(\d+)주');
    final match = regExp.firstMatch(period);

    if (match != null && match.groupCount == 2) {
      final startWeek = int.parse(match.group(1)!);
      final endWeek = int.parse(match.group(2)!);
      return currentWeek >= startWeek && currentWeek <= endWeek;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    List<DataRow> buildRows() {
      return ScheduleData.data.map((dataEntry) {
        final highlight = isCurrentWeekInRange(dataEntry['period']!);

        return DataRow(
          color: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
              if (highlight) return Color(0xFFFCDBDB);
              return null;
            },
          ),
          cells: [
            DataCell(CustomDataCell(text: dataEntry['period']!)),
            DataCell(CustomDataCell(text: dataEntry['testType']!)),
            DataCell(CustomDataCell(text: dataEntry['description']!)),
          ],
        );
      }).toList();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('임신개월별검사'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  Divider(color: Colors.grey),
                  Align(
                    alignment: Alignment.centerRight,
                    child: RichText(
                      text: TextSpan(
                        text: '현재 ',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: '$currentWeek주',
                            style: TextStyle(
                              color: Color(0xFFF37777),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Divider(color: Colors.grey),
                ],
              ),
            ),
            DataTable(
              columnSpacing: 38.0,
              dataRowMaxHeight: double.infinity,
              columns: const [
                DataColumn(label: Text('검사시기', textAlign: TextAlign.center)),
                DataColumn(label: Text('검사종류', textAlign: TextAlign.center)),
                DataColumn(label: Text('설명', textAlign: TextAlign.center)),
              ],
              rows: buildRows(),
            ),
          ],
        ),
      ),
    );
  }
}
