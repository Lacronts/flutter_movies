part of 'tabs_bloc.dart';

class TabsState extends Equatable {
  final AppTab activeTab;
  final currentIndex;

  TabsState(this.activeTab) : this.currentIndex = appTabs.indexOf(activeTab);

  @override
  List<Object> get props => [activeTab, currentIndex];
}
