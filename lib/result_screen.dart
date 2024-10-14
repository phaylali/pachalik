import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pachalik/age_provider.dart';

class ResultScreen extends ConsumerWidget {
  const ResultScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dob = ref.watch(dobProvider);
    if (dob == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => context.go('/'),
          ),
        ),
        body: const Center(
          child: Text('Invalid date of birth'),
        ),
      );
    }

    final now = DateTime.now();
    final ageDuration = now.difference(dob);
    final years = ageDuration.inDays ~/ 365;
    final months = (ageDuration.inDays % 365) ~/ 30;
    final days = (ageDuration.inDays % 365) % 30;
    final hours = ageDuration.inHours;
    final minutes = ageDuration.inMinutes;
    final seconds = ageDuration.inSeconds;

    // Calculate the next birthday
    DateTime nextBirthday = DateTime(now.year, dob.month, dob.day);
    if (nextBirthday.isBefore(now)) {
      nextBirthday = DateTime(now.year + 1, dob.month, dob.day);
    }
    final daysUntilNextBirthday = nextBirthday.difference(now).inDays;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Age'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Table(
                columnWidths: const {
                  0: FlexColumnWidth(3),
                  1: FlexColumnWidth(2),
                },
                children: [
                  TableRow(
                    children: [
                      const TableCell(
                        child: Text(
                          'Years:',
                          textAlign: TextAlign.start,
                          style: TextStyle(fontSize: 24),
                        ),
                      ),
                      TableCell(
                        child: Center(
                          child: Text(
                            '$years',
                            style: const TextStyle(fontSize: 24),
                          ),
                        ),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      const TableCell(
                        child: Text(
                          'Months:',
                          textAlign: TextAlign.start,
                          style: TextStyle(fontSize: 22),
                        ),
                      ),
                      TableCell(
                        child: Center(
                          child: Text(
                            '$months',
                            style: const TextStyle(fontSize: 22),
                          ),
                        ),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      const TableCell(
                        child: Text(
                          'Days:',
                          textAlign: TextAlign.start,
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      TableCell(
                        child: Center(
                          child: Text(
                            '$days',
                            style: const TextStyle(fontSize: 20),
                          ),
                        ),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      const TableCell(
                        child: Text(
                          'Hours:',
                          textAlign: TextAlign.start,
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      TableCell(
                        child: Center(
                          child: Text(
                            '$hours',
                            style: const TextStyle(fontSize: 18),
                          ),
                        ),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      const TableCell(
                        child: Text(
                          'Minutes:',
                          textAlign: TextAlign.start,
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      TableCell(
                        child: Center(
                          child: Text(
                            '$minutes',
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      const TableCell(
                        child: Text(
                          'Seconds:',
                          textAlign: TextAlign.start,
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                      TableCell(
                        child: Center(
                          child: Text(
                            '$seconds',
                            style: const TextStyle(fontSize: 14),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 24.0),
              const Text(
                'Days until next birthday:',
                style: TextStyle(fontSize: 24),
                textAlign: TextAlign.center,
              ),
              Text(
                '$daysUntilNextBirthday',
                style: const TextStyle(fontSize: 24),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24.0),
              ElevatedButton(
                onPressed: () {
                  context.go('/');
                },
                child: const Text('Go Back'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
