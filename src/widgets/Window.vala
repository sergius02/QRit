public class QRit.Window {

    public Window (QRit.Application application) {
        new QRit.HeaderBar (application);

        application.colorbutton_background.color_set.connect (() => {
            application.background = application.colorbutton_background.get_rgba ();
        });
        application.colorbutton_foreground.color_set.connect (() => {
            application.foreground = application.colorbutton_foreground.get_rgba ();
        });
        application.button_regenerate.clicked.connect (() => {
            QRit.QRitUtils.generateQR (application);
        });

        application.button_copy.clicked.connect (() => {
            QRit.QRitUtils.copyQR (application);
        });

        application.button_save.clicked.connect (() => {
            QRit.QRitUtils.saveQR (application);
        });
    }
}