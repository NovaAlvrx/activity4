import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Emoji Tabs',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const TabDropdownExample(),
    );
  }
}

class TabDropdownExample extends StatefulWidget {
  const TabDropdownExample({super.key});

  @override
  State<TabDropdownExample> createState() => _TabDropdownExampleState();
}

class _TabDropdownExampleState extends State<TabDropdownExample>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedIndex = 0;
  final List<String> _tabs = ["Smiley", "Tab 2", "Tab 3", "Tab 4"];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: DropdownButton<int>(
          value: _selectedIndex,
          underline: const SizedBox(),
          items: List.generate(
            _tabs.length,
            (index) => DropdownMenuItem(
              value: index,
              child: Text(_tabs[index]),
            ),
          ),
          onChanged: (value) {
            if (value != null) {
              setState(() {
                _selectedIndex = value;
                _tabController.index = value;
              });
            }
          },
        ),
        centerTitle: true,
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // tab 1 (smiley face)
          CustomPaint(
            painter: SmileyPainter(),
            child: Container(),
          ),
          // other tabs
          Center(child: Text("Tab 2", style: TextStyle(fontSize: 24))),
          Center(child: Text("Tab 3", style: TextStyle(fontSize: 24))),
          Center(child: Text("Tab 4", style: TextStyle(fontSize: 24))),
        ],
      ),
    );
  }
}

// CustomPainter for a simple smiley face
class SmileyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final centerX = size.width / 2;
    final centerY = size.height / 2;
    final faceRadius = 100.0;

    // Face circle
    final facePaint = Paint()
      ..color = Colors.yellow
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(centerX, centerY), faceRadius, facePaint);

    // Eyes
    final eyePaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(centerX - 40, centerY - 30), 10, eyePaint);
    canvas.drawCircle(Offset(centerX + 40, centerY - 30), 10, eyePaint);

    // Smile (arc)
    final smilePaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5;
    final smileRect = Rect.fromCircle(center: Offset(centerX, centerY), radius: 60);
    canvas.drawArc(smileRect, 0.1 * 3.14, 0.8 * 3.14, false, smilePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}