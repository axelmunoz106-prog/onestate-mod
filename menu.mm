#import <UIKit/UIKit.h>
#include "hooks.h"
static UIWindow* gW; static UIButton* gB; static UIView* gP;
@interface MM : UIViewController @end
@implementation MM
- (void)viewDidLoad {
 [super viewDidLoad];
 self.view.backgroundColor=UIColor.clearColor;
 gB=[UIButton buttonWithType:UIButtonTypeSystem];
 gB.frame=CGRectMake(10,110,46,46);
 gB.backgroundColor=[UIColor colorWithWhite:0 alpha:0.5];
 gB.layer.cornerRadius=23;
 [gB setTitle:@"+" forState:UIControlStateNormal];
 [gB addTarget:self action:@selector(tog) forControlEvents:UIControlEventTouchUpInside];
 [gB addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(drag:)]];
 [self.view addSubview:gB];
 gP=[[UIView alloc] initWithFrame:CGRectMake(10,164,280,190)];
 gP.backgroundColor=[UIColor colorWithWhite:0.08 alpha:0.93];
 gP.layer.cornerRadius=12; gP.hidden=YES;
 [self.view addSubview:gP];
 NSArray* t=@[@"Gemas",@"Unban"];
 for(int i=0;i<2;i++){
  UILabel* l=[[UILabel alloc] initWithFrame:CGRectMake(12,14+i*48,150,32)];
  l.text=t[i]; l.textColor=UIColor.whiteColor; l.font=[UIFont systemFontOfSize:13];
  UISwitch* s=[[UISwitch alloc] initWithFrame:CGRectMake(196,14+i*48,51,31)];
  s.tag=i; [s addTarget:self action:@selector(flip:) forControlEvents:UIControlEventValueChanged];
  [gP addSubview:l]; [gP addSubview:s];
 }
 UIButton* h=[UIButton buttonWithType:UIButtonTypeSystem];
 h.frame=CGRectMake(12,120,256,36);
 h.backgroundColor=[UIColor colorWithWhite:1 alpha:0.12]; h.layer.cornerRadius=8;
 [h setTitle:@"Ocultar" forState:UIControlStateNormal];
 [h addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchUpInside];
 [gP addSubview:h];
}
- (void)tog { gP.hidden=!gP.hidden; }
- (void)hide { gP.hidden=YES; gB.hidden=YES; }
- (void)drag:(UIPanGestureRecognizer*)g { CGPoint p=[g translationInView:self.view]; gB.center=CGPointMake(gB.center.x+p.x,gB.center.y+p.y); [g setTranslation:CGPointZero inView:self.view]; }
- (void)flip:(UISwitch*)s { if(s.tag==0) g_fakeHard=s.isOn; else g_unban=s.isOn; }
@end
void menu_show(void){
 dispatch_async(dispatch_get_main_queue(), ^{
  UIWindow* k=nil;
  for(UIWindow* w in UIApplication.sharedApplication.windows) if(w.isKeyWindow) k=w;
  if(!k) return;
  gW=[[UIWindow alloc] initWithFrame:k.bounds];
  gW.windowLevel=UIWindowLevelAlert+1;
  gW.rootViewController=[MM new];
  gW.backgroundColor=UIColor.clearColor;
  gW.hidden=NO;
 });
}
