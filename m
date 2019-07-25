Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A5DF075328
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jul 2019 17:49:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725842AbfGYPtE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 25 Jul 2019 11:49:04 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:34549 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726312AbfGYPtD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 25 Jul 2019 11:49:03 -0400
Received: by mail-wm1-f67.google.com with SMTP id w9so36063308wmd.1
        for <linux-kselftest@vger.kernel.org>; Thu, 25 Jul 2019 08:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Nj56UzH1PDtV9YHAalrKYNsojqYwKS7s5wWJEEqlrL4=;
        b=gw2kHdTAL4KVhHpCV+um6iZqELlhySONTiehwa6g5QeQU29YwInudLGBA7K3X1yf6u
         tGpD8Z1vgSOb7+R9wc+Oy6D8ozPh4wbacCx5nisacbG3b0j969DMLlvW3PcRWDaIcvo/
         3SrFR459HbTEUuAEkHhYA96FfeRaTeqnkXPZxx4nt7cjLmMkcdXEHyDeIqY6NqPSLebx
         BWcNPMKTUVNJ7YRIFu0eEnEbfjNugLDdX2GgyaHweJ7YOn/ftqiDAds7P+LrHLCWpwpW
         bEW2Yuw1qmndfEzSfRQppZh+Tx4rMj9bb6oI6YoNfcWaPbdZZ/Qdmmbves+6QG/rluG9
         87dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Nj56UzH1PDtV9YHAalrKYNsojqYwKS7s5wWJEEqlrL4=;
        b=Fv5LjTb5XgMFD33LWiobDrArkr7kXv1vq2cZQ+R6MSrwmfKLRp58/l6oFl0maj7UNu
         ml/SULmibvWIbxxjlg6dDVr6NUrpRiZYfSlroA+vcxUDPFLsJVkrWtJqbs5fGMtdONFR
         RwApNZhqVoo4XDMY0ZArrekAxXFfHA76XdE8E9q20U6gdUkuL35I7T4mX2VvfdFiLA+P
         PLcEIvder0fYr10Oh+KsgpwhK3UJvaaddfDYjJFALIcKW5fz5Sv4lvyFl8YNSG1Hkt77
         0J6RMFx/AhPLl+zAI4G5JkDI4B7cfQMX9FLkP5WaAulIXAMTCcIRa50sz6Xvz5g/G9Ux
         DqlA==
X-Gm-Message-State: APjAAAX40xP/5KuwaP+Zc/MxZb+X5Gy6S9yGmDgEY5ZKmPj7CbEsXqQd
        R49k7ufIZIp02e05xCogKYwRaqycnQzX4mTd7kYSAg==
X-Google-Smtp-Source: APXvYqwL4FEoD8QQkg4Xf0kRb52k0R3kguaiq/O0bjKuP46wO9tSnkX540tSMF5//Vp0NKl2Wo/16L+q3qX93PXHnnk=
X-Received: by 2002:a1c:cfc7:: with SMTP id f190mr76486787wmg.85.1564069740241;
 Thu, 25 Jul 2019 08:49:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190725002204.185225-1-surenb@google.com> <20190725002204.185225-2-surenb@google.com>
 <57a23124f9e4d7ac5fb3145e990810dc2d190f72.camel@opteya.com>
In-Reply-To: <57a23124f9e4d7ac5fb3145e990810dc2d190f72.camel@opteya.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 25 Jul 2019 08:48:49 -0700
Message-ID: <CAJuCfpFvL1WjpCv74T23x1fgSok8FK=a-dMgcrSCVnu-masY8A@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] tests: add pidfd poll tests
To:     Yann Droneaud <ydroneaud@opteya.com>
Cc:     Christian Brauner <christian@brauner.io>, arnd@arndb.de,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Daniel Colascione <dancol@google.com>, tglx@linutronix.de,
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

On Thu, Jul 25, 2019 at 4:58 AM Yann Droneaud <ydroneaud@opteya.com> wrote:
>
> Hi,
>
> Le mercredi 24 juillet 2019 =C3=A0 17:22 -0700, Suren Baghdasaryan a =C3=
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
> >  .../testing/selftests/pidfd/pidfd_poll_test.c | 112 ++++++++++++++++++
> >  3 files changed, 114 insertions(+), 1 deletion(-)
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
> > index 000000000000..d45c612a0fe5
> > --- /dev/null
> > +++ b/tools/testing/selftests/pidfd/pidfd_poll_test.c
> > @@ -0,0 +1,112 @@
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
> > +             if (!child_pid) {
> > +                     /* Child process just sleeps for a min and exits =
*/
> > +                     sleep(60);
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
> > +             /* Check for error conditions */
> > +             if (nevents < 0)
> > +                     ksft_exit_fail_msg("%s - poll failed\n",
> > +                                     strerror(errno));
> > +
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
>
> There's no call to wait(), or alike function. Is it required for the
> test to left zombies ?

The test checks that death notification gets sent from kernel, which
by design should happen for any process that has non-zero
task->exit_state and that includes zombies (see
https://elixir.bootlin.com/linux/v5.3-rc1/source/kernel/fork.c#L1731
for that condition). So IIUC this code, the poll() should succeed no
matter if the task is zombie or dead. Or do I misunderstand your
question?
Thanks,
Suren.

>
> Regards.
>
> --
> Yann Droneaud
> OPTEYA
>
>
> --
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to kernel-team+unsubscribe@android.com.
>
