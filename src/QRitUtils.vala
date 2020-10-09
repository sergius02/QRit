/**
* This class helps the UI with the generation of the QR
*/
public class QRit.QRitUtils {

    public static string qr_content;
    public static string file_extension;

    /**
    * Generate the QR and store it in the cache folder.
    *
    * It takes the foreground and background from the Application
    */
    public static void generate_qr (QRit.Application application, string qr_content) {
        if (qr_content != "") {
            QRit.QRitUtils.qr_content = qr_content;
            QRit.QRitUtils.file_extension = application.window.combobox_formats.get_active_text ();
            string background_hex = QRit.QRitUtils.to_hex (application.window.background);
            string foregroun_hex = QRit.QRitUtils.to_hex (application.window.foreground);
            
            string cached_file = application.cache_folder + "/Awesome_QR." + file_extension;
            string[] command = {
                "qrencode",                         // Base command
                "-o", cached_file,                  // QR result path
                "-s", "6",                          // QR image size
                "-t", file_extension.up (),         // QR format image
                "--foreground=" + foregroun_hex,    // QR foreground color
                "--background=" + background_hex    // QR background color
            };

            execute_command (application, command);

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
    public static void save_qr (QRit.Application application) {
        string file_name = application.window.entry_nameqr.get_text ();
        if (file_name == "") {
            file_name = "Awesome_QR.";
        }
        file_name += file_extension;

        string[] command_piped = {
            "cp", application.cache_folder + "/Awesome_QR." + file_extension,
            GLib.Environment.get_home_dir () + "/" + file_name
        };

        execute_command (application, command_piped);
        application.notification.set_body (_("QR saved at your home directory"));
        application.send_notification ("com.github.sergius02.qrit", application.notification);
    }

    /**
    * Copy the QR to the clipboard
    */
    public static void copy_qr (QRit.Application application) {
        try {
            Gdk.Pixbuf pixbuf = new Gdk.Pixbuf.from_file (application.cache_folder + "/Awesome_QR.png");
            application.clipboard.set_image (pixbuf);
            application.notification.set_body (_("Your QR is in your clipboard now!"));
            application.send_notification ("com.github.sergius02.qrit", application.notification);
        } catch (GLib.Error error) {
            printerr (error.message);
        }
    }

    /**
    * Auxiliar method to execute commands
    */
    private static void execute_command (QRit.Application application, string[] command) {
        int child_pid, standard_input, standard_output, standard_error;
        try {
            Process.spawn_async_with_pipes (
                "$HOME",
                command,
                Environ.get (),
                SpawnFlags.SEARCH_PATH | SpawnFlags.DO_NOT_REAP_CHILD,
                null,
                out child_pid,
                out standard_input,
                out standard_output,
                out standard_error
            );
        } catch (GLib.SpawnError error) {
            printerr (error.message);
        }

        FileStream command_input = FileStream.fdopen (standard_input, "w");
        command_input.write (qr_content.data);
        ChildWatch.add (child_pid, (pid, status) => {
            // Triggered when the child indicated by child_pid exits
            Process.close_pid (pid);

            application.window.image_qr.set_from_file (application.cache_folder + "/Awesome_QR."+file_extension);
            if (file_extension == "png" || file_extension == "svg") {
                application.window.label_warning_preview.visible = false;
            } else {
                application.window.label_warning_preview.visible = true;
            }
        });
    }

    /**
    * Convert RGBA to HEX format
    */
    private static string to_hex (Gdk.RGBA rgba) {
        return "%02x%02x%02x"
            .printf ((uint) (rgba.red * 255),
                    (uint) (rgba.green * 255),
                    (uint) (rgba.blue * 255));
    }

}
