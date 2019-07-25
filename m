Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4391E75954
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jul 2019 23:10:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbfGYVKc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 25 Jul 2019 17:10:32 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:47016 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726380AbfGYVKc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 25 Jul 2019 17:10:32 -0400
Received: by mail-wr1-f67.google.com with SMTP id z1so52160032wru.13
        for <linux-kselftest@vger.kernel.org>; Thu, 25 Jul 2019 14:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=PAgL1L2vSwRbRF/b3cBOPDI+Q0dA5GZt0Ej0IQu6St4=;
        b=cmV/kmd2Esz3cfTA/wLQ0KiLN41zHPtmFpLSI2uy1OUZss6C0i2ZoWIATpRzlS1mBe
         aEf3llzPiVcFYPVvCjb5PGhwBTE5LVb7EhGpYBzGhhqhgwG6DujKYEoF2TNnofH6qd3n
         aOeIOSv9eD9N+myI+Tux5R4s/Gq7mlgDHfKPOveVtzTo2OoJ2zKHOJjm8CAVoVwxZqs7
         16iugMzliAR5dTw4tANKoI6GepTwEqcvTXJTwF+GLJ0zbTerDzEzQFUrqi+FBBiw5n0E
         057wDpMDAEyi6oZYcYpNauTGUkWrFUiBAiLs9FMgDJ3YBt5rboND1IaoGfQ6RJ09RIjS
         FkMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PAgL1L2vSwRbRF/b3cBOPDI+Q0dA5GZt0Ej0IQu6St4=;
        b=WS07tPpSAj9NMgmON70XxbXpL8/YEW6qCEvDPq0IDrSLfU8f4KorlHdpCgNvjXdDfR
         x4/5s1FISzOJ4GNyQH36Lj/IeOD8seFs/aSXhf9Azw/nAwrdNCCPYOmXms9EB9lBl/G7
         ehPhZyGakCmyHLnoQSQIP/EwqX5OvHdifF/YnbS/WwNET2TCOQD4X6rew4iq47K2tPAQ
         W+eBb9ZK5tuyYId5Oz033PZcweRfy8Up7P8ZILffk2QklvmRp2MVgROk59nrPCBqd2MU
         v7Kt3pJsRV0hu584NgXVnoE89qaEAEDW+OktxJvGLnMQ98Kqtbve1RjcjomVAIPHDJj8
         /BUw==
X-Gm-Message-State: APjAAAVjR/Asb2UZVGXVjXdIbykehQ/rv0jynEkcdl6s+NqyVs8yGCqd
        KvOmdr+PHTqvt8T551SdGQCS6QqYK8RZ2K/UK9EErg==
X-Google-Smtp-Source: APXvYqzuvEZ55FCkSs6fE0L0QEuvo0+NT75xQP59lz0N2e/4BLLWzkDNs/MrSmBgJgdEHBQn8iU7HwBYzAQLTA+8nsw=
X-Received: by 2002:a5d:46cf:: with SMTP id g15mr100119568wrs.93.1564089028994;
 Thu, 25 Jul 2019 14:10:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190725002204.185225-1-surenb@google.com> <20190725002204.185225-2-surenb@google.com>
 <57a23124f9e4d7ac5fb3145e990810dc2d190f72.camel@opteya.com>
 <CAJuCfpFvL1WjpCv74T23x1fgSok8FK=a-dMgcrSCVnu-masY8A@mail.gmail.com> <bdd5475f06763b8c3050b3b87471c5f6ce2e9168.camel@opteya.com>
In-Reply-To: <bdd5475f06763b8c3050b3b87471c5f6ce2e9168.camel@opteya.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 25 Jul 2019 14:10:17 -0700
Message-ID: <CAJuCfpG6+9Ly8YRn+vK=SPTKZt32ivL=AA==Vn_M_rrgxZKGZQ@mail.gmail.com>
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

On Thu, Jul 25, 2019 at 1:57 PM Yann Droneaud <ydroneaud@opteya.com> wrote:
>
> Hi,
>
> Le jeudi 25 juillet 2019 =C3=A0 08:48 -0700, Suren Baghdasaryan a =C3=A9c=
rit :
> > On Thu, Jul 25, 2019 at 4:58 AM Yann Droneaud <ydroneaud@opteya.com> wr=
ote:
> > > Le mercredi 24 juillet 2019 =C3=A0 17:22 -0700, Suren Baghdasaryan a =
=C3=A9crit :
> > > > This adds testing for polling on pidfd of a process being killed. T=
est runs
> > > > 10000 iterations by default to stress test pidfd polling functional=
ity.
> > > > It accepts an optional command-line parameter to override the numbe=
r or
> > > > iterations to run.
> > > > Specifically, it tests for:
> > > > - pidfd_open on a child process succeeds
> > > > - pidfd_send_signal on a child process succeeds
> > > > - polling on pidfd succeeds and returns exactly one event
> > > > - returned event is POLLIN
> > > > - event is received within 3 secs of the process being killed
> > > >
> > > > 10000 iterations was chosen because of the race condition being tes=
ted
> > > > which is not consistently reproducible but usually is revealed afte=
r less
> > > > than 2000 iterations.
> > > > Reveals race fixed by commit b191d6491be6 ("pidfd: fix a poll race =
when setting exit_state")
> > > >
> > > > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > > > ---
> > > >  tools/testing/selftests/pidfd/.gitignore      |   1 +
> > > >  tools/testing/selftests/pidfd/Makefile        |   2 +-
> > > >  .../testing/selftests/pidfd/pidfd_poll_test.c | 112 ++++++++++++++=
++++
> > > >  3 files changed, 114 insertions(+), 1 deletion(-)
> > > >  create mode 100644 tools/testing/selftests/pidfd/pidfd_poll_test.c
> > > >
> > > > diff --git a/tools/testing/selftests/pidfd/.gitignore b/tools/testi=
ng/selftests/pidfd/.gitignore
> > > > index 16d84d117bc0..a67896347d34 100644
> > > > --- a/tools/testing/selftests/pidfd/.gitignore
> > > > +++ b/tools/testing/selftests/pidfd/.gitignore
> > > > @@ -1,2 +1,3 @@
> > > >  pidfd_open_test
> > > > +pidfd_poll_test
> > > >  pidfd_test
> > > > diff --git a/tools/testing/selftests/pidfd/Makefile b/tools/testing=
/selftests/pidfd/Makefile
> > > > index 720b2d884b3c..ed58b7108d18 100644
> > > > --- a/tools/testing/selftests/pidfd/Makefile
> > > > +++ b/tools/testing/selftests/pidfd/Makefile
> > > > @@ -1,7 +1,7 @@
> > > >  # SPDX-License-Identifier: GPL-2.0-only
> > > >  CFLAGS +=3D -g -I../../../../usr/include/ -lpthread
> > > >
> > > > -TEST_GEN_PROGS :=3D pidfd_test pidfd_open_test
> > > > +TEST_GEN_PROGS :=3D pidfd_test pidfd_open_test pidfd_poll_test
> > > >
> > > >  include ../lib.mk
> > > >
> > > > diff --git a/tools/testing/selftests/pidfd/pidfd_poll_test.c b/tool=
s/testing/selftests/pidfd/pidfd_poll_test.c
> > > > new file mode 100644
> > > > index 000000000000..d45c612a0fe5
> > > > --- /dev/null
> > > > +++ b/tools/testing/selftests/pidfd/pidfd_poll_test.c
> > > > @@ -0,0 +1,112 @@
> > > > +// SPDX-License-Identifier: GPL-2.0
> > > > +
> > > > +#define _GNU_SOURCE
> > > > +#include <errno.h>
> > > > +#include <linux/types.h>
> > > > +#include <linux/wait.h>
> > > > +#include <poll.h>
> > > > +#include <signal.h>
> > > > +#include <stdbool.h>
> > > > +#include <stdio.h>
> > > > +#include <stdlib.h>
> > > > +#include <string.h>
> > > > +#include <syscall.h>
> > > > +#include <sys/wait.h>
> > > > +#include <unistd.h>
> > > > +
> > > > +#include "pidfd.h"
> > > > +#include "../kselftest.h"
> > > > +
> > > > +static bool timeout;
> > > > +
> > > > +static void handle_alarm(int sig)
> > > > +{
> > > > +     timeout =3D true;
> > > > +}
> > > > +
> > > > +int main(int argc, char **argv)
> > > > +{
> > > > +     struct pollfd fds;
> > > > +     int iter, nevents;
> > > > +     int nr_iterations =3D 10000;
> > > > +
> > > > +     fds.events =3D POLLIN;
> > > > +
> > > > +     if (argc > 2)
> > > > +             ksft_exit_fail_msg("Unexpected command line argument\=
n");
> > > > +
> > > > +     if (argc =3D=3D 2) {
> > > > +             nr_iterations =3D atoi(argv[1]);
> > > > +             if (nr_iterations <=3D 0)
> > > > +                     ksft_exit_fail_msg("invalid input parameter %=
s\n",
> > > > +                                     argv[1]);
> > > > +     }
> > > > +
> > > > +     ksft_print_msg("running pidfd poll test for %d iterations\n",
> > > > +             nr_iterations);
> > > > +
> > > > +     for (iter =3D 0; iter < nr_iterations; iter++) {
> > > > +             int pidfd;
> > > > +             int child_pid =3D fork();
> > > > +
> > > > +             if (child_pid < 0) {
> > > > +                     if (errno =3D=3D EAGAIN) {
> > > > +                             iter--;
> > > > +                             continue;
> > > > +                     }
> > > > +                     ksft_exit_fail_msg(
> > > > +                             "%s - failed to fork a child process\=
n",
> > > > +                             strerror(errno));
> > > > +             }
> > > > +
> > > > +             if (!child_pid) {
> > > > +                     /* Child process just sleeps for a min and ex=
its */
> > > > +                     sleep(60);
> > > > +                     exit(EXIT_SUCCESS);
> > > > +             }
> > > > +
> > > > +             /* Parent kills the child and waits for its death */
> > > > +             pidfd =3D sys_pidfd_open(child_pid, 0);
> > > > +             if (pidfd < 0)
> > > > +                     ksft_exit_fail_msg("%s - pidfd_open failed\n"=
,
> > > > +                                     strerror(errno));
> > > > +
> > > > +             /* Setup 3 sec alarm - plenty of time */
> > > > +             if (signal(SIGALRM, handle_alarm) =3D=3D SIG_ERR)
> > > > +                     ksft_exit_fail_msg("%s - signal failed\n",
> > > > +                                     strerror(errno));
> > > > +             alarm(3);
> > > > +
> > > > +             /* Send SIGKILL to the child */
> > > > +             if (sys_pidfd_send_signal(pidfd, SIGKILL, NULL, 0))
> > > > +                     ksft_exit_fail_msg("%s - pidfd_send_signal fa=
iled\n",
> > > > +                                     strerror(errno));
> > > > +
> > > > +             /* Wait for the death notification */
> > > > +             fds.fd =3D pidfd;
> > > > +             nevents =3D poll(&fds, 1, -1);
> > > > +
> > > > +             /* Check for error conditions */
> > > > +             if (nevents < 0)
> > > > +                     ksft_exit_fail_msg("%s - poll failed\n",
> > > > +                                     strerror(errno));
> > > > +
> > > > +             if (nevents !=3D 1)
> > > > +                     ksft_exit_fail_msg("unexpected poll result: %=
d\n",
> > > > +                                     nevents);
> > > > +
> > > > +             if (!(fds.revents & POLLIN))
> > > > +                     ksft_exit_fail_msg(
> > > > +                             "unexpected event type received: 0x%x=
\n",
> > > > +                             fds.revents);
> > > > +
> > > > +             if (timeout)
> > > > +                     ksft_exit_fail_msg(
> > > > +                             "death notification wait timeout\n");
> > > > +
> > > > +             close(pidfd);
> > >
> > > There's no call to wait(), or alike function. Is it required for the
> > > test to left zombies ?
> >
> > The test checks that death notification gets sent from kernel, which
> > by design should happen for any process that has non-zero
> > task->exit_state and that includes zombies (see
> > https://elixir.bootlin.com/linux/v5.3-rc1/source/kernel/fork.c#L1731
> > for that condition). So IIUC this code, the poll() should succeed no
> > matter if the task is zombie or dead. Or do I misunderstand your
> > question?
>
> OK, so I think it would be better to call wait() (in the future
> pidfd_wait()) to reap processes as they die.
>
> I'm not afraid by one zombie, but herding an army of 10000 zombie
> processes is another matter :)

Ah, I see what you mean now. I can respin this patch with a
wait(child_pid, NULL, 0) after close(pidfd) call. Would that address
your concern?

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
