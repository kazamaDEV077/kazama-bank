import 'package:flutter/material.dart';

class FormContainerWidget extends StatelessWidget {
  final String title;
  final List<Widget> fields;
  final VoidCallback onSubmit;
  final Widget? footer;

  const FormContainerWidget(
      {super.key, required this.title, required this.fields, required this.onSubmit, this.footer});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          ...fields,
          const SizedBox(height: 16),
          ElevatedButton(onPressed: onSubmit, child: const Text("Submit")),
          if (footer != null) footer!,
        ],
      ),
    );
  }
}
