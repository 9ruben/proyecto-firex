#ifndef RUNNER_FLUTTER_WINDOW_H_
#define RUNNER_FLUTTER_WINDOW_H_

#include <flutter/dart_project.h>
#include <flutter/flutter_view_controller.h>

#include <memory>

#include "win32_window.h"

// Clase que representa una ventana que alberga una vista de Flutter.
class FlutterWindow : public Win32Window {
 public:
  // Crea una nueva FlutterWindow que alberga una vista de Flutter ejecutando |project|.
  explicit FlutterWindow(const flutter::DartProject& project);
  virtual ~FlutterWindow();

 protected:
  // Métodos sobrescritos de Win32Window.
  bool OnCreate() override;
  void OnDestroy() override;
  LRESULT MessageHandler(HWND window, UINT const message, WPARAM const wparam,
                         LPARAM const lparam) noexcept override;

 private:
  // Proyecto que se va a ejecutar.
  flutter::DartProject project_;

  // Instancia de Flutter alojada por esta ventana.
  std::unique_ptr<flutter::FlutterViewController> flutter_controller_;
};

#endif  // RUNNER_FLUTTER_WINDOW_H_
