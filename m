Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E9138385D
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Aug 2019 20:03:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbfHFSDY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 6 Aug 2019 14:03:24 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:33699 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731516AbfHFSDY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 6 Aug 2019 14:03:24 -0400
Received: by mail-wm1-f65.google.com with SMTP id p77so187918wme.0
        for <linux-kselftest@vger.kernel.org>; Tue, 06 Aug 2019 11:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=yNTTi0L5msRg8ZrDWO80ik8XmW4n67AEXe5k7CZUqus=;
        b=bqTTjRtzHhpT5DKhF2oOChRlqk1w6XVUY+frRyXMTtkZUj3zEvYNtUcKjMQtu0WSGw
         TIIzX2Ts9+qoahZkm0oYTQCG2D2BK2oUWCKJJJPjnjLd6gdw9YfrJm1z4OPEG1KgXqYY
         zOq8PQ7ufmbk54AiV/lf5bk3+UlI6d8tai/M++2349YMvdXcdWZ6jwYZ8mvCrxgwMOTA
         EtHsLM7CbBEN7eHbsvlyBacUAEFv4dGL17LRfQ+5gdTSUbUPQhKEeUKxonSFz8GSonXr
         2mV4doUqyobQbJYlMx9EU0ozaXBYMNMLsDlzD7gmawCRXCwuByzRl7NFRCwdx5fBVDlj
         udcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=yNTTi0L5msRg8ZrDWO80ik8XmW4n67AEXe5k7CZUqus=;
        b=SxHrgObr40JizRjTiGnj2qgbbITKedYorpcnv/JFgTWkdLPGhEa0OReTh8IJ+8FZye
         40AO8z+qgkeJwrInx8e0CBA6skCYR7NkawlQog/PRS+EbWW5HnxTfjx4PjBnGXHaNc+M
         05r/IgO8GQc7tlxEG+kYuWfibBHkfqkfav3NRLKO0RvC1sWAlZ/ZFF+hItjqe1S/Qc7L
         ctVJsQXxnd85bFY3LjNNwhoViahGJu1ni4+iQb/0KE8Y9S3TXI0P/Q6Lg3u6Q5J2JLYV
         2pYnV/xrSrRa5eQ+1ykJ6hK70PUfwlMs2d5tpxZam2lGsXUhwZZGTJbCoN5vP3mw9IYu
         ZePQ==
X-Gm-Message-State: APjAAAXSuJlH0i1E9516dL4oL10Zfoutuu/V73SMsXFtSAYQkkWA3Mxp
        EyCSvQSHWXhrdrC9SniOP28+R/kLmevLGXP1Hyc4zA==
X-Google-Smtp-Source: APXvYqwGusU8CDdp7JNsdGsKgN+TJIc0Uhd3178RHvAQERhYawmmaVVqy+RTWHRz6CP16nm3mlmm52x7qe3d5p2F+pM=
X-Received: by 2002:a1c:1f41:: with SMTP id f62mr5987715wmf.176.1565114601107;
 Tue, 06 Aug 2019 11:03:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190726162226.252750-1-surenb@google.com> <20190726162226.252750-2-surenb@google.com>
 <542deab5d3450adc004602b9b8bbb4e38824c35b.camel@opteya.com>
In-Reply-To: <542deab5d3450adc004602b9b8bbb4e38824c35b.camel@opteya.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 6 Aug 2019 11:03:09 -0700
Message-ID: <CAJuCfpGu=Or1z0UEBBfsjoiEznWbLs8vNRZumUHGSkikb7+iHQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] tests: add pidfd poll tests
To:     Yann Droneaud <ydroneaud@opteya.com>
Cc:     Christian Brauner <christian@brauner.io>, arnd@arndb.de,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Daniel Colascione <dancol@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jann Horn <jannh@google.com>, dhowells@redhat.com,
        mtk.manpages@gmail.com, luto@kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>, cyphar@cyphar.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        viro@zeniv.linux.org.uk, linux-api@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        kernel-team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Jul 27, 2019 at 11:24 AM Yann Droneaud <ydroneaud@opteya.com> wrote=
:
>
> Hi,

Hi Yann,
 So sorry I missed your email. My email filters were messed up and I
fixed them now but missed a bunch of emails :(

>
> Le vendredi 26 juillet 2019 =C3=A0 09:22 -0700, Suren Baghdasaryan a =C3=
=A9crit :
> > This adds testing for polling on pidfd of a process being killed. Test =
runs
> > 10000 iterations by default to stress test pidfd polling functionality.
> > It accepts an optional command-line parameter to override the number or
> > iterations to run.
> > Specifically, it tests for:
> > - pidfd_open on a child process succeeds
> > - pidfd_send_signal on a child process succeeds
> > - polling on pidfd succeeds and returns exactly one event
> > - returned event is POLLIN
> > - event is received within 3 secs of the process being killed
> >
> > 10000 iterations was chosen because of the race condition being tested
> > which is not consistently reproducible but usually is revealed after le=
ss
> > than 2000 iterations.
> > Reveals race fixed by commit b191d6491be6 ("pidfd: fix a poll race when=
 setting exit_state")
> >
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > ---
> >  tools/testing/selftests/pidfd/.gitignore      |   1 +
> >  tools/testing/selftests/pidfd/Makefile        |   2 +-
> >  .../testing/selftests/pidfd/pidfd_poll_test.c | 117 ++++++++++++++++++
> >  3 files changed, 119 insertions(+), 1 deletion(-)
> >  create mode 100644 tools/testing/selftests/pidfd/pidfd_poll_test.c
> >
> > diff --git a/tools/testing/selftests/pidfd/.gitignore b/tools/testing/s=
elftests/pidfd/.gitignore
> > index 16d84d117bc0..a67896347d34 100644
> > --- a/tools/testing/selftests/pidfd/.gitignore
> > +++ b/tools/testing/selftests/pidfd/.gitignore
> > @@ -1,2 +1,3 @@
> >  pidfd_open_test
> > +pidfd_poll_test
> >  pidfd_test
> > diff --git a/tools/testing/selftests/pidfd/Makefile b/tools/testing/sel=
ftests/pidfd/Makefile
> > index 720b2d884b3c..ed58b7108d18 100644
> > --- a/tools/testing/selftests/pidfd/Makefile
> > +++ b/tools/testing/selftests/pidfd/Makefile
> > @@ -1,7 +1,7 @@
> >  # SPDX-License-Identifier: GPL-2.0-only
> >  CFLAGS +=3D -g -I../../../../usr/include/ -lpthread
> >
> > -TEST_GEN_PROGS :=3D pidfd_test pidfd_open_test
> > +TEST_GEN_PROGS :=3D pidfd_test pidfd_open_test pidfd_poll_test
> >
> >  include ../lib.mk
> >
> > diff --git a/tools/testing/selftests/pidfd/pidfd_poll_test.c b/tools/te=
sting/selftests/pidfd/pidfd_poll_test.c
> > new file mode 100644
> > index 000000000000..f1b62b91e53e
> > --- /dev/null
> > +++ b/tools/testing/selftests/pidfd/pidfd_poll_test.c
> > @@ -0,0 +1,117 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +#define _GNU_SOURCE
> > +#include <errno.h>
> > +#include <linux/types.h>
> > +#include <linux/wait.h>
> > +#include <poll.h>
> > +#include <signal.h>
> > +#include <stdbool.h>
> > +#include <stdio.h>
> > +#include <stdlib.h>
> > +#include <string.h>
> > +#include <syscall.h>
> > +#include <sys/wait.h>
> > +#include <unistd.h>
> > +
> > +#include "pidfd.h"
> > +#include "../kselftest.h"
> > +
> > +static bool timeout;
> > +
> > +static void handle_alarm(int sig)
> > +{
> > +     timeout =3D true;
> > +}
>
> Not needed if poll() timeout is used instead.
>
> > +
> > +int main(int argc, char **argv)
> > +{
> > +     struct pollfd fds;
> > +     int iter, nevents;
> > +     int nr_iterations =3D 10000;
> > +
> > +     fds.events =3D POLLIN;
> > +
> > +     if (argc > 2)
> > +             ksft_exit_fail_msg("Unexpected command line argument\n");
> > +
> > +     if (argc =3D=3D 2) {
> > +             nr_iterations =3D atoi(argv[1]);
> > +             if (nr_iterations <=3D 0)
> > +                     ksft_exit_fail_msg("invalid input parameter %s\n"=
,
> > +                                     argv[1]);
> > +     }
> > +
> > +     ksft_print_msg("running pidfd poll test for %d iterations\n",
> > +             nr_iterations);
> > +
> > +     for (iter =3D 0; iter < nr_iterations; iter++) {
> > +             int pidfd;
> > +             int child_pid =3D fork();
> > +
> > +             if (child_pid < 0) {
> > +                     if (errno =3D=3D EAGAIN) {
> > +                             iter--;
> > +                             continue;
> > +                     }
> > +                     ksft_exit_fail_msg(
> > +                             "%s - failed to fork a child process\n",
> > +                             strerror(errno));
> > +             }
> > +
> > +             if (child_pid =3D=3D 0) {
> > +                     /* Child process just sleeps for a min and exits =
*/
> > +                     sleep(60);
>
> Instead of relying on a timer for no reason, I would use the following:
>
>         while (1)
>                 pause();
>

Yeah, not much difference I think. If you don't strongly object I'll
keep it this way.

> > +                     exit(EXIT_SUCCESS);
> > +             }
> > +
> > +             /* Parent kills the child and waits for its death */
> > +             pidfd =3D sys_pidfd_open(child_pid, 0);
> > +             if (pidfd < 0)
> > +                     ksft_exit_fail_msg("%s - pidfd_open failed\n",
> > +                                     strerror(errno));
> > +
> > +             /* Setup 3 sec alarm - plenty of time */
> > +             if (signal(SIGALRM, handle_alarm) =3D=3D SIG_ERR)
> > +                     ksft_exit_fail_msg("%s - signal failed\n",
> > +                                     strerror(errno));
> > +             alarm(3);
> > +
>
> Would the poll() timeout be more simpler to use than relying on
> SIGALRM: no need to setup signal, no need for handler, no need for
> timeout variable.

Unfortunately that would not work because after timeout is passed
poll() checks for the condition one last time, it sees that the
process is dead (the condition is satisfied) and it returns nevents=3D=3D1
(event did happen) instead of nevents=3D=3D0 (poll timed out). I did
implement it this way originally and was surprised that it never timed
out even when I saw a 3 sec delay but then figured it out after going
through the kernel code.

> > +             /* Send SIGKILL to the child */
> > +             if (sys_pidfd_send_signal(pidfd, SIGKILL, NULL, 0))
> > +                     ksft_exit_fail_msg("%s - pidfd_send_signal failed=
\n",
> > +                                     strerror(errno));
> > +
> > +             /* Wait for the death notification */
> > +             fds.fd =3D pidfd;
> > +             nevents =3D poll(&fds, 1, -1);
> > +
>
> With
>
>         nevents =3D poll(&fds, 1, 3000);
>
> > +             /* Check for error conditions */
> > +             if (nevents < 0)
> > +                     ksft_exit_fail_msg("%s - poll failed\n",
> > +                                     strerror(errno));
> > +
>
> And
>         if (nevents =3D=3D 0)
>                 ksft_exit_fail_msg(
>                         "death notification wait timeout\n");
>
> > +             if (nevents !=3D 1)
> > +                     ksft_exit_fail_msg("unexpected poll result: %d\n"=
,
> > +                                     nevents);
> > +
> > +             if (!(fds.revents & POLLIN))
> > +                     ksft_exit_fail_msg(
> > +                             "unexpected event type received: 0x%x\n",
> > +                             fds.revents);
> > +
> > +             if (timeout)
> > +                     ksft_exit_fail_msg(
> > +                             "death notification wait timeout\n");
> > +
> > +             close(pidfd);
> > +             // Wait for child to prevent zombies
> > +             if (waitpid(child_pid, NULL, 0) < 0)
> > +                     ksft_exit_fail_msg("%s - waitpid failed\n",
> > +                                     strerror(errno));
>
> I feel safer now you defeated the zombies army :) Thanks.

Thanks for pointing it out!

>
> > +
> > +     }
> > +
> > +     ksft_test_result_pass("pidfd poll test: pass\n");
> > +     return ksft_exit_pass();
> > +}
>
> Regards
>
> --
> Yann Droneaud
> OPTEYA
>

Thanks,
Suren.

>
> --
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to kernel-team+unsubscribe@android.com.
>
