public class QRit.QRitUtils {

    public static void generateQR (QRit.Application application) {
        string qrContent = application.entry_contenttoqr.get_text ();
        if (qrContent != "") {
            string backgroundHex = QRit.QRitUtils.toHex (application.background);
            string foregroundHex = QRit.QRitUtils.toHex (application.foreground);

            string command = "qrencode "; // Base command
            command += " -s 6"; // QR image size
            command += " -t PNG"; // QR format image
            command += " --foreground=" + foregroundHex; // QR foreground color
            command += " --background=" + backgroundHex; // QR background color
            command += " -o " + application.cacheFolder + "/Awesome_QR.png "; // QR result path
            command += qrContent; // QR content
            executeCommand (command);

            application.label_tutorialtext.visible = false;
            
            application.image_qr.set_from_file (application.cacheFolder + "/Awesome_QR.png");

            application.revealer_qr.reveal_child = true;
        } else {
            application.notification.set_body (_("You must enter a content to that QR!"));
            application.send_notification ("com.github.sergius02.qrit", application.notification);
        }
    }

    public static void saveQR (QRit.Application application) {
        string fileName = application.entry_nameqr.get_text ();
        if (fileName != "") {
            if (!fileName.has_suffix (".png")) {
                fileName += ".png"; 
            }
            string command = "cp " + application.cacheFolder + "/Awesome_QR.png " + GLib.Environment.get_home_dir() + "/" + fileName;
            executeCommand (command);
            application.notification.set_body (_("QR saved at your home directory"));
            application.send_notification ("com.github.sergius02.qrit", application.notification);
        } else {
            application.notification.set_body (_("You must give an awesome name to that QR!"));
            application.send_notification ("com.github.sergius02.qrit", application.notification);
        }
    }

    public static void copyQR (QRit.Application application) {
        try {
            Gdk.Pixbuf pixbuf = new Gdk.Pixbuf.from_file (application.cacheFolder + "/Awesome_QR.png");
            application.clipboard.set_image(pixbuf);
            application.notification.set_body (_("Your QR is in your clipboard now!"));
            application.send_notification ("com.github.sergius02.qrit", application.notification);
        } catch (GLib.Error error) {
            printerr (error.message);
        }
    }
    
    private static void executeCommand (string command) {
        try {
            Process.spawn_command_line_sync (command);
        } catch (GLib.Error error) {
            printerr (error.message);
        }
    }

    private static string toHex (Gdk.RGBA rgba) {
        return "%02x%02x%02x"
            .printf((uint) (rgba.red * 255),
                    (uint) (rgba.green * 255),
                    (uint) (rgba.blue * 255));
    }

}