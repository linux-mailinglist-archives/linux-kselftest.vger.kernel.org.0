Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4F4327740F
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Sep 2020 16:33:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728303AbgIXOdW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 24 Sep 2020 10:33:22 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:59413 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728088AbgIXOdV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 24 Sep 2020 10:33:21 -0400
Received: from ip5f5af089.dynamic.kabel-deutschland.de ([95.90.240.137] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1kLSJD-0002uO-79; Thu, 24 Sep 2020 14:33:19 +0000
Date:   Thu, 24 Sep 2020 16:33:17 +0200
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
Message-ID: <20200924143317.getruzwu423g3o3e@wittgenstein>
References: <CA+G9fYtF44bTzjswt26tOwfEQxrWvcSOROmEtH0HKfGn24QbRQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+G9fYtF44bTzjswt26tOwfEQxrWvcSOROmEtH0HKfGn24QbRQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Sep 23, 2020 at 07:52:05PM +0530, Naresh Kamboju wrote:
> selftests: pidfd: pidfd_wait hangs on linux next kernel on x86_64,
> i386 and arm64 Juno-r2
> These devices are using NFS mounted rootfs.
> I have tested pidfd testcases independently and all test PASS.
> 
> The Hang or exit from test run noticed when run by run_kselftest.sh
> 
> pidfd_wait.c:208:wait_nonblock:Expected sys_waitid(P_PIDFD, pidfd,
> &info, WSTOPPED, NULL) (-1) == 0 (0)
> wait_nonblock: Test terminated by assertion
> 
> metadata:
>   git branch: master
>   git repo: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
>   git commit: e64997027d5f171148687e58b78c8b3c869a6158
>   git describe: next-20200922
>   make_kernelversion: 5.9.0-rc6
>   kernel-config:
> http://snapshots.linaro.org/openembedded/lkft/lkft/sumo/intel-core2-32/lkft/linux-next/865/config
> 
> Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>

Thanks for reproting this. I'm taking a look now!
Christian
 https://lkft.linaro.org
