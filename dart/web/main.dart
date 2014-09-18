library security_monkey;

import 'package:angular/angular.dart';
import 'package:angular_ui/angular_ui.dart';
import 'package:angular/application_factory.dart';
import 'package:logging/logging.dart';

// Hammock
import 'package:hammock/hammock.dart';
import 'package:SecurityMonkey/model/hammock_config.dart';

// Controllers
import 'package:SecurityMonkey/controller/username_controller.dart' show UsernameController;

// Components
import 'package:SecurityMonkey/component/itemdetails/itemdetails_component.dart';
import 'package:SecurityMonkey/component/revision_table_component/revision_table_component.dart';
import 'package:SecurityMonkey/component/item_table_component/item_table_component.dart';
import 'package:SecurityMonkey/component/revision/revision_component.dart';
import 'package:SecurityMonkey/component/issue_table_component/issue_table_component.dart';

import 'package:SecurityMonkey/component/search_page_component/search_page_component.dart';
import 'package:SecurityMonkey/component/search_bar_component/search_bar_component.dart';
import 'package:SecurityMonkey/component/signout_component/signout_component.dart';
import 'package:SecurityMonkey/component/settings_component/settings_component.dart';

// Services
import 'package:SecurityMonkey/service/revisions_service.dart';
import 'package:SecurityMonkey/service/items_service.dart';
import 'package:SecurityMonkey/service/itemdetails_service.dart';
import 'package:SecurityMonkey/service/user_settings_service.dart';
import 'package:SecurityMonkey/service/justify_service.dart';
import 'package:SecurityMonkey/service/revision_comment_service.dart';
import 'package:SecurityMonkey/service/revision_service.dart';
import 'package:SecurityMonkey/service/item_comment_service.dart';
import 'package:SecurityMonkey/service/username_service.dart';
import 'package:SecurityMonkey/service/issues_service.dart';
import 'package:SecurityMonkey/service/account_service.dart';

// Model
import 'package:SecurityMonkey/model/Account.dart';

// Routing
import 'package:SecurityMonkey/routing/securitymonkey_router.dart';

// HTTP Interceptor
import 'dart:convert';
import 'package:di/di.dart';
import 'dart:async';
import 'package:SecurityMonkey/util/constants.dart';
part 'package:SecurityMonkey/interceptor/global_http_interceptor.dart';

// Interceptor Error Messages
part 'package:SecurityMonkey/service/messages.dart';

// Part components
part 'package:SecurityMonkey/component/account_view_component/account_view_component.dart';

// Temporary, please follow https://github.com/angular/angular.dart/issues/476
//@MirrorsUsed(
//  targets: const ['revisions_controller'],
//  override: '*')
//import 'dart:mirrors';

class SecurityMonkeyModule extends Module {

  SecurityMonkeyModule() {
    
    // AngularUI
    install(new AngularUIModule());
    
    // Hammock (like restangular)
    install(new Hammock());
    bind(HammockConfig, toFactory: createHammockConfig);
    
    // Controllers
    bind(UsernameController);

    // Components
    bind(ItemDetailsComponent);
    bind(RevisionTableComponent);
    bind(ItemTableComponent);
    bind(RevisionComponent);
    bind(IssueTableComponent);
    bind(AccountViewComponent);
    bind(SearchPageComponent);
    bind(SearchBarComponent);
    bind(SignoutComponent);
    bind(SettingsComponent);

    // Services
    bind(RevisionsService);
    bind(ItemsService);
    bind(ItemDetailsService);
    bind(UserSettingsService);
    bind(JustifyService);
    bind(RevisionCommentService);
    bind(RevisionService);
    bind(ItemCommentService);
    bind(UsernameService);
    bind(IssuesService);
    bind(AccountService);
    bind(Messages);

    // Routing
    bind(RouteInitializerFn, toValue: securityMonkeyRouteInitializer);
    bind(NgRoutingUsePushState,
        toValue: new NgRoutingUsePushState.value(false));
  }
}


main() {
  Logger.root..level = Level.FINEST
             ..onRecord.listen((LogRecord rec) {
               print('${rec.level.name}: ${rec.time}: ${rec.message}');
               });
  final inj = applicationFactory()
        .addModule(new SecurityMonkeyModule())
        .run();
  GlobalHttpInterceptors.setUp(inj);
}