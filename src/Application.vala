public class QRit.Application : Gtk.Application {

    public Gdk.RGBA background { get; set; }
    public Gdk.RGBA foreground { get; set; }

    public Gtk.Builder builder { get; set; }
    public Gtk.Clipboard clipboard { get; set; }
    public Notification notification { get; set; }
    public string cacheFolder { get; set; }

    public Gtk.Entry entry_contenttoqr { get; set; }
    public Gtk.Entry entry_nameqr { get; set; }

    public Gtk.Label label_tutorialtext { get; set; }

    public Gtk.Revealer revealer_qr { get; set; }

    public Gtk.Image image_qr { get; set; }

    public Gtk.Button button_contenttoqr { get; set; }
    public Gtk.Button button_copy { get; set; }
    public Gtk.Button button_save { get; set; }
    public Gtk.Button button_regenerate { get; set; }

    public Gtk.ColorButton colorbutton_background { get; set; }
    public Gtk.ColorButton colorbutton_foreground { get; set; }

    public Application () {
        Object (
            application_id: "com.github.sergius02.qrit",
            flags: ApplicationFlags.FLAGS_NONE
        );
    }

    protected override void activate () {
        var builder = new Gtk.Builder.from_resource ("/com/github/sergius02/qrit/ui/qrit.glade");
        generateUI (builder);
        createCacheFolder ();

        builder.set_application (this);
        var window = builder.get_object ("main_window") as Gtk.ApplicationWindow;
        this.clipboard = Gtk.Clipboard.get_for_display (window.get_display (), Gdk.SELECTION_CLIPBOARD);

        add_window (window);

        window.show_all ();

        new QRit.Window (this);
    }

    private void generateUI (Gtk.Builder builder) {
        this.notification = new Notification (_("QRit"));

        this.entry_contenttoqr = builder.get_object ("entry_contenttoqr") as Gtk.Entry;
        this.entry_nameqr = builder.get_object ("entry_nameqr") as Gtk.Entry;

        this.label_tutorialtext = builder.get_object ("label_tutorialtext") as Gtk.Label;

        this.revealer_qr = builder.get_object ("revealer_qr") as Gtk.Revealer;

        this.image_qr = builder.get_object ("image_qr") as Gtk.Image;

        this.button_contenttoqr = builder.get_object ("button_contenttoqr") as Gtk.Button;
        this.button_copy = builder.get_object ("button_copy") as Gtk.Button;
        this.button_save = builder.get_object ("button_save") as Gtk.Button;
        this.button_regenerate = builder.get_object ("button_regenerate") as Gtk.Button;

        this.colorbutton_background = builder.get_object ("colorbutton_background") as Gtk.ColorButton;
        this.colorbutton_foreground = builder.get_object ("colorbutton_foreground") as Gtk.ColorButton;

        this.background = this.colorbutton_background.get_rgba ();
        this.foreground = this.colorbutton_foreground.get_rgba ();
    }

    private string createCacheFolder () {
        this.cacheFolder = GLib.Path.build_filename (GLib.Environment.get_user_cache_dir (), application_id);
        try {
            File file = File.new_for_path (cacheFolder);
            if (!file.query_exists ()) {
                file.make_directory ();
            }

            return cacheFolder;
        } catch (Error e) {
            warning (e.message);
        }

        return "";
    }
}

