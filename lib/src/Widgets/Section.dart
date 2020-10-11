import 'package:flutter/material.dart';
import 'package:flutter_movie/src/Widgets/AppContainer.dart';
import 'package:flutter_movie/src/Widgets/Subheader.dart';

enum EShadowPosition { top, bottom, both, none }

const Color _kKeyUmbraOpacity = Color(0x33000000); // alpha = 0.2
const Color _kKeyPenumbraOpacity = Color(0x24000000); // alpha = 0.14
const Color _kAmbientShadowOpacity = Color(0x1F000000); //

const Map<EShadowPosition, List<BoxShadow>> _positionToShadow = <EShadowPosition, List<BoxShadow>>{
  EShadowPosition.none: [],
  EShadowPosition.bottom: <BoxShadow>[
    BoxShadow(
        offset: Offset(0.0, 3.0), blurRadius: 3.0, spreadRadius: -2.0, color: _kKeyUmbraOpacity),
    BoxShadow(
        offset: Offset(0.0, 4.0), blurRadius: 4.0, spreadRadius: 0.0, color: _kKeyPenumbraOpacity),
    BoxShadow(
        offset: Offset(0.0, 5.5),
        blurRadius: 5.0,
        spreadRadius: 0.0,
        color: _kAmbientShadowOpacity),
  ],
  EShadowPosition.top: <BoxShadow>[
    BoxShadow(
        offset: Offset(0.0, -3.0), blurRadius: 3.0, spreadRadius: -2.0, color: _kKeyUmbraOpacity),
    BoxShadow(
        offset: Offset(0.0, -4.0), blurRadius: 4.0, spreadRadius: 0.0, color: _kKeyPenumbraOpacity),
    BoxShadow(
        offset: Offset(0.0, -5.5),
        blurRadius: 5.0,
        spreadRadius: 0.0,
        color: _kAmbientShadowOpacity),
  ],
  EShadowPosition.both: <BoxShadow>[
    BoxShadow(
        offset: Offset(0.0, 3.0), blurRadius: 3.0, spreadRadius: -2.0, color: _kKeyUmbraOpacity),
    BoxShadow(
        offset: Offset(0.0, 4.0), blurRadius: 4.0, spreadRadius: 0.0, color: _kKeyPenumbraOpacity),
    BoxShadow(
        offset: Offset(0.0, 5.5),
        blurRadius: 5.0,
        spreadRadius: 0.0,
        color: _kAmbientShadowOpacity),
    BoxShadow(
        offset: Offset(0.0, -3.0), blurRadius: 3.0, spreadRadius: -2.0, color: _kKeyUmbraOpacity),
    BoxShadow(
        offset: Offset(0.0, -4.0), blurRadius: 4.0, spreadRadius: 0.0, color: _kKeyPenumbraOpacity),
    BoxShadow(
        offset: Offset(0.0, -5.5),
        blurRadius: 5.0,
        spreadRadius: 0.0,
        color: _kAmbientShadowOpacity),
  ]
};

const Map<EShadowPosition, EdgeInsetsGeometry> _positionToMargin = {
  EShadowPosition.bottom: EdgeInsets.only(bottom: 10),
  EShadowPosition.top: EdgeInsets.only(top: 10),
  EShadowPosition.both: EdgeInsets.symmetric(vertical: 20),
  EShadowPosition.none: EdgeInsets.zero,
};

class Section extends StatelessWidget {
  final Widget child;
  final EShadowPosition shadowPosition;
  final String title;

  const Section({@required this.child, this.title, this.shadowPosition = EShadowPosition.none});

  @override
  Widget build(BuildContext context) {
    if (child == null) return SizedBox.shrink();
    return Container(
      margin: _positionToMargin[shadowPosition],
      child: Container(
        decoration: BoxDecoration(boxShadow: _positionToShadow[shadowPosition]),
        child: AppContainer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              if (title != null) Subheader(title),
              child,
            ],
          ),
        ),
      ),
    );
  }
}
