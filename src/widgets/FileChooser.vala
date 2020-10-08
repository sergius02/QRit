[GtkTemplate (ui = "/com/github/sergius02/qrit/ui/file_chooser.ui")]
public class QRit.FileChooser : Gtk.FileChooserDialog {

    [GtkChild]
    private Gtk.Button button_filechooser_open;

    [GtkChild]
    private Gtk.Button button_filechooser_close;

    public FileChooser (QRit.Application application) {
        Gtk.FileFilter file_filter = new Gtk.FileFilter ();
        file_filter.add_pattern ("*.txt");
        file_filter.add_pattern ("*.html");
        file_filter.add_pattern ("*.css");
        file_filter.add_pattern ("*.js");
        add_filter(file_filter);

        button_filechooser_open.clicked.connect (() => {
            string result = "";
            File file = File.new_for_path (get_filename ());
            try {
                FileInputStream @is = file.read ();
                DataInputStream dis = new DataInputStream (@is);
                string line;

                while ((line = dis.read_line ()) != null) {
                    result += line + "\n";
                }
            } catch (Error e) {
                print ("Error: %s\n", e.message);
            }
    
            dispose ();

            QRitUtils.generateQR (application, result);
        });

        button_filechooser_close.clicked.connect (() => {
            dispose ();
        });
    }

}