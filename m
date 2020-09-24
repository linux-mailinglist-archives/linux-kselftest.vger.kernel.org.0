Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E8F0277681
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Sep 2020 18:21:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbgIXQVa (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 24 Sep 2020 12:21:30 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:35348 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726477AbgIXQVa (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 24 Sep 2020 12:21:30 -0400
Received: from ip5f5af089.dynamic.kabel-deutschland.de ([95.90.240.137] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1kLTzr-00031R-6I; Thu, 24 Sep 2020 16:21:27 +0000
Date:   Thu, 24 Sep 2020 18:21:26 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, linux-api@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        Christian Brauner <christian@brauner.io>,
        Kees Cook <keescook@chromium.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Sargun Dhillon <sargun@sargun.me>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Jens Axboe <axboe@kernel.dk>, Shuah Khan <shuah@kernel.org>,
        lkft-triage@lists.linaro.org
Subject: Re: selftests: pidfd: pidfd_wait hangs on linux next kernel on all
 devices
Message-ID: <20200924162126.mbthwz32w7rba7oe@wittgenstein>
References: <CA+G9fYtF44bTzjswt26tOwfEQxrWvcSOROmEtH0HKfGn24QbRQ@mail.gmail.com>
 <20200924143317.getruzwu423g3o3e@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200924143317.getruzwu423g3o3e@wittgenstein>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Sep 24, 2020 at 04:33:17PM +0200, Christian Brauner wrote:
> On Wed, Sep 23, 2020 at 07:52:05PM +0530, Naresh Kamboju wrote:
> > selftests: pidfd: pidfd_wait hangs on linux next kernel on x86_64,
> > i386 and arm64 Juno-r2
> > These devices are using NFS mounted rootfs.
> > I have tested pidfd testcases independently and all test PASS.
> > 
> > The Hang or exit from test run noticed when run by run_kselftest.sh
> > 
> > pidfd_wait.c:208:wait_nonblock:Expected sys_waitid(P_PIDFD, pidfd,
> > &info, WSTOPPED, NULL) (-1) == 0 (0)
> > wait_nonblock: Test terminated by assertion
> > 
> > metadata:
> >   git branch: master
> >   git repo: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
> >   git commit: e64997027d5f171148687e58b78c8b3c869a6158
> >   git describe: next-20200922
> >   make_kernelversion: 5.9.0-rc6
> >   kernel-config:
> > http://snapshots.linaro.org/openembedded/lkft/lkft/sumo/intel-core2-32/lkft/linux-next/865/config
> > 
> > Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> 
> Thanks for reproting this. I'm taking a look now!

Ok, this is a simple race in the selftests, that I overlooked and which
is more likely to hit when there's a lot of processes running on the
system. Basically the child process hasn't SIGSTOPed itself yet but the
parent is already calling waitid() on a O_NONBLOCK pidfd. Since it
doesn't find a WSTOPPED process it returns -EAGAIN correctly.

The fix for this is to move the line where we're removing the O_NONBLOCK
property from the fd before the waitid() WSTOPPED call so we hang until
the child becomes stopped.

So I believe the fix is:

diff --git a/tools/testing/selftests/pidfd/pidfd_wait.c b/tools/testing/selftests/pidfd/pidfd_wait.c
index 4063d6f31fa4..be2943f072f6 100644
--- a/tools/testing/selftests/pidfd/pidfd_wait.c
+++ b/tools/testing/selftests/pidfd/pidfd_wait.c
@@ -205,6 +205,8 @@ TEST(wait_nonblock)
        ret = sys_waitid(P_PIDFD, pidfd, &info, WEXITED | WNOHANG, NULL);
        ASSERT_EQ(ret, 0);

+       ASSERT_EQ(fcntl(pidfd, F_SETFL, (flags & ~O_NONBLOCK)), 0);
+
        ASSERT_EQ(sys_waitid(P_PIDFD, pidfd, &info, WSTOPPED, NULL), 0);
        ASSERT_EQ(info.si_signo, SIGCHLD);
        ASSERT_EQ(info.si_code, CLD_STOPPED);
@@ -212,8 +214,6 @@ TEST(wait_nonblock)

        ASSERT_EQ(sys_pidfd_send_signal(pidfd, SIGCONT, NULL, 0), 0);

-       ASSERT_EQ(fcntl(pidfd, F_SETFL, (flags & ~O_NONBLOCK)), 0);
-
        ASSERT_EQ(sys_waitid(P_PIDFD, pidfd, &info, WEXITED, NULL), 0);
        ASSERT_EQ(info.si_signo, SIGCHLD);
        ASSERT_EQ(info.si_code, CLD_EXITED);

Christian
