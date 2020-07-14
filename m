Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F72321E470
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Jul 2020 02:22:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbgGNAWq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 13 Jul 2020 20:22:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726830AbgGNAWp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 13 Jul 2020 20:22:45 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A98CC061794
        for <linux-kselftest@vger.kernel.org>; Mon, 13 Jul 2020 17:22:45 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id md7so685203pjb.1
        for <linux-kselftest@vger.kernel.org>; Mon, 13 Jul 2020 17:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=f31PxKyy1+P4RLk/c/fs6WJ3JZAuSosfsqLmLnDvgYc=;
        b=hAm2TyI92wIZU5/F1Y4YPs2YKhsON68XvqNjT6Pmhmw74jv7JlXhnCN0gg01iquXKw
         hnOryIieMfykorbKwGHWSc7pbU+lFL5aw/ndIF5NqTC2DfsBTWsLbRhBAo0NcR0Ml9gg
         eh7fwxYlXDgib+VAVJCFTkkOXALlwgKwl/nsE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=f31PxKyy1+P4RLk/c/fs6WJ3JZAuSosfsqLmLnDvgYc=;
        b=LSFvGzF7bqkMHPvsyaNgc7NhYPugfkVcZ10n5b7lGTI2R3+xIOYfuF8uCHIDZiVrdx
         rFUaLJ++sHVqntIz8q6/4018XRTxNtp6J302jaIvWwpX+x22fY6K/5JrJgPiO/gksa9f
         iZ6LJywMuyVTeKR8gBBl5RyWO0aDHrWgmIT23/DRwJNx6zqfo+qkN1fl43cnjAOLveDo
         uJPJeEdcZo2rj34rFp4SKEMKY4nju+PLZ6cAahUGNqbZ1iowWGAMGmBOQtBavAfD6zkQ
         c8rojBrzJ2Wuwy3beFBjO4UfhB2Mt53T5KBUE9GeW2/q1N66ukIK7l6qBx6XRtF+kkcJ
         R+Ng==
X-Gm-Message-State: AOAM533Xkmx7IzFkuWmMRjNIoNviabKs0jMUC1bsqnmd5O6nHnEy+aO/
        kVjTn9B/kxJYl/P9g+svgrYHHQ==
X-Google-Smtp-Source: ABdhPJyfCHiZLk4sXm+zuWFA5WhiLeOyc8dTrfJa+zRTsxo3cIkE+ek1j8Ao4GJDYAVxH8ZeV288MA==
X-Received: by 2002:a17:902:ea8a:: with SMTP id x10mr1717906plb.95.1594686164646;
        Mon, 13 Jul 2020 17:22:44 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y200sm15072202pfb.33.2020.07.13.17.22.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 17:22:43 -0700 (PDT)
Date:   Mon, 13 Jul 2020 17:22:42 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org,
        kernel@collabora.com, willy@infradead.org, luto@kernel.org,
        gofmanp@gmail.com, linux-kselftest@vger.kernel.org,
        shuah@kernel.org
Subject: Re: [PATCH v3 2/2] selftests: Add kselftest for syscall user dispatch
Message-ID: <202007131716.303AF8371F@keescook>
References: <20200712044516.2347844-1-krisman@collabora.com>
 <20200712044516.2347844-3-krisman@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200712044516.2347844-3-krisman@collabora.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, Jul 12, 2020 at 12:45:16AM -0400, Gabriel Krisman Bertazi wrote:
> Implement functionality tests for syscall user dispatch.  In order to
> make the test portable, refrain from open coding syscall dispatchers and
> calculating glibc memory ranges.
> 
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
> ---
>  tools/testing/selftests/Makefile              |   1 +
>  .../syscall_user_dispatch/.gitignore          |   1 +
>  .../selftests/syscall_user_dispatch/Makefile  |   5 +
>  .../selftests/syscall_user_dispatch/config    |   1 +
>  .../syscall_user_dispatch.c                   | 259 ++++++++++++++++++
>  5 files changed, 267 insertions(+)
>  create mode 100644 tools/testing/selftests/syscall_user_dispatch/.gitignore
>  create mode 100644 tools/testing/selftests/syscall_user_dispatch/Makefile
>  create mode 100644 tools/testing/selftests/syscall_user_dispatch/config
>  create mode 100644 tools/testing/selftests/syscall_user_dispatch/syscall_user_dispatch.c
> 
> diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
> index 1195bd85af38..31b07dd774a6 100644
> --- a/tools/testing/selftests/Makefile
> +++ b/tools/testing/selftests/Makefile
> @@ -47,6 +47,7 @@ TARGETS += openat2
>  TARGETS += rseq
>  TARGETS += rtc
>  TARGETS += seccomp
> +TARGETS += syscall_user_dispatch
>  TARGETS += sigaltstack
>  TARGETS += size
>  TARGETS += sparc64

nit: moar alphabetical! :)

> diff --git a/tools/testing/selftests/syscall_user_dispatch/.gitignore b/tools/testing/selftests/syscall_user_dispatch/.gitignore
> new file mode 100644
> index 000000000000..fadfb304c539
> --- /dev/null
> +++ b/tools/testing/selftests/syscall_user_dispatch/.gitignore
> @@ -0,0 +1 @@
> +syscall_user_dispatch

nit: this needs as the first line:

# SPDX-License-Identifier: GPL-2.0-only

> diff --git a/tools/testing/selftests/syscall_user_dispatch/Makefile b/tools/testing/selftests/syscall_user_dispatch/Makefile
> new file mode 100644
> index 000000000000..4785c98d4714
> --- /dev/null
> +++ b/tools/testing/selftests/syscall_user_dispatch/Makefile
> @@ -0,0 +1,5 @@
> +# SPDX-License-Identifier: GPL-2.0
> +CFLAGS += -Wall
> +
> +TEST_GEN_PROGS := syscall_user_dispatch
> +include ../lib.mk
> diff --git a/tools/testing/selftests/syscall_user_dispatch/config b/tools/testing/selftests/syscall_user_dispatch/config
> new file mode 100644
> index 000000000000..22c4dfe167ca
> --- /dev/null
> +++ b/tools/testing/selftests/syscall_user_dispatch/config
> @@ -0,0 +1 @@
> +CONFIG_SYSCALL_USER_DISPATCH=y
> diff --git a/tools/testing/selftests/syscall_user_dispatch/syscall_user_dispatch.c b/tools/testing/selftests/syscall_user_dispatch/syscall_user_dispatch.c
> new file mode 100644
> index 000000000000..d713147863ef
> --- /dev/null
> +++ b/tools/testing/selftests/syscall_user_dispatch/syscall_user_dispatch.c
> @@ -0,0 +1,259 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + *  Copyright (c) 2020 Collabora Ltd.
> + *
> + * Test code for syscall user dispatch
> + */
> +
> +#define _GNU_SOURCE
> +#include <sys/types.h>
> +#include <sys/prctl.h>
> +#include <sys/syscall.h>
> +#include <sys/sysinfo.h>
> +#include <signal.h>
> +#include <errno.h>
> +
> +#include "../kselftest_harness.h"
> +
> +#ifndef PR_SET_SYSCALL_USER_DISPATCH

style nit: I usually use the initial ifndef to wrap all those related to
it. i.e.:

#ifndef PR_SET_SYSCALL_USER_DISPATCH
# define PR_SET_SYSCALL_USER_DISPATCH	59
# define PR_SYS_DISPATCH_OFF	0
# define PR_SYS_DISPATCH_ON	1
...
#endif

But either way is fine.

> +# define PR_SET_SYSCALL_USER_DISPATCH	59
> +#endif
> +
> +#ifndef PR_SYS_DISPATCH_OFF
> +# define PR_SYS_DISPATCH_OFF	0
> +#endif
> +
> +#ifndef PR_SYS_DISPATCH_ON
> +# define PR_SYS_DISPATCH_ON	1
> +#endif
> +
> +#ifndef SYS_USER_DISPATCH
> +# define SYS_USER_DISPATCH	2
> +#endif
> +
> +#define SYSCALL_DISPATCH_ON(x) ((x) = 1)
> +#define SYSCALL_DISPATCH_OFF(x) ((x) = 0)
> +
> +/* Test Summary:
> + *
> + * - dispatch_trigger_sigsys: Verify if PR_SET_SYSCALL_USER_DISPATCH is
> + *   able to trigger SIGSYS on a syscall.
> + *
> + * - bad_selector: Test that a bad selector value triggers SIGSEGV.
> + *
> + * - bad_prctl_param: Test that the API correctly rejects invalid
> + *   parameters on prctl
> + *
> + * - dispatch_and_return: Test that a syscall is selectively dispatched
> + *   to userspace depending on the value of selector.
> + *
> + * - disable_dispatch: Test that the PR_SYS_DISPATCH_OFF correctly
> + *   disables the dispatcher
> + *
> + * - direct_dispatch_range: Test that a syscall within the allowed range
> + *   can bypass the dispatcher.
> + */
> +
> +TEST_SIGNAL(dispatch_trigger_sigsys, SIGSYS)
> +{
> +	char sel = 0;
> +	struct sysinfo info;
> +	int ret;
> +
> +	ret = sysinfo(&info);
> +	ASSERT_EQ(0, ret);
> +
> +	ret = prctl(PR_SET_SYSCALL_USER_DISPATCH, PR_SYS_DISPATCH_ON, 0, 0, &sel);
> +	ASSERT_EQ(0, ret) {
> +		TH_LOG("Kernel does not support CONFIG_SYSCALL_USER_DISPATCH");
> +	}
> +
> +	SYSCALL_DISPATCH_ON(sel);
> +
> +	sysinfo(&info);
> +
> +	EXPECT_FALSE(true) {
> +		TH_LOG("Unreachable!");
> +	}
> +}
> +
> +TEST_SIGNAL(bad_selector, SIGSEGV)
> +{
> +	char sel = -1;
> +	long ret;
> +
> +	ret = prctl(PR_SET_SYSCALL_USER_DISPATCH, PR_SYS_DISPATCH_ON, 0, 0, &sel);
> +	ASSERT_EQ(0, ret) {
> +		TH_LOG("Kernel does not support CONFIG_SYSCALL_USER_DISPATCH");
> +	}
> +	EXPECT_FALSE(true) {
> +		TH_LOG("Unreachable!");
> +	}
> +}
> +
> +TEST(bad_prctl_param)
> +{
> +	char sel = 0;
> +	int op;
> +
> +	/* Invalid op */
> +	op = -1;
> +	prctl(PR_SET_SYSCALL_USER_DISPATCH, op, 0, 0, &sel);
> +	ASSERT_EQ(EINVAL, errno);
> +
> +	/* PR_SYS_DISPATCH_OFF */
> +	op = PR_SYS_DISPATCH_OFF;
> +
> +	/* start_addr != 0 */
> +	prctl(PR_SET_SYSCALL_USER_DISPATCH, op, 0x1, 0xff, 0);
> +	EXPECT_EQ(EINVAL, errno);
> +
> +	/* end_addr != 0 */
> +	prctl(PR_SET_SYSCALL_USER_DISPATCH, op, 0x0, 0xff, 0);
> +	EXPECT_EQ(EINVAL, errno);
> +
> +	/* sel != NULL */
> +	prctl(PR_SET_SYSCALL_USER_DISPATCH, op, 0x0, 0x0, &sel);
> +	EXPECT_EQ(EINVAL, errno);

I think here would be a good place to test PR_GET_... too?

> +
> +	/* Valid parameter */
> +	errno = 0;
> +	syscall(SYS_prctl, PR_SET_SYSCALL_USER_DISPATCH, op, 0x0, 0x0, 0x0);
> +	EXPECT_EQ(0, errno);
> +
> +	/* PR_SYS_DISPATCH_ON */
> +	op = PR_SYS_DISPATCH_ON;
> +
> +	/* start_addr > end_addr */
> +	syscall(SYS_prctl, PR_SET_SYSCALL_USER_DISPATCH, op, 0x1, 0x0, &sel);
> +	EXPECT_EQ(EINVAL, errno);
> +
> +	/* Invalid selector */
> +	syscall(SYS_prctl, PR_SET_SYSCALL_USER_DISPATCH, op, 0x0, 0x1, (void *) -1);
> +	ASSERT_EQ(EFAULT, errno);
> +}
> +
> +#define MAGIC_SYSCALL_1 0xff00  /* Bad Linux syscall number */

Some archs do weird things with syscalls. Maybe use __NR_syscalls + 1?
For x86, this should be fine, though.

> +
> +/*
> + * Use global selector for handle_sigsys tests, to avoid passing
> + * selector to signal handler
> + */
> +char glob_sel;
> +int nr_syscalls_emulated;
> +int si_code;
> +
> +static void handle_sigsys(int sig, siginfo_t *info, void *ucontext)
> +{
> +	si_code = info->si_code;
> +
> +	if (info->si_syscall == MAGIC_SYSCALL_1)
> +		nr_syscalls_emulated++;
> +
> +	/* In preparation for sigreturn. */
> +	SYSCALL_DISPATCH_OFF(glob_sel);
> +}
> +
> +TEST(dispatch_and_return)
> +{
> +	long ret;
> +	struct sigaction act;
> +	sigset_t mask;
> +
> +	glob_sel = 0;
> +	nr_syscalls_emulated = 0;
> +	si_code = 0;
> +
> +	memset(&act, 0, sizeof(act));
> +	sigemptyset(&mask);
> +
> +	act.sa_sigaction = handle_sigsys;
> +	act.sa_flags = SA_SIGINFO;
> +	act.sa_mask = mask;
> +
> +	ret = sigaction(SIGSYS, &act, NULL);
> +	ASSERT_EQ(0, ret);
> +
> +	/* Make sure selector is good prior to prctl. */
> +	SYSCALL_DISPATCH_OFF(glob_sel);
> +
> +	ret = prctl(PR_SET_SYSCALL_USER_DISPATCH, PR_SYS_DISPATCH_ON, 0, 0, &glob_sel);
> +	ASSERT_EQ(0, ret) {
> +		TH_LOG("Kernel does not support CONFIG_SYSCALL_USER_DISPATCH");
> +	}
> +
> +	/* MAGIC_SYSCALL_1 doesn't exist. */
> +	SYSCALL_DISPATCH_OFF(glob_sel);
> +	ret = syscall(MAGIC_SYSCALL_1);
> +	EXPECT_EQ(-1, ret) {
> +		TH_LOG("Dispatch triggered unexpectedly");
> +	}
> +
> +	/* MAGIC_SYSCALL_1 should be emulated. */
> +	nr_syscalls_emulated = 0;
> +	SYSCALL_DISPATCH_ON(glob_sel);
> +
> +	ret = syscall(MAGIC_SYSCALL_1);
> +	EXPECT_EQ(MAGIC_SYSCALL_1, ret) {
> +		TH_LOG("Failed to intercept syscall");
> +	}
> +	EXPECT_EQ(1, nr_syscalls_emulated) {
> +		TH_LOG("Failed to emulate syscall");
> +	}
> +	ASSERT_EQ(SYS_USER_DISPATCH, si_code) {
> +		TH_LOG("Bad si_code in SIGSYS");
> +	}
> +}
> +
> +TEST(disable_dispatch)
> +{
> +	int ret;
> +	struct sysinfo info;
> +	char sel = 0;
> +
> +	ret = prctl(PR_SET_SYSCALL_USER_DISPATCH, PR_SYS_DISPATCH_ON, 0, 0, &sel);
> +	ASSERT_EQ(0, ret) {
> +		TH_LOG("Kernel does not support CONFIG_SYSCALL_USER_DISPATCH");
> +	}
> +
> +	/* MAGIC_SYSCALL_1 doesn't exist. */
> +	SYSCALL_DISPATCH_OFF(glob_sel);
> +
> +	ret = prctl(PR_SET_SYSCALL_USER_DISPATCH, PR_SYS_DISPATCH_OFF, 0, 0, 0);
> +	EXPECT_EQ(0, ret) {
> +		TH_LOG("Failed to unset syscall user dispatch");
> +	}
> +
> +	/* Shouldn't have any effect... */
> +	SYSCALL_DISPATCH_ON(glob_sel);
> +
> +	ret = syscall(SYS_sysinfo, &info);
> +	EXPECT_EQ(0, ret) {
> +		TH_LOG("Dispatch triggered unexpectedly");
> +	}
> +}
> +
> +TEST(direct_dispatch_range)
> +{
> +	int ret = 0;
> +	struct sysinfo info;
> +	char sel = 0;
> +
> +	/*
> +	 * Instead of calculating libc addresses; allow the entire
> +	 * memory map and lock the selector.
> +	 */
> +	ret = prctl(PR_SET_SYSCALL_USER_DISPATCH, PR_SYS_DISPATCH_ON, 0, -1L, &sel);
> +	ASSERT_EQ(0, ret) {
> +		TH_LOG("Kernel does not support CONFIG_SYSCALL_USER_DISPATCH");
> +	}
> +
> +	SYSCALL_DISPATCH_ON(sel);
> +
> +	ret = syscall(SYS_sysinfo, &info);
> +	ASSERT_EQ(0, ret) {
> +		TH_LOG("Dispatch triggered unexpectedly");
> +	}
> +}
> +
> +TEST_HARNESS_MAIN

Yay tests! :) Thank you! :)

-- 
Kees Cook
