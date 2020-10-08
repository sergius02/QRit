/**
* The Window and all it components
*/
[GtkTemplate (ui = "/com/github/sergius02/qrit/ui/qrit.ui")]
public class QRit.ApplicationWindow : Gtk.ApplicationWindow {

    public QRit.HeaderBar headerBar;

    public Gdk.RGBA background;
    public Gdk.RGBA foreground;

    [GtkChild]
    public Gtk.Entry entry_nameqr;

    [GtkChild]
    public Gtk.Label label_tutorialtext;

    [GtkChild]
    public Gtk.Revealer revealer_qr;

    [GtkChild]
    public Gtk.Image image_qr;

    [GtkChild]
    public Gtk.Button button_copy;

    [GtkChild]
    public Gtk.Button button_save;

    [GtkChild]
    public Gtk.ColorButton colorbutton_background;

    [GtkChild]
    public Gtk.ColorButton colorbutton_foreground;

    public ApplicationWindow (QRit.Application application) {
        
        this.headerBar = new QRit.HeaderBar (application);
        this.set_titlebar (headerBar);

        // The buttons functionallity
        this.colorbutton_background.color_set.connect (() => {
            this.background = this.colorbutton_background.get_rgba ();

            QRit.QRitUtils.generateQR (application, QRit.QRitUtils.qr_content); // Automatically regenerate the QR
        });
        
        this.colorbutton_foreground.color_set.connect (() => {
            this.foreground = this.colorbutton_foreground.get_rgba ();

            QRit.QRitUtils.generateQR (application, QRit.QRitUtils.qr_content); // Automatically regenerate the QR
        });

        this.button_copy.clicked.connect (() => {
            QRit.QRitUtils.copyQR (application);
        });

        this.button_save.clicked.connect (() => {
            QRit.QRitUtils.saveQR (application);
        });

        this.background = this.colorbutton_background.get_rgba ();
        this.foreground = this.colorbutton_foreground.get_rgba ();
    }

}