/**
* The HeaderBar and all it components
*/
[GtkTemplate (ui = "/com/github/sergius02/qrit/ui/headerbar.ui")]
public class QRit.HeaderBar : Gtk.HeaderBar{

    [GtkChild]
    public Gtk.Entry entry_contenttoqr;

    [GtkChild]
    public Gtk.Button button_contenttoqr;

    public HeaderBar (QRit.Application application) {
        
        this.button_contenttoqr.clicked.connect (() => {
            QRit.QRitUtils.generateQR (application);
        });

        this.entry_contenttoqr.activate.connect (() => {
            // If the Gtk.Entry is empty, disable QR generation
            if (this.entry_contenttoqr.text != "") {
                QRitUtils.generateQR (application);
            }
        });

        this.entry_contenttoqr.changed.connect (() => {
            // If the Gtk.Entry is empty, disable generate button
            this.button_contenttoqr.sensitive = (this.entry_contenttoqr.text != "");
        });

        this.button_contenttoqr.sensitive = false;
    }

}