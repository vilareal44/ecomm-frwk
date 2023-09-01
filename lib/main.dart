import 'package:ecomm/features/auth/domain/repositories/repositories.dart';
import 'package:flutter/material.dart';

import 'app/view/view.dart';
import 'bootstrap.dart';
import 'firebase_options.dart';
import 'service_locator.dart';

void main() {
  bootstrap(() async {
    final userRepo = sl.get<UserRepository>();
    final user = await userRepo.user.first;

    return MyApp(user: user);
  });
}
