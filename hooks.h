#pragma once
#include <stdbool.h>
#include <stdint.h>
#include "il2cpp.h"
extern bool g_fakeHard, g_unban, g_banSuppress, g_spending;
void hooks_init(void);
void hacks_install(void);
void* rva(uintptr_t r);
