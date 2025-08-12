// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i558;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:red_rocket_test/data/auth/auth_service.dart' as _i241;
import 'package:red_rocket_test/data/auth/mock_auth_service.dart' as _i625;
import 'package:red_rocket_test/di/modules.dart' as _i271;
import 'package:red_rocket_test/logic/auth_state_notifier.dart' as _i787;
import 'package:red_rocket_test/presentation/view/auth/logic/login/login_cubit.dart'
    as _i160;
import 'package:red_rocket_test/presentation/view/auth/logic/logout/logout_cubit.dart'
    as _i751;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final appModules = _$AppModules();
    gh.lazySingleton<_i558.FlutterSecureStorage>(
      () => appModules.secureStorage(),
    );
    gh.lazySingleton<_i787.AuthStateNotifier>(() => _i787.AuthStateNotifier());
    gh.lazySingleton<_i241.AuthService>(
      () => _i625.MockAuthService(gh<_i558.FlutterSecureStorage>()),
    );
    gh.factory<_i160.LoginCubit>(
      () => _i160.LoginCubit(
        gh<_i241.AuthService>(),
        gh<_i787.AuthStateNotifier>(),
      ),
    );
    gh.factory<_i751.LogoutCubit>(
      () => _i751.LogoutCubit(
        gh<_i241.AuthService>(),
        gh<_i787.AuthStateNotifier>(),
      ),
    );
    return this;
  }
}

class _$AppModules extends _i271.AppModules {}
