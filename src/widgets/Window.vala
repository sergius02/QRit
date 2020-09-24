public class QRit.Window {

    public Gtk.ApplicationWindow applicationWindow;
    public QRit.HeaderBar headerBar;

    public Gdk.RGBA background { get; set; }
    public Gdk.RGBA foreground { get; set; }

    public Gtk.Entry entry_nameqr { get; set; }

    public Gtk.Label label_tutorialtext { get; set; }

    public Gtk.Revealer revealer_qr { get; set; }

    public Gtk.Image image_qr { get; set; }

    public Gtk.Button button_copy { get; set; }
    public Gtk.Button button_save { get; set; }

    public Gtk.ColorButton colorbutton_background { get; set; }
    public Gtk.ColorButton colorbutton_foreground { get; set; }

    public Window (QRit.Application application) {
        generateUI (application.builder);
        
        this.applicationWindow = application.builder.get_object ("main_window") as Gtk.ApplicationWindow;
        this.headerBar = new QRit.HeaderBar (application);

        this.colorbutton_background.color_set.connect (() => {
            this.background = this.colorbutton_background.get_rgba ();

            QRit.QRitUtils.generateQR (application);
        });
        this.colorbutton_foreground.color_set.connect (() => {
            this.foreground = this.colorbutton_foreground.get_rgba ();

            QRit.QRitUtils.generateQR (application);
        });

        this.button_copy.clicked.connect (() => {
            QRit.QRitUtils.copyQR (application);
        });

        this.button_save.clicked.connect (() => {
            QRit.QRitUtils.saveQR (application);
        });
    }

    private void generateUI (Gtk.Builder builder) {
        this.entry_nameqr = builder.get_object ("entry_nameqr") as Gtk.Entry;

        this.label_tutorialtext = builder.get_object ("label_tutorialtext") as Gtk.Label;

        this.revealer_qr = builder.get_object ("revealer_qr") as Gtk.Revealer;

        this.image_qr = builder.get_object ("image_qr") as Gtk.Image;

        this.button_copy = builder.get_object ("button_copy") as Gtk.Button;
        this.button_save = builder.get_object ("button_save") as Gtk.Button;

        this.colorbutton_background = builder.get_object ("colorbutton_background") as Gtk.ColorButton;
        this.colorbutton_foreground = builder.get_object ("colorbutton_foreground") as Gtk.ColorButton;

        this.background = this.colorbutton_background.get_rgba ();
        this.foreground = this.colorbutton_foreground.get_rgba ();
    }

}