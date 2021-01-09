#define PL_ARITY_AS_SIZE 1
#include <cstdio>
#include <cstdlib>
#include <iostream>
#include <string>

#include <Magick++.h>
#include <SWI-cpp.h>
#include <SWI-Prolog.h>
#include <SWI-Stream.h>

[[nodiscard]] static auto magick_error(const std::string& msg) -> int;
[[nodiscard]] auto open_image(const term_t name) -> const Magick::Image;
[[nodiscard]] static auto pl_get_file_name(const term_t n,
                                           int flags) -> std::string;

PREDICATE(image_columns, 2)
{
  const Magick::Image img{open_image(A1)};
  return A2 = static_cast<long>(img.columns());
}

PREDICATE(image_format, 2)
{
  try {
    const Magick::Image f{open_image(A1)};
    return A2 = f.magick().c_str();
  } catch (const Magick::ErrorCorruptImage& e) {
    return magick_error(e.what());
  } catch (const Magick::ErrorMissingDelegate& e) {
    return magick_error(e.what());
  }
}

PREDICATE(image_rows, 2)
{
  const Magick::Image img{open_image(A1)};
  return A2 = static_cast<long>(img.rows());
}

PREDICATE(is_image, 1)
{
  try {
    const Magick::Image f{open_image(A1)};
    PL_succeed;
  } catch (const Magick::ErrorCorruptImage&) {
    PL_fail;
  } catch (const Magick::ErrorMissingDelegate&) {
    PL_fail;
  }
}

/*!
 * Returns an image object for the image stores in the file name by
 * the supplied Prolog term.
 */
auto open_image(const term_t name) -> const Magick::Image
{
  return{pl_get_file_name(name, PL_FILE_EXIST)};
}

/*!
 * Returns the supplied Prolog term as a C++ standard library string
 * file name.
 */
auto pl_get_file_name(const term_t n,
                      const int flags) -> std::string
{
  char* string;
  if (!PL_get_file_name(n, &string, flags)) {
    PL_fail;
  }
  return{string};
}

static auto magick_error(const std::string& msg) -> int
{
  const PlCompound formal{"image_error", PlTermv(msg.c_str())};
  return{PL_raise_exception(PlCompound("error", PlTermv(formal, PlTerm())))};
}

extern "C" {
  install_t install_image()
  {
  }
}
