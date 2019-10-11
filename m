Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 820C4D3AE0
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Oct 2019 10:22:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727176AbfJKIVY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 11 Oct 2019 04:21:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:36342 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726885AbfJKIVY (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 11 Oct 2019 04:21:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5E9C6B124;
        Fri, 11 Oct 2019 08:21:21 +0000 (UTC)
Date:   Fri, 11 Oct 2019 10:21:18 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     linux-kernel@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>,
        Florian Weimer <fweimer@redhat.com>, libc-alpha@sourceware.org,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Shuah Khan <shuah@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Roman Gushchin <guro@fb.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Aleksa Sarai <cyphar@cyphar.com>,
        "Dmitry V. Levin" <ldv@altlinux.org>,
        linux-kselftest@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [PATCH 1/2] clone3: add CLONE3_CLEAR_SIGHAND
Message-ID: <20191011082118.GA26368@dhcp22.suse.cz>
References: <20191010133518.5420-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191010133518.5420-1-christian.brauner@ubuntu.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

[Cc linux-api]

On Thu 10-10-19 15:35:17, Christian Brauner wrote:
> Reset all signal handlers of the child not set to SIG_IGN to SIG_DFL.
> Mutually exclusive with CLONE_SIGHAND to not disturb other thread's
> signal handler.
> 
> In the spirit of closer cooperation between glibc developers and kernel
> developers (cf. [2]) this patchset came out of a discussion on the glibc
> mailing list for improving posix_spawn() (cf. [1], [3], [4]). Kernel
> support for this feature has been explicitly requested by glibc and I
> see no reason not to help them with this.
> 
> The child helper process on Linux posix_spawn must ensure that no signal
> handlers are enabled, so the signal disposition must be either SIG_DFL
> or SIG_IGN. However, it requires a sigprocmask to obtain the current
> signal mask and at least _NSIG sigaction calls to reset the signal
> handlers for each posix_spawn call or complex state tracking that might
> lead to data corruption in glibc. Adding this flags lets glibc avoid
> these problems.
> 
> [1]: https://www.sourceware.org/ml/libc-alpha/2019-10/msg00149.html
> [3]: https://www.sourceware.org/ml/libc-alpha/2019-10/msg00158.html
> [4]: https://www.sourceware.org/ml/libc-alpha/2019-10/msg00160.html
> [2]: https://lwn.net/Articles/799331/
>      '[...] by asking for better cooperation with the C-library projects
>      in general. They should be copied on patches containing ABI
>      changes, for example. I noted that there are often times where
>      C-library developers wish the kernel community had done things
>      differently; how could those be avoided in the future? Members of
>      the audience suggested that more glibc developers should perhaps
>      join the linux-api list. The other suggestion was to "copy Florian
>      on everything".'
> Cc: Oleg Nesterov <oleg@redhat.com>
> Cc: Florian Weimer <fweimer@redhat.com>
> Cc: libc-alpha@sourceware.org
> Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> ---
>  include/uapi/linux/sched.h |  3 +++
>  kernel/fork.c              | 11 ++++++++++-
>  2 files changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/include/uapi/linux/sched.h b/include/uapi/linux/sched.h
> index 99335e1f4a27..c583720f689f 100644
> --- a/include/uapi/linux/sched.h
> +++ b/include/uapi/linux/sched.h
> @@ -33,6 +33,9 @@
>  #define CLONE_NEWNET		0x40000000	/* New network namespace */
>  #define CLONE_IO		0x80000000	/* Clone io context */
>  
> +/* Flags for the clone3() syscall */
> +#define CLONE3_CLEAR_SIGHAND 0x100000000ULL /* Clear any signal handler and reset to SIG_DFL. */
> +
>  #ifndef __ASSEMBLY__
>  /**
>   * struct clone_args - arguments for the clone3 syscall
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 1f6c45f6a734..661f8d1f3881 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -1517,6 +1517,11 @@ static int copy_sighand(unsigned long clone_flags, struct task_struct *tsk)
>  	spin_lock_irq(&current->sighand->siglock);
>  	memcpy(sig->action, current->sighand->action, sizeof(sig->action));
>  	spin_unlock_irq(&current->sighand->siglock);
> +
> +	/* Reset all signal handler not set to SIG_IGN to SIG_DFL. */
> +	if (clone_flags & CLONE3_CLEAR_SIGHAND)
> +		flush_signal_handlers(tsk, 0);
> +
>  	return 0;
>  }
>  
> @@ -2567,7 +2572,7 @@ static bool clone3_args_valid(const struct kernel_clone_args *kargs)
>  	 * All lower bits of the flag word are taken.
>  	 * Verify that no other unknown flags are passed along.
>  	 */
> -	if (kargs->flags & ~CLONE_LEGACY_FLAGS)
> +	if (kargs->flags & ~(CLONE_LEGACY_FLAGS | CLONE3_CLEAR_SIGHAND))
>  		return false;
>  
>  	/*
> @@ -2577,6 +2582,10 @@ static bool clone3_args_valid(const struct kernel_clone_args *kargs)
>  	if (kargs->flags & (CLONE_DETACHED | CSIGNAL))
>  		return false;
>  
> +	if ((kargs->flags & (CLONE_SIGHAND | CLONE3_CLEAR_SIGHAND)) ==
> +	    (CLONE_SIGHAND | CLONE3_CLEAR_SIGHAND))
> +		return false;
> +
>  	if ((kargs->flags & (CLONE_THREAD | CLONE_PARENT)) &&
>  	    kargs->exit_signal)
>  		return false;
> -- 
> 2.23.0

-- 
Michal Hocko
SUSE Labs
