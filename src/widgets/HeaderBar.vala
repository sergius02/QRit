/**
* The HeaderBar and all it components
*/
public class QRit.HeaderBar {

    public Gtk.Entry entry_contenttoqr;

    public Gtk.Button button_contenttoqr;

    public HeaderBar (QRit.Application application) {
        generateUI (application.builder);
        
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
    }

    /**
    * Initialize the HeaderBar components from the .glade
    */
    private void generateUI (Gtk.Builder builder) {
        this.entry_contenttoqr = builder.get_object ("entry_contenttoqr") as Gtk.Entry;
        this.button_contenttoqr = builder.get_object ("button_contenttoqr") as Gtk.Button;

        this.button_contenttoqr.sensitive = false;
    }

}