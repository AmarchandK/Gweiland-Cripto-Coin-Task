import 'package:flutter/material.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({super.key});

  static final InputBorder outlineInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(15.0),
      borderSide: const BorderSide(color: Colors.transparent));

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: TextFormField(
                decoration: InputDecoration(
                    prefix: const Icon(Icons.search),
                    border: InputBorder.none,
                    filled: true,
                    focusedBorder: outlineInputBorder,
                    enabledBorder: outlineInputBorder,
                    errorBorder: outlineInputBorder,
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                    fillColor: Colors.grey.withOpacity(0.4)),
              )),
        ),
        SizedBox(
          height: 45,
          child: OutlinedButton.icon(
            onPressed: () {},
            icon: const Icon(
              Icons.sort,
              size: 15,
            ),
            label: const Text(
              'Filter',
              style: TextStyle(fontSize: 14),
            ),
          ),
        )
      ],
    );
  }
}
