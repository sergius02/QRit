/**
* The main class of the application
*/
public class QRit.Application : Gtk.Application {

    public Gtk.Clipboard clipboard;
    public Notification notification;
    public string cache_folder;

    public QRit.ApplicationWindow window;

    public static int main (string[] args) {
        var app = new QRit.Application (args);
        return app.run (args);
    }

    public Application (string[] args) {
        Object (
            application_id: "com.github.sergius02.qrit",
            flags: ApplicationFlags.HANDLES_COMMAND_LINE
        );
    }

    public override int command_line (ApplicationCommandLine command_line) {
        this.hold ();
        int res = _command_line (command_line);
        this.release ();
        return res;
    }

    private int _command_line (ApplicationCommandLine command_line) {
        bool version = false;
        string file = "";
        string text = "";

        OptionEntry[] options = new OptionEntry[3];
        options[0] = {"version", 'v', 0, OptionArg.STRING, ref version, "Version number", null};
        options[1] = {"file", 'f', 0, OptionArg.FILENAME, ref file, "Absolute path to the file you want to convert into a QR", null};
        options[2] = {"text", 't', 0, OptionArg.STRING, ref text, "The text you want to convert into a QR", null};
        // We have to make an extra copy of the array, since .parse assumes
		// that it can remove strings from the array without freeing them.
		string[] args = command_line.get_arguments ();
		string*[] _args = new string[args.length];
		for (int i = 0; i < args.length; i++) {
			_args[i] = args[i];
		}

		try {
			var opt_context = new OptionContext ("");
			opt_context.set_help_enabled (true);
			opt_context.add_main_entries (options, null);
			unowned string[] tmp = _args;
			opt_context.parse (ref tmp);
		} catch (OptionError e) {
			command_line.print ("error: %s\n", e.message);
			command_line.print ("Run '%s --help' to see a full list of available command line options.\n", args[0]);
			return 0;
		}

		if (version) {
			command_line.print ("QRit 1.0.4\n");
			return 0;
        } else if (file != "") {
            activate ();
            string file_content = QRitUtils.read_file (file);
            QRitUtils.generate_qr (this, file_content);
        } else if (text != "") {
            activate ();
            QRitUtils.generate_qr (this, text);
        } else {
            activate ();
        }
        
        return 0;
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
