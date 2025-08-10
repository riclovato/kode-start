import 'package:flutter/material.dart';

Future<Map<String, String?>?> showFilterModal(
  BuildContext context, {
  String? initialStatus,
  String? initialGender,
}) {
  String? statusSelected = initialStatus;
  String? genderSelected = initialGender;

  return showModalBottomSheet<Map<String, String?>?>(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Filters',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),

                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Status',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          RadioListTile<String>(
                            title: const Text('Alive'),
                            value: 'alive',
                            groupValue: statusSelected,
                            onChanged: (value) {
                              setState(() {
                                statusSelected = value;
                              });
                            },
                          ),
                          RadioListTile<String>(
                            title: const Text('Dead'),
                            value: 'dead',
                            groupValue: statusSelected,
                            onChanged: (value) {
                              setState(() {
                                statusSelected = value;
                              });
                            },
                          ),
                          RadioListTile<String>(
                            title: const Text('Unknown'),
                            value: 'unknown',
                            groupValue: statusSelected,
                            onChanged: (value) {
                              setState(() {
                                statusSelected = value;
                              });
                            },
                          ),
                        ],
                      ),
                    ),

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Gender',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          RadioListTile<String>(
                            title: const Text('Female'),
                            value: 'female',
                            groupValue: genderSelected,
                            onChanged: (value) {
                              setState(() {
                                genderSelected = value;
                              });
                            },
                          ),
                          RadioListTile<String>(
                            title: const Text('Male'),
                            value: 'male',
                            groupValue: genderSelected,
                            onChanged: (value) {
                              setState(() {
                                genderSelected = value;
                              });
                            },
                          ),
                          RadioListTile<String>(
                            title: const Text('Genderless'),
                            value: 'genderless',
                            groupValue: genderSelected,
                            onChanged: (value) {
                              setState(() {
                                genderSelected = value;
                              });
                            },
                          ),
                          RadioListTile<String>(
                            title: const Text('Unknown'),
                            value: 'unknown',
                            groupValue: genderSelected,
                            onChanged: (value) {
                              setState(() {
                                genderSelected = value;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 10),

                // Botões
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey[300],
                          foregroundColor: Colors.black,
                        ),
                        onPressed: () {
                          Navigator.pop(context, {
                            'status': null,
                            'gender': null,
                          });
                        },
                        child: const Text('Reset'),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context, {
                            'status': statusSelected,
                            'gender': genderSelected,
                          });
                        },
                        child: const Text('Apply'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      );
    },
  );
}
