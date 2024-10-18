#include "utils.h"

#include <flutter_windows.h>
#include <io.h>
#include <stdio.h>
#include <windows.h>

#include <iostream>

// Crea y adjunta una consola a la aplicación si es necesario.
void CreateAndAttachConsole() {
  if (::AllocConsole()) {
    FILE *unused;
    if (freopen_s(&unused, "CONOUT$", "w", stdout)) {
      _dup2(_fileno(stdout), 1); // Redirige stdout a la consola.
    }
    if (freopen_s(&unused, "CONOUT$", "w", stderr)) {
      _dup2(_fileno(stdout), 2); // Redirige stderr a la consola.
    }
    std::ios::sync_with_stdio(); // Sincroniza los flujos de C++ con C.
    FlutterDesktopResyncOutputStreams(); // Sincroniza flujos de Flutter.
  }
}

// Obtiene los argumentos de línea de comandos y los convierte de UTF-16 a UTF-8.
std::vector<std::string> GetCommandLineArguments() {
  int argc;
  wchar_t** argv = ::CommandLineToArgvW(::GetCommandLineW(), &argc);
  if (argv == nullptr) {
    return std::vector<std::string>(); // Retorna un vector vacío si hay un error.
  }

  std::vector<std::string> command_line_arguments;

  // Se omite el primer argumento ya que es el nombre del binario.
  for (int i = 1; i < argc; i++) {
    command_line_arguments.push_back(Utf8FromUtf16(argv[i])); // Convierte cada argumento.
  }

  ::LocalFree(argv); // Libera la memoria asignada para los argumentos.

  return command_line_arguments;
}

// Convierte una cadena UTF-16 a UTF-8.
std::string Utf8FromUtf16(const wchar_t* utf16_string) {
  if (utf16_string == nullptr) {
    return std::string(); // Retorna una cadena vacía si la cadena de entrada es nula.
  }
  unsigned int target_length = ::WideCharToMultiByte(
      CP_UTF8, WC_ERR_INVALID_CHARS, utf16_string,
      -1, nullptr, 0, nullptr, nullptr) - 1; // Elimina el carácter nulo final.
  
  int input_length = (int)wcslen(utf16_string); // Longitud de la cadena de entrada.
  std::string utf8_string;

  if (target_length == 0 || target_length > utf8_string.max_size()) {
    return utf8_string; // Retorna una cadena vacía si la longitud es inválida.
  }
  
  utf8_string.resize(target_length); // Redimensiona la cadena de destino.
  int converted_length = ::WideCharToMultiByte(
      CP_UTF8, WC_ERR_INVALID_CHARS, utf16_string,
      input_length, utf8_string.data(), target_length, nullptr, nullptr);
  
  if (converted_length == 0) {
    return std::string(); // Retorna una cadena vacía si la conversión falla.
  }
  
  return utf8_string; // Retorna la cadena convertida.
}

