import 'package:ecomm/app/app.dart';
import 'package:ecomm/app/bloc/app_bloc.dart';
import 'package:ecomm/app/constants/app_colors.dart';
import 'package:ecomm/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static Page page() => const MaterialPage<void>(child: HomePage());

  PopupMenuItem _buildPopupItem({
    required IconData iconData,
    required String title,
    required VoidCallback onTap,
  }) {
    return PopupMenuItem(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Icon(
            iconData,
            color: AppColors.black,
            size: 20,
          ),
          Text(title),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final locales =
        context.findAncestorWidgetOfExactType<MaterialApp>()?.supportedLocales;

    return Scaffold(
      appBar: AppBar(
        actions: [
          PopupMenuButton(
            icon: const Icon(Icons.settings),
            itemBuilder: (context) {
              final localesButtons = locales != null
                  ? locales.map(
                      (locale) {
                        return _buildPopupItem(
                          iconData: Icons.language,
                          title: locale.languageCode,
                          onTap: () {
                            context.read<AppBloc>().add(
                                  AppLocaleChanged(Locale(locale.languageCode)),
                                );
                          },
                        );
                      },
                    ).toList()
                  : [];

              return <PopupMenuItem>[
                ...localesButtons,
                _buildPopupItem(
                    iconData: Icons.logout,
                    title: l10n.logoutButton,
                    onTap: () {
                      context.read<AppBloc>().add(const AppLogoutRequested());
                    }),
              ];
            },
          ),
        ],
      ),
      body: const SafeArea(child: HomeView()),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Shopping Ecomm',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Text(
              'Framework',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ],
        ),
      ],
    );
  }
}
