import 'package:flutter/material.dart';
import 'package:noteapp/ui/style/app.dart';

class CustomTabView extends StatefulWidget {
  final int? itemCount;
  final IndexedWidgetBuilder? tabBuilder;
  final IndexedWidgetBuilder? pageBuilder;
  final Widget? stub;
  final ValueChanged<int>? onPositionChange;
  final ValueChanged<double>? onScroll;
  final int? initPosition;

  CustomTabView(
      {this.itemCount,
      this.tabBuilder,
      this.pageBuilder,
      this.stub,
      this.onPositionChange,
      this.onScroll,
      this.initPosition});

  @override
  _CustomTabsState createState() => _CustomTabsState();
}

class _CustomTabsState extends State<CustomTabView>
    with TickerProviderStateMixin {
  late TabController controller;
  late int _currentCount;
  late int _currentPosition;

  @override
  void initState() {
    _currentPosition = widget.initPosition!;
    controller = TabController(
        length: widget.itemCount!, vsync: this, initialIndex: _currentPosition);
    controller.addListener(onPositionChange);
    controller.animation!.addListener(onScroll);
    _currentCount = widget.itemCount!;
    super.initState();
  }

  @override
  void didUpdateWidget(CustomTabView oldWidget) {
    if (_currentCount != widget.itemCount) {
      controller.animation!.removeListener(onScroll);
      controller.removeListener(onPositionChange);
      controller.dispose();

      if (widget.initPosition != null) {
        _currentPosition = widget.initPosition!;
      }

      if (_currentPosition > widget.itemCount! - 1) {
        _currentPosition = widget.itemCount! - 1;
        _currentPosition = _currentPosition < 0 ? 0 : _currentPosition;
        if (widget.onPositionChange is ValueChanged<int>) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted) {
              widget.onPositionChange!(_currentPosition);
            }
          });
        }
      }

      _currentCount = widget.itemCount!;
      setState(() {
        controller = TabController(
            length: widget.itemCount!,
            vsync: this,
            initialIndex: _currentPosition);
        controller.addListener(onPositionChange);
        controller.animation!.addListener(onScroll);
      });
    } else if (widget.initPosition != null) {
      controller.animateTo(widget.initPosition!);
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    controller.animation!.removeListener(onScroll);
    controller.removeListener(onPositionChange);
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.itemCount! < 1) return widget.stub ?? Container();

    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TabBar(
              isScrollable: true,
              unselectedLabelColor: darkColor,
              labelStyle:
                  const TextStyle(fontSize: 22.0, fontFamily: 'Montserrat'),
              unselectedLabelStyle:
                  const TextStyle(fontFamily: 'OpenSans', fontSize: 20.0),
              indicator: BoxDecoration(
                  color: lighterMainColor,
                  borderRadius: const BorderRadius.all(Radius.circular(16.0))),
              controller: controller,
              tabs: List.generate(widget.itemCount!,
                  (index) => widget.tabBuilder!(context, index))),
          Expanded(
              child: TabBarView(
                  controller: controller,
                  children: List.generate(widget.itemCount!,
                      (index) => widget.pageBuilder!(context, index))))
        ]);
  }

  onPositionChange() {
    if (!controller.indexIsChanging) {
      _currentPosition = controller.index;
      if (widget.onPositionChange is ValueChanged<int>) {
        widget.onPositionChange!(_currentPosition);
      }
    }
  }

  onScroll() {
    if (widget.onScroll is ValueChanged<double>) {
      widget.onScroll!(controller.animation!.value);
    }
  }
}
