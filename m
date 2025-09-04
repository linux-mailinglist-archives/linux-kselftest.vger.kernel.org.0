Return-Path: <linux-kselftest+bounces-40791-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40336B442A2
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Sep 2025 18:26:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9F9F1C85771
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Sep 2025 16:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92086230BEC;
	Thu,  4 Sep 2025 16:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S6TViemx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C0A82264BA;
	Thu,  4 Sep 2025 16:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757003200; cv=none; b=HNMUYgPiGKaG5HzlamZg7kksFWL2vGMF82iLAFCg3Mt1UqvbAztioQsy+9OcSm+e/eE3wMbI7+Kz6CC5FCXY+Qc4c91EmShvuVBqh4y4F/a/dxAZZjeO4MwlgHjMXNKPW2qg/bXVsewwH1ZC/3Hv0hfv4QkZw54OKvBTWfbe5XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757003200; c=relaxed/simple;
	bh=lqZgHQzOxA1Zj3sJl1xvirCzLc0+9WX5kcWsHt+pKHE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AxF2YHFriuAxyNv9v2ZHHAcROi9qvP20Uoa9hBZs5I4+uzEVmI7kwWAfxs51sxaIxJr9fiKacFfzEs5unN8uZHxLA4TxuW7CG+REUN6bRTG/8YMBQrUcZjZeMzQj1RigQ6tlbRs2fRhgzRCyw9Ji6qBOgzwW6eu8N95u5B/EUH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S6TViemx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 019BAC4CEF0;
	Thu,  4 Sep 2025 16:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757003200;
	bh=lqZgHQzOxA1Zj3sJl1xvirCzLc0+9WX5kcWsHt+pKHE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S6TViemxT65cv1I6rXOnCLco9jZGlUXqJpo5BCDNXtAqJdtlQ57wh68gZs7H53RQm
	 cd+Ns5MoOrxuYUVbNwJEjXnbpfZmMcwsMTJj+EceGXwyIpDHIae/0bcEkSRKQN25IT
	 7Fu8StCuS0A9CHa4yqexArg8MbZt8fWNWlsgjzoLVUX5qtertdBG5PZTIC6HjKpRP/
	 qoP+0yXzdsM6RiXY0PA7CylGhKD4f5ImoO2sqcr4ejuyBLH0LEjl3bZJkxSOElYJOl
	 kyq8re1ZpG5dG7r/Q4KM4NB6fMcXMYI5t8C5m3ZyH+uaKX1rxnSwclW37siRLIQapN
	 G6TpNGgP27Nng==
Date: Thu, 4 Sep 2025 09:26:39 -0700
From: Kees Cook <kees@kernel.org>
To: Tom Hromatka <tom.hromatka@oracle.com>
Cc: luto@amacapital.net, wad@chromium.org, sargun@sargun.me, corbet@lwn.net,
	shuah@kernel.org, brauner@kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH] seccomp: Add SECCOMP_CLONE_FILTER operation
Message-ID: <202509040837.78EFA6E@keescook>
References: <20250903203805.1335307-1-tom.hromatka@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250903203805.1335307-1-tom.hromatka@oracle.com>

On Wed, Sep 03, 2025 at 08:38:03PM +0000, Tom Hromatka wrote:
> Add an operation, SECCOMP_CLONE_FILTER, that can copy the seccomp filters
> from another process to the current process.
> 
> I roughly reproduced the Docker seccomp filter [1] and timed how long it
> takes to build it (via libseccomp) and attach it to a process.  After
> 1000 runs, on average it took 3,740,000 TSC ticks (or ~1440 microseconds)
> on an AMD EPYC 9J14 running at 2596 MHz.  The median build/load time was
> 3,715,000 TSC ticks.
> 
> On the same system, I preloaded the above Docker seccomp filter onto a
> process.  (Note that I opened a pidfd to the reference process and left
> the pidfd open for the entire run.)  I then cloned the filter using the
> feature in this patch to 1000 new processes.  On average, it took 9,300
> TSC ticks (or ~3.6 microseconds) to copy the filter to the new processes.
> The median clone time was 9,048 TSC ticks.
> 
> This is approximately a 400x performance improvement for those container
> managers that are using the exact same seccomp filter across all of their
> containers.

This is a nice speedup, but with devil's advocate hat on, are launchers
spawning at rates high enough that this makes a difference?

> 
> [1] https://raw.githubusercontent.com/moby/moby/refs/heads/master/profiles/seccomp/default.json
> 
> Signed-off-by: Tom Hromatka <tom.hromatka@oracle.com>
> ---
>  .../userspace-api/seccomp_filter.rst          |  10 ++
>  include/uapi/linux/seccomp.h                  |   1 +
>  kernel/seccomp.c                              |  48 ++++++
>  samples/seccomp/Makefile                      |   2 +-
>  samples/seccomp/clone-filter.c                | 143 ++++++++++++++++++
>  tools/include/uapi/linux/seccomp.h            |   1 +
>  tools/testing/selftests/seccomp/seccomp_bpf.c |  71 +++++++++
>  7 files changed, 275 insertions(+), 1 deletion(-)
>  create mode 100644 samples/seccomp/clone-filter.c
> 
> diff --git a/Documentation/userspace-api/seccomp_filter.rst b/Documentation/userspace-api/seccomp_filter.rst
> index cff0fa7f3175..ef1797d093f6 100644
> --- a/Documentation/userspace-api/seccomp_filter.rst
> +++ b/Documentation/userspace-api/seccomp_filter.rst
> @@ -289,6 +289,16 @@ above in this document: all arguments being read from the tracee's memory
>  should be read into the tracer's memory before any policy decisions are made.
>  This allows for an atomic decision on syscall arguments.
>  
> +Cloning an Existing Seccomp Filter
> +==================================
> +
> +Constructing and loading a complex seccomp filter can often take a non-trivial
> +amount of time. If a user wants to use the same seccomp filter across more
> +than one process, it can be cloned to new processes via the
> +``SECCOMP_CLONE_FILTER`` operation. Note that the clone will only succeed if
> +the destination process does not have any seccomp filters already applied to
> +it. See ``samples/seccomp/clone-filter.c`` for an example.

Is "does not have any seccomp filters" a reasonable expectation? I mean,
I'm fine with it, but will this feature be generally useful with that
restriction? (i.e. becomes unusable under Docker, in several systemd
contexts, etc)

> +static long seccomp_clone_filter(void __user *upidfd)
> +{
> +	struct task_struct *task;
> +	unsigned int flags;
> +	pid_t pidfd;
> +
> +	if (!capable(CAP_SYS_ADMIN))
> +		return -EPERM;

Again, I'm fine with this being CAP_SYS_ADMIN, but the normal seccomp
filter restriction is NNP || CAP_SYS_ADMIN. Would it be safe to do
clones with non-ADMIN? Hmmm.

> +	if (atomic_read(&current->seccomp.filter_count) > 0)
> +		return -EINVAL;

I'd wait to test this until you're under &current->sighand->siglock,
and just test current->seccomp.filter.

> +
> +	if (copy_from_user(&pidfd, upidfd, sizeof(pid_t)))
> +		return -EFAULT;
> +
> +	task = pidfd_get_task(pidfd, &flags);
> +	if (IS_ERR(task))
> +		return -ESRCH;

Is this the right way to pass in a pidfd? Shouldn't this be an int, not
a pointer? What is idiomatic for pidfd interfaces?

> +
> +	spin_lock_irq(&current->sighand->siglock);
> +	spin_lock_irq(&task->sighand->siglock);

As others mentioned, you can't do this. ;) I'm pretty sure you can just
take references progressively:

- task = pidfd_get_task
- mutex_lock_killable(&task->signal->cred_guard_mutex)
- spin_lock_irq(&task->sighand->siglock);
- check seccomp mode for filter mode, e.g. see seccomp_may_assign_mode()
- get_seccomp_filter(task)
- struct seccomp copy = task->seccomp (copies filter pointer, count,
  and mode)
- release siglock
- release cred_guard_mutex
- put task

Now you have the seccomp copy! :) Any errors from here mean you need
to use __seccomp_filter_release to "put" the filter, if I'm reading
things correctly. (We might have issues with USER_NOTIF, but I haven't
looked closely yet.)

And applying it should be:

- take current->signal->cred_guard_mutex
- take current->sighand->siglock
- make sure task->seccomp.filter == NULL
- current->seccomp = copy
- release siglock
- release cred_guard_mutex

I *think* the above is correct. I may have forgotten some details, but I
was mostly trying to combine TSYNC and regular application of a filter
to current.

> +
> +	if (atomic_read(&task->seccomp.filter_count) == 0) {
> +		spin_unlock_irq(&task->sighand->siglock);
> +		spin_unlock_irq(&current->sighand->siglock);
> +		put_task_struct(task);
> +		return -EINVAL;
> +	}
> +
> +	get_seccomp_filter(task);
> +	current->seccomp = task->seccomp;
> +
> +	spin_unlock_irq(&task->sighand->siglock);
> +
> +	set_task_syscall_work(current, SECCOMP);
> +
> +	spin_unlock_irq(&current->sighand->siglock);
> +
> +	put_task_struct(task);
> +
> +	return 0;
> +}
> +
>  /* Common entry point for both prctl and syscall. */
>  static long do_seccomp(unsigned int op, unsigned int flags,
>  		       void __user *uargs)
> @@ -2102,6 +2145,11 @@ static long do_seccomp(unsigned int op, unsigned int flags,
>  			return -EINVAL;
>  
>  		return seccomp_get_notif_sizes(uargs);
> +	case SECCOMP_CLONE_FILTER:
> +		if (flags != 0)
> +			return -EINVAL;
> +
> +		return seccomp_clone_filter(uargs);
>  	default:
>  		return -EINVAL;
>  	}
> diff --git a/samples/seccomp/Makefile b/samples/seccomp/Makefile
> index c85ae0ed8342..d38977f41b86 100644
> --- a/samples/seccomp/Makefile
> +++ b/samples/seccomp/Makefile
> @@ -1,5 +1,5 @@
>  # SPDX-License-Identifier: GPL-2.0
> -userprogs-always-y += bpf-fancy dropper bpf-direct user-trap
> +userprogs-always-y += bpf-fancy dropper bpf-direct user-trap clone-filter
>  
>  bpf-fancy-objs := bpf-fancy.o bpf-helper.o
>  
> diff --git a/samples/seccomp/clone-filter.c b/samples/seccomp/clone-filter.c
> new file mode 100644
> index 000000000000..d26e1375b9dc
> --- /dev/null
> +++ b/samples/seccomp/clone-filter.c
> @@ -0,0 +1,143 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Seccomp filter example for cloning a filter
> + *
> + * Copyright (c) 2025 Oracle and/or its affiliates.
> + * Author: Tom Hromatka <tom.hromatka@oracle.com>
> + *
> + * The code may be used by anyone for any purpose,
> + * and can serve as a starting point for developing
> + * applications that reuse the same seccomp filter
> + * across many processes.
> + */
> +#include <linux/seccomp.h>
> +#include <linux/filter.h>
> +#include <sys/syscall.h>
> +#include <sys/wait.h>
> +#include <stdbool.h>
> +#include <signal.h>
> +#include <stddef.h>
> +#include <stdlib.h>
> +#include <unistd.h>
> +#include <stdio.h>
> +#include <errno.h>
> +
> +#define ARRAY_SIZE(x) (sizeof(x) / sizeof(*(x)))
> +
> +static int seccomp(unsigned int op, unsigned int flags, void *args)
> +{
> +	errno = 0;
> +	return syscall(__NR_seccomp, op, flags, args);
> +}
> +
> +static int install_filter(void)
> +{
> +	struct sock_filter deny_filter[] = {
> +		BPF_STMT(BPF_LD|BPF_W|BPF_ABS,
> +			offsetof(struct seccomp_data, nr)),
> +		BPF_JUMP(BPF_JMP|BPF_JEQ|BPF_K, __NR_getppid, 0, 1),
> +		BPF_STMT(BPF_RET|BPF_K, SECCOMP_RET_ERRNO | ESRCH),
> +		BPF_STMT(BPF_RET|BPF_K, SECCOMP_RET_ALLOW),
> +	};
> +	struct sock_fprog deny_prog = {
> +		.len = (unsigned short)ARRAY_SIZE(deny_filter),
> +		.filter = deny_filter,
> +	};
> +
> +	return seccomp(SECCOMP_SET_MODE_FILTER, 0, &deny_prog);
> +}
> +
> +static int clone_filter(pid_t ref_pid)
> +{
> +	int ref_pidfd, ret;
> +
> +	ref_pidfd = syscall(SYS_pidfd_open, ref_pid, 0);
> +	if (ref_pidfd < 0)
> +		return -errno;
> +
> +	ret = seccomp(SECCOMP_CLONE_FILTER, 0, &ref_pidfd);
> +
> +	close(ref_pidfd);
> +
> +	return ret;
> +}
> +
> +static void do_ref_filter(void)
> +{
> +	int ret;
> +
> +	ret = install_filter();
> +	if (ret) {
> +		perror("Failed to install ref filter\n");
> +		exit(1);
> +	}
> +
> +	while (true)
> +		sleep(1);
> +}
> +
> +static void do_child_process(pid_t ref_pid)
> +{
> +	pid_t res;
> +	int ret;
> +
> +	ret = clone_filter(ref_pid);
> +	if (ret != 0) {
> +		perror("Failed to clone filter. Installing filter from scratch\n");
> +
> +		ret = install_filter();
> +		if (ret != 0) {
> +			perror("Filter install failed\n");
> +			exit(ret);
> +		}
> +	}
> +
> +	res = syscall(__NR_getpid);
> +	if (res < 0) {
> +		perror("getpid() unexpectedly failed\n");
> +		exit(errno);
> +	}
> +
> +	res = syscall(__NR_getppid);
> +	if (res > 0) {
> +		perror("getppid() unexpectedly succeeded\n");
> +		exit(1);
> +	}
> +
> +	exit(0);
> +}
> +
> +int main(void)
> +{
> +	pid_t ref_pid = -1, child_pid = -1;
> +	int ret, status;
> +
> +	ref_pid = fork();
> +	if (ref_pid < 0)
> +		exit(errno);
> +	else if (ref_pid == 0)
> +		do_ref_filter();
> +
> +	child_pid = fork();
> +	if (child_pid < 0)
> +		goto out;
> +	else if (child_pid == 0)
> +		do_child_process(ref_pid);
> +
> +	waitpid(child_pid, &status, 0);
> +	if (WEXITSTATUS(status) != 0) {
> +		perror("child process failed");
> +		ret = WEXITSTATUS(status);
> +		goto out;
> +	}
> +
> +	ret = 0;
> +
> +out:
> +	if (ref_pid != -1)
> +		kill(ref_pid, SIGKILL);
> +	if (child_pid != -1)
> +		kill(child_pid, SIGKILL);
> +
> +	exit(ret);
> +}
> diff --git a/tools/include/uapi/linux/seccomp.h b/tools/include/uapi/linux/seccomp.h
> index dbfc9b37fcae..b0917e333b4b 100644
> --- a/tools/include/uapi/linux/seccomp.h
> +++ b/tools/include/uapi/linux/seccomp.h
> @@ -16,6 +16,7 @@
>  #define SECCOMP_SET_MODE_FILTER		1
>  #define SECCOMP_GET_ACTION_AVAIL	2
>  #define SECCOMP_GET_NOTIF_SIZES		3
> +#define SECCOMP_CLONE_FILTER		4
>  
>  /* Valid flags for SECCOMP_SET_MODE_FILTER */
>  #define SECCOMP_FILTER_FLAG_TSYNC		(1UL << 0)
> diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
> index 61acbd45ffaa..df5e0f615da0 100644
> --- a/tools/testing/selftests/seccomp/seccomp_bpf.c
> +++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
> @@ -177,6 +177,10 @@ struct seccomp_data {
>  #define SECCOMP_GET_NOTIF_SIZES 3
>  #endif
>  
> +#ifndef SECCOMP_CLONE_FILTER
> +#define SECCOMP_CLONE_FILTER 4
> +#endif
> +
>  #ifndef SECCOMP_FILTER_FLAG_TSYNC
>  #define SECCOMP_FILTER_FLAG_TSYNC (1UL << 0)
>  #endif
> @@ -5090,6 +5094,73 @@ TEST_F(URETPROBE, uretprobe_default_block_with_uretprobe_syscall)
>  	ASSERT_EQ(0, run_probed_with_filter(&prog));
>  }
>  
> +TEST(clone_filter)

Yay tests!

> +{
> +	struct sock_filter deny_filter[] = {
> +		BPF_STMT(BPF_LD|BPF_W|BPF_ABS,
> +			offsetof(struct seccomp_data, nr)),
> +		BPF_JUMP(BPF_JMP|BPF_JEQ|BPF_K, __NR_getppid, 0, 1),
> +		BPF_STMT(BPF_RET|BPF_K, SECCOMP_RET_ERRNO | ESRCH),
> +		BPF_STMT(BPF_RET|BPF_K, SECCOMP_RET_ALLOW),
> +	};
> +	struct sock_fprog deny_prog = {
> +		.len = (unsigned short)ARRAY_SIZE(deny_filter),
> +		.filter = deny_filter,
> +	};
> +	struct timespec ts = {
> +		.tv_sec = 0,
> +		.tv_nsec = 100000000,
> +	};
> +
> +	pid_t child_pid, self_pid, res;
> +	int child_pidfd, ret;
> +
> +	/* Only real root can copy a filter. */
> +	if (geteuid()) {

That's not true: uid==0 is not CAP_SYS_ADMIN. :) Look in this test for:

        cap_get_flag(cap, CAP_SYS_ADMIN, CAP_EFFECTIVE, &is_cap_sys_admin);

which is how to test this correctly.

> +		SKIP(return, "clone_filter requires real root");
> +		return;
> +	}
> +
> +	self_pid = getpid();
> +
> +	child_pid = fork();
> +	ASSERT_LE(0, child_pid);

Uh, isn't that supposed to be GE? This should have failed your test
immediately every time. Does this test pass for you? :P

> +
> +	if (child_pid == 0) {
> +		ASSERT_EQ(0, prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0));
> +		ASSERT_EQ(0, prctl(PR_SET_SECCOMP, SECCOMP_MODE_FILTER, &deny_prog));

I'd assert that get_ppid gives ESRCH here just for completeness.

> +
> +		while (true)
> +			EXPECT_EQ(0, syscall(__NR_nanosleep, &ts, NULL));
> +	}
> +
> +	/* wait for the child pid to create its seccomp filter */
> +	ASSERT_EQ(0, syscall(__NR_nanosleep, &ts, NULL));

Please look at the other tests to see how to synchronize without a
non-deterministic sleep "guess". :) It's bad form to induce needless
delays in tests.

> +
> +	child_pidfd = syscall(SYS_pidfd_open, child_pid, 0);
> +	EXPECT_LE(0, child_pidfd);
> +
> +	/* Invalid flag provided */
> +	ret = seccomp(SECCOMP_CLONE_FILTER, 1, &child_pidfd);

I'd set all the bits, not just 1.

This is also missing a EFAULT test (i.e. a NULL child_pidfd). (Though I
still want to know if this is idiomatic for pidfd interfaces -- I'd not
expect this to be passed as a pointer.)

And it's missing a ESRCH test.

And a "this is not a pidfd" test.

> +	EXPECT_EQ(-1, ret);
> +	EXPECT_EQ(errno, EINVAL);
> +
> +	errno = 0;
> +	ret = seccomp(SECCOMP_CLONE_FILTER, 0, &child_pidfd);
> +	EXPECT_EQ(0, ret);
> +	EXPECT_EQ(errno, 0);
> +
> +	res = syscall(__NR_getppid);
> +	EXPECT_EQ(res, -1);
> +	EXPECT_EQ(errno, ESRCH);

I would validate that getppid succeeds before the CLONE_FILTER, just for
robustness.

> +
> +	res = syscall(__NR_getpid);
> +	EXPECT_EQ(res, self_pid);
> +
> +	close(child_pidfd);
> +	kill(child_pid, SIGKILL);

I'm not a fan of using "kill" for child sync in tests. I'd rather see a
blocking read or similar (so the child doesn't have to spin, even if
it's in sleep). But at the very least I'd want to see a
waitpid for this kill.

> +}

Please also check for the "I already have a filter attached"
failure path.

> +
>  /*
>   * TODO:
>   * - expand NNP testing
> -- 
> 2.47.3
> 

Thanks for working on this! It'd be a nice speed-up for sure.

-Kees

-- 
Kees Cook

