#include <flutter/dart_project.h>
#include <flutter/flutter_view_controller.h>
#include <windows.h>

#include "flutter_window.h"
#include "utils.h"

int APIENTRY wWinMain(_In_ HINSTANCE instance, _In_opt_ HINSTANCE prev,
                      _In_ wchar_t *command_line, _In_ int show_command) {
  // Conectar a la consola cuando esté presente (por ejemplo, 'flutter run') 
  // o crear una nueva consola al ejecutar con un depurador.
  if (!::AttachConsole(ATTACH_PARENT_PROCESS) && ::IsDebuggerPresent()) {
    CreateAndAttachConsole();
  }

  // Inicializar COM para que esté disponible en la biblioteca y/o plugins.
  ::CoInitializeEx(nullptr, COINIT_APARTMENTTHREADED);

  // Inicializar el proyecto Dart con la carpeta de datos.
  flutter::DartProject project(L"data");

  // Obtener argumentos de línea de comandos.
  std::vector<std::string> command_line_arguments = GetCommandLineArguments();
  project.set_dart_entrypoint_arguments(std::move(command_line_arguments));

  // Crear la ventana de Flutter.
  FlutterWindow window(project);
  Win32Window::Point origin(10, 10);
  Win32Window::Size size(1280, 720);
  if (!window.Create(L"firetask", origin, size)) {
    return EXIT_FAILURE;
  }
  window.SetQuitOnClose(true);

  // Bucle de mensajes de Windows.
  ::MSG msg;
  while (::GetMessage(&msg, nullptr, 0, 0)) {
    ::TranslateMessage(&msg);
    ::DispatchMessage(&msg);
  }

  ::CoUninitialize();
  return EXIT_SUCCESS;
}
