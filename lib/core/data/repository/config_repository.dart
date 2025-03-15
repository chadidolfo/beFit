import 'package:beFit/core/data/data_source/config_data_source.dart';
import 'package:beFit/core/data/dbo/app_theme_dbo.dart';
import 'package:beFit/core/data/dbo/config_dbo.dart';
import 'package:beFit/core/domain/entity/app_theme_entity.dart';
import 'package:beFit/core/domain/entity/config_entity.dart';

class ConfigRepository {
  final ConfigDataSource _configDataSource;

  ConfigRepository(this._configDataSource);

  Future<void> updateConfig(ConfigEntity configEntity) async {
    final configDBO = ConfigDBO.fromConfigEntity(configEntity);
    _configDataSource.addConfig(configDBO);
  }

  Future<void> setConfigDisclaimer(bool hasAcceptedDisclaimer) async {
    _configDataSource.setConfigDisclaimer(hasAcceptedDisclaimer);
  }

  Future<void> setConfigHasAcceptedAnonymousData(
      bool hasAcceptedAnonymousData) async {
    _configDataSource.setConfigAcceptedAnonymousData(hasAcceptedAnonymousData);
  }

  Future<bool> getConfigHasAcceptedAnonymousData() async {
    return await _configDataSource.getHasAcceptedAnonymousData();
  }

  Future<AppThemeEntity> getConfigAppTheme() async {
    final appThemeDBO = await _configDataSource.getAppTheme();
    return AppThemeEntity.fromAppThemeDBO(appThemeDBO);
  }

  Future<void> setConfigAppTheme(AppThemeEntity appTheme) async {
    await _configDataSource
        .setConfigAppTheme(AppThemeDBO.fromAppThemeEntity(appTheme));
  }

  Future<ConfigEntity> getConfig() async {
    final configDBO = await _configDataSource.getConfig();
    return ConfigEntity.fromConfigDBO(configDBO);
  }
}
