#ifndef RUNNER_WIN32_WINDOW_H_
#define RUNNER_WIN32_WINDOW_H_

#include <windows.h>
#include <functional>
#include <memory>
#include <string>

// Clase que abstrae una ventana Win32 con alta compatibilidad con DPI.
// Está diseñada para ser heredada por clases que deseen especializarse en
// renderizado y manejo de entrada personalizados.
class Win32Window {
 public:
  struct Point {
    unsigned int x;
    unsigned int y;
    Point(unsigned int x, unsigned int y) : x(x), y(y) {}
  };

  struct Size {
    unsigned int width;
    unsigned int height;
    Size(unsigned int width, unsigned int height)
        : width(width), height(height) {}
  };

  Win32Window();
  virtual ~Win32Window();

  // Crea una ventana Win32 con |title|, posicionada y dimensionada usando
  // |origin| y |size|. Las nuevas ventanas se crean en el monitor predeterminado.
  // Los tamaños de la ventana se especifican en píxeles físicos, por lo que 
  // esta función escalará el ancho y la altura según sea apropiado para 
  // el monitor predeterminado. La ventana es invisible hasta que se 
  // llama a |Show|. Retorna true si la ventana fue creada exitosamente.
  bool Create(const std::wstring& title, const Point& origin, const Size& size);

  // Muestra la ventana actual. Retorna true si la ventana fue mostrada exitosamente.
  bool Show();

  // Libera los recursos del sistema asociados con la ventana.
  void Destroy();

  // Inserta |content| en el árbol de la ventana.
  void SetChildContent(HWND content);

  // Retorna el manejador de la ventana para permitir que los clientes
  // configuren el ícono y otras propiedades de la ventana.
  // Retorna nullptr si la ventana ha sido destruida.
  HWND GetHandle();

  // Si es verdadero, cerrar esta ventana saldrá de la aplicación.
  void SetQuitOnClose(bool quit_on_close);

  // Retorna un RECT que representa los límites del área de cliente actual.
  RECT GetClientArea();

 protected:
  // Procesa y enruta los mensajes de ventana importantes para el manejo del mouse,
  // cambio de tamaño y DPI. Delegando el manejo a sobrecargas de miembro
  // que las clases derivadas pueden manejar.
  virtual LRESULT MessageHandler(HWND window,
                                 UINT const message,
                                 WPARAM const wparam,
                                 LPARAM const lparam) noexcept;

  // Llamado cuando se llama a CreateAndShow, permitiendo la configuración
  // relacionada con la ventana en subclases. Las subclases deben retornar
  // false si la configuración falla.
  virtual bool OnCreate();

  // Llamado cuando se llama a Destroy.
  virtual void OnDestroy();

 private:
  friend class WindowClassRegistrar;

  // Callback del sistema operativo llamado por el pump de mensajes.
  // Maneja el mensaje WM_NCCREATE, habilitando la escala de DPI no cliente
  // automática. Todos los demás mensajes son manejados por MessageHandler.
  static LRESULT CALLBACK WndProc(HWND const window,
                                  UINT const message,
                                  WPARAM const wparam,
                                  LPARAM const lparam) noexcept;

  // Recupera un puntero a la instancia de clase para |window|.
  static Win32Window* GetThisFromHandle(HWND const window) noexcept;

  // Actualiza el tema del marco de la ventana para que coincida con el tema del sistema.
  static void UpdateTheme(HWND const window);

  bool quit_on_close_ = false;  // Si el cierre de la ventana sale de la aplicación.

  HWND window_handle_ = nullptr;  // Manejador de la ventana principal.
  HWND child_content_ = nullptr;   // Manejador para el contenido alojado.
};

#endif  // RUNNER_WIN32_WINDOW_H_
