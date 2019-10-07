import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DialogProviderAdapter extends StatelessWidget {
  final Widget child;

  DialogProviderAdapter({@required this.child});

  @override
  Widget build(BuildContext context) => child;

  T of<T> (BuildContext context) => Provider.of<T>(context);
}