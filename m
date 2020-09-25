Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 807BD278053
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Sep 2020 08:09:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727151AbgIYGJs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 25 Sep 2020 02:09:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727090AbgIYGJs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 25 Sep 2020 02:09:48 -0400
Received: from mail-ua1-x943.google.com (mail-ua1-x943.google.com [IPv6:2607:f8b0:4864:20::943])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02F53C0613CE
        for <linux-kselftest@vger.kernel.org>; Thu, 24 Sep 2020 23:09:48 -0700 (PDT)
Received: by mail-ua1-x943.google.com with SMTP id d18so558542uav.4
        for <linux-kselftest@vger.kernel.org>; Thu, 24 Sep 2020 23:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+Gekh1/5HoSJgzGHBdPAl6wdzLsESdx094pfUMDJNyY=;
        b=dD5keCca5UgZ+EkGaoslYMH6ugraBNwjEpWR+NeC67ssf+Snq7vYe3XpYQ7kzkqMKz
         Sm19c1aeIJMEIuC7O+mIAJDQ4GaduImiLb8BwTm/ijJo/9/RLR6zG9UFvkrMiIl/LfGV
         a8iQ4bTXB38uRWc2wFr/Tg+pgiR4/WnsCAUXlAz4D2AzOHt372+ILQ3QpEr85DCqDmoI
         0qrscfR//nr/b1WyvAfUKdycS2Gqnk/zzMU5nxViEninjYR2SqXS5Vwc0k0zj5pbO/WJ
         jxHVuJs1GCPTxtgHn5l9JxRSNMQbaMoBlUmELwE8Jd2o2T8e4Jv5Oac3vVxusY3hsN3z
         R95Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+Gekh1/5HoSJgzGHBdPAl6wdzLsESdx094pfUMDJNyY=;
        b=PZll7LIW2hkYQBgGnOknDsbfNNTn57RajdrUiXyeFIoaKNUtzXUG47Vnp0ObCecn34
         DZeA9prZUyf0NwyrKqT/iExAH+C3LCHnQNTnmVNUhIvV7jK1fiCz2r8nuB6vBtyRcYSE
         sxgSzJySWWzKn9gEv6tlI6yLoUM/Y1hQIJLEpE0CEaqxnWU7OlNULpOdbSpk5OTiRQOG
         VmFvfb1VvS99ksVktzmPsQBBKih5Lvg+/QB6qRv0OqzdDRX2CGu+Z0eHQhVDiUuP7xQP
         5UBOtpAWPxINfi7YExL5BjA1QefTYKaJKetAiTLB7krw64h+PxIJq8Fn06yPFzwKow8G
         9YMQ==
X-Gm-Message-State: AOAM531f33RIcEhG6E4C+RVZYyzfa7m8czJh4cm2HkaghhKrDEThGVRR
        wnbwTLjY9zewPmE/BV2tBAs1/lqJu0StsObkMI7Bwg==
X-Google-Smtp-Source: ABdhPJws0yBakJxLSgvK/0x/1OQPz7YxRxkZQcqwZiHxwegfJTqjSbUaJljKms2pqCM5u1+NBYuCQeQxme7+GWDW+OM=
X-Received: by 2002:a9f:29c5:: with SMTP id s63mr1581180uas.34.1601014186979;
 Thu, 24 Sep 2020 23:09:46 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYtF44bTzjswt26tOwfEQxrWvcSOROmEtH0HKfGn24QbRQ@mail.gmail.com>
 <20200924143317.getruzwu423g3o3e@wittgenstein> <20200924162126.mbthwz32w7rba7oe@wittgenstein>
In-Reply-To: <20200924162126.mbthwz32w7rba7oe@wittgenstein>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 25 Sep 2020 11:39:35 +0530
Message-ID: <CA+G9fYsCRxD+ViHgtOUtVba4wxzH1vua2gQwj6OvbBLoLj7=AA@mail.gmail.com>
Subject: Re: selftests: pidfd: pidfd_wait hangs on linux next kernel on all devices
To:     Christian Brauner <christian.brauner@ubuntu.com>
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, 24 Sep 2020 at 21:51, Christian Brauner
<christian.brauner@ubuntu.com> wrote:
>
> On Thu, Sep 24, 2020 at 04:33:17PM +0200, Christian Brauner wrote:
> > On Wed, Sep 23, 2020 at 07:52:05PM +0530, Naresh Kamboju wrote:
> > > selftests: pidfd: pidfd_wait hangs on linux next kernel on x86_64,
> > > i386 and arm64 Juno-r2
> > > These devices are using NFS mounted rootfs.
> > > I have tested pidfd testcases independently and all test PASS.
> > >
> > > The Hang or exit from test run noticed when run by run_kselftest.sh
> > >
> > > pidfd_wait.c:208:wait_nonblock:Expected sys_waitid(P_PIDFD, pidfd,
> > > &info, WSTOPPED, NULL) (-1) == 0 (0)
> > > wait_nonblock: Test terminated by assertion
> > >
> > > metadata:
> > >   git branch: master
> > >   git repo: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
> > >   git commit: e64997027d5f171148687e58b78c8b3c869a6158
> > >   git describe: next-20200922
> > >   make_kernelversion: 5.9.0-rc6
> > >   kernel-config:
> > > http://snapshots.linaro.org/openembedded/lkft/lkft/sumo/intel-core2-32/lkft/linux-next/865/config
> > >
> > > Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> >
> > Thanks for reproting this. I'm taking a look now!
>
> Ok, this is a simple race in the selftests, that I overlooked and which
> is more likely to hit when there's a lot of processes running on the
> system. Basically the child process hasn't SIGSTOPed itself yet but the
> parent is already calling waitid() on a O_NONBLOCK pidfd. Since it
> doesn't find a WSTOPPED process it returns -EAGAIN correctly.
>
> The fix for this is to move the line where we're removing the O_NONBLOCK
> property from the fd before the waitid() WSTOPPED call so we hang until
> the child becomes stopped.
>
> So I believe the fix is:

This patch applied and scheduled for kselftest full test run.

>
> diff --git a/tools/testing/selftests/pidfd/pidfd_wait.c b/tools/testing/selftests/pidfd/pidfd_wait.c
> index 4063d6f31fa4..be2943f072f6 100644
> --- a/tools/testing/selftests/pidfd/pidfd_wait.c
> +++ b/tools/testing/selftests/pidfd/pidfd_wait.c
> @@ -205,6 +205,8 @@ TEST(wait_nonblock)
>         ret = sys_waitid(P_PIDFD, pidfd, &info, WEXITED | WNOHANG, NULL);
>         ASSERT_EQ(ret, 0);
>
> +       ASSERT_EQ(fcntl(pidfd, F_SETFL, (flags & ~O_NONBLOCK)), 0);
> +
>         ASSERT_EQ(sys_waitid(P_PIDFD, pidfd, &info, WSTOPPED, NULL), 0);
>         ASSERT_EQ(info.si_signo, SIGCHLD);
>         ASSERT_EQ(info.si_code, CLD_STOPPED);
> @@ -212,8 +214,6 @@ TEST(wait_nonblock)
>
>         ASSERT_EQ(sys_pidfd_send_signal(pidfd, SIGCONT, NULL, 0), 0);
>
> -       ASSERT_EQ(fcntl(pidfd, F_SETFL, (flags & ~O_NONBLOCK)), 0);
> -
>         ASSERT_EQ(sys_waitid(P_PIDFD, pidfd, &info, WEXITED, NULL), 0);
>         ASSERT_EQ(info.si_signo, SIGCHLD);
>         ASSERT_EQ(info.si_code, CLD_EXITED);
>
> Christian

- Naresh
