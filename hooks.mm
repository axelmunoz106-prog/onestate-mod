#import <Foundation/Foundation.h>
#include <dlfcn.h>
#include <string.h>
#include "il2cpp.h"
#include "hooks.h"
#include "config.h"
bool g_fakeHard=false,g_unban=false,g_banSuppress=true,g_spending=false;
static uintptr_t gBase=0;
void* rva(uintptr_t r){return gBase?(void*)(gBase+r):NULL;}
void hooks_init(void){uint32_t n=_dyld_image_count();for(uint32_t i=0;i<n;i++){const char*s=_dyld_get_image_name(i);if(s&&strstr(s,"UnityFramework"))gBase=(uintptr_t)_dyld_get_image_header(i);}NSLog(@"[mod] base %p",(void*)gBase);}
static MethodInfo* at(uintptr_t r){if(!gBase)return NULL;uintptr_t t=gBase+r;size_t n=0;const Il2CppAssembly**a=il2cpp_domain_get_assemblies(il2cpp_domain_get(),&n);for(size_t i=0;i<n;i++){Il2CppImage*im=il2cpp_assembly_get_image(a[i]);if(!im)continue;size_t cn=il2cpp_image_get_class_count(im);for(size_t c=0;c<cn;c++){Il2CppClass*k=il2cpp_image_get_class(im,c);if(!k)continue;void*it=NULL;MethodInfo*m;while((m=il2cpp_class_get_methods(k,&it))){if(*(uintptr_t*)m==t)return m;}}}return NULL;}
static bool hook(uintptr_t r,void*fn,void**o){MethodInfo*m=at(r);if(!m){NSLog(@"[mod] fail %llx",(unsigned long long)r);return false;}void**p=(void**)m;void**v=(void**)((char*)m+8);if(o)*o=*p;*p=fn;if((uintptr_t)*v>=gBase)*v=fn;NSLog(@"[mod] ok %llx",(unsigned long long)r);return true;}
static long(*o_amt)(void*,int)=NULL;
long hk_amt(void*e,int t){if(g_fakeHard&&t==RES_HARD&&!g_spending)return 250000LL;return o_amt?o_amt(e,t):0;}
static bool(*o_has)(void*,int,long)=NULL;
bool hk_has(void*e,int t,long a){if(g_fakeHard&&t==RES_HARD)return true;return o_has?o_has(e,t,a):false;}
static bool(*o_chk)(void*,int,long)=NULL;
bool hk_chk(void*e,int t,long a){if(g_fakeHard&&t==RES_HARD)return true;return o_chk?o_chk(e,t,a):false;}
typedef struct{int32_t value;bool hasValue;}NP;
static void(*o_ban)(int,void*,NP)=NULL;
void hk_ban(int tm,void*rs,NP t){if(g_unban&&t.hasValue&&t.value==0){if(g_banSuppress)return;if(o_ban){o_ban(0,rs,t);return;}}if(o_ban)o_ban(tm,rs,t);}
static void(*o_kick)(int)=NULL;
void hk_kick(int r){if(g_unban)return;if(o_kick)o_kick(r);}
void set_fake_hard(long v){g_fakeHard=v!=0;}
long get_real_hard(void){return o_amt?o_amt(NULL,RES_HARD):0;}
void hacks_install(void){hook(RVA_AMT,(void*)hk_amt,(void**)&o_amt);hook(RVA_HAS,(void*)hk_has,(void**)&o_has);hook(RVA_CHK,(void*)hk_chk,(void**)&o_chk);hook(RVA_BAN,(void*)hk_ban,(void**)&o_ban);hook(RVA_KICK,(void*)hk_kick,(void**)&o_kick);}
