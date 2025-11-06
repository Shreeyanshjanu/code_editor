import 'package:flutter/material.dart';

class CompilerWidget extends StatelessWidget {
  final TextEditingController codeController;
  final VoidCallback? onRun;
  final VoidCallback onClear;
  final bool isRunning;

  const CompilerWidget({
    Key? key,
    required this.codeController,
    required this.onRun,
    required this.onClear,
    this.isRunning = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: const Color(0xFF3A3A3A),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
            child: Row(
              children: [
                // Mac buttons
                Container(
                  width: 12,
                  height: 12,
                  decoration: const BoxDecoration(
                    color: Color(0xFFFF5F56),
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  width: 12,
                  height: 12,
                  decoration: const BoxDecoration(
                    color: Color(0xFFFFBD2E),
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  width: 12,
                  height: 12,
                  decoration: const BoxDecoration(
                    color: Color(0xFF27C93F),
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 18),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFF27C93F),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: const Text(
                    'main.cpp',
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.white70),
                  onPressed: onClear,
                  iconSize: 18,
                  tooltip: 'Clear',
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: onRun,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isRunning
                        ? Colors.grey
                        : const Color(0xFF27C93F),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 22,
                      vertical: 10,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    isRunning ? 'Running...' : 'Run',
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
          // Code editor
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(15),
              child: TextField(
                controller: codeController,
                maxLines: null,
                expands: true,
                textInputAction: TextInputAction.newline,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(0),
                ),
                style: const TextStyle(
                  color: Colors.white,
                  fontFamily: 'Courier',
                  fontSize: 14,
                  height: 1.5,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
