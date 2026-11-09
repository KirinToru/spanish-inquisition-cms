// Говорим компилятору автоматически слинковать GTK3
#link <gtk-3>

extern "c" U0 gtk_init(I32 *argc, U8 ***argv);
extern "c" U8* gtk_window_new(I32 type);
extern "c" U0 gtk_window_set_title(U8 *window, U8 *title);
extern "c" U0 gtk_window_set_default_size(U8 *window, I32 width, I32 height);
extern "c" U8* gtk_label_new(U8 *str);
extern "c" U0 gtk_container_add(U8 *container, U8 *widget);
extern "c" U0 gtk_widget_show_all(U8 *widget);
extern "c" U0 gtk_main();

U0 Main() {
    I32 argc = 0;
    U8 **argv = 0;

    gtk_init(&argc, &argv);

    U8 *win = gtk_window_new(0);
    gtk_window_set_title(win, "Test Interfejsu - HolyC");
    gtk_window_set_default_size(win, 400, 200);

    U8 *label = gtk_label_new("Jan Pawel II kochal gory i kremowki.");

    gtk_container_add(win, label);
    gtk_widget_show_all(win);

    "Starting basic GUI loop...\n";
    gtk_main();
}
Main;
