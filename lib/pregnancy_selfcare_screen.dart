import 'package:flutter/material.dart';
import './data/self_care_content.dart';

class PregnancySelfCareScreen extends StatefulWidget {
  @override
  _PregnancySelfCareScreenState createState() =>
      _PregnancySelfCareScreenState();
}

class _PregnancySelfCareScreenState extends State<PregnancySelfCareScreen> {
  String? _expandedTitle;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('임신 중 자기 관리'),
      ),
      body: ListView.builder(
        itemCount: detailedContent.length,
        itemBuilder: (context, index) {
          String title = detailedContent.keys.elementAt(index);
          return _buildItem(title, detailedContent[title]!);
        },
      ),
    );
  }

  Widget _buildItem(String title, String content) {
    bool isExpanded = _expandedTitle == title;
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      color: Colors.grey[300],
      child: Column(
        children: [
          InkWell(
            onTap: () => setState(() {
              if (isExpanded) {
                _expandedTitle = null;
              } else {
                _expandedTitle = title;
              }
            }),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  Icon(
                    isExpanded ? Icons.expand_less : Icons.expand_more,
                    color: Theme.of(context).primaryColor,
                  ),
                ],
              ),
            ),
          ),
          AnimatedCrossFade(
            firstChild: Container(),
            secondChild: Padding(
              padding: EdgeInsets.all(20),
              child: Text(content, style: TextStyle(fontSize: 16)),
            ),
            crossFadeState: isExpanded
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            duration: Duration(milliseconds: 300),
            firstCurve: Curves.fastOutSlowIn,
            secondCurve: Curves.fastOutSlowIn,
            sizeCurve: Curves.fastOutSlowIn,
          ),
        ],
      ),
    );
  }
}

void main() => runApp(MaterialApp(home: PregnancySelfCareScreen()));
