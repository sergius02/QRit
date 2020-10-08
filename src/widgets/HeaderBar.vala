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
            QRit.FileChooser file_chooser = new QRit.FileChooser (application);
            file_chooser.transient_for = application.window;
            file_chooser.present ();
        });

        this.button_contenttoqr.sensitive = false;
    }

}
