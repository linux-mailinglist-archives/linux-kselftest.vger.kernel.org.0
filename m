Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29E1645669B
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Nov 2021 00:53:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233364AbhKRX4Y (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 18 Nov 2021 18:56:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233268AbhKRX4W (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 18 Nov 2021 18:56:22 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A33C9C061748
        for <linux-kselftest@vger.kernel.org>; Thu, 18 Nov 2021 15:53:21 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id m14so7667285pfc.9
        for <linux-kselftest@vger.kernel.org>; Thu, 18 Nov 2021 15:53:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hZ3r2kf8R13rsVx7g/YA2yeu3ofgQVI3DTKofna3Wmw=;
        b=KiBUnlJuvIRzRltvlBuf4EeZxz8kUGVShDvJXhFsvwv2uV21y8nLWV/vNHzAihprK1
         wiI1+gPV0Fb/kzmDtrr5/Cx6i9GM3SuOk3wzh4Jg8XQ8XQnJQjj7+bOU7jtvoDBXCptA
         O5dMqe3anHEjS2cENlbYR1VzocrhHIUzi/xZs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hZ3r2kf8R13rsVx7g/YA2yeu3ofgQVI3DTKofna3Wmw=;
        b=umuA4lnKhjnosTVBxjgSm6rVx76RGuwUKSuy3czPhsIqWhbnzeykKu6xdH9o+UkGLm
         PRsvQOeCAn9JRQKl2qqkif/cHwH2LX/x1r+4hp1kk1HrqEc0Q0IA6ouEnepCAG+qwpYn
         SDSeeG/1+EbjLHEzSKThju2xByxOK10zA7UJlc83Oe0t98daNRpTIaCyAnOYqJ9dkE6I
         wSrC+7ffQgRnA3a/o4Hcsfd6Kf26AdzRERTKsFWejXzt6Leg9279JM9lqfkoIuBeJk+0
         jWYg7ui0DZqmfJI6NHsmIV1uErL6qj7h+lJ8yuEs7Gu8WjLmRr8Jj0A1yScI3coioOP/
         BsVg==
X-Gm-Message-State: AOAM5320LpKRFeGO96sUijgagI0fqr8OY1g/twt+1HHaV1FLb05OGaOq
        QJS+5q2qJOl5m0o4Q1AQ/+6sYA==
X-Google-Smtp-Source: ABdhPJxBaIrzhEeCf8LLSX589Z8Ds3e/3xOQvD2/xUahe2AZdJB8ZtuD0iHvTkFqwFzitphrIMoQ7Q==
X-Received: by 2002:a63:9c02:: with SMTP id f2mr4152562pge.422.1637279601101;
        Thu, 18 Nov 2021 15:53:21 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id r34sm584887pgk.7.2021.11.18.15.53.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 15:53:20 -0800 (PST)
Date:   Thu, 18 Nov 2021 15:53:20 -0800
From:   Kees Cook <keescook@chromium.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org, Kyle Huey <me@kylehuey.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrea Righi <andrea.righi@canonical.com>,
        Shuah Khan <shuah@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        linux-hardening@vger.kernel.org,
        Robert O'Callahan <rocallahan@gmail.com>,
        Oliver Sang <oliver.sang@intel.com>, lkp@lists.01.org,
        lkp@intel.com
Subject: Re: [PATCH 2/2] signal: Replace force_fatal_sig with force_exit_sig
 when in doubt
Message-ID: <202111181552.A6F6E9B3EC@keescook>
References: <CAP045AqjHRL=bcZeQ-O+-Yh4nS93VEW7Mu-eE2GROjhKOa-VxA@mail.gmail.com>
 <87k0h6334w.fsf@email.froward.int.ebiederm.org>
 <202111171341.41053845C3@keescook>
 <CAHk-=wgkOGmkTu18hJQaJ4mk8hGZc16=gzGMgGGOd=uwpXsdyw@mail.gmail.com>
 <CAP045ApYXxhiAfmn=fQM7_hD58T-yx724ctWFHO4UAWCD+QapQ@mail.gmail.com>
 <CAHk-=wiCRbSvUi_TnQkokLeM==_+Tow0GsQXnV3UYwhsxirPwg@mail.gmail.com>
 <CAP045AoqssLTKOqse1t1DG1HgK9h+goG8C3sqgOyOV3Wwq+LDA@mail.gmail.com>
 <202111171728.D85A4E2571@keescook>
 <87h7c9qg7p.fsf_-_@email.froward.int.ebiederm.org>
 <871r3dqfv8.fsf_-_@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871r3dqfv8.fsf_-_@email.froward.int.ebiederm.org>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Nov 18, 2021 at 04:05:31PM -0600, Eric W. Biederman wrote:
> 
> Recently to prevent issues with SECCOMP_RET_KILL and similar signals
> being changed before they are delivered SA_IMMUTABLE was added.
> 
> Unfortunately this broke debuggers[1][2] which reasonably expect
> to be able to trap synchronous SIGTRAP and SIGSEGV even when
> the target process is not configured to handle those signals.
> 
> Add force_exit_sig and use it instead of force_fatal_sig where
> historically the code has directly called do_exit.  This has the
> implementation benefits of going through the signal exit path
> (including generating core dumps) without the danger of allowing
> userspace to ignore or change these signals.
> 
> This avoids userspace regressions as older kernels exited with do_exit
> which debuggers also can not intercept.
> 
> In the future is should be possible to improve the quality of
> implementation of the kernel by changing some of these force_exit_sig
> calls to force_fatal_sig.  That can be done where it matters on
> a case-by-case basis with careful analysis.
> 
> Reported-by: Kyle Huey <me@kylehuey.com>
> Reported-by: kernel test robot <oliver.sang@intel.com>
> [1] https://lkml.kernel.org/r/CAP045AoMY4xf8aC_4QU_-j7obuEPYgTcnQQP3Yxk=2X90jtpjw@mail.gmail.com
> [2] https://lkml.kernel.org/r/20211117150258.GB5403@xsang-OptiPlex-902
> Fixes: 00b06da29cf9 ("signal: Add SA_IMMUTABLE to ensure forced siganls do not get changed")
> Fixes: a3616a3c0272 ("signal/m68k: Use force_sigsegv(SIGSEGV) in fpsp040_die")
> Fixes: 83a1f27ad773 ("signal/powerpc: On swapcontext failure force SIGSEGV")
> Fixes: 9bc508cf0791 ("signal/s390: Use force_sigsegv in default_trap_handler")
> Fixes: 086ec444f866 ("signal/sparc32: In setup_rt_frame and setup_fram use force_fatal_sig")
> Fixes: c317d306d550 ("signal/sparc32: Exit with a fatal signal when try_to_clear_window_buffer fails")
> Fixes: 695dd0d634df ("signal/x86: In emulate_vsyscall force a signal instead of calling do_exit")
> Fixes: 1fbd60df8a85 ("signal/vm86_32: Properly send SIGSEGV when the vm86 state cannot be saved.")
> Fixes: 941edc5bf174 ("exit/syscall_user_dispatch: Send ordinary signals on failure")
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>

Reviewed-by: Kees Cook <keescook@chromium.org>
Tested-by: Kees Cook <keescook@chromium.org>

Thanks!

-Kees

> ---
>  arch/m68k/kernel/traps.c              |  2 +-
>  arch/powerpc/kernel/signal_32.c       |  2 +-
>  arch/powerpc/kernel/signal_64.c       |  4 ++--
>  arch/s390/kernel/traps.c              |  2 +-
>  arch/sparc/kernel/signal_32.c         |  4 ++--
>  arch/sparc/kernel/windows.c           |  2 +-
>  arch/x86/entry/vsyscall/vsyscall_64.c |  2 +-
>  arch/x86/kernel/vm86_32.c             |  2 +-
>  include/linux/sched/signal.h          |  1 +
>  kernel/entry/syscall_user_dispatch.c  |  4 ++--
>  kernel/signal.c                       | 13 +++++++++++++
>  11 files changed, 26 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/m68k/kernel/traps.c b/arch/m68k/kernel/traps.c
> index 99058a6da956..34d6458340b0 100644
> --- a/arch/m68k/kernel/traps.c
> +++ b/arch/m68k/kernel/traps.c
> @@ -1145,7 +1145,7 @@ asmlinkage void set_esp0(unsigned long ssp)
>   */
>  asmlinkage void fpsp040_die(void)
>  {
> -	force_fatal_sig(SIGSEGV);
> +	force_exit_sig(SIGSEGV);
>  }
>  
>  #ifdef CONFIG_M68KFPU_EMU
> diff --git a/arch/powerpc/kernel/signal_32.c b/arch/powerpc/kernel/signal_32.c
> index 00a9c9cd6d42..3e053e2fd6b6 100644
> --- a/arch/powerpc/kernel/signal_32.c
> +++ b/arch/powerpc/kernel/signal_32.c
> @@ -1063,7 +1063,7 @@ SYSCALL_DEFINE3(swapcontext, struct ucontext __user *, old_ctx,
>  	 * We kill the task with a SIGSEGV in this situation.
>  	 */
>  	if (do_setcontext(new_ctx, regs, 0)) {
> -		force_fatal_sig(SIGSEGV);
> +		force_exit_sig(SIGSEGV);
>  		return -EFAULT;
>  	}
>  
> diff --git a/arch/powerpc/kernel/signal_64.c b/arch/powerpc/kernel/signal_64.c
> index ef518535d436..d1e1fc0acbea 100644
> --- a/arch/powerpc/kernel/signal_64.c
> +++ b/arch/powerpc/kernel/signal_64.c
> @@ -704,7 +704,7 @@ SYSCALL_DEFINE3(swapcontext, struct ucontext __user *, old_ctx,
>  	 */
>  
>  	if (__get_user_sigset(&set, &new_ctx->uc_sigmask)) {
> -		force_fatal_sig(SIGSEGV);
> +		force_exit_sig(SIGSEGV);
>  		return -EFAULT;
>  	}
>  	set_current_blocked(&set);
> @@ -713,7 +713,7 @@ SYSCALL_DEFINE3(swapcontext, struct ucontext __user *, old_ctx,
>  		return -EFAULT;
>  	if (__unsafe_restore_sigcontext(current, NULL, 0, &new_ctx->uc_mcontext)) {
>  		user_read_access_end();
> -		force_fatal_sig(SIGSEGV);
> +		force_exit_sig(SIGSEGV);
>  		return -EFAULT;
>  	}
>  	user_read_access_end();
> diff --git a/arch/s390/kernel/traps.c b/arch/s390/kernel/traps.c
> index 035705c9f23e..2b780786fc68 100644
> --- a/arch/s390/kernel/traps.c
> +++ b/arch/s390/kernel/traps.c
> @@ -84,7 +84,7 @@ static void default_trap_handler(struct pt_regs *regs)
>  {
>  	if (user_mode(regs)) {
>  		report_user_fault(regs, SIGSEGV, 0);
> -		force_fatal_sig(SIGSEGV);
> +		force_exit_sig(SIGSEGV);
>  	} else
>  		die(regs, "Unknown program exception");
>  }
> diff --git a/arch/sparc/kernel/signal_32.c b/arch/sparc/kernel/signal_32.c
> index cd677bc564a7..ffab16369bea 100644
> --- a/arch/sparc/kernel/signal_32.c
> +++ b/arch/sparc/kernel/signal_32.c
> @@ -244,7 +244,7 @@ static int setup_frame(struct ksignal *ksig, struct pt_regs *regs,
>  		get_sigframe(ksig, regs, sigframe_size);
>  
>  	if (invalid_frame_pointer(sf, sigframe_size)) {
> -		force_fatal_sig(SIGILL);
> +		force_exit_sig(SIGILL);
>  		return -EINVAL;
>  	}
>  
> @@ -336,7 +336,7 @@ static int setup_rt_frame(struct ksignal *ksig, struct pt_regs *regs,
>  	sf = (struct rt_signal_frame __user *)
>  		get_sigframe(ksig, regs, sigframe_size);
>  	if (invalid_frame_pointer(sf, sigframe_size)) {
> -		force_fatal_sig(SIGILL);
> +		force_exit_sig(SIGILL);
>  		return -EINVAL;
>  	}
>  
> diff --git a/arch/sparc/kernel/windows.c b/arch/sparc/kernel/windows.c
> index bbbd40cc6b28..8f20862ccc83 100644
> --- a/arch/sparc/kernel/windows.c
> +++ b/arch/sparc/kernel/windows.c
> @@ -122,7 +122,7 @@ void try_to_clear_window_buffer(struct pt_regs *regs, int who)
>  		if ((sp & 7) ||
>  		    copy_to_user((char __user *) sp, &tp->reg_window[window],
>  				 sizeof(struct reg_window32))) {
> -			force_fatal_sig(SIGILL);
> +			force_exit_sig(SIGILL);
>  			return;
>  		}
>  	}
> diff --git a/arch/x86/entry/vsyscall/vsyscall_64.c b/arch/x86/entry/vsyscall/vsyscall_64.c
> index 0b6b277ee050..fd2ee9408e91 100644
> --- a/arch/x86/entry/vsyscall/vsyscall_64.c
> +++ b/arch/x86/entry/vsyscall/vsyscall_64.c
> @@ -226,7 +226,7 @@ bool emulate_vsyscall(unsigned long error_code,
>  	if ((!tmp && regs->orig_ax != syscall_nr) || regs->ip != address) {
>  		warn_bad_vsyscall(KERN_DEBUG, regs,
>  				  "seccomp tried to change syscall nr or ip");
> -		force_fatal_sig(SIGSYS);
> +		force_exit_sig(SIGSYS);
>  		return true;
>  	}
>  	regs->orig_ax = -1;
> diff --git a/arch/x86/kernel/vm86_32.c b/arch/x86/kernel/vm86_32.c
> index cce1c89cb7df..c21bcd668284 100644
> --- a/arch/x86/kernel/vm86_32.c
> +++ b/arch/x86/kernel/vm86_32.c
> @@ -160,7 +160,7 @@ void save_v86_state(struct kernel_vm86_regs *regs, int retval)
>  	user_access_end();
>  Efault:
>  	pr_alert("could not access userspace vm86 info\n");
> -	force_fatal_sig(SIGSEGV);
> +	force_exit_sig(SIGSEGV);
>  	goto exit_vm86;
>  }
>  
> diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
> index 23505394ef70..33a50642cf41 100644
> --- a/include/linux/sched/signal.h
> +++ b/include/linux/sched/signal.h
> @@ -352,6 +352,7 @@ extern __must_check bool do_notify_parent(struct task_struct *, int);
>  extern void __wake_up_parent(struct task_struct *p, struct task_struct *parent);
>  extern void force_sig(int);
>  extern void force_fatal_sig(int);
> +extern void force_exit_sig(int);
>  extern int send_sig(int, struct task_struct *, int);
>  extern int zap_other_threads(struct task_struct *p);
>  extern struct sigqueue *sigqueue_alloc(void);
> diff --git a/kernel/entry/syscall_user_dispatch.c b/kernel/entry/syscall_user_dispatch.c
> index 4508201847d2..0b6379adff6b 100644
> --- a/kernel/entry/syscall_user_dispatch.c
> +++ b/kernel/entry/syscall_user_dispatch.c
> @@ -48,7 +48,7 @@ bool syscall_user_dispatch(struct pt_regs *regs)
>  		 * the selector is loaded by userspace.
>  		 */
>  		if (unlikely(__get_user(state, sd->selector))) {
> -			force_fatal_sig(SIGSEGV);
> +			force_exit_sig(SIGSEGV);
>  			return true;
>  		}
>  
> @@ -56,7 +56,7 @@ bool syscall_user_dispatch(struct pt_regs *regs)
>  			return false;
>  
>  		if (state != SYSCALL_DISPATCH_FILTER_BLOCK) {
> -			force_fatal_sig(SIGSYS);
> +			force_exit_sig(SIGSYS);
>  			return true;
>  		}
>  	}
> diff --git a/kernel/signal.c b/kernel/signal.c
> index 02058c983bd6..fe7ba05145d4 100644
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -1671,6 +1671,19 @@ void force_fatal_sig(int sig)
>  	force_sig_info_to_task(&info, current, HANDLER_SIG_DFL);
>  }
>  
> +void force_exit_sig(int sig)
> +{
> +	struct kernel_siginfo info;
> +
> +	clear_siginfo(&info);
> +	info.si_signo = sig;
> +	info.si_errno = 0;
> +	info.si_code = SI_KERNEL;
> +	info.si_pid = 0;
> +	info.si_uid = 0;
> +	force_sig_info_to_task(&info, current, HANDLER_EXIT);
> +}
> +
>  /*
>   * When things go south during signal handling, we
>   * will force a SIGSEGV. And if the signal that caused
> -- 
> 2.20.1
> 

-- 
Kees Cook
