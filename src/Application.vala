/**
* The main class of the application
*/
public class QRit.Application : Gtk.Application {

    public Gtk.Clipboard clipboard;
    public Notification notification;
    public string cache_folder;

    public QRit.ApplicationWindow window;

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
        this.notification = new Notification (_("QRit"));
        create_cache_folder ();

        this.window = new QRit.ApplicationWindow (this);
        this.clipboard = Gtk.Clipboard.get_for_display (this.window.get_display (), Gdk.SELECTION_CLIPBOARD);

        add_window (window);
        window.show_all ();
    }

    /**
    * This method creates the cache folder $HOME/.cache where QRit stores the QR generated
    */
    public string create_cache_folder () {
        this.cache_folder = GLib.Path.build_filename (GLib.Environment.get_user_cache_dir (), application_id);
        try {
            File file = File.new_for_path (cache_folder);
            if (!file.query_exists ()) {
                file.make_directory ();
            } else {
                clean_cache_folder ();
            }

            return cache_folder;
        } catch (Error e) {
            warning (e.message);
        }

        return "";
    }

    public void clean_cache_folder () {
        try {
            Dir dir = Dir.open (cache_folder);
            string file_name = "";
            while ((file_name = dir.read_name ()) != null) {
                FileUtils.remove (cache_folder + "/" + file_name);
            }
        } catch (Error e) {
            warning (e.message);
        }
    }
}
