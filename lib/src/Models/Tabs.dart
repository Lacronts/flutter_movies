import 'package:flutter/material.dart';

const NowPlayingTab = 'В кино';
const UpcomingTab = 'Скоро';
const TopRatedTab = 'Топ';

class AppTab {
  const AppTab(this.title, this.icon);
  final String title;
  final IconData icon;
}

const List<AppTab> appTabs = <AppTab>[
  AppTab(NowPlayingTab, Icons.camera_roll),
  AppTab(UpcomingTab, Icons.business),
  AppTab(TopRatedTab, Icons.vertical_align_top),
];
