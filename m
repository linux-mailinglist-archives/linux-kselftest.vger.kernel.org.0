Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E41F25F818
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Sep 2020 12:26:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728406AbgIGK03 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Sep 2020 06:26:29 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:59727 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728721AbgIGKQX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Sep 2020 06:16:23 -0400
Received: from ip5f5af70b.dynamic.kabel-deutschland.de ([95.90.247.11] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1kFECA-0005WP-VQ; Mon, 07 Sep 2020 10:16:19 +0000
Date:   Mon, 7 Sep 2020 12:16:18 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     luto@kernel.org, tglx@linutronix.de, keescook@chromium.org,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, willy@infradead.org,
        linux-kselftest@vger.kernel.org, shuah@kernel.org,
        kernel@collabora.com
Subject: Re: [PATCH v6 2/9] kernel: entry: Support TIF_SYSCAL_INTERCEPT on
 common entry code
Message-ID: <20200907101618.dnxv5n4x4vty73hr@wittgenstein>
References: <20200904203147.2908430-1-krisman@collabora.com>
 <20200904203147.2908430-3-krisman@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200904203147.2908430-3-krisman@collabora.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Sep 04, 2020 at 04:31:40PM -0400, Gabriel Krisman Bertazi wrote:
> Syscalls that use common entry code (x86 at the moment of this writing)
> need to have their defines updated inside this commit.  This added a
> measureable overhead of 1ns to seccomp_benchmark selftests on a
> bare-metal AMD system.
> 
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
> ---
>  arch/x86/include/asm/thread_info.h |  4 ++--
>  include/linux/entry-common.h       |  6 +-----
>  kernel/entry/common.c              | 24 +++++++++++++++++++++---
>  3 files changed, 24 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/x86/include/asm/thread_info.h b/arch/x86/include/asm/thread_info.h
> index 267701ae3d86..cf723181e1f2 100644
> --- a/arch/x86/include/asm/thread_info.h
> +++ b/arch/x86/include/asm/thread_info.h
> @@ -82,7 +82,7 @@ struct thread_info {
>  #define TIF_SSBD		5	/* Speculative store bypass disable */
>  #define TIF_SYSCALL_EMU		6	/* syscall emulation active */
>  #define TIF_SYSCALL_AUDIT	7	/* syscall auditing active */
> -#define TIF_SECCOMP		8	/* secure computing */
> +#define TIF_SYSCALL_INTERCEPT	8	/* Intercept system call */
>  #define TIF_SPEC_IB		9	/* Indirect branch speculation mitigation */
>  #define TIF_SPEC_FORCE_UPDATE	10	/* Force speculation MSR update in context switch */
>  #define TIF_USER_RETURN_NOTIFY	11	/* notify kernel of userspace return */
> @@ -112,7 +112,7 @@ struct thread_info {
>  #define _TIF_SSBD		(1 << TIF_SSBD)
>  #define _TIF_SYSCALL_EMU	(1 << TIF_SYSCALL_EMU)
>  #define _TIF_SYSCALL_AUDIT	(1 << TIF_SYSCALL_AUDIT)
> -#define _TIF_SECCOMP		(1 << TIF_SECCOMP)
> +#define _TIF_SYSCALL_INTERCEPT	(1 << TIF_SYSCALL_INTERCEPT)
>  #define _TIF_SPEC_IB		(1 << TIF_SPEC_IB)
>  #define _TIF_SPEC_FORCE_UPDATE	(1 << TIF_SPEC_FORCE_UPDATE)
>  #define _TIF_USER_RETURN_NOTIFY	(1 << TIF_USER_RETURN_NOTIFY)
> diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
> index efebbffcd5cc..72ce9ca860c6 100644
> --- a/include/linux/entry-common.h
> +++ b/include/linux/entry-common.h
> @@ -21,10 +21,6 @@
>  # define _TIF_SYSCALL_TRACEPOINT	(0)
>  #endif
>  
> -#ifndef _TIF_SECCOMP
> -# define _TIF_SECCOMP			(0)
> -#endif
> -
>  #ifndef _TIF_SYSCALL_AUDIT
>  # define _TIF_SYSCALL_AUDIT		(0)
>  #endif
> @@ -45,7 +41,7 @@
>  #endif
>  
>  #define SYSCALL_ENTER_WORK						\
> -	(_TIF_SYSCALL_TRACE | _TIF_SYSCALL_AUDIT | _TIF_SECCOMP |	\
> +	(_TIF_SYSCALL_TRACE | _TIF_SYSCALL_AUDIT | _TIF_SYSCALL_INTERCEPT | \
>  	 _TIF_SYSCALL_TRACEPOINT | _TIF_SYSCALL_EMU |			\
>  	 ARCH_SYSCALL_ENTER_WORK)
>  
> diff --git a/kernel/entry/common.c b/kernel/entry/common.c
> index fcae019158ca..44fd089d59da 100644
> --- a/kernel/entry/common.c
> +++ b/kernel/entry/common.c
> @@ -4,6 +4,7 @@
>  #include <linux/entry-common.h>
>  #include <linux/livepatch.h>
>  #include <linux/audit.h>
> +#include <linux/syscall_intercept.h>
>  
>  #define CREATE_TRACE_POINTS
>  #include <trace/events/syscalls.h>
> @@ -41,6 +42,20 @@ static inline void syscall_enter_audit(struct pt_regs *regs, long syscall)
>  	}
>  }
>  
> +static inline long do_syscall_intercept(struct pt_regs *regs)

Hey Gabriel,

I think you can drop the pt_regs argument and just have this be

static inline do_syscall_intercept(void)

otherwise

Acked-by: Christian Brauner <christian.brauner@ubuntu.com>

> +{
> +	int sysint_work = READ_ONCE(current->syscall_intercept);
> +	int ret;
> +
> +	if (sysint_work & SYSINT_SECCOMP) {
> +		ret = __secure_computing(NULL);
> +		if (ret == -1L)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +
>  static long syscall_trace_enter(struct pt_regs *regs, long syscall,
>  				unsigned long ti_work)
>  {
> @@ -53,9 +68,12 @@ static long syscall_trace_enter(struct pt_regs *regs, long syscall,
>  			return -1L;
>  	}
>  
> -	/* Do seccomp after ptrace, to catch any tracer changes. */
> -	if (ti_work & _TIF_SECCOMP) {
> -		ret = __secure_computing(NULL);
> +	/*
> +	 * Do syscall interception like seccomp after ptrace, to catch
> +	 * any tracer changes.
> +	 */
> +	if (ti_work & _TIF_SYSCALL_INTERCEPT) {
> +		ret = do_syscall_intercept(regs);
>  		if (ret == -1L)
>  			return ret;
>  	}
> -- 
> 2.28.0
