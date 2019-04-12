import 'package:fab_action_menu/callback_listener.dart';
import 'package:fab_action_menu/fab_action_object.dart';
import 'package:flutter/material.dart';


class FabActionMenu extends StatefulWidget {

  List<FloatingActionObject> buttonData;
  CallbackListener clickListener;
  int animationDuration;
  BuildContext context;
  Color fabButtonColor;
  Color fabOnPressColor;

  FabActionMenu(
      {@required this.buttonData,
        @required this.clickListener,
        this.context,
        this.animationDuration = 250,
        this.fabButtonColor,
        this.fabOnPressColor});

  @override
  _FabActionMenuState createState() => _FabActionMenuState();
}

class _FabActionMenuState extends State<FabActionMenu>
    with TickerProviderStateMixin {
  bool isPressed = false;
  Animation<double> _animateIcon;
  Animation<Color> _animateColor;
  Animation<double> _translateButton;
  Animation<double> _translateButtonX2;
  Animation<double> _translateButtonY2;
  AnimationController _animationController;
  AnimationController _buttonController;
  Curve _curve = Curves.linear;
  double _fabHeight = 56.0;

  Animation<double> _translateButtonY3;

  Animation<double> _translateButtonX3;

  String text = "Floating Menu";

  Animation<double> _translateButtonX1;

  @override
  void initState() {
    super.initState();
    print("ButtonLength " + widget.buttonData.length.toString());
    if (widget.fabButtonColor == null) {
      widget.fabButtonColor = Theme.of(widget.context).primaryColor;
    }
    if (widget.fabOnPressColor == null) {
      widget.fabOnPressColor = Theme.of(widget.context).accentColor;
    }

    _animationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: widget.animationDuration))
      ..addListener(() {
        setState(() {});
      });

    _buttonController = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: widget.animationDuration));

    _animateIcon =
        Tween<double>(begin: 0.0, end: 1.0).animate(_buttonController);

    _animateColor = ColorTween(
        begin: widget.fabButtonColor, end: widget.fabOnPressColor)
        .animate(CurvedAnimation(parent: _animationController, curve: _curve));

    _translateButton = Tween<double>(begin: _fabHeight, end: -14.0)
        .animate(CurvedAnimation(parent: _animationController, curve: _curve));
    _translateButtonX1 = Tween<double>(begin: 0, end: 15)
        .animate(CurvedAnimation(parent: _animationController, curve: _curve));

    _translateButtonY2 = Tween<double>(begin: _fabHeight, end: 30.0).animate(
        CurvedAnimation(
            parent: _animationController,
            curve: Interval(0.5, 1.0, curve: _curve)));

    _translateButtonX2 = Tween<double>(begin: 0, end: -52.0).animate(
        CurvedAnimation(
            parent: _animationController,
            curve: Interval(0.5, 1.0, curve: _curve)));

    _translateButtonY3 = Tween<double>(begin: _fabHeight, end: 60.0).animate(
        CurvedAnimation(
            parent: _animationController,
            curve: Interval(0.8, 1.0, curve: _curve)));

    _translateButtonX3 = Tween<double>(begin: 0, end: -70.0).animate(
        CurvedAnimation(
            parent: _animationController,
            curve: Interval(0.8, 1.0, curve: _curve)));
  }

  animate() {
    isPressed = !isPressed;
    if (isPressed) {
      _buttonController.forward();
      _animationController.forward();
    } else {
      this.text = "Floating Menu";
      _buttonController.reverse();
      _animationController.reverse();
    }
  }

  Widget button() {
    return FloatingActionButton(
        backgroundColor: _animateColor.value,
        onPressed: animate,
        elevation: 10,
        tooltip: 'Toggle',
        child: new AnimatedIcon(
          icon: AnimatedIcons.menu_close,
          progress: _animateIcon,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 250,
        height: 300,
        child:
        _buttons()); // This trailing comma makes auto-formatting nicer for build methods.
  }

  Widget _buttons() {
    if (widget.buttonData == null) {
      throw ("Data is null");
    }

    if (widget.buttonData.length == 3) {
      return Container(
        width: 250,
        height: 300,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Transform(
              transformHitTests: true,
              transform: Matrix4.translationValues(_translateButtonX3.value,
                  _translateButtonY3.value * 3.0, 0.0),
              child: Container(
                child: floatingActionButton(widget.buttonData[0]),
              ),
            ),
            Transform(
              transform: Matrix4.translationValues(_translateButtonX2.value,
                  _translateButtonY2.value * 2.0, 0.0),
              child: floatingActionButton(widget.buttonData[1]),
            ),
            Transform(
              transform: Matrix4.translationValues(
                  _translateButtonX1.value, _translateButton.value * 1.0, 0.0),
              child: Container(
                child: floatingActionButton(widget.buttonData[2]),
              ),
            ),
            button()
          ],
        ),
      );
    } else if (widget.buttonData.length == 2) {
      return Container(
        width: 200,
        height: 200,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Transform(
              transformHitTests: true,
              transform: Matrix4.translationValues(_translateButtonX3.value,
                  _translateButtonY3.value * 2.0, 0.0),
              child: Container(
                child: floatingActionButton(widget.buttonData[0]),
              ),
            ),
            Transform(
              transform: Matrix4.translationValues(
                  0.0, _translateButton.value * 1.0, 0.0),
              child: Container(
                child: floatingActionButton(widget.buttonData[1]),
              ),
            ),
            button()
          ],
        ),
      );
    } else {
      return Container(
        width: 200,
        height: 200,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Transform(
                 transform: Matrix4.translationValues(
                  0.0, _translateButton.value * 1.0, 0.0),
              child: Container(
                child: floatingActionButton(widget.buttonData[0]),
              ),
            ),
            button()
          ],
        ),
      );
    }
  }

  FloatingActionButton floatingActionButton(FloatingActionObject buttonData) {
    return FloatingActionButton(
      heroTag: buttonData.id.toString(),
      backgroundColor: buttonData.color,
      onPressed: () {
        widget.clickListener.onButtonClick(buttonData.id);
        onButtonTap(buttonData.id.toString());
      },
      child: Icon(buttonData.iconData),
      elevation: 2,
    );
  }

  void onButtonTap(String text) {
    this.text = text;
    isPressed = !isPressed;
    _animationController.reverse();
    _buttonController.reverse();
    setState(() {});
  }
}
