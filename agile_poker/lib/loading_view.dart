import 'package:flutter/material.dart';

class LoadingView<T> extends StatefulWidget {
  final LoadingViewWidgetBuilder<T> viewBuilder;
  final Future loadingOperation;

  LoadingView({@required this.viewBuilder, @required this.loadingOperation});

  @override
  State<StatefulWidget> createState() => _LoadingViewState<T>();
}

class _LoadingViewState<T> extends State<LoadingView> {
  T _value;

  @override
  void initState() {
    widget.loadingOperation.then((value) {
      _value = value;
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) =>
    _value != null ? widget.viewBuilder(_value) : Container();
}

typedef LoadingViewWidgetBuilder<T> = Widget Function(T value);