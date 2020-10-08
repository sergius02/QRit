/**
* This class helps the UI with the generation of the QR
*/
public class QRit.QRitUtils {

    public static string qr_content;

    /**
    * Generate the QR and store it in the cache folder.
    *
    * It takes the foreground and background from the Application
    */
    public static void generateQR (QRit.Application application, string qr_content) {
        if (qr_content != "") {
            QRit.QRitUtils.qr_content = qr_content;
            string backgroundHex = QRit.QRitUtils.toHex (application.window.background);
            string foregroundHex = QRit.QRitUtils.toHex (application.window.foreground);
            
            string[] command = {
                "qrencode",                                         // Base command
                "-o",application.cacheFolder + "/Awesome_QR.png",   // QR result path
                "-s","6",                                           // QR image size
                "-t","PNG",                                         // QR format image
                "--foreground=" + foregroundHex,                    // QR foreground color
                "--background=" + backgroundHex                     // QR background color
            };

            executeCommand (application, command);
            
            application.window.label_tutorialtext.visible = false;
            
            application.window.revealer_qr.reveal_child = true;
        } else {
            application.notification.set_body (_("You must enter a content to that QR!"));
            application.send_notification ("com.github.sergius02.qrit", application.notification);
        }
    }

    /** 
    * Save the QR to the $HOME folder
    */
    public static void saveQR (QRit.Application application) {
        string fileName = application.window.entry_nameqr.get_text ();
        if (fileName == "") {
            fileName = "Awesome_QR.png";
        }

        if (!fileName.has_suffix (".png")) {
            fileName += ".png"; 
        }

        string[] command_piped = {
            "cp", application.cacheFolder + "/Awesome_QR.png", 
            GLib.Environment.get_home_dir() + "/" + fileName
        };

        executeCommand (application, command_piped);
        application.notification.set_body (_("QR saved at your home directory"));
        application.send_notification ("com.github.sergius02.qrit", application.notification);
    }

    /**
    * Copy the QR to the clipboard
    */
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
    
    /**
    * Auxiliar method to execute commands
    */
    private static void executeCommand (QRit.Application application, string[] command) {
        int child_pid, standard_input, standard_output, standard_error;
        try {
            Process.spawn_async_with_pipes ("$HOME", command,Environ.get (), SpawnFlags.SEARCH_PATH | SpawnFlags.DO_NOT_REAP_CHILD, null, out child_pid,  out standard_input, out standard_output, out standard_error);
        } catch (GLib.SpawnError error) {
            printerr (error.message);
        }

        FileStream command_input = FileStream.fdopen (standard_input, "w");
        command_input.write (qr_content.data);
        ChildWatch.add (child_pid, (pid, status) => {
            // Triggered when the child indicated by child_pid exits
            Process.close_pid (pid);
            application.window.image_qr.set_from_file (application.cacheFolder + "/Awesome_QR.png");
        });
    }

    /**
    * Convert RGBA to HEX format
    */
    private static string toHex (Gdk.RGBA rgba) {
        return "%02x%02x%02x"
            .printf((uint) (rgba.red * 255),
                    (uint) (rgba.green * 255),
                    (uint) (rgba.blue * 255));
    }

}