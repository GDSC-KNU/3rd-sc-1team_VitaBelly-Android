import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() => runApp(MaterialApp(home: HousekeepingServicesScreen()));

class Housekeeper {
  final String name;
  final String description;
  final String serviceLocation;
  final String imagePath;
  final double hourlyRate;
  final String skills;
  final String languages;
  final String availability;
  final String certifications;
  bool isFavorite;

  Housekeeper({
    required this.name,
    required this.description,
    required this.serviceLocation,
    required this.imagePath,
    required this.hourlyRate,
    required this.skills,
    required this.languages,
    required this.availability,
    required this.certifications,
    this.isFavorite = false,
  });

  String get formattedHourlyRate =>
      NumberFormat('#,###', 'ko_KR').format(hourlyRate);
}

final List<Housekeeper> housekeepers = [
  Housekeeper(
    name: "김민지",
    description: "10년 경력의 전문 가사 도우미, 세심한 청소와 정돈으로 깨끗한 집을 만들어 드립니다.",
    serviceLocation: "서울특별시 강남구",
    imagePath: "assets/vitabelly_housekeeper1.png",
    hourlyRate: 25000,
    skills: "청소, 빨래, 요리",
    languages: "한국어, 기본 영어",
    availability: "월 - 금, 오전 9시 - 오후 6시",
    certifications: "전문 청소 인증",
    isFavorite: false,
  ),
  Housekeeper(
    name: "최유리",
    description: "유아 돌봄 가능. 가사 일과 아이 돌보기를 원활히 병행하여 가정에 활력을 더합니다.",
    serviceLocation: "대구광역시 중구",
    imagePath: "assets/vitabelly_housekeeper2.png",
    hourlyRate: 20000,
    skills: "유아 돌봄, 가벼운 요리, 집안 정리",
    languages: "한국어",
    availability: "화 - 토, 오전 10시 - 오후 5시",
    certifications: "유아 돌봄 전문가 과정 수료",
    isFavorite: false,
  ),
  Housekeeper(
    name: "박소윤",
    description: "정성 가득한 식사 준비와 철저한 위생 관리, 가족 같은 마음으로 돌보겠습니다.",
    serviceLocation: "인천광역시 연수구",
    imagePath: "assets/vitabelly_housekeeper3.png",
    hourlyRate: 23000,
    skills: "식사 준비, 청소, 세탁",
    languages: "한국어, 중급 영어",
    availability: "주말 제외 모든 요일, 오전 8시 - 오후 4시",
    certifications: "위생 관리 및 식품 준비 인증",
    isFavorite: false,
  ),
];

class HousekeepingServicesScreen extends StatelessWidget {
  void _showHousekeeperDetails(BuildContext context, Housekeeper housekeeper) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(housekeeper.name),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Image.asset(housekeeper.imagePath,
                    width: MediaQuery.of(context).size.width),
                SizedBox(height: 16),
                Text(
                  housekeeper.description,
                  style: TextStyle(fontSize: 14),
                ),
                SizedBox(height: 16),
                Text(
                  "위치",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(housekeeper.serviceLocation),
                SizedBox(height: 16),
                Text(
                  "1시간 당 요금",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text("${housekeeper.formattedHourlyRate}"),
                SizedBox(height: 16),
                Text(
                  "가능한 작업",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(housekeeper.skills),
                SizedBox(height: 16),
                Text(
                  "언어",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(housekeeper.languages),
                SizedBox(height: 16),
                Text(
                  "가능한 시간",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(housekeeper.availability),
                SizedBox(height: 16),
                Text(
                  "자격증",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(housekeeper.certifications),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('닫기'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('가사 도우미 서비스'),
      ),
      body: ListView.builder(
        itemCount: housekeepers.length,
        itemBuilder: (context, index) {
          final housekeeper = housekeepers[index];
          return Card(
            child: Column(
              children: [
                Stack(
                  alignment: Alignment.bottomLeft,
                  children: [
                    Image.asset(housekeeper.imagePath),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [
                              Colors.black.withOpacity(0.7),
                              Colors.transparent,
                            ],
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                housekeeper.name,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.grey[850],
                                borderRadius: BorderRadius.circular(15),
                              ),
                              padding: EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              child: Text(
                                '${housekeeper.formattedHourlyRate} / hr',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      top: 10,
                      right: 10,
                      child: IconButton(
                        icon: Icon(
                          housekeeper.isFavorite
                              ? Icons.bookmark
                              : Icons.bookmark_border,
                          color: Colors.white,
                          size: 30,
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
                ListTile(
                  title: Padding(
                    padding: EdgeInsets.only(top: 8),
                    child: Text(
                      housekeeper.description,
                      style: TextStyle(
                        height: 1.3,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  subtitle: Padding(
                    padding: EdgeInsets.only(top: 16, bottom: 8),
                    child: Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          color: Theme.of(context).colorScheme.secondary,
                          size: 20,
                        ),
                        SizedBox(width: 5),
                        Expanded(
                          child: Text(
                            housekeeper.serviceLocation,
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  onTap: () => _showHousekeeperDetails(context, housekeeper),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
