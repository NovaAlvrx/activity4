import 'dart:math' as Math;
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
  final List<String> _tabs = ["Smiley", "Tab 2", "Heart", "Custom Emoji"];

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
          CustomPaint(
            painter: HeartPainter(),
            child: Container(),
          ),
          CustomPaint(
            painter: CustomEmojiPainter(),
            child: Container(),
          ),
        ],
      ),
    );
  }
}

//-------Tab 1: Smiley Face-------//
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

//-------Tab 3: Heart Shape-------//
// CustomPainter for a simple heart shape
class HeartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final centerX = size.width / 2;
    final centerY = size.height / 2;

    final paint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.fill;

    // Size and position of the ovals
    final ovalWidth = 78.0;
    final ovalHeight = 80.0;

    // Left oval
    final leftOval = Rect.fromCenter(
      center: Offset(centerX - 25, centerY - 20),
      width: ovalWidth,
      height: ovalHeight,
    );

    // Right oval
    final rightOval = Rect.fromCenter(
      center: Offset(centerX + 25, centerY - 20),
      width: ovalWidth,
      height: ovalHeight,
    );

    // Draw the ovals
    canvas.drawOval(leftOval, paint);
    canvas.drawOval(rightOval, paint);

    // Draw the bottom triangle
    final trianglePath = Path()
      ..moveTo(centerX - 60, centerY) // left point
      ..lineTo(centerX + 60, centerY) // right point
      ..lineTo(centerX, centerY + 100) // bottom point
      ..close();

    canvas.drawPath(trianglePath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

//-------Tab 4: Custom Emoji-------//
// CustomPainter for a custom emoji (star)
class CustomEmojiPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.orange
      ..style = PaintingStyle.fill;

    final center = Offset(size.width / 2, size.height / 2); // Center of the emoji
    final radius = 70.0; // Radius of the star
    final path = Path(); // Initialize path
    const int points = 5; // Number of star points

    for (int i = 0; i < points * 2; i++) { // Loop alternating between outer and inner points
      double angle = (i * 3.14159) / points; // Calculate angle for each point where half circle is pi 
      double r = (i % 2 == 0) ? radius : radius / 2; // Alternate between outer and inner radius
      double x = center.dx + r * Math.cos(angle - 3.14159 / 2); 
      double y = center.dy + r * Math.sin(angle - 3.14159 / 2);
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}