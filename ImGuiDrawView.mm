//Require standard library
#import <Metal/Metal.h>
#import <MetalKit/MetalKit.h>
#import <Foundation/Foundation.h>
//Imgui library
#import "Esp/CaptainHook.h"
#import "Esp/ImGuiDrawView.h"
#import "IMGUI/imgui.h"
#import "IMGUI/imgui_impl_metal.h"
#import "IMGUI/zzz.h"
//Patch library
#import "5Toubun/NakanoIchika.h"
#import "5Toubun/NakanoNino.h"
#import "5Toubun/NakanoMiku.h"
#import "5Toubun/NakanoYotsuba.h"
#import "5Toubun/NakanoItsuki.h"
#import "5Toubun/dobby.h"
#import "5Toubun/il2cpp.h"

#define kWidth  [UIScreen mainScreen].bounds.size.width
#define kHeight [UIScreen mainScreen].bounds.size.height
#define kScale [UIScreen mainScreen].scale
#define patch_NULL(a, b) vm(ENCRYPTOFFSET(a), strtoul(ENCRYPTHEX(b), nullptr, 0))
#define patch(a, b) vm_unity(ENCRYPTOFFSET(a), strtoul(ENCRYPTHEX(b), nullptr, 0))


@interface ImGuiDrawView () <MTKViewDelegate>
@property (nonatomic, strong) id <MTLDevice> device;
@property (nonatomic, strong) id <MTLCommandQueue> commandQueue;
@end

@implementation ImGuiDrawView

static bool show_s0 = false;

//Function for hacking/cheating is now up here. Example auto update right here (work on every version of this game)
void (*_LActorRoot_Visible)(void *instance, int camp, bool bVisible, const bool forceSync);
void LActorRoot_Visible(void *instance, int camp, bool bVisible, const bool forceSync = false) {
    if (instance != nullptr && show_s0) {
        if(camp == 1 || camp == 2 || camp == 110 || camp == 255) {
            bVisible = true;
        }
    } 
 return _LActorRoot_Visible(instance, camp, bVisible, forceSync);
}

uint64_t methodOffset;

void initial_setup(){
    //Auto update using ByNameModding for il2cpp
    Il2CppAttach();

    Il2CppMethod& getClass(const char* namespaze, const char* className);
    uint64_t getMethod(const char* methodName, int argsCount);

    Il2CppMethod methodAccess("Project.Plugins_d.dll");
    methodOffset = methodAccess.getClass("NucleusDrive.Logic", "LVActorLinker").getMethod("SetVisible", 3);
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //use DobbyHook, same kind of MSHookFunction but working on JIT, Dopamine!
        DobbyHook((void *)getRealOffset(methodOffset), (void *)LActorRoot_Visible, (void **)&_LActorRoot_Visible);
    });
}

static bool MenDeal = true;


- (instancetype)initWithNibName:(nullable NSString *)nibNameOrNil bundle:(nullable NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];

    _device = MTLCreateSystemDefaultDevice();
    _commandQueue = [_device newCommandQueue];

    if (!self.device) abort();

    IMGUI_CHECKVERSION();
    ImGui::CreateContext();
    ImGuiIO& io = ImGui::GetIO(); (void)io;

    ImGui::StyleColorsClassic();
    
    ImFont* font = io.Fonts->AddFontFromMemoryCompressedTTF((void*)zzz_compressed_data, zzz_compressed_size, 60.0f, NULL, io.Fonts->GetGlyphRangesVietnamese());
    
    ImGui_ImplMetal_Init(_device);

    return self;
}

+ (void)showChange:(BOOL)open
{
    MenDeal = open;
}

- (MTKView *)mtkView
{
    return (MTKView *)self.view;
}

- (void)loadView
{

 

    CGFloat w = [UIApplication sharedApplication].windows[0].rootViewController.view.frame.size.width;
    CGFloat h = [UIApplication sharedApplication].windows[0].rootViewController.view.frame.size.height;
    self.view = [[MTKView alloc] initWithFrame:CGRectMake(0, 0, w, h)];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.mtkView.device = self.device;
    self.mtkView.delegate = self;
    self.mtkView.clearColor = MTLClearColorMake(0, 0, 0, 0);
    self.mtkView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    self.mtkView.clipsToBounds = YES;

}



#pragma mark - Interaction

- (void)updateIOWithTouchEvent:(UIEvent *)event
{
    UITouch *anyTouch = event.allTouches.anyObject;
    CGPoint touchLocation = [anyTouch locationInView:self.view];
    ImGuiIO &io = ImGui::GetIO();
    io.MousePos = ImVec2(touchLocation.x, touchLocation.y);

    BOOL hasActiveTouch = NO;
    for (UITouch *touch in event.allTouches)
    {
        if (touch.phase != UITouchPhaseEnded && touch.phase != UITouchPhaseCancelled)
        {
            hasActiveTouch = YES;
            break;
        }
    }
    io.MouseDown[0] = hasActiveTouch;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self updateIOWithTouchEvent:event];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self updateIOWithTouchEvent:event];
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self updateIOWithTouchEvent:event];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self updateIOWithTouchEvent:event];
}

#pragma mark - MTKViewDelegate

- (void)drawInMTKView:(MTKView*)view
{
   
    
    ImGuiIO& io = ImGui::GetIO();
    io.DisplaySize.x = view.bounds.size.width;
    io.DisplaySize.y = view.bounds.size.height;

    CGFloat framebufferScale = view.window.screen.scale ?: UIScreen.mainScreen.scale;
    io.DisplayFramebufferScale = ImVec2(framebufferScale, framebufferScale);
    io.DeltaTime = 1 / float(view.preferredFramesPerSecond ?: 120);
    
    id<MTLCommandBuffer> commandBuffer = [self.commandQueue commandBuffer];
    

//Define your bool/function in here
    static bool show_s1 = false;    
    static bool show_s2 = false;    
    static bool show_s3 = false;    
    static bool show_s4 = false;    
    static bool show_s5 = false;    
    static bool show_s6 = false;                    
    static bool show_s7 = false;        
    static bool show_s8 = false;      
    static bool show_s9 = false;     
    static bool show_s10 = false;     
    static bool show_s11 = false;     
    static bool show_s12 = false;     

//Define active function
    static bool show_s0_active = false;
    static bool show_s1_active = false;
    
        
        if (MenDeal == true) {
            [self.view setUserInteractionEnabled:YES];
        } else if (MenDeal == false) {
            [self.view setUserInteractionEnabled:NO];
        }

        MTLRenderPassDescriptor* renderPassDescriptor = view.currentRenderPassDescriptor;
        if (renderPassDescriptor != nil)
        {
            id <MTLRenderCommandEncoder> renderEncoder = [commandBuffer renderCommandEncoderWithDescriptor:renderPassDescriptor];
            [renderEncoder pushDebugGroup:@"ImGui Jane"];

            ImGui_ImplMetal_NewFrame(renderPassDescriptor);
            ImGui::NewFrame();
            
            ImFont* font = ImGui::GetFont();
            font->Scale = 15.f / font->FontSize;
            
            CGFloat x = (([UIApplication sharedApplication].windows[0].rootViewController.view.frame.size.width) - 360) / 2;
            CGFloat y = (([UIApplication sharedApplication].windows[0].rootViewController.view.frame.size.height) - 300) / 2;
            
            ImGui::SetNextWindowPos(ImVec2(x, y), ImGuiCond_FirstUseEver);
            ImGui::SetNextWindowSize(ImVec2(400, 300), ImGuiCond_FirstUseEver);
            
                        if (MenDeal == true)
            {                
                ImGui::Begin("Free Fire Mod Menu [iOS Non-Jailbreak]", &MenDeal);
                
                ImGui::Text("Управление: 3 пальца х 3 тапа — Открыть | 2 пальца х 2 тапа — Скрыть");
                ImGui::Text("FPS: %.1f | Статус: Безопасно", ImGui::GetIO().Framerate);
                ImGui::Separator();

                if (ImGui::BeginTabBar("FreeFireTabs")) 
                {
                    if (ImGui::BeginTabItem("Стрельба (Aimbot)")) 
                    {
                        ImGui::Spacing();
                        ImGui::Checkbox("Включить Аимбот (Aimbot)", &show_s1);
                        ImGui::Checkbox("Аим по нажатию (Aim on Fire)", &show_s2);
                        ImGui::Checkbox("Умное наведение (Silent Aim)", &show_s3);
                        ImGui::Checkbox("Без отдачи (No Recoil)", &show_s4);
                    } // Это закрывает вкладку Аимбота

                    if (ImGui::BeginTabItem("Визуалы (ESP)")) 
                    {
                        ImGui::Spacing();
                        ImGui::Checkbox("Включить Hack Map (Оригинал)", &show_s0); 
                        ImGui::Separator();
                        ImGui::Checkbox("Линии до игроков (ESP Lines)", &show_s5);
                        ImGui::Checkbox("2D Квадраты (ESP Boxes)", &show_s6);
                        ImGui::Checkbox("Показывать здоровье (ESP Health)", &show_s7);
                        ImGui::Checkbox("Дистанция (ESP Distance)", &show_s8);
                        ImGui::EndTabItem();
                    }

                    if (ImGui::BeginTabItem("Разное (Misc)")) 
                    {
                        ImGui::Spacing();
                        ImGui::Checkbox("Быстрый бег (SpeedHack)", &show_s9);
                        ImGui::Checkbox("Высокий прыжок (Super Jump)", &show_s10);
                        ImGui::Checkbox("Подмена оружия (Weapon Swap)", &show_s11);
                        ImGui::Checkbox("Вечерний режим (Night Mode)", &show_s12);
                        ImGui::EndTabItem();
                    }

                    ImGui::EndTabBar();
                }

                ImGui::Separator();
                ImGui::Text("Создано для iPhone 7 (iOS 15.8.3) via GitHub Actions");

                ImGui::End();
                
                initial_setup();
            }

            ImDrawList* draw_list = ImGui::GetBackgroundDrawList();


//This function is a patch example function, doesn't work on this menu because I didn't add the button into menu UI
            if(show_s1){
                if(show_s1_active == NO){
                    patch("0x517A154", "0x360080D2");
                    patch_NULL("0x10517A154", "0x360080D2");
                    }
                show_s1_active = YES;
            }
            else{
                if(show_s1_active == YES){
                    patch("0x517A154", "0xF60302AA");
                    patch_NULL("0x10517A154", "0xF60302AA");
                    }
                show_s1_active = NO;
            }


            ImGui::Render();
            ImDrawData* draw_data = ImGui::GetDrawData();
            ImGui_ImplMetal_RenderDrawData(draw_data, commandBuffer, renderEncoder);
          
            [renderEncoder popDebugGroup];
            [renderEncoder endEncoding];

            [commandBuffer presentDrawable:view.currentDrawable];
        }

        [commandBuffer commit];
}

- (void)mtkView:(MTKView*)view drawableSizeWillChange:(CGSize)size
{
    
}

@end

