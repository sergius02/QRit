/**
* The HeaderBar and all it components
*/
[GtkTemplate (ui = "/com/github/sergius02/qrit/ui/headerbar.ui")]
public class QRit.HeaderBar : Gtk.HeaderBar {

    [GtkChild]
    public Gtk.Entry entry_contenttoqr;

    [GtkChild]
    public Gtk.Button button_contenttoqr;

    [GtkChild]
    public Gtk.Button button_openfile;

    public HeaderBar (QRit.Application application) {
        this.button_contenttoqr.clicked.connect (() => {
            QRit.QRitUtils.generate_qr (application, entry_contenttoqr.text);
        });

        this.entry_contenttoqr.activate.connect (() => {
            // If the Gtk.Entry is empty, disable QR generation
            if (this.entry_contenttoqr.text != "") {
                QRitUtils.generate_qr (application, entry_contenttoqr.text);
            }
        });

        this.entry_contenttoqr.changed.connect (() => {
            // If the Gtk.Entry is empty, disable generate button
            this.button_contenttoqr.sensitive = (this.entry_contenttoqr.text != "");
        });

        this.button_openfile.clicked.connect (() => {

            var file_chooser = new Gtk.FileChooserNative (
                null,
                application.window,
                Gtk.FileChooserAction.OPEN,
                _("Open"),
                _("Cancel")
            );

            Gtk.FileFilter file_filter = new Gtk.FileFilter ();
            file_filter.add_pattern ("*.txt");
            file_filter.add_pattern ("*.html");
            file_filter.add_pattern ("*.css");
            file_filter.add_pattern ("*.js");
            file_chooser.add_filter (file_filter);

            file_chooser.response.connect ((id) => {
                if (id == Gtk.ResponseType.ACCEPT) {
                    string file_content = QRitUtils.read_file (file_chooser.get_filename ());
                    file_chooser.dispose ();
                    QRitUtils.generate_qr (application, file_content);
                } else {
                    file_chooser.dispose ();
                }
            });

            file_chooser.show ();
        });

        this.button_contenttoqr.sensitive = false;
    }

}
