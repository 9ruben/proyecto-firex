//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <flutter_secure_storage_linux/flutter_secure_storage_linux_plugin.h>
#include <some_auth_plugin/some_auth_plugin.h>  // Reemplaza con el nombre real del plugin

void fl_register_plugins(FlPluginRegistry* registry) {
  g_autoptr(FlPluginRegistrar) flutter_secure_storage_linux_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "FlutterSecureStorageLinuxPlugin");
  flutter_secure_storage_linux_plugin_register_with_registrar(flutter_secure_storage_linux_registrar);

  // Registro del nuevo plugin de autenticación
  g_autoptr(FlPluginRegistrar) some_auth_plugin_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "SomeAuthPlugin");  // Reemplaza con el nombre real
  some_auth_plugin_register_with_registrar(some_auth_plugin_registrar);
}
