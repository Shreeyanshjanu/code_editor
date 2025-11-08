import 'package:code_editor/widgets/drawer_icons_widgets/developer_widget.dart';
import 'package:code_editor/widgets/drawer_icons_widgets/settings_widgets.dart';
import 'package:flutter/material.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  // Track which page to show
  String _currentView = 'main'; // 'main', 'developer', 'settings'

  @override
  Widget build(BuildContext context) {
    // Show Developer Page
    if (_currentView == 'developer') {
      return DeveloperWidget(
        onBack: () {
          setState(() {
            _currentView = 'main';
          });
        },
      );
    }

    // Show Settings Page
    if (_currentView == 'settings') {
      return Container(
        width: 350,
        color: Colors.black,
        child: Column(
          children: [
            // Back Button Header
            Container(
              padding: const EdgeInsets.all(20),
              color: const Color(0xFF3A3A3A),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () {
                      setState(() {
                        _currentView = 'main';
                      });
                    },
                  ),
                  const Text(
                    'Settings',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            // Settings Widget
            Expanded(
              child: Center(
                child: const SettingsWidget(),
              ),
            ),
          ],
        ),
      );
    }
    // Original Main Drawer View
    return Container(
      width: 350,
      color: Colors.black,
      child: Column(
        children: [
          // Sidebar Header
          Container(
            padding: const EdgeInsets.all(20),
            color: const Color(0xFF3A3A3A),
            alignment: Alignment.centerLeft,
            child: const Text(
              'C++ Compiler',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          // Sidebar Items
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                ListTile(
                  leading: const Icon(Icons.settings, color: Colors.white70),
                  title: const Text(
                    'Settings',
                    style: TextStyle(color: Colors.white70),
                  ),
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white38,
                    size: 16,
                  ),
                  onTap: () {
                    setState(() {
                      _currentView = 'settings';
                    });
                  },
                ),
                const Divider(color: Colors.white24, height: 1),
                ListTile(
                  leading: const Icon(Icons.info, color: Colors.white70),
                  title: const Text(
                    'About Developer',
                    style: TextStyle(color: Colors.white70),
                  ),
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white38,
                    size: 16,
                  ),
                  onTap: () {
                    setState(() {
                      _currentView = 'developer';
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
