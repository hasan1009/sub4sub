import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class policyDialog extends StatelessWidget {
  final double radius;
  final String mdFilename;
  const policyDialog({super.key, this.radius = 8, required this.mdFilename});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius)),
      child: Column(
        children: [
          Expanded(
              child: FutureBuilder(
                  future: Future.delayed(const Duration(milliseconds: 150))
                      .then((value) {
                    return rootBundle.loadString("assets/mdfile/$mdFilename");
                  }),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      return Markdown(data: snapshot.data);
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  })),
          TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Close"))
        ],
      ),
    );
  }
}
