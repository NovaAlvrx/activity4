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
  final List<String> _tabs = ["Smiley", "Party", "Tab 3", "Tab 4"];

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
          // Tab 1 (smiley face)
          CustomPaint(
            painter: SmileyPainter(),
            child: Container(),
          ),
          // Tab 2 (party face)
          CustomPaint(
            painter: PartyPainter(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(),
                Image.network(
                  'https://media1.giphy.com/media/v1.Y2lkPTc5MGI3NjExb3B6bDl3aHZhdXI1eGN6cHhkODR3bno1cXRraGEzZ3dja241MzlzdiZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9cw/PotiYSwEnO33KX007a/giphy.gif',
                  width: 700,
                  height: 700,
                ),
              ],
            ),
          ),
          Center(child: Text("Tab 3", style: TextStyle(fontSize: 24))),
          Center(child: Text("Tab 4", style: TextStyle(fontSize: 24))),
        ],
      ),
    );
  }
}

// Smiley face painter
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

// Party face painter
class PartyPainter extends CustomPainter {
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

    // Eyebrows
    final eyebrowPaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5;
    
    final leftEyebrowRect = Rect.fromCircle(center: Offset(centerX - 43, centerY - 25), radius: 15);
    final rightEyebrowRect = Rect.fromCircle(center: Offset(centerX + 43, centerY - 25), radius: 15);
    canvas.drawArc(leftEyebrowRect.inflate(5), 1.05 * 3.14, 0.6 * 3.14, false, eyebrowPaint);
    canvas.drawArc(rightEyebrowRect.inflate(5), 1.35 * 3.14, 0.6 * 3.14, false, eyebrowPaint);

    // Eyes
    final eyePaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5;

    final leftEyeRect = Rect.fromCircle(center: Offset(centerX - 35, centerY - 25), radius: 15);
    final rightEyeRect = Rect.fromCircle(center: Offset(centerX + 35, centerY - 25), radius: 15);
    canvas.drawArc(leftEyeRect.inflate(5), 0.2 * 3.14, 0.6 * 3.14, false, eyePaint);
    canvas.drawArc(rightEyeRect.inflate(5), 0.2 * 3.14, 0.6 * 3.14, false, eyePaint);

    // Smile (arc)
    final smilePaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;
    final topSmileRect = Rect.fromLTWH(centerX - 30, centerY + 30, 50, 15);
    final bottomSmileRect = Rect.fromLTWH(centerX - 30, centerY + 44, 50, 15);
    canvas.drawArc(topSmileRect, -3.14 / 2, 3.14, false, smilePaint);
    canvas.drawArc(bottomSmileRect, -3.14 / 2, 3.14, false, smilePaint);

    // Hat
    final hatStrokePaint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;

    // Coordinates
    final tip = Offset(centerX - 90, centerY - 160); // top of hat
    final left = Offset(centerX - 95, centerY - 40); // bottom left
    final right = Offset(centerX, centerY - 90); // bottom right

    // Gradient for the hat
    final hatGradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [const Color.fromARGB(255, 235, 16, 0), const Color.fromARGB(255, 255, 172, 49)],
    );

    // Bounding rect for the shader
    final rect = Rect.fromPoints(
      Offset(tip.dx, tip.dy),
      Offset(right.dx, left.dy),
    );

    // Paint with shader
    final hatFillPaint = Paint()
      ..shader = hatGradient.createShader(rect)
      ..style = PaintingStyle.fill;

    // Draw the triangle as a gradient-filled shape
    final path = Path()
      ..moveTo(tip.dx, tip.dy)
      ..lineTo(left.dx, left.dy)
      ..lineTo(right.dx, right.dy)
      ..close();
    canvas.drawPath(path, hatFillPaint);

  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}