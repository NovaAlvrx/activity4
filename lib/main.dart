import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dropdown Tab Navigation',
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
  final List<String> _tabs = ["Tab 1", "Tab 2", "Tab 3", "Tab 4"];

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
          underline: const SizedBox(), // removes default underline
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
          _buildTabContent("This is Tab 1"),
          _buildTabContent("This is Tab 2"),
          _buildTabContent("This is Tab 3"),
          _buildTabContent("This is Tab 4"),
        ],
      ),
    );
  }

  Widget _buildTabContent(String text) {
    return Center(
      child: Text(
        text,
        style: const TextStyle(fontSize: 24),
      ),
    );
  }
}