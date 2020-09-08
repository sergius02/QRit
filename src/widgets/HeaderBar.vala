public class QRit.HeaderBar {

    private Gtk.Builder builder { get; set; }

    public HeaderBar (QRit.Application application) {
        application.button_contenttoqr.clicked.connect (() => {
            QRit.QRitUtils.generateQR (application);
        });
    }

}