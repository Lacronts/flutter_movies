part of 'tabs_bloc.dart';

abstract class TabsEvent extends Equatable {
  const TabsEvent();
}

class TabSelected extends TabsEvent {
  final AppTab newTab;

  const TabSelected({this.newTab});

  @override
  List<Object> get props => [newTab];
}
