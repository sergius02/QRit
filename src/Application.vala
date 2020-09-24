public class QRit.Application : Gtk.Application {

    public Gtk.Builder builder { get; set; }
    public Gtk.Clipboard clipboard { get; set; }
    public Notification notification { get; set; }
    public string cacheFolder { get; set; }

    public QRit.Window window;

    public static int main (string[] args) {
        var app = new QRit.Application ();
        return app.run (args);
    }

    public Application () {
        Object (
            application_id: "com.github.sergius02.qrit",
            flags: ApplicationFlags.FLAGS_NONE
        );
    }

    protected override void activate () {
        this.builder = new Gtk.Builder.from_resource ("/com/github/sergius02/qrit/ui/qrit.glade");
        this.notification = new Notification (_("QRit"));
        createCacheFolder ();

        builder.set_application (this);
        
        this.window = new QRit.Window (this);
        this.clipboard = Gtk.Clipboard.get_for_display (this.window.applicationWindow.get_display (), Gdk.SELECTION_CLIPBOARD);

        add_window (window.applicationWindow);
        window.applicationWindow.show_all ();
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

