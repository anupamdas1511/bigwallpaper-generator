# **bwall - Big Wallpaper**

`bwall` is a simple command-line tool that automatically changes your desktop wallpaper by downloading random high-quality wallpapers from Unsplash, based on a user-defined query or theme. It supports various desktop environments and window managers such as GNOME, KDE, XFCE.

## **Features**
- Downloads random wallpapers from Unsplash using their API.
- Allows custom search queries for specific themes (e.g., nature, city, space).
- Automatically sets the downloaded image as the wallpaper.
- Supports GNOME, KDE Plasma, XFCE, and lightweight window managers like `feh`.
- Can be automated to run at system startup.

## **Requirements**
- **cURL**: For making HTTP requests to the Unsplash API.
- **jq**: For parsing JSON responses from the API.
- **gsettings**, **xfconf-query**, **qdbus**, or **feh** (depending on your desktop environment).

### **Dependencies (Installation)**

To install the required dependencies on Ubuntu/Debian-based systems:

```bash
sudo apt update
sudo apt install curl jq gsettings-desktop-schemas
```

### **Installation**

1. **Clone or download the script:**
```bash
git clone https://github.com/anupamdas1511/bigwallpaper-generator.git
```

2. **Set up your Unsplash API Access Key:**

    - Sign up at [Unsplash Developers](https://unsplash.com/developers) and get an API access key.
    - Update the `ACCESS_KEY` variable in the `bwall.sh` script with your key.
        ```bash
        ACCESS_KEY="your_unsplash_access_key_here"
        ```
        Replace `your_unsplash_access_key_here` with your actual API access key.


3. **Move the script to a directory in your `PATH`:**
```bash
cd bigwallpaper-generator
./install.sh
```

4. **Ensure that the script is executable:**
```bash
chmod +x $HOME/Script/bwall
```

## **Usage**
### **Basic Command**

To change the wallpaper, simple run:
```bash
bwall
``` 

### **Options**

- **Search by query**: You can specify a query (e.g., `nature`, `city`) to get wallpapers related to that theme. The query string will be URL-encoded automatically.

    ```bash
    bwall --query nature
    ```
    or
    ```bash
    bwall -q nature
    ```

- **Help**: To display `help` information:
    ```bash
    bwall --help
    ```
    or
    ```bash
    bwall -h
    ```

### **Automate on Startup (Optional)**

To automatically set a new wallpaper on system startup:

1. Open the crontab:

   ```bash
   crontab -e
   ```

2. Add the following line to run `bwall` on reboot:

    ```bash
    @reboot /bin/bash /home/yourusername/Scripts/bwall
    ```
    Replace *yourusername* with your actual username if necessary.

This ensures that `bwall` will run every time your system starts, fetching and setting a new wallpaper. You can set it as you see fit.

## **Desktop Environment Support**

`bwall` supports several desktop environments and window managers. It automatically detects the environment and sets the wallpaper accordingly:

-    GNOME: Uses `gsettings`.
-    XFCE: Uses `xfconf-query`.
-    KDE Plasma: Uses `qdbus`.

Uncomment the appropriate lines in the script depending on your desktop environment.