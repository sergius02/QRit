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
        add_filter (file_filter);

        button_filechooser_open.clicked.connect (() => {
            string file_content = QRitUtils.read_file (get_filename ());
            dispose ();
            QRitUtils.generate_qr (application, file_content);
        });

        button_filechooser_close.clicked.connect (() => {
            dispose ();
        });
    }

}
