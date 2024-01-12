import 'package:flutter/cupertino.dart';

Widget buildErrorWidget(String error) {
  return Center(
    child: Text(
      error,
      style: const TextStyle(
        fontSize: 12.0,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}
