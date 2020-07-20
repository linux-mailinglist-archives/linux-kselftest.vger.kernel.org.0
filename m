Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 707DD225C6C
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Jul 2020 12:08:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728088AbgGTKIv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 20 Jul 2020 06:08:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728001AbgGTKIu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 20 Jul 2020 06:08:50 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79EE1C061794;
        Mon, 20 Jul 2020 03:08:50 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595239728;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BxrLT5OO8VVnt/lsBoQzr6HhEU8ioJ8QRLnEkjNYsa8=;
        b=AN9DdqOoQ9igheMYCJMVwq1S5xiGUqz9xbMTDHPJmDyY7qQ+1j845Ngqu5mWJhKKXhMxYh
        CprUH3H6nl5sywboIOPjTuzXsjKUZ+eCvC6EYv3d2nMgNqkjjXK0axRmVDZa3gKRWiAM60
        q0aBRYyyLc7oUQF+iUlTImGFsqE3dwX7nkORww/xSSXYvqfpsd1wZ1zvaq4kVj5fam4h4B
        fOQrWvlAzKWjioz7kHdHhQh3m1/+9fTn6m3LDmEUY3h6i615j4Ugwc4CsF4Fg3HL9YQoD+
        QOCXPsbtJFF6W2EZoJJnuyLaa03uG9+gjH4dmtNhl3baC+Y5JkjCAJV9qNeViA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595239728;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BxrLT5OO8VVnt/lsBoQzr6HhEU8ioJ8QRLnEkjNYsa8=;
        b=sFpY6PKNr4+f3NvSLNIw3Ac3fU3okqtU+lGXTektLQ6F7TcMwglOxbVyg4WGpHmwYql0P3
        ZkJqIgtlwPXu/sCQ==
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     linux-kernel@vger.kernel.org, kernel@collabora.com,
        willy@infradead.org, luto@kernel.org, gofmanp@gmail.com,
        keescook@chromium.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org, Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: Re: [PATCH v4 1/2] kernel: Implement selective syscall userspace redirection
In-Reply-To: <20200716193141.4068476-2-krisman@collabora.com>
References: <20200716193141.4068476-1-krisman@collabora.com> <20200716193141.4068476-2-krisman@collabora.com>
Date:   Mon, 20 Jul 2020 12:08:47 +0200
Message-ID: <87v9iimrbk.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Gabriel,

Gabriel Krisman Bertazi <krisman@collabora.com> writes:
> Introduce a mechanism to quickly disable/enable syscall handling for a
> specific process and redirect to userspace via SIGSYS.  This is useful
> for processes with parts that require syscall redirection and parts that
> don't, but who need to perform this boundary crossing really fast,
> without paying the cost of a system call to reconfigure syscall handling
> on each boundary transition.  This is particularly important for Windows
> games running over Wine.
>
> The proposed interface looks like this:
>
>   prctl(PR_SET_SYSCALL_USER_DISPATCH, <op>, <start_addr>, <end_addr>, [selector])
>
> The range [<start_addr>,<end_addr>] is a part of the process memory map
> that is allowed to by-pass the redirection code and dispatch syscalls
> directly, such that in fast paths a process doesn't need to disable the
> trap nor the kernel has to check the selector.  This is essential to
> return from SIGSYS to a blocked area without triggering another SIGSYS
> from rt_sigreturn.

Why isn't rt_sigreturn() exempt from that redirection in the first place?

> ---
>  arch/Kconfig                          | 20 ++++++
>  arch/x86/Kconfig                      |  1 +
>  arch/x86/entry/common.c               |  5 ++
>  arch/x86/include/asm/thread_info.h    |  4 +-
>  arch/x86/kernel/signal_compat.c       |  2 +-
>  fs/exec.c                             |  2 +
>  include/linux/sched.h                 |  3 +
>  include/linux/syscall_user_dispatch.h | 50 +++++++++++++++
>  include/uapi/asm-generic/siginfo.h    |  3 +-
>  include/uapi/linux/prctl.h            |  5 ++
>  kernel/Makefile                       |  1 +
>  kernel/fork.c                         |  1 +
>  kernel/sys.c                          |  5 ++
>  kernel/syscall_user_dispatch.c        | 92 +++++++++++++++++++++++++++

A big combo patch is not how we do that. Please split it up into the
core part and a patch enabling it for a particular architexture.

As I said in my reply to Andy, this wants to go on top of the generic
entry/exit work stuff:

  https://lore.kernel.org/r/20200716182208.180916541@linutronix.de

and then syscall_user_dispatch.c ends up in kernel/entry/ and the
dispatching function is not exposed outside of that directory.

I'm going to post a new version later today. Will cc you.

> --- a/arch/x86/include/asm/thread_info.h
> +++ b/arch/x86/include/asm/thread_info.h
> @@ -93,6 +93,7 @@ struct thread_info {
>  #define TIF_NOTSC		16	/* TSC is not accessible in userland */
>  #define TIF_IA32		17	/* IA32 compatibility process */
>  #define TIF_SLD			18	/* Restore split lock detection on context switch */
> +#define TIF_SYSCALL_USER_DISPATCH 19	/* Redirect syscall for userspace handling */

There are two other things out there which compete about the last TIF
bits on x86, so we need to clean that up first.

> +static void trigger_sigsys(struct pt_regs *regs)
> +{
> +	struct kernel_siginfo info;
> +
> +	clear_siginfo(&info);
> +	info.si_signo = SIGSYS;
> +	info.si_code = SYS_USER_DISPATCH;
> +	info.si_call_addr = (void __user *)KSTK_EIP(current);
> +	info.si_errno = 0;
> +	info.si_arch = syscall_get_arch(current);
> +	info.si_syscall = syscall_get_nr(current, regs);
> +
> +	force_sig_info(&info);
> +}
> +
> +int do_syscall_user_dispatch(struct pt_regs *regs)
> +{
> +	struct syscall_user_dispatch *sd = &current->syscall_dispatch;
> +	unsigned long ip = instruction_pointer(regs);
> +	char state;
> +
> +	if (likely(ip >= sd->dispatcher_start && ip <= sd->dispatcher_end))
> +		return 0;
> +
> +	if (likely(sd->selector)) {
> +		if (unlikely(__get_user(state, sd->selector)))

__get_user() mandates an explicit access_ok() which happened in the
prctl(). So this wants a comment why there is none right here.

> +			do_exit(SIGSEGV);
> +
> +		if (likely(state == 0))
> +			return 0;
> +
> +		if (state != 1)
> +			do_exit(SIGSEGV);

If that happens its going to be quite interesting to debug.

Also please use proper defines which are exposed to user space instead
of 0/1.

> +	}
> +
> +	syscall_rollback(current, regs);
> +	trigger_sigsys(regs);
> +
> +	return 1;
> +}
> +
> +int set_syscall_user_dispatch(int mode, unsigned long dispatcher_start,
> +			      unsigned long dispatcher_end, char __user *selector)
> +{
> +	switch (mode) {
> +	case PR_SYS_DISPATCH_OFF:
> +		if (dispatcher_start || dispatcher_end || selector)
> +			return -EINVAL;
> +		break;
> +	case PR_SYS_DISPATCH_ON:
> +		/*
> +		 * Validate the direct dispatcher region just for basic
> +		 * sanity.  If the user is able to submit a syscall from
> +		 * an address, that address is obviously valid.
> +		 */
> +		if (dispatcher_end < dispatcher_start)
> +			return -EINVAL;
> +
> +		if (selector && !access_ok(selector, 1))

  sizeof(*selector)

Thanks,

        tglx
