#import <UIKit/UIKit.h>
#include <dlfcn.h>
#include <pthread.h>
#include <unistd.h>
#include "hooks.h"
#include "menu.h"
static void* boot(void*){
 for(int i=0;i<600;i++){
  void* d=dlsym(RTLD_DEFAULT,"il2cpp_domain_get");
  if(d&&((void*(*)(void))d)()) break;
  usleep(100000);
 }
 hooks_init();
 sleep(1);
 hacks_install();
 for(int i=0;i<300;i++){
  __block BOOL r=NO;
  dispatch_sync(dispatch_get_main_queue(), ^{
   for(UIWindow* w in UIApplication.sharedApplication.windows) if(w.isKeyWindow) r=YES;
  });
  if(r) break;
  usleep(200000);
 }
 menu_show();
 return NULL;
}
__attribute__((constructor))
static void mod_init(void){
 pthread_t t;
 pthread_create(&t,NULL,boot,NULL);
 pthread_detach(t);
}
