# Photostream Import

This scans the photostream folder and any files that exist in that folder are copied to another folder. This other folder I have setup in Picasa. It also sorts them in to yearly folders. This can really be used for any sort of syncronization of two folders but was primarily designed for photostream.

Photostream works by displaying the last few months of pictures. After a while these are deleted from photostream and no longer exist in the photostream directory. This script only ever copies files that don't exist (by name) in the destination folder. This means if you take a picture and remove it from photostream after this script has run then you will manually have to go to destination folder and delete it. Also a limitation on photostream is it only syncs pictures, not videos (as of October 2013 with iCloud control panel v3.0). So you still need to copy those over manually to save them. And since the iOS device uses a special driver it doesn't show up in explorer with a drive letter, so this script won't work (as far as I know). While a little convoluted what you can do is copy everything on the phone to a temporary folder, set up a copy of this to scan that folder and let it run. Anything it already copied from photostream it wouldn't copy again.

## Usage (draft)

- Copy `config-default.ini` to `config.ini`
- Edit this file for your setup
    - `source_dir`: The source directory. Typically all you have to do is change the `YOUR_USERNAME` part of it
    - `dest_dir`: Destination directory. In my setup, this points to a folder I have [picasa](http://picasa.google.com/) monitor. It's also a folder I have in my backup schedule (you are backing up your pictures, right?)
    - `sort_method`: How to organize the destination directory. Options can be either `year`, `month`, or `day`. Unless you take a lot of pictures, `year` should be fine.
        - Given the file `IMG_0001.JPG` with modification time of January 10, 2013 and a destination directory of `C:\pics` this is where each method would put the file (creating any needed directories)
        - `year`: `C:\pics\2013\IMG_0001.JPG`
        - `month`: `C:\pics\2013\01\IMG_0001.JPG`
        - `day`: `C:\pics\2013\01\10\IMG_0001.JPG`
    - `enable_log`: Enable writing log to file. This is a global "kill switch" for file log. You can fine tune it with `ignore_log_level` below
    - `ignore_log_level`: What log levels you want to ignore. This is a comma separated list of levels. Be sure not to put spaces before or after the comma. The default `INFO,DEBUG` means it will log `ERROR` level messages. I'd recommend removing `INFO` from that list as well as it tells you when new images are copied over but it may be too noisy for some.
    - `log_file`: Where to write the log file. The default `runtime.log` means it will create `runtime.log` in the same folder this script resides on and writes it there.
- Should run at least the first time by just double clicking on the script. It will display any errors it encounters.
- Afterwards you can setup a job in [Task Manager](http://windows.microsoft.com/en-us/windows7/schedule-a-task) (link to windows 7 instructions) to run at whatever schedule you prefer. Something like once an hour or once a day should be fine for most

## Caveats

First off read the intro paragraphs. Also I don't copy `desktop.ini` as this is a system file that doesn't contain any information about the photos. Also it may clash with whatever tool you use to manage photos.

## License

This project is [Unlicensed](http://unlicense.org/)

    This is free and unencumbered software released into the public domain.

    Anyone is free to copy, modify, publish, use, compile, sell, or
    distribute this software, either in source code form or as a compiled
    binary, for any purpose, commercial or non-commercial, and by any
    means.

    In jurisdictions that recognize copyright laws, the author or authors
    of this software dedicate any and all copyright interest in the
    software to the public domain. We make this dedication for the benefit
    of the public at large and to the detriment of our heirs and
    successors. We intend this dedication to be an overt act of
    relinquishment in perpetuity of all present and future rights to this
    software under copyright law.

    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
    EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
    MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
    IN NO EVENT SHALL THE AUTHORS BE LIABLE FOR ANY CLAIM, DAMAGES OR
    OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
    ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
    OTHER DEALINGS IN THE SOFTWARE.

    For more information, please refer to <http://unlicense.org/>
