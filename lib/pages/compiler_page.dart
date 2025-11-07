import 'package:code_editor/services/cpp_service.dart';
import 'package:code_editor/widgets/compiler_widget.dart';
import 'package:code_editor/widgets/drawer_widget.dart';
import 'package:flutter/material.dart';

class CompilerPage extends StatefulWidget {
  const CompilerPage({Key? key}) : super(key: key);

  @override
  State<CompilerPage> createState() => _CompilerPageState();
}

class _CompilerPageState extends State<CompilerPage> {
  late TextEditingController codeController;
  late TextEditingController inputController;
  late TextEditingController outputController;
  bool isRunning = false;

  @override
  void initState() {
    super.initState();
    codeController = TextEditingController(
      text: '''#include<iostream>
using namespace std;

int main() {
    cout << "Hello World" << endl;
    return 0;
}''',
    );
    inputController = TextEditingController();
    outputController = TextEditingController();
  }

  @override
  void dispose() {
    codeController.dispose();
    inputController.dispose();
    outputController.dispose();
    super.dispose();
  }

  Future<void> _runCode() async {
    setState(() {
      isRunning = true;
      outputController.text = 'Compiling and running....';
    });
    try {
      final result = await CppService.compileAndRun(
        code: codeController.text,
        input: inputController.text,
      );
      setState(() {
        if (result['success']) {
          outputController.text = result['output'] ?? '(No output)';
        } else {
          outputController.text = 'X Error:\n ${result['error']}';
        }
        isRunning = false;
      });
    } catch (e) {
      setState(() {
        outputController.text = '✗ Error:\n$e';
        isRunning = false;
      });
    }
  }

  void _clearCode() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Clear Code?'),
        content: const Text('Are you sure?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              codeController.clear();
              Navigator.pop(context);
            },
            child: const Text('Clear'),
          ),
        ],
      ),
    );
  }

  // ignore: unused_element
  void _clearOutput() {
    outputController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Fixed Drawer on the left
          const DrawerWidget(),
          // Main Content
          Expanded(
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  // Left: Code Editor
                  Expanded(
                    flex: 2,
                    child: CompilerWidget(
                      codeController: codeController,
                      onRun: isRunning ? null : _runCode,
                      onClear: _clearCode,
                      isRunning: isRunning,
                    ),
                  ),
                  const SizedBox(width: 24),
                  // Right: Terminal + Input
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: [
                        // Input Panel
                        Expanded(
                          flex: 1,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: const Color(0xFF3A3A3A),
                                width: 1,
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 15,
                                    vertical: 12,
                                  ),
                                  decoration: const BoxDecoration(
                                    color: Color(0xFF3A3A3A),
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10),
                                    ),
                                  ),
                                  child: const Text(
                                    'Input',
                                    style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    padding: const EdgeInsets.all(12),
                                    child: TextField(
                                      controller: inputController,
                                      maxLines: null,
                                      expands: true,
                                      textInputAction: TextInputAction.newline,
                                      decoration: const InputDecoration(
                                        hintText: 'Enter input here...',
                                        hintStyle: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 12,
                                        ),
                                        border: InputBorder.none,
                                      ),
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Courier',
                                        fontSize: 13,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),
                        // Output Panel
                        Expanded(
                          flex: 1,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: const Color(0xFF3A3A3A),
                                width: 1,
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 15,
                                    vertical: 12,
                                  ),
                                  decoration: const BoxDecoration(
                                    color: Color(0xFF3A3A3A),
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        'Output Terminal',
                                        style: TextStyle(
                                          color: Colors.white70,
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      if (isRunning)
                                        const SizedBox(
                                          width: 14,
                                          height: 14,
                                          child: CircularProgressIndicator(
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
                                              Colors.greenAccent,
                                            ),
                                            strokeWidth: 2,
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    padding: const EdgeInsets.all(15),
                                    child: SingleChildScrollView(
                                      child: SelectableText(
                                        outputController.text.isEmpty
                                            ? 'Output will appear here...'
                                            : outputController.text,
                                        style: TextStyle(
                                          color: outputController.text.isEmpty
                                              ? Colors.grey
                                              : Colors.greenAccent,
                                          fontFamily: 'Courier',
                                          fontSize: 12,
                                          height: 1.4,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
