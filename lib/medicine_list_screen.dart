import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VitaBelly',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MedicineListScreen(),
    );
  }
}

class MedicineListScreen extends StatefulWidget {
  @override
  _MedicineListScreenState createState() => _MedicineListScreenState();
}

class MedicineDetailScreen extends StatelessWidget {
  final Map<String, dynamic> medicine;

  MedicineDetailScreen({Key? key, required this.medicine}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle titleStyle = TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Theme.of(context).primaryColor);
    TextStyle contentStyle = TextStyle(fontSize: 14, color: Colors.black87);
    double spacing = 10.0;

    return Scaffold(
      appBar: AppBar(
        title: Text(medicine['제품명']),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: spacing),
            Text('제품명', style: titleStyle),
            SizedBox(height: spacing),
            Text('${medicine['제품명']}', style: contentStyle),
            SizedBox(height: spacing),
            Divider(thickness: 1),
            SizedBox(height: spacing),
            Text('성분명', style: titleStyle),
            SizedBox(height: spacing),
            Text('${medicine['성분명']}', style: contentStyle),
            SizedBox(height: spacing),
            Divider(thickness: 1),
            SizedBox(height: spacing),
            Text('성분코드', style: titleStyle),
            SizedBox(height: spacing),
            Text('${medicine['성분코드']}', style: contentStyle),
            SizedBox(height: spacing),
            Divider(thickness: 1),
            SizedBox(height: spacing),
            Text('제품코드', style: titleStyle),
            SizedBox(height: spacing),
            Text('${medicine['제품코드']}', style: contentStyle),
            SizedBox(height: spacing),
            Divider(thickness: 1),
            SizedBox(height: spacing),
            Text('업체명', style: titleStyle),
            SizedBox(height: spacing),
            Text('${medicine['업체명']}', style: contentStyle),
            SizedBox(height: spacing),
            Divider(thickness: 1),
            SizedBox(height: spacing),
            Text('고시일자', style: titleStyle),
            SizedBox(height: spacing),
            Text('${medicine['고시일자']}', style: contentStyle),
            SizedBox(height: spacing),
            Divider(thickness: 1),
            SizedBox(height: spacing),
            Text('고시번호', style: titleStyle),
            SizedBox(height: spacing),
            Text('${medicine['고시번호']}', style: contentStyle),
            SizedBox(height: spacing),
            Divider(thickness: 1),
            SizedBox(height: spacing),
            Text('금기등급', style: titleStyle),
            SizedBox(height: spacing),
            Text('${medicine['금기등급']}', style: contentStyle),
            SizedBox(height: spacing),
            Divider(thickness: 1),
            SizedBox(height: spacing),
            Text('상세정보', style: titleStyle),
            SizedBox(height: spacing),
            Text('${medicine['상세정보']}', style: contentStyle),
            SizedBox(height: spacing),
            Divider(thickness: 1),
          ],
        ),
      ),
    );
  }
}

class _MedicineListScreenState extends State<MedicineListScreen> {
  List<dynamic> _medicines = [];
  List<dynamic> _filteredMedicines = [];
  String _sortType = '금기등급';

  @override
  void initState() {
    super.initState();
    loadMedicineData();
  }

  Future<void> loadMedicineData() async {
    String jsonString =
        await rootBundle.loadString('assets/vitabelly_medicine_list_data.json');
    final jsonResponse = json.decode(jsonString);
    setState(() {
      _medicines = jsonResponse;
      _filteredMedicines = jsonResponse;
      sortMedicineData(_sortType);
    });
  }

  void sortMedicineData(String sortType) {
    setState(() {
      if (sortType == '금기등급') {
        _filteredMedicines.sort(
            (a, b) => a['금기등급'].toString().compareTo(b['금기등급'].toString()));
      } else if (sortType == '제품명') {
        _filteredMedicines.sort((a, b) => a['제품명'].compareTo(b['제품명']));
      } else if (sortType == '업체명') {
        _filteredMedicines.sort((a, b) => a['업체명'].compareTo(b['업체명']));
      }
      _sortType = sortType;
    });
  }

  void searchMedicine(String query) {
    final suggestions = _medicines.where((medicine) {
      final medicineName = medicine['제품명'].toLowerCase();
      final input = query.toLowerCase();
      return medicineName.contains(input);
    }).toList();

    setState(() {
      _filteredMedicines = suggestions;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('임신 중 금기 의약품 목록'),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                border: OutlineInputBorder(),
                hintText: '궁금한 의약품을 검색해보세요!',
              ),
              onChanged: searchMedicine,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <String>['금기등급', '제품명', '업체명'].map((String value) {
                return Expanded(
                  child: RadioListTile<String>(
                    title: Text('$value순', style: TextStyle(fontSize: 12)),
                    value: value,
                    groupValue: _sortType,
                    onChanged: (String? newValue) {
                      sortMedicineData(newValue!);
                    },
                    dense: true,
                    contentPadding: EdgeInsets.symmetric(horizontal: 2.0),
                  ),
                );
              }).toList(),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _filteredMedicines.length,
              itemBuilder: (context, index) {
                var medicine = _filteredMedicines[index];
                return ListTile(
                  title: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: '${medicine['제품명']} ',
                          style: TextStyle(fontSize: 16),
                        ),
                        TextSpan(
                          text: ' ${medicine['성분명']} ',
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                        WidgetSpan(
                          child: Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                              color: medicine['금기등급'] == 1
                                  ? Colors.red
                                  : Colors.yellow,
                              shape: BoxShape.circle,
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              '${medicine['금기등급']}',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  subtitle: Text(
                    medicine['업체명'],
                    style: TextStyle(
                      color: Colors.grey.shade500,
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            MedicineDetailScreen(medicine: medicine),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
