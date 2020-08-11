Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B1262417C4
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Aug 2020 10:01:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728306AbgHKIBB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 11 Aug 2020 04:01:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726397AbgHKIBA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 11 Aug 2020 04:01:00 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79750C06174A;
        Tue, 11 Aug 2020 01:01:00 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id c4so9392529otf.12;
        Tue, 11 Aug 2020 01:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=49W3z429YTWwYqoLUkRh2ENpilgF9rMqX+cAAlUfygw=;
        b=ajFImN6v6tU5+2Ys28WJuK7fA2bH2660VnDHrs0VbtBAKiVEWY4C5dxumwoauF/WRn
         rnXTxurRsVCwwNrP9Fzd1n84q5LrfF8ihy4h0gEQh1h4Fa9572168IaphIqoUHXWCYJl
         fZjU+l6VhTfmgjiO8YrSoGftpRms4sjJOGliTBf4qpIZ3YEeQTC1hPL9rngCrBtnMhno
         PY+AqReTZ6ciPZmIfRKohiyoF/NvwUvzNkDfjC4t1YFhut4LFGEoV6WRtfWF7qlHRov0
         9Pw5m9Y1pDB76r5jVlXRlLk9hvXt8H0fyGWdGKezzlx+KxNJkizl+ts5UzQmUq0OWuuc
         +cnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=49W3z429YTWwYqoLUkRh2ENpilgF9rMqX+cAAlUfygw=;
        b=XZ4Z2+e+sS9FdMV3Kd89FoKHwMGGEOmX+DbUExafLI5PP0m+mdH/lJ62oVgCFvPyPs
         3E4ocFbauatvGXraSwuCxS0wlUIDlGT2/SOOSRvJrbth88slnBhJfUXNs8dntrmHBM8Q
         aWAjRKczyjdcE3dKJf9arvMyvS/2g/WfbkGCUndPQYhdb4A/mQTNojlPddGA4wmiB2EC
         fb1TQppQc5fXvpk65JRoZ6jKL4/QM6pCgerPJ0Zz6s3c0KlqorBV+gr/ZXv0YvGY6XPA
         OozBhEZzNypjiQu1xzS/0cz5YT5yGWs/gEpYSlp8bLV6ChNfvBXusJ0T/3XXm7gA7oCG
         aQcg==
X-Gm-Message-State: AOAM531nQ/MiP1+L3c2feVT0loVthjE91mnVu4rNzcr6nMgpu8Afu7Jx
        8jicopfL/lzME9+LEHZYcscpc5CcNY2eAHsLh8rWIkis
X-Google-Smtp-Source: ABdhPJzMYnUh1+kbHSoPoB8v+G4LaNIvNtOJ55FLQw/SQbqsVkxP13qdelxHp/TCi7lhAu2hnB0ld+4kthp6dR4LIX8=
X-Received: by 2002:a9d:4e6:: with SMTP id 93mr4104308otm.308.1597132859596;
 Tue, 11 Aug 2020 01:00:59 -0700 (PDT)
MIME-Version: 1.0
References: <202008101448.9BAFCF5@keescook>
In-Reply-To: <202008101448.9BAFCF5@keescook>
Reply-To: mtk.manpages@gmail.com
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Date:   Tue, 11 Aug 2020 10:00:47 +0200
Message-ID: <CAKgNAkjDWxNPAOrLxw1NQu76aDrDz5R3Nh3=tLjq1C0KDPuWyQ@mail.gmail.com>
Subject: Re: [PATCH] selftests/socket: Introduce simple SCM_RIGHTS tests
To:     Kees Cook <keescook@chromium.org>
Cc:     Shuah Khan <shuah@kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi,

On Mon, 10 Aug 2020 at 23:52, Kees Cook <keescook@chromium.org> wrote:
>
> This makes sure that simple SCM_RIGHTS fd passing works as expected, to
> avoid any future regressions. This is mostly code from Michael Kerrisk's
> examples on how to set up and perform fd passing with SCM_RIGHTS. Add
> a test script and wire it up to the selftests.
>
> Signed-off-by: Kees Cook <keescook@chromium.org>

Acked-by: Michael Kerrisk <mtk.manpages@gmail.com>

(As per off-list discussion with Kees), I confirm that I'm okay with
relicensing to GPL2+.

Cheers,

Michael

> ---
> FYI, this also relicenses Michael's code (with his permission) from
> GPL3+ to GPL2+, who is on CC to publicly confirm. :) Thank you Michael!
> ---
>  tools/testing/selftests/Makefile              |   1 +
>  tools/testing/selftests/socket/.gitignore     |   4 +
>  tools/testing/selftests/socket/Makefile       |  11 ++
>  tools/testing/selftests/socket/hello.txt      |   1 +
>  tools/testing/selftests/socket/scm_rights.h   |  40 +++++
>  .../selftests/socket/scm_rights_recv.c        | 168 ++++++++++++++++++
>  .../selftests/socket/scm_rights_send.c        | 144 +++++++++++++++
>  .../selftests/socket/simple_scm_rights.sh     |  30 ++++
>  tools/testing/selftests/socket/unix_sockets.c |  88 +++++++++
>  tools/testing/selftests/socket/unix_sockets.h |  23 +++
>  10 files changed, 510 insertions(+)
>  create mode 100644 tools/testing/selftests/socket/.gitignore
>  create mode 100644 tools/testing/selftests/socket/Makefile
>  create mode 100644 tools/testing/selftests/socket/hello.txt
>  create mode 100644 tools/testing/selftests/socket/scm_rights.h
>  create mode 100644 tools/testing/selftests/socket/scm_rights_recv.c
>  create mode 100644 tools/testing/selftests/socket/scm_rights_send.c
>  create mode 100755 tools/testing/selftests/socket/simple_scm_rights.sh
>  create mode 100644 tools/testing/selftests/socket/unix_sockets.c
>  create mode 100644 tools/testing/selftests/socket/unix_sockets.h
>
> diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
> index e03bc15ce731..97e155596660 100644
> --- a/tools/testing/selftests/Makefile
> +++ b/tools/testing/selftests/Makefile
> @@ -51,6 +51,7 @@ TARGETS += rtc
>  TARGETS += seccomp
>  TARGETS += sigaltstack
>  TARGETS += size
> +TARGETS += socket
>  TARGETS += sparc64
>  TARGETS += splice
>  TARGETS += static_keys
> diff --git a/tools/testing/selftests/socket/.gitignore b/tools/testing/selftests/socket/.gitignore
> new file mode 100644
> index 000000000000..bc9a892956b0
> --- /dev/null
> +++ b/tools/testing/selftests/socket/.gitignore
> @@ -0,0 +1,4 @@
> +unix_sockets.o
> +scm_rights_send
> +scm_rights_recv
> +scm_rights
> diff --git a/tools/testing/selftests/socket/Makefile b/tools/testing/selftests/socket/Makefile
> new file mode 100644
> index 000000000000..3eb7ef0db997
> --- /dev/null
> +++ b/tools/testing/selftests/socket/Makefile
> @@ -0,0 +1,11 @@
> +# SPDX-License-Identifier: GPL-2.0+
> +TEST_PROGS := simple_scm_rights.sh
> +TEST_GEN_PROGS_EXTENDED := scm_rights_send scm_rights_recv
> +
> +include ../lib.mk
> +
> +$(OUTPUT)/unix_sockets.o: unix_sockets.h
> +$(OUTPUT)/scm_rights_recv: $(OUTPUT)/unix_sockets.o scm_rights.h
> +$(OUTPUT)/scm_rights_send: $(OUTPUT)/unix_sockets.o scm_rights.h
> +
> +EXTRA_CLEAN += $(OUTPUT)/unix_sockets.o $(OUTPUT)/scm_rights
> diff --git a/tools/testing/selftests/socket/hello.txt b/tools/testing/selftests/socket/hello.txt
> new file mode 100644
> index 000000000000..e965047ad7c5
> --- /dev/null
> +++ b/tools/testing/selftests/socket/hello.txt
> @@ -0,0 +1 @@
> +Hello
> diff --git a/tools/testing/selftests/socket/scm_rights.h b/tools/testing/selftests/socket/scm_rights.h
> new file mode 100644
> index 000000000000..4501a46bf1be
> --- /dev/null
> +++ b/tools/testing/selftests/socket/scm_rights.h
> @@ -0,0 +1,40 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * scm_rights.h
> + *
> + *  Copyright (C) Michael Kerrisk, 2020.
> + *
> + *  Header file used by scm_rights_send.c and scm_rights_recv.c.
> + */
> +#include <errno.h>
> +#include <fcntl.h>
> +#include <stdbool.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <sys/socket.h>
> +#include <sys/un.h>
> +
> +#include "unix_sockets.h"
> +
> +#define SOCK_PATH "scm_rights"
> +
> +#define errExit(fmt, ...) do {                                 \
> +               fprintf(stderr, fmt, ## __VA_ARGS__);           \
> +               fprintf(stderr, ": %s\n", strerror(errno));     \
> +               exit(EXIT_FAILURE);                             \
> +       } while (0)
> +
> +#define fatal(str) errExit("%s\n", str)
> +
> +#define usageErr(fmt, ...) do {                                        \
> +               fprintf(stderr, "Usage: ");                     \
> +               fprintf(stderr, fmt, ## __VA_ARGS__);           \
> +               exit(EXIT_FAILURE);                             \
> +       } while (0)
> +
> +static bool debugging;
> +
> +#define debug(fmt, ...) do {                                   \
> +               if (debugging)                                  \
> +                       fprintf(stderr, fmt, ## __VA_ARGS__);   \
> +       } while (0)
> diff --git a/tools/testing/selftests/socket/scm_rights_recv.c b/tools/testing/selftests/socket/scm_rights_recv.c
> new file mode 100644
> index 000000000000..4c916e43c319
> --- /dev/null
> +++ b/tools/testing/selftests/socket/scm_rights_recv.c
> @@ -0,0 +1,168 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * scm_rights_recv.c
> + *
> + * Copyright (C) Michael Kerrisk, 2020.
> + *
> + * Used in conjunction with scm_rights_send.c to demonstrate passing of
> + * file descriptors via a UNIX domain socket.
> + *
> + * This program receives a file descriptor sent to a UNIX domain socket.
> + *
> + * Usage is as shown in the usageErr() call below.
> + *
> + * File descriptors can be exchanged over stream or datagram sockets. This
> + * program uses stream sockets by default; the "-d" command-line option
> + * specifies that datagram sockets should be used instead.
> + *
> + * This program is Linux-specific.
> + */
> +#include "scm_rights.h"
> +
> +#define BUF_SIZE 100
> +
> +int
> +main(int argc, char *argv[])
> +{
> +       int data, lfd, sfd, fd, opt;
> +       ssize_t nr;
> +       bool useDatagramSocket;
> +       struct msghdr msgh;
> +       struct iovec iov;
> +
> +       /* Allocate a char array of suitable size to hold the ancillary data.
> +        * However, since this buffer is in reality a 'struct cmsghdr', use a
> +        * union to ensure that it is aligned as required for that structure.
> +        * Alternatively, we could allocate the buffer using malloc(), which
> +        * returns a buffer that satisfies the strictest alignment
> +        * requirements of any type
> +        */
> +
> +       union {
> +               char   buf[CMSG_SPACE(sizeof(int))];
> +               /* Space large enough to hold an 'int' */
> +               struct cmsghdr align;
> +       } controlMsg;
> +       struct cmsghdr *cmsgp;  /* Pointer used to iterate through
> +                                * headers in ancillary data
> +                                */
> +
> +       /* Parse command-line options */
> +
> +       useDatagramSocket = false;
> +
> +       while ((opt = getopt(argc, argv, "dD")) != -1) {
> +               switch (opt) {
> +               case 'd':
> +                       useDatagramSocket = true;
> +                       break;
> +
> +               default:
> +                       usageErr("%s [-dD]\n"
> +                                        "              -D      enable debugging\n"
> +                                        "              -d      use datagram socket\n", argv[0]);
> +               }
> +       }
> +
> +       /* Create socket bound to a well-known address. In the case where
> +        * we are using stream sockets, also make the socket a listening
> +        * socket and accept a connection on the socket.
> +        */
> +
> +       if (remove(SOCK_PATH) == -1 && errno != ENOENT)
> +               errExit("remove-%s", SOCK_PATH);
> +
> +       if (useDatagramSocket) {
> +               sfd = unixBind(SOCK_PATH, SOCK_DGRAM);
> +               if (sfd == -1)
> +                       errExit("unixBind");
> +
> +       } else {
> +               lfd = unixBind(SOCK_PATH, SOCK_STREAM);
> +               if (lfd == -1)
> +                       errExit("unixBind");
> +
> +               if (listen(lfd, 5) == -1)
> +                       errExit("listen");
> +
> +               sfd = accept(lfd, NULL, NULL);
> +               if (sfd == -1)
> +                       errExit("accept");
> +       }
> +
> +       /* The 'msg_name' field can be set to point to a buffer where the
> +        * kernel will place the address of the peer socket. However, we don't
> +        * need the address of the peer, so we set this field to NULL.
> +        */
> +
> +       msgh.msg_name = NULL;
> +       msgh.msg_namelen = 0;
> +
> +       /* Set fields of 'msgh' to point to buffer used to receive the (real)
> +        * data read by recvmsg()
> +        */
> +
> +       msgh.msg_iov = &iov;
> +       msgh.msg_iovlen = 1;
> +       iov.iov_base = &data;
> +       iov.iov_len = sizeof(int);
> +
> +       /* Set 'msgh' fields to describe the ancillary data buffer */
> +
> +       msgh.msg_control = controlMsg.buf;
> +       msgh.msg_controllen = sizeof(controlMsg.buf);
> +
> +       /* Receive real plus ancillary data */
> +
> +       nr = recvmsg(sfd, &msgh, 0);
> +       if (nr == -1)
> +               errExit("recvmsg");
> +       debug("recvmsg() returned %ld\n", (long) nr);
> +
> +       if (nr > 0)
> +               debug("Received data = %d\n", data);
> +
> +       /* Get the address of the first 'cmsghdr' in the received
> +        * ancillary data
> +        */
> +
> +       cmsgp = CMSG_FIRSTHDR(&msgh);
> +
> +       /* Check the validity of the 'cmsghdr' */
> +
> +       if (cmsgp == NULL || cmsgp->cmsg_len != CMSG_LEN(sizeof(int)))
> +               fatal("bad cmsg header / message length");
> +       if (cmsgp->cmsg_level != SOL_SOCKET)
> +               fatal("cmsg_level != SOL_SOCKET");
> +       if (cmsgp->cmsg_type != SCM_RIGHTS)
> +               fatal("cmsg_type != SCM_RIGHTS");
> +
> +       /* The data area of the 'cmsghdr' is an 'int' (a file descriptor);
> +        * copy that integer to a local variable. (The received file descriptor
> +        * is typically a different file descriptor number than was used in the
> +        * sending process.)
> +        */
> +
> +       memcpy(&fd, CMSG_DATA(cmsgp), sizeof(int));
> +       debug("Received FD %d\n", fd);
> +
> +       /* Having obtained the file descriptor, read the file's contents and
> +        * print them on standard output
> +        */
> +
> +       for (;;) {
> +               char buf[BUF_SIZE];
> +               ssize_t numRead;
> +
> +               numRead = read(fd, buf, BUF_SIZE);
> +               if (numRead == -1)
> +                       errExit("read");
> +
> +               if (numRead == 0)
> +                       break;
> +
> +               write(STDOUT_FILENO, buf, numRead);
> +       }
> +
> +       exit(EXIT_SUCCESS);
> +}
> diff --git a/tools/testing/selftests/socket/scm_rights_send.c b/tools/testing/selftests/socket/scm_rights_send.c
> new file mode 100644
> index 000000000000..c5718d10a80d
> --- /dev/null
> +++ b/tools/testing/selftests/socket/scm_rights_send.c
> @@ -0,0 +1,144 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * scm_rights_send.c
> + *
> + * Copyright (C) Michael Kerrisk, 2020.
> + *
> + * Used in conjunction with scm_rights_recv.c to demonstrate passing of
> + * file descriptors via a UNIX domain socket.
> + *
> + * This program sends a file descriptor to a UNIX domain socket.
> + *
> + * Usage is as shown in the usageErr() call below.
> + *
> + * File descriptors can be exchanged over stream or datagram sockets. This
> + * program uses stream sockets by default; the "-d" command-line option
> + * specifies that datagram sockets should be used instead.
> + *
> + * This program is Linux-specific.
> + */
> +#include "scm_rights.h"
> +
> +int
> +main(int argc, char *argv[])
> +{
> +       int data, sfd, opt, fd;
> +       ssize_t ns;
> +       bool useDatagramSocket;
> +       struct msghdr msgh;
> +       struct iovec iov;
> +
> +       /* Allocate a char array of suitable size to hold the ancillary data.
> +        * However, since this buffer is in reality a 'struct cmsghdr', use a
> +        * union to ensure that it is aligned as required for that structure.
> +        * Alternatively, we could allocate the buffer using malloc(), which
> +        * returns a buffer that satisfies the strictest alignment
> +        * requirements of any type.
> +        */
> +
> +       union {
> +               char   buf[CMSG_SPACE(sizeof(int))];
> +               /* Space large enough to hold an 'int' */
> +               struct cmsghdr align;
> +       } controlMsg;
> +       struct cmsghdr *cmsgp;  /* Pointer used to iterate through
> +                                * headers in ancillary data
> +                                */
> +
> +       /* Parse command-line options */
> +
> +       useDatagramSocket = false;
> +
> +       while ((opt = getopt(argc, argv, "dD")) != -1) {
> +               switch (opt) {
> +               case 'd':
> +                       useDatagramSocket = true;
> +                       break;
> +               case 'D':
> +                       debugging = true;
> +                       break;
> +               default:
> +                       usageErr("%s [-dD] file\n"
> +                                        "              -D      enable debugging\n"
> +                                        "              -d      use datagram socket\n", argv[0]);
> +               }
> +       }
> +
> +       if (argc != optind + 1)
> +               usageErr("%s [-dD] file\n", argv[0]);
> +
> +       /* Open the file named on the command line */
> +
> +       fd = open(argv[optind], O_RDONLY);
> +       if (fd == -1)
> +               errExit("open");
> +
> +       /* The 'msg_name' field can be used to specify the address of the
> +        * destination socket when sending a datagram. However, we do not
> +        * need to use this field because we use connect() below, which sets
> +        * a default outgoing address for datagrams.
> +        */
> +
> +       msgh.msg_name = NULL;
> +       msgh.msg_namelen = 0;
> +
> +       /* On Linux, we must transmit at least 1 byte of real data in
> +        * order to send ancillary data
> +        */
> +
> +       msgh.msg_iov = &iov;
> +       msgh.msg_iovlen = 1;
> +       iov.iov_base = &data;
> +       iov.iov_len = sizeof(int);
> +       data = 12345;
> +       debug("Sending data = %d\n", data);
> +
> +       /* Set 'msgh' fields to describe the ancillary data buffer */
> +
> +       msgh.msg_control = controlMsg.buf;
> +       msgh.msg_controllen = sizeof(controlMsg.buf);
> +
> +       /* The control message buffer must be zero-initialized in order
> +        * for the CMSG_NXTHDR() macro to work correctly. Although we
> +        * don't need to use CMSG_NXTHDR() in this example (because
> +        * there is only one block of ancillary data), we show this
> +        * step to demonstrate best practice
> +        */
> +
> +       memset(controlMsg.buf, 0, sizeof(controlMsg.buf));
> +
> +       /* Set message header to describe the ancillary data that
> +        * we want to send
> +        */
> +
> +       cmsgp = CMSG_FIRSTHDR(&msgh);
> +       cmsgp->cmsg_len = CMSG_LEN(sizeof(int));
> +       cmsgp->cmsg_level = SOL_SOCKET;
> +       cmsgp->cmsg_type = SCM_RIGHTS;
> +       memcpy(CMSG_DATA(cmsgp), &fd, sizeof(int));
> +
> +       /* Connect to the peer socket */
> +
> +       sfd = unixConnect(SOCK_PATH, useDatagramSocket ? SOCK_DGRAM : SOCK_STREAM);
> +       if (sfd == -1)
> +               errExit("unixConnect");
> +
> +       debug("Sending FD %d\n", fd);
> +
> +       /* Send real plus ancillary data */
> +
> +       ns = sendmsg(sfd, &msgh, 0);
> +       if (ns == -1)
> +               errExit("sendmsg");
> +
> +       debug("sendmsg() returned %ld\n", (long) ns);
> +
> +       /* Once the file descriptor has been sent, it is no longer necessary
> +        * to keep it open in the sending process
> +        */
> +
> +       if (close(fd) == -1)
> +               errExit("close");
> +
> +       exit(EXIT_SUCCESS);
> +}
> diff --git a/tools/testing/selftests/socket/simple_scm_rights.sh b/tools/testing/selftests/socket/simple_scm_rights.sh
> new file mode 100755
> index 000000000000..31ea0fc1bb6d
> --- /dev/null
> +++ b/tools/testing/selftests/socket/simple_scm_rights.sh
> @@ -0,0 +1,30 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0+
> +set -e
> +
> +ret=0
> +hello=$(cat hello.txt)
> +
> +rm -f scm_rights
> +(sleep 0.1; ./scm_rights_send hello.txt) &
> +out=$(./scm_rights_recv)
> +
> +if [ "$hello" != "$out" ] ; then
> +       echo "FAIL: SCM_RIGHTS fd contents mismatch"
> +       ret=1
> +else
> +       echo "ok: SOCK_STREAM"
> +fi
> +
> +rm -f scm_rights
> +(sleep 0.1; ./scm_rights_send -d hello.txt) &
> +out=$(./scm_rights_recv -d)
> +
> +if [ "$hello" != "$out" ] ; then
> +       echo "FAIL: SCM_RIGHTS fd contents mismatch"
> +       ret=1
> +else
> +       echo "ok: SOCK_DGRAM"
> +fi
> +
> +exit $ret
> diff --git a/tools/testing/selftests/socket/unix_sockets.c b/tools/testing/selftests/socket/unix_sockets.c
> new file mode 100644
> index 000000000000..a7678fad1a16
> --- /dev/null
> +++ b/tools/testing/selftests/socket/unix_sockets.c
> @@ -0,0 +1,88 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * unix_sockets.c
> + *
> + * Copyright (C) Michael Kerrisk, 2020.
> + *
> + * A package of useful routines for UNIX domain sockets.
> + */
> +#include "unix_sockets.h"         /* Declares functions defined here */
> +
> +/* Build a UNIX domain socket address structure for 'path', returning
> + * it in 'addr'. Returns -1 on success, or 0 on error.
> + */
> +
> +int
> +unixBuildAddress(const char *path, struct sockaddr_un *addr)
> +{
> +       if (addr == NULL || path == NULL) {
> +               errno = EINVAL;
> +               return -1;
> +       }
> +
> +       memset(addr, 0, sizeof(struct sockaddr_un));
> +       addr->sun_family = AF_UNIX;
> +       if (strlen(path) < sizeof(addr->sun_path)) {
> +               strncpy(addr->sun_path, path, sizeof(addr->sun_path) - 1);
> +               return 0;
> +       } else {
> +               errno = ENAMETOOLONG;
> +               return -1;
> +       }
> +}
> +
> +/* Create a UNIX domain socket of type 'type' and connect it
> + * to the remote address specified by the 'path'.
> + * Return the socket descriptor on success, or -1 on error
> + */
> +
> +int
> +unixConnect(const char *path, int type)
> +{
> +       int sd, savedErrno;
> +       struct sockaddr_un addr;
> +
> +       if (unixBuildAddress(path, &addr) == -1)
> +               return -1;
> +
> +       sd = socket(AF_UNIX, type, 0);
> +       if (sd == -1)
> +               return -1;
> +
> +       if (connect(sd, (struct sockaddr *) &addr,
> +                               sizeof(struct sockaddr_un)) == -1) {
> +               savedErrno = errno;
> +               close(sd);                        /* Might change 'errno' */
> +               errno = savedErrno;
> +               return -1;
> +       }
> +
> +       return sd;
> +}
> +
> +/* Create a UNIX domain socket and bind it to 'path'.
> + * Return the socket descriptor on success, or -1 on error.
> + */
> +
> +int
> +unixBind(const char *path, int type)
> +{
> +       int sd, savedErrno;
> +       struct sockaddr_un addr;
> +
> +       if (unixBuildAddress(path, &addr) == -1)
> +               return -1;
> +
> +       sd = socket(AF_UNIX, type, 0);
> +       if (sd == -1)
> +               return -1;
> +
> +       if (bind(sd, (struct sockaddr *) &addr, sizeof(struct sockaddr_un)) == -1) {
> +               savedErrno = errno;
> +               close(sd);                        /* Might change 'errno' */
> +               errno = savedErrno;
> +               return -1;
> +       }
> +
> +       return sd;
> +}
> diff --git a/tools/testing/selftests/socket/unix_sockets.h b/tools/testing/selftests/socket/unix_sockets.h
> new file mode 100644
> index 000000000000..e03a5aecd10c
> --- /dev/null
> +++ b/tools/testing/selftests/socket/unix_sockets.h
> @@ -0,0 +1,23 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + *  unix_sockets.h
> + *
> + *  Copyright (C) Michael Kerrisk, 2020.
> + *
> + *  Header file for unix_sockets.c.
> + */
> +#ifndef UNIX_SOCKETS_H
> +#define UNIX_SOCKETS_H      /* Prevent accidental double inclusion */
> +
> +#include <errno.h>
> +#include <unistd.h>
> +#include <sys/socket.h>
> +#include <sys/un.h>
> +
> +int unixBuildAddress(const char *path, struct sockaddr_un *addr);
> +
> +int unixConnect(const char *path, int type);
> +
> +int unixBind(const char *path, int type);
> +
> +#endif
> --
> 2.25.1
>
>
> --
> Kees Cook



-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
