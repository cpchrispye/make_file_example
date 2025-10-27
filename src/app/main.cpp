// /C:/projects/make_file_example/src/app/main.cpp
// Demo main that exercises available project libraries when present.
// Uses conditional includes to compile even if some headers are missing.

#include <iostream>
#include <string>

#include "../math/math_operations.h"
#include "../utils/string_utils.h"

int main(int argc, char** argv) {

    std::cout << "Demo application math:\n" << MathOps::factorial(5) << '\n';
    std::cout << "Demo application string:\n" << StringUtils::toUpper(std::string("hello")) << '\n';
    return 0;
}