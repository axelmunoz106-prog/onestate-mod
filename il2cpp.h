#pragma once
#include <stddef.h>
#include <stdint.h>
typedef struct Il2CppDomain Il2CppDomain;
typedef struct Il2CppClass Il2CppClass;
typedef struct Il2CppImage Il2CppImage;
typedef struct Il2CppAssembly Il2CppAssembly;
typedef struct MethodInfo MethodInfo;
extern "C" {
Il2CppDomain* il2cpp_domain_get(void);
const Il2CppAssembly** il2cpp_domain_get_assemblies(const Il2CppDomain*, size_t*);
Il2CppImage* il2cpp_assembly_get_image(const Il2CppAssembly*);
size_t il2cpp_image_get_class_count(const Il2CppImage*);
Il2CppClass* il2cpp_image_get_class(const Il2CppImage*, size_t);
MethodInfo* il2cpp_class_get_methods(Il2CppClass*, void**);
}
