#link <gtk-3>
#link <gdk-3>
#link <gobject-2.0>
#link <glib-2.0>
#link <fontconfig>

//**********************************************
// System & Signal Bindings
//**********************************************
extern "c" U0 gtk_main_quit();
extern "c" U64 g_signal_connect_data(U8 *instance, U8 *detailed_signal, U0 *c_handler, U8 *data, U8 *destroy_data, I32 connect_flags);
extern "c" U32 g_timeout_add(U32 interval, U0 *function, U8 *data);
extern "c" U8 FcConfigAppFontAddFile(U8 *config, U8 *file);
extern "c" I32 system(U8 *command);

#ifdef _WIN32
#link <winmm>
extern "c" I32 PlaySoundA(U8 *pszSound, U8 *hmod, U32 fdwSound);
#endif

//**********************************************
// GTK Core & Layout Bindings
//**********************************************
extern "c" U0 gtk_init(I32 *argc, U8 ***argv);
extern "c" U8* gtk_window_new(I32 type);
extern "c" U0 gtk_window_set_title(U8 *window, U8 *title);
extern "c" U0 gtk_window_set_default_size(U8 *window, I32 width, I32 height);
extern "c" U0 gtk_widget_show_all(U8 *widget);
extern "c" U0 gtk_widget_set_opacity(U8 *widget, F64 opacity);
extern "c" U0 gtk_main();

extern "c" U8* gtk_box_new(I32 orientation, I32 spacing);
extern "c" U0 gtk_container_add(U8 *container, U8 *widget);
extern "c" U0 gtk_box_pack_start(U8 *box, U8 *child, I32 expand, I32 fill, I32 padding);
extern "c" U8* gtk_stack_new();
extern "c" U8* gtk_stack_switcher_new();
extern "c" U0 gtk_stack_switcher_set_stack(U8 *switcher, U8 *stack);
extern "c" U0 gtk_stack_set_transition_type(U8 *stack, I32 transition);
extern "c" U0 gtk_stack_set_transition_duration(U8 *stack, U32 duration);
extern "c" U0 gtk_stack_set_visible_child_name(U8 *stack, U8 *name);
extern "c" U0 gtk_stack_add_named(U8 *stack, U8 *child, U8 *name);
extern "c" U0 gtk_stack_add_titled(U8 *stack, U8 *child, U8 *name, U8 *title);
extern "c" U8* gtk_label_new(U8 *str);
extern "c" U8* gtk_entry_new();
extern "c" U0 gtk_entry_set_placeholder_text(U8 *entry, U8 *text);
extern "c" U8* gtk_button_new_with_label(U8 *label);
extern "c" U0 gtk_widget_set_name(U8 *widget, U8 *name);
extern "c" U0 gtk_container_set_border_width(U8 *container, U32 border_width);

//**********************************************
// GTK CSS Bindings
//**********************************************
extern "c" U8* gtk_css_provider_new();
extern "c" U0 gtk_css_provider_load_from_data(U8 *css_provider, U8 *data, I64 length, U8 *error);
extern "c" U8* gdk_display_get_default();
extern "c" U8* gdk_display_get_default_screen(U8 *display);
extern "c" U0 gtk_style_context_add_provider_for_screen(U8 *screen, U8 *provider, U32 priority);

//**********************************************
// Globals for Animation State
//**********************************************
U8 *g_win = 0;
U8 *g_stack = 0;
U8 *g_switcher = 0;
F64 g_opacity = 0.0;
F64 g_menu_opacity = 0.0;

//**********************************************
// Custom Callbacks & Timers
//**********************************************
U0 QuitHandler() {
    #ifdef _WIN32
    PlaySoundA(0, 0, 0);
    #else
    system("kill -9 $(cat /tmp/inq_music.pid) 2>/dev/null");
    #endif
    gtk_main_quit();
}

// Timer 1: Fades in the main application window from black
I32 FadeInTick(U8 *data) {
    g_opacity = g_opacity + 0.05;
    if (g_opacity >= 1.0) {
        gtk_widget_set_opacity(g_win, 1.0);
        return 0; // Stop the timer
    }
    gtk_widget_set_opacity(g_win, g_opacity);
    return 1; // Continue the timer
}

// Timer 3: Fades in the navigation menu elements smoothly
I32 FadeInMenuTick(U8 *data) {
    g_menu_opacity = g_menu_opacity + 0.02;
    if (g_menu_opacity >= 1.0) {
        gtk_widget_set_opacity(g_switcher, 1.0);
        return 0; // Stop the timer
    }
    gtk_widget_set_opacity(g_switcher, g_menu_opacity);
    return 1; // Continue the timer
}

// Timer 4: Disables stack transition after the intro finishes
I32 DisableTransition(U8 *data) {
    gtk_stack_set_transition_type(g_stack, 0); // 0 = GTK_STACK_TRANSITION_TYPE_NONE
    return 0; // Stop the timer
}

// Timer 2: Triggers the crossfade to the menu and starts music
I32 SplashToMenu(U8 *data) {
    // Start music with fade-in effect
    #ifdef _WIN32
    PlaySoundA("music.wav", 0, 0x20009);
    #else
    system("mpv --loop-file=inf --no-video --af=afade=t=in:ss=0:d=3 music.wav >/dev/null 2>&1 & echo $! > /tmp/inq_music.pid");
    #endif

    // Trigger GTK Crossfade animation for the stack content
    gtk_stack_set_visible_child_name(g_stack, "menu");

    // Start fade-in timer for the navigation tabs
    g_timeout_add(50, &FadeInMenuTick, 0);

    // 2500ms is the duration of the crossfade. After it finishes, disable animations.
    g_timeout_add(2500, &DisableTransition, 0);

    return 0; // Stop the timer
}

//**********************************************
// UI Component Functions
//**********************************************

U8* CreateSplashTab() {
    U8 *box = gtk_box_new(1, 0);
    // Catholic Cross symbol for the Inquisition
    U8 *cross_label = gtk_label_new("✝");
    gtk_widget_set_name(cross_label, "cross_label");
    gtk_box_pack_start(box, cross_label, 1, 1, 0);
    return box;
}

U8* CreateMenuTab() {
    U8 *box = gtk_box_new(1, 30);
    U8 *title = gtk_label_new("Nikt nie spodziewa sie\nHiszpanskiej Inkwizycji!");
    gtk_widget_set_name(title, "title_label");
    gtk_box_pack_start(box, title, 1, 1, 0);
    return box;
}

U8* CreateRegisterTab() {
    U8 *box = gtk_box_new(1, 15);

    U8 *e1 = gtk_entry_new(); gtk_entry_set_placeholder_text(e1, "Imie heretyka");
    U8 *e2 = gtk_entry_new(); gtk_entry_set_placeholder_text(e2, "Nazwisko heretyka");
    U8 *e3 = gtk_entry_new(); gtk_entry_set_placeholder_text(e3, "Wiek");
    U8 *e4 = gtk_entry_new(); gtk_entry_set_placeholder_text(e4, "Rodzaj herezji");
    U8 *btn = gtk_button_new_with_label("Zglos na stos");

    gtk_box_pack_start(box, e1, 0, 0, 5);
    gtk_box_pack_start(box, e2, 0, 0, 5);
    gtk_box_pack_start(box, e3, 0, 0, 5);
    gtk_box_pack_start(box, e4, 0, 0, 5);
    gtk_box_pack_start(box, btn, 0, 0, 20);

    return box;
}

U8* CreateInterrogationTab() {
    U8 *box = gtk_box_new(1, 15);

    U8 *e1 = gtk_entry_new(); gtk_entry_set_placeholder_text(e1, "Data i czas");
    U8 *e2 = gtk_entry_new(); gtk_entry_set_placeholder_text(e2, "Inkwizytor prowadzacy");
    U8 *e3 = gtk_entry_new(); gtk_entry_set_placeholder_text(e3, "Wynik");
    U8 *e4 = gtk_entry_new(); gtk_entry_set_placeholder_text(e4, "Transkrypt");
    U8 *btn = gtk_button_new_with_label("Zaplanuj Przesluchanie");

    gtk_box_pack_start(box, e1, 0, 0, 5);
    gtk_box_pack_start(box, e2, 0, 0, 5);
    gtk_box_pack_start(box, e3, 0, 0, 5);
    gtk_box_pack_start(box, e4, 0, 0, 5);
    gtk_box_pack_start(box, btn, 0, 0, 20);

    return box;
}

U8* CreateInventoryTab() {
    U8 *box = gtk_box_new(1, 15);

    U8 *e1 = gtk_entry_new(); gtk_entry_set_placeholder_text(e1, "Numer Sali");
    U8 *e2 = gtk_entry_new(); gtk_entry_set_placeholder_text(e2, "Wyposazenie");
    U8 *e3 = gtk_entry_new(); gtk_entry_set_placeholder_text(e3, "Pojemnosc");
    U8 *e4 = gtk_entry_new(); gtk_entry_set_placeholder_text(e4, "Status");
    U8 *btn = gtk_button_new_with_label("Aktualizuj Inwentarz");

    gtk_box_pack_start(box, e1, 0, 0, 5);
    gtk_box_pack_start(box, e2, 0, 0, 5);
    gtk_box_pack_start(box, e3, 0, 0, 5);
    gtk_box_pack_start(box, e4, 0, 0, 5);
    gtk_box_pack_start(box, btn, 0, 0, 20);

    return box;
}

//**********************************************
// Application Entry Point
//**********************************************
U0 Main() {
    I32 argc = 0;
    U8 **argv = 0;

    gtk_init(&argc, &argv);
    FcConfigAppFontAddFile(0, "font.ttf");

    //**********************************************
    // CSS Styling Setup
    //**********************************************
    U8 *provider = gtk_css_provider_new();
    U8 *css =
    "window { background-image: radial-gradient(circle at center, #3b0d0d 0%, #050101 100%); }\n"
    "#main_box { border: 6px double #d4af37; padding: 20px; background-color: rgba(0,0,0,0.4); }\n"

    // Splash screen cross styling
    "#cross_label { font-size: 200px; color: #d4af37; text-shadow: 0 0 40px #ff0000, 0 0 15px #ff0000; margin-top: 80px; }\n"

    "label { color: #d4af37; font-family: \"SanMarco\", serif; text-shadow: 2px 2px 4px #000000; font-size: 24px; }\n"
    "button { background-image: linear-gradient(to bottom, #5c0000, #2b0000); color: #d4af37; font-family: \"SanMarco\", serif; font-size: 20px; border: 2px solid #1a0000; border-radius: 4px; box-shadow: inset 0 0 4px #ff4d4d, 0 4px 8px rgba(0,0,0,0.9); padding: 12px; transition: all 150ms ease-in-out; }\n"
    "button:hover { background-image: linear-gradient(to bottom, #8a0000, #4d0000); border-color: #d4af37; box-shadow: inset 0 0 8px #ff4d4d, 0 4px 12px rgba(0,0,0,1); }\n"
    "button:active { background-image: linear-gradient(to bottom, #3a0000, #1a0000); box-shadow: inset 0 4px 10px rgba(0,0,0,0.9); color: #a88a2d; }\n"
    "button:checked { background-image: linear-gradient(to bottom, #1a0000, #050000); border-color: #d4af37; box-shadow: inset 0 4px 12px rgba(0,0,0,1); color: #886a1d; }\n"
    "button:checked:hover { background-image: linear-gradient(to bottom, #1a0000, #050000); box-shadow: inset 0 4px 12px rgba(0,0,0,1); }\n"
    "entry { background-color: rgba(10, 2, 2, 0.85); color: #e8d08b; border: 2px solid #5c0000; border-radius: 2px; box-shadow: inset 3px 3px 6px #000000; font-family: \"SanMarco\", serif; font-size: 22px; padding: 10px; }\n"
    "entry:focus { border-color: #d4af37; }\n"
    "#title_label { font-size: 52px; color: #ff2a2a; text-shadow: 0 0 15px #ff0000, 4px 4px 6px #000000; }";

    gtk_css_provider_load_from_data(provider, css, -1, 0);
    U8 *display = gdk_display_get_default();
    U8 *screen = gdk_display_get_default_screen(display);
    gtk_style_context_add_provider_for_screen(screen, provider, 800);

    //**********************************************
    // Main Window Setup
    //**********************************************
    g_win = gtk_window_new(0);
    gtk_window_set_title(g_win, "Spanish Inquisition CMS");
    gtk_window_set_default_size(g_win, 900, 700);
    gtk_widget_set_opacity(g_win, 0.0); // Start fully transparent

    g_signal_connect_data(g_win, "destroy", &QuitHandler, 0, 0, 0);

    U8 *vbox = gtk_box_new(1, 0);
    gtk_widget_set_name(vbox, "main_box");
    gtk_container_set_border_width(vbox, 15);
    gtk_container_add(g_win, vbox);

    //**********************************************
    // Navigation Stack Setup (with animations)
    //**********************************************
    g_stack = gtk_stack_new();

    // 1 = GTK_STACK_TRANSITION_TYPE_CROSSFADE
    gtk_stack_set_transition_type(g_stack, 1);
    // Crossfade duration: 2500 milliseconds (2.5 seconds)
    gtk_stack_set_transition_duration(g_stack, 2500);

    g_switcher = gtk_stack_switcher_new();
    gtk_stack_switcher_set_stack(g_switcher, g_stack);

    gtk_box_pack_start(vbox, g_switcher, 0, 0, 15);
    gtk_box_pack_start(vbox, g_stack, 1, 1, 0);

    //**********************************************
    // Initialize Tabs from Functions
    //**********************************************

    // Add Splash Tab (Using add_named so it doesn't get a button in the switcher)
    U8 *splash_box = CreateSplashTab();
    gtk_stack_add_named(g_stack, splash_box, "splash");

    // Add standard tabs
    U8 *menu_box = CreateMenuTab();
    U8 *reg_box = CreateRegisterTab();
    U8 *int_box = CreateInterrogationTab();
    U8 *inv_box = CreateInventoryTab();

    gtk_stack_add_titled(g_stack, menu_box, "menu", "Glowna Sala");
    gtk_stack_add_titled(g_stack, reg_box, "register", "Rejestr Grzechow");
    gtk_stack_add_titled(g_stack, int_box, "interrogation", "Zarzadzanie Przesluchaniami");
    gtk_stack_add_titled(g_stack, inv_box, "inventory", "Inwentarz Sali");

    // Show all widgets
    gtk_widget_show_all(g_win);

    // Crucial fix: Make the switcher fully transparent instead of hiding it.
    // This reserves the vertical space from the start, so the cross won't jump.
    gtk_widget_set_opacity(g_switcher, 0.0);

    //**********************************************
    // Start Timers
    //**********************************************
    // Timer 1: Trigger window fade-in every 50ms (Takes 1 second total)
    g_timeout_add(50, &FadeInTick, 0);

    // Timer 2: Wait 2.5 seconds, then trigger the fade-out to the main menu
    g_timeout_add(2500, &SplashToMenu, 0);

    gtk_main();
}
Main;
