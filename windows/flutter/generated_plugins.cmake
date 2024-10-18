#
# Generated file, do not edit.
#

# List of Flutter plugins to include in the project
list(APPEND FLUTTER_PLUGIN_LIST
  cloud_firestore
  firebase_auth
  firebase_core
  flutter_secure_storage_windows
)

# List of FFI plugins (currently empty)
list(APPEND FLUTTER_FFI_PLUGIN_LIST
)

# Variable to store bundled libraries for plugins
set(PLUGIN_BUNDLED_LIBRARIES)

# Iterate over each Flutter plugin and add it to the project
foreach(plugin ${FLUTTER_PLUGIN_LIST})
  add_subdirectory(flutter/ephemeral/.plugin_symlinks/${plugin}/windows plugins/${plugin})
  target_link_libraries(${BINARY_NAME} PRIVATE ${plugin}_plugin)
  
  # Add the plugin's bundled libraries to the list
  list(APPEND PLUGIN_BUNDLED_LIBRARIES $<TARGET_FILE:${plugin}_plugin>)
  list(APPEND PLUGIN_BUNDLED_LIBRARIES ${${plugin}_bundled_libraries})
endforeach()

# Iterate over each FFI plugin (if any) and add it to the project
foreach(ffi_plugin ${FLUTTER_FFI_PLUGIN_LIST})
  add_subdirectory(flutter/ephemeral/.plugin_symlinks/${ffi_plugin}/windows plugins/${ffi_plugin})
  
  # Add the FFI plugin's bundled libraries to the list
  list(APPEND PLUGIN_BUNDLED_LIBRARIES ${${ffi_plugin}_bundled_libraries})
endforeach()
