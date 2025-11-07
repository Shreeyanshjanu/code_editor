import 'package:code_editor/widgets/drawer_icons_widgets/developer_widget.dart';
import 'package:flutter/material.dart';


class DrawerWidget extends StatefulWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  bool _showDeveloperPage = false;

  @override
  Widget build(BuildContext context) {
    if (_showDeveloperPage) {
      return DeveloperWidget(
        onBack: () {
          setState(() {
            _showDeveloperPage = false;
          });
        },
      );
    }

    // Original drawer view
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
                  onTap: () {
                    // Handle navigation
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.info, color: Colors.white70),
                  title: const Text(
                    'About developer',
                    style: TextStyle(color: Colors.white70),
                  ),
                  onTap: () {
                    setState(() {
                      _showDeveloperPage = true;
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
