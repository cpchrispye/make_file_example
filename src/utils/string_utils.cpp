
#include <string>
#include <vector>
#include "string_utils.h"

/**
 * String Utilities Library
 * Demonstrates string manipulation functions for Make tutorial
 */

namespace StringUtils {
    /**
     * Convert string to uppercase
     * @param str Input string
     * @return Uppercase version of the string
     */
    std::string toUpper(const std::string& str) 
    {
        std::string result = str;
        for (char& c : result) {
            c = static_cast<char>(std::toupper(c));
        }
        return result;
    }


}



