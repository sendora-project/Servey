import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Toolbox {
  static const List<String> kUnits = ['GB', 'MB', 'KB', 'bytes'];
  static const int kKB = 1024;
  static const int kMB = kKB * 1024;
  static const int kGB = kMB * 1024;

  static String kBullet = '•';

  static List<String> kEnMonths = [
    'undefined',
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];

  static Map<int, String> kEnDays = {
    1: 'Monday',
    2: 'Tuesday',
    3: 'Wednesday',
    4: 'Thursday',
    5: 'Friday',
    6: 'Saturday',
    7: 'Sunday'
  };
}

extension IntUtils on int {
  String asSize() {
    var size = toDouble();

    for (var unit in [Toolbox.kGB, Toolbox.kMB, Toolbox.kKB]) {
      if (size >= unit) {
        return '${(size / unit).toStringAsFixed(2)} $unit';
      }
    }

    return '$size ${Toolbox.kUnits.last}';
  }

  String asTime() {
    int minutes = this ~/ 60;
    int remaining = this % 60;
    return '$minutes:${remaining.toString().padLeft(2, '0')}';
  }

  String asMonth() {
    assert(this >= 1 && this <= 12, 'Invalid month: $this');
    return Toolbox.kEnMonths[this];
  }

  String asWeekday() {
    assert(this >= 1 && this <= 7, 'Invalid weekday: $this');
    return Toolbox.kEnDays[this]!;
  }
}

extension StringUtils on String {
  String toCapitalized() {
    return this[0].toUpperCase() + substring(1).toLowerCase();
  }

  bool isLongerThan(int length) {
    return this.length > length;
  }

  bool containsAny(List<String> strings) {
    return strings.contains(this);
  }

  int toInt() {
    return int.parse(this);
  }

  TimeOfDay asTime() {
    return TimeOfDay.fromDateTime(
      DateFormat('yyyy-MM-dd h:mm a').parse('2023-01-01 $this'),
    );
  }

  String strip(int maxLength) {
    if (length <= maxLength) {
      return this;
    } else {
      return substring(0, maxLength);
    }
  }
}

extension ListUtils on List<dynamic> {
  bool get isSingle => length == 1;

  bool containsAny(List<dynamic> values) {
    return values.any((v) => contains(v));
  }

  bool containsAll(List<String> elements) {
    return elements.every((element) => contains(element));
  }

  bool containsOnly(String element) {
    return length == 1 && contains(element);
  }

  bool containsOnlyAll(List<String> elements) {
    return length <= elements.length && containsAll(elements);
  }
}

extension IterableUtils<T> on Iterable<T> {
  Map<K, List<T>> groupByKey<K, V>({
    required K Function(T) predicate,
  }) {
    final Map<K, List<T>> map = {};

    for (final v in this) {
      final key = predicate(v);
      map[key] ??= [];
      map[key]!.add(v);
    }

    return map;
  }

  Iterable<T> findByProperty(bool Function(T) predicate) {
    final List<T> values = [];

    for (final value in this) {
      if (!predicate(value)) continue;
      values.add(value);
    }

    return values;
  }
}

extension SetUtils on Set<dynamic> {
  bool containsAny(List<dynamic> values) {
    return values.any((v) => contains(v));
  }
}

extension MapUtils<A, B> on Map<A, B> {
  Map<A, B> sort() {
    var entryList = entries.toList()
      ..sort((a, b) {
        final tA = (a.value as dynamic).timestamp;
        final tB = (b.value as dynamic).timestamp;
        return tB.compareTo(tA);
      });

    return Map.fromEntries(entryList);
  }
}

extension DateTimeUtils on DateTime {
  DateTime stripHours() => DateTime(year, month, day);
  String asSimpleString() => '$day/$month/$year';
}

extension ByteUtils on Uint8List {
  String toUtf8() {
    return utf8.decode(this);
  }
}
