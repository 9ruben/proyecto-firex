#ifndef RUNNER_UTILS_H_
#define RUNNER_UTILS_H_

#include <string>
#include <vector>

// Crea una consola para el proceso y redirige stdout y stderr a
// ella, tanto para el runner como para la biblioteca Flutter.
void CreateAndAttachConsole();

// Toma un wchar_t* terminado en nulo, codificado en UTF-16, y devuelve un std::string
// codificado en UTF-8. Retorna un std::string vacío en caso de fallo.
std::string Utf8FromUtf16(const wchar_t* utf16_string);

// Obtiene los argumentos de la línea de comandos pasados como un std::vector<std::string>,
// codificados en UTF-8. Retorna un std::vector<std::string> vacío en caso de fallo.
std::vector<std::string> GetCommandLineArguments();

#endif  // RUNNER_UTILS_H_
