# SSHFS on macOS

SSHFS is a way to mount a remote file system over ssh. Under the hood it talks to 
the ssh/sftp daemon on the server and sends commands to download or upload files when
needed.

It is not a true network file system so you have to be careful not to change files
on both sides of the connection simultaneously. It does not offer any protection
against this, e.g., full or partial file locking. Modifying files directly on 
the server and on a mounted volume simultaneously will lead to unpredictable results.

On Linux, where it was first introduced, sshfs is a userspace file system. So one needs
tp first install a piece of software called [FUSE](https://www.kernel.org/doc/html/next/filesystems/fuse.html)
to support user space file systems, and then the software that provides sshfs. 
Implementations on other operating systems often follow a similar approach.

Note however that at the time of writing of this text (June 2023) the
[Linux sshfs project](https://github.com/libfuse/sshfs) is without maintainer, though there are
some forks in which further development seems to be happening. If no new maintainer is
found, it is rather likely that sshfs will be abandoned by Linux distributions as security bugs
are no longer fixed, and it is unclear what the future is of ports to other operating systems.


## Open-source implementation based on macFUSE

There is a command line open source implementation for macOS that follows the principles also
used on Linux, as part of the [macFUSE (previously OSXFuse) project](https://osxfuse.github.io/).

Installation is done in two parts. First a 
[recent version of macFUSE](https://github.com/osxfuse/osxfuse/releases) 
has to be installed. 
The implementation at the time of writing (June 2023) still relies on kernel extensions, a mechanism 
that Apple wants to get rid off due to security concerns, and which requires relaxing security
settings on Apple Silicon macs. It is to be expected that this implementation will stop working on 
a future version of macOS. 

Next one can [install SSHFS](https://github.com/osxfuse/osxfuse/releases). SSHFS hasn't been maintained
since 2014 and our experience is that it does not always work well anymore. E.g., when connecting to 
LUMI, a Cray EX system running SUSE Linux, it fails to follow symbolic links to directories on the 
Lustre file system of which the userid connecting is not the owner.

The version number (2.5.0 in June 2023, released back in 2014) also suggests that the macOS implementation
is derived from an ancient version of the Linux sshfs implementation (which stopped at version 3.7.3).

There is a fork that saw [development as recent as the summer of 2022](https://github.com/tormodwill/macSSHFS)
(at the time of writing in June 2023) but that fork also is still derived 
from a rather old version of the Linux sshfs implementation and hence may not solve all problems with 
the implementation by the macFUSE project. According to the README file this is because the macFUSE 
project does not offer support for the newer libfuse 3 API.


??? Note "Links"
    -   [macFUSE GitHub repository]()
    -   [sshfs in the macFUSE proejct GitHub repository](https://github.com/osxfuse/sshfs)
    -   [A forkof the macFUSE sshfs implementation](https://github.com/tormodwill/macSSHFS)


### Commercial implementations

Below is just a selection of applications. The list doesn't aim to be complete.

-   [Mountain Duck](https://mountainduck.io/) is a package from the developers of
    CyberDuck that supports not only the sftp protocol (on which sshfs implementations
    are based) but also several cloud storage technologies, including S3. Contrary to
    CyberDuck it also allows to mount volumes and claims to use smart synchronization
    that also enables offline work. It supports both Windows and macOS.

    It does not use the macOS File PRovider API, because - as they claim - the latter
    can only cache in `~/Library/CloudStorage` and not on external drives which may be
    needed for larger volumes.

    There is native support for Apple Silicon.

-   [ExpanDrive](https://www.expandrive.com/) provides two products that both support more
    than just sshfs-like access:

    -   [Strongsync](https://www.expandrive.com/strongsync/) is their newer implementation 
        using the macOS File Provider API. It does not need any kernel extension and offers
        native support for Apple Silicon machines. It is the preferred implementation for
        newer macOS machines but is not yet as complete in its support for other cloud
        storage technologies as the next product.

    -   [ExpanDrive](https://www.expandrive.com/desktop/) is the older product that is also
        available for Windows and Linux. It offers support for a huge array of cloud services
        and includes support for Amazon S3. It looks like it still uses a kernel extension though
        on macOS that provides FUSE functionality (certainly older versions did).


-   [NetDrive](https://www.netdrive.net/) is a commercial package for Windows and macOS that does not
    only support SSHFS but can also mount several other types of cloud storage as if it is a local file
    system, including, e.g., S3. There is a personal version which is still relatively cheap, but the
    team version which is needed to offer full privacy also on multi-user PCs is rather expensive to
    academic standards.

-   [/n software SFTP Drive](https://www.nsoftware.com/sftpdrive/) also supports macOS besides Windows and Linux.

-   [CloudMounter](https://cloudmounter.net/sftp-client-mac.html) is another package enabling mounting from an
    sftp server, and it too supports some other cloud storage technologies. It also exists in a version for Windows.


