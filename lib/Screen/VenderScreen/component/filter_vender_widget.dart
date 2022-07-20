import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FilterVenderWidget extends StatelessWidget {
  const FilterVenderWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ActionChip(
                backgroundColor: Colors.black38,
                label: const Text(
                  'All Venders',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                onPressed: () {}),
            ActionChip(
                backgroundColor: Colors.black38,
                label: const Text('Active',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold)),
                onPressed: () {}),
            ActionChip(
                backgroundColor: Colors.black38,
                label: const Text('Inactive',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold)),
                onPressed: () {}),
            ActionChip(
                backgroundColor: Colors.black38,
                label: const Text('Top Picked',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold)),
                onPressed: () {}),
            ActionChip(
                backgroundColor: Colors.black38,
                label: const Text('Top Rated',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold)),
                onPressed: () {}),
          ],
        ),
      ),
    );
  }
}
