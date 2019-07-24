Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70ABE7348C
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jul 2019 19:04:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbfGXREN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 24 Jul 2019 13:04:13 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38273 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726575AbfGXREN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 24 Jul 2019 13:04:13 -0400
Received: by mail-wm1-f67.google.com with SMTP id s15so20927868wmj.3
        for <linux-kselftest@vger.kernel.org>; Wed, 24 Jul 2019 10:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9ujl5V1w4mNBwDy22VY19uphlCRoFVxEw++qYxxlthA=;
        b=AvO6TdTpeaemGncAgHgSxvl8NyD+ABGy6HpIx+gdSw3/+fVJOMgK2JF+4W8fj1ZJBt
         s27RIRFiCs+xFIUdb4sGio2LtzoROeMNvZt2BuBZ+NjHEp9x10eRKwmYrYuwyi0EaSba
         BA1+TOvT+HNRnmlD8GajxDa6UaZX0MlEdzenLRoc5ktMBIn+f5U288Pa8vKTeD7e5SXg
         21nritV+/vlHQO+aed/d0HCnrkTeIZz/+a8JDSnPM+mjTjyn0Hl1iJEZIJGq9fWW8YBx
         e/VFvtYht2SXkLAprcvCKAkDSaIA605hLTmab19xP1OxZlzAM7cZ86Siat8iBhjEDEmS
         qzGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9ujl5V1w4mNBwDy22VY19uphlCRoFVxEw++qYxxlthA=;
        b=QMUPXVbV+jfmILx2fgVxHxSYdmNpLeyymNLuB0rNVH2BnU0IUKh4y26U2oXe7hcVUt
         WECsf2GP0bbMTYKyyfDoZZTz3Jy0LH9V1bsI3qf/Ro63JBzlX9U1xNli9WTxx4+LqPsm
         K/yeiCuv040UQaDXWLXtXeTI2+iBgBpv+Jkyte1XePD0C4yL+g8dxSmKzH+NwhqbqSLH
         Ezn24NNfrk5Q/lbu7ijLTn8J0Z5vi11NkQTkQMNS34YjDViBkgyWOHzzKY2OiPayOLp6
         se2xTwnWJYvCGucAFW3yobfgld3olOivv3FbTFM5gmTi4VG2uCN1MkKJWr/LwxxP7PVK
         iJlQ==
X-Gm-Message-State: APjAAAVn991l1qUyOIds//T564lvRW1Ha4zpv6njgdpbjt5753fwVZzg
        ROIGi/n8/+PWH6aaWnhrjikwTTHqQ4NzuO1aSOxJ+g==
X-Google-Smtp-Source: APXvYqzNJMRhZ7Ymxuw1/AjYI4F1X3Qu0/2IUKwriRcLlXLq8WjFtWfbaXBEb+zE63rhrwq1F9Knz0iaikccl9aLXsc=
X-Received: by 2002:a7b:c947:: with SMTP id i7mr77639368wml.77.1563987849601;
 Wed, 24 Jul 2019 10:04:09 -0700 (PDT)
MIME-Version: 1.0
References: <20190723173907.196488-1-surenb@google.com> <20190724103845.pxhpx7n6ih2byrsm@brauner.io>
In-Reply-To: <20190724103845.pxhpx7n6ih2byrsm@brauner.io>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Wed, 24 Jul 2019 10:03:58 -0700
Message-ID: <CAJuCfpG-xfDhbjhEWkDtZDfvh7S7zQNu-8Z8pwAYVL35Kees8w@mail.gmail.com>
Subject: Re: [PATCH 1/1] tests: add pidfd poll tests
To:     Christian Brauner <christian@brauner.io>
Cc:     arnd@arndb.de, "Eric W. Biederman" <ebiederm@xmission.com>,
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
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Jul 24, 2019 at 3:38 AM Christian Brauner <christian@brauner.io> wrote:
>
> On Tue, Jul 23, 2019 at 10:39:07AM -0700, Suren Baghdasaryan wrote:
> > This adds testing for polling on pidfd of a process being killed. Test runs
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
> > which is not consistently reproducible but usually is revealed after less
> > than 2000 iterations.
> > Reveals race fixed by commit b191d6491be6 ("pidfd: fix a poll race when setting exit_state")
>
> Thanks for upstreaming the stress-tester. A few comments below.
>

Thanks for the comments. All make sense. I'll send an update later
today or tomorrow.

> >
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > ---
> >  tools/testing/selftests/pidfd/.gitignore      |   1 +
> >  tools/testing/selftests/pidfd/Makefile        |   2 +-
> >  .../testing/selftests/pidfd/pidfd_poll_test.c | 137 ++++++++++++++++++
> >  3 files changed, 139 insertions(+), 1 deletion(-)
> >  create mode 100644 tools/testing/selftests/pidfd/pidfd_poll_test.c
> >
> > diff --git a/tools/testing/selftests/pidfd/.gitignore b/tools/testing/selftests/pidfd/.gitignore
> > index 16d84d117bc0..a67896347d34 100644
> > --- a/tools/testing/selftests/pidfd/.gitignore
> > +++ b/tools/testing/selftests/pidfd/.gitignore
> > @@ -1,2 +1,3 @@
> >  pidfd_open_test
> > +pidfd_poll_test
> >  pidfd_test
> > diff --git a/tools/testing/selftests/pidfd/Makefile b/tools/testing/selftests/pidfd/Makefile
> > index 720b2d884b3c..ed58b7108d18 100644
> > --- a/tools/testing/selftests/pidfd/Makefile
> > +++ b/tools/testing/selftests/pidfd/Makefile
> > @@ -1,7 +1,7 @@
> >  # SPDX-License-Identifier: GPL-2.0-only
> >  CFLAGS += -g -I../../../../usr/include/ -lpthread
> >
> > -TEST_GEN_PROGS := pidfd_test pidfd_open_test
> > +TEST_GEN_PROGS := pidfd_test pidfd_open_test pidfd_poll_test
> >
> >  include ../lib.mk
> >
> > diff --git a/tools/testing/selftests/pidfd/pidfd_poll_test.c b/tools/testing/selftests/pidfd/pidfd_poll_test.c
> > new file mode 100644
> > index 000000000000..f2934aa070ae
> > --- /dev/null
> > +++ b/tools/testing/selftests/pidfd/pidfd_poll_test.c
> > @@ -0,0 +1,137 @@
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
> > +#define __NR_pidfd_send_signal 424
> > +#define __NR_pidfd_open 434
>
> That won't work on Alpha where this number is unfortunately different so
> I'm not sure which syscall you'd hit there (/me checks
> 424     common  tgkill                          sys_tgkill
> )
>
> The better option is to just place
>
> #ifndef __NR_pidfd_send_signal
> #define __NR_pidfd_send_signal -1
> #endif
>
> #ifndef __NR_pidfd_open
> #define __NR_pidfd_open -1
> #endif
>
> into the pidfd.h header.
>
> > +
> > +static inline int sys_pidfd_open(pid_t pid, unsigned int flags)
> > +{
> > +     return syscall(__NR_pidfd_open, pid, flags);
> > +}
> > +
> > +static inline int sys_pidfd_send_signal(int pidfd, int sig, siginfo_t *info,
> > +                                     unsigned int flags)
> > +{
> > +     return syscall(__NR_pidfd_send_signal, pidfd, sig, info, flags);
> > +}
>
> Those can go into pidfd.h too.
>
> > +
> > +static bool timeout;
> > +
> > +static void handle_alarm(int sig)
> > +{
> > +     timeout = true;
> > +}
> > +
> > +int main(int argc, char **argv)
> > +{
> > +     int ret = 1;
> > +     int pidfd = -1;
> > +     struct pollfd fds;
> > +     int iter, nevents;
> > +     int nr_iterations = 10000;
> > +
> > +     fds.events = POLLIN;
>
> if (argc > 2)
>         ksft_exit_fail_msg("Unexpected command line argument");
>
> > +     if (argc > 1) {
>
>         if (argc == 2)
>
> > +             nr_iterations = atoi(argv[1]);
> > +             if (!nr_iterations) {
>
> You should probably also check for negative values.
>
> > +                     ksft_test_result_fail("invalid input parameter %s\n",
> > +                             argv[1]);
> > +                     return ksft_exit_fail();
> > +             }
> > +     }
> > +
> > +     ksft_print_msg("running pidfd poll test for %d iterations\n",
> > +             nr_iterations);
> > +
> > +     for (iter = 0; iter < nr_iterations; iter++) {
> > +             int child_pid = fork();
> > +
> > +             if (!child_pid) {
> > +                     /* Child process just sleeps for a min */
> > +                     sleep(60);
> > +                     exit(0);
>
> Just for kicks, please use exit(EXIT_SUCCESS)
>
> > +             }
>
>
> You should switch the checkes, i.e.
>
>         if (child_pid < 0)
>                 /* do stuff */
>
>         if (child_pid == 0)
>                 /* do other stuff */
>
> > +
> > +             /* Parent kills the child and waits for its death */
> > +             if (child_pid < 0) {
> > +                     if (errno == EAGAIN) {
> > +                             iter--;
> > +                             continue;
> > +                     }
> > +                     ksft_print_msg("%s - failed to fork a child process\n",
> > +                             strerror(errno));
>
> Uhm, shouldn't you exit with an error here?, i.e.
>
>                 ksft_exit_fail_msg(...
>
> > +             }
> > +             pidfd = sys_pidfd_open(child_pid, 0);
> > +             if (pidfd < 0) {
> > +                     ksft_print_msg("%s - pidfd_open failed\n",
> > +                             strerror(errno));
> > +                     goto on_error;
>
> I think you honestly can just call ksft_exit_fail_msg() everywhere. The
> fds will be cleaned up on process exit anyway and it's pretty
> short-lived.
>
> > +             }
> > +             /* Setup 3 sec alarm - plenty of time */
> > +             if (signal(SIGALRM, handle_alarm) == SIG_ERR) {
> > +                     ksft_print_msg("%s - signal failed\n",
> > +                             strerror(errno));
> > +                     goto on_error;
> > +             }
> > +             alarm(3);
> > +             /* Send SIGKILL to the child */
> > +             if (sys_pidfd_send_signal(pidfd, SIGKILL, NULL, 0)) {
> > +                     ksft_print_msg("%s - pidfd_send_signal failed\n",
> > +                             strerror(errno));
> > +                     goto on_error;
> > +             }
> > +             /* Wait for the death notification */
> > +             fds.fd = pidfd;
> > +             nevents = poll(&fds, 1, -1);
> > +             if (nevents < 0) {
> > +                     ksft_print_msg("%s - poll failed\n",
> > +                             strerror(errno));
> > +                     goto on_error;
> > +             }
> > +             if (nevents != 1) {
> > +                     ksft_print_msg("unexpected poll result: %d\n",
> > +                             nevents);
> > +                     goto on_error;
> > +             }
> > +             if (!(fds.revents & POLLIN)) {
> > +                     ksft_print_msg(
> > +                             "unexpected event type received: 0x%x\n",
> > +                             fds.revents);
> > +                     goto on_error;
> > +             }
> > +             if (timeout) {
> > +                     ksft_print_msg("death notification wait timeout\n");
> > +                     goto on_error;
> > +             }
> > +             close(pidfd);
> > +     }
> > +     ret = 0;
> > +
> > +on_error:
> > +     if (pidfd)
> > +             close(pidfd);
> > +
> > +     if (ret) {
> > +             ksft_test_result_fail("failed after %d retries\n", iter);
> > +             return ksft_exit_fail();
> > +     }
> > +
> > +     ksft_test_result_pass("pidfd poll test: pass\n");
> > +     return ksft_exit_pass();
> > +}
> > --
> > 2.22.0.657.g960e92d24f-goog
> >
