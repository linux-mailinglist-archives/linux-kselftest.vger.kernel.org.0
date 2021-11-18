Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61C4945668E
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Nov 2021 00:52:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233330AbhKRXzY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 18 Nov 2021 18:55:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232949AbhKRXzX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 18 Nov 2021 18:55:23 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13074C061748
        for <linux-kselftest@vger.kernel.org>; Thu, 18 Nov 2021 15:52:23 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id p18-20020a17090ad31200b001a78bb52876so9595533pju.3
        for <linux-kselftest@vger.kernel.org>; Thu, 18 Nov 2021 15:52:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5csrtvGfUTJpKF36Wio1zVqY+YzQi+hNlntFmMAP5yg=;
        b=g2lurF0Wk+tsvpUW7wbChUs+KopNziAVGrGyEwWVUi1JL40npMY/P45frOYQltqlkN
         HzbTpOa+CSf20GXvlzUwZ8r1nWk4P/Ny/5RI7MKoq5WedFas/awujDCP280w60AFULjw
         YMWA+8q4b3wlhHjXQIyMkcJCsDB9rkL7L5vqc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5csrtvGfUTJpKF36Wio1zVqY+YzQi+hNlntFmMAP5yg=;
        b=Y8pI/v/bpYOTfE/kW/+EeBJ3wouw1F3A10JJprX5++L9dt9wx9/zVFJHjEUdKiIjSP
         5ilx/iYGO2uVONL+5UpQ+NKFdKHjUBRi/X4mGG61qHLE39x8jCv6HrWefjfvuTt3hAU3
         NBu1TzOoIPBiYx30kZCinMh3a6Y6Rgueg3aA8U1WEh4ldh6ckwo1wKk5LtGOUm6oj0lE
         awNuTi+wrdhHPLxuYvJsqJ+dtPlMzoLjwR1IB6Wa8vAulF4Pwo3RlftSOsYoq2NJfmj1
         KvGG8Osqz93StQeifneMCEHPGsMKHGZXdezFRumvVETBWDiE7mFqelyGzEFbre0+yqBR
         wuGQ==
X-Gm-Message-State: AOAM531C2RKi3awri3kCUb4PIgPve7iT3ihohR/Ybx+KiYlycZPoBKQ7
        WhGaKauPSKAnTaGgRhIH2IJN6w==
X-Google-Smtp-Source: ABdhPJyCkMcnVji2etMSb9tSf8G2lX6aXR4fLRsukFT9YdqZmATb5ELAUMXF/+B7nHJtvSt9Daa/CA==
X-Received: by 2002:a17:903:1105:b0:143:a593:dc6e with SMTP id n5-20020a170903110500b00143a593dc6emr68520805plh.6.1637279542582;
        Thu, 18 Nov 2021 15:52:22 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id oc10sm10128805pjb.26.2021.11.18.15.52.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 15:52:22 -0800 (PST)
Date:   Thu, 18 Nov 2021 15:52:21 -0800
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
Subject: Re: [PATCH 1/2] signal: Don't always set SA_IMMUTABLE for forced
 signals
Message-ID: <202111181551.FE7B4825B0@keescook>
References: <CAP045AqjHRL=bcZeQ-O+-Yh4nS93VEW7Mu-eE2GROjhKOa-VxA@mail.gmail.com>
 <87k0h6334w.fsf@email.froward.int.ebiederm.org>
 <202111171341.41053845C3@keescook>
 <CAHk-=wgkOGmkTu18hJQaJ4mk8hGZc16=gzGMgGGOd=uwpXsdyw@mail.gmail.com>
 <CAP045ApYXxhiAfmn=fQM7_hD58T-yx724ctWFHO4UAWCD+QapQ@mail.gmail.com>
 <CAHk-=wiCRbSvUi_TnQkokLeM==_+Tow0GsQXnV3UYwhsxirPwg@mail.gmail.com>
 <CAP045AoqssLTKOqse1t1DG1HgK9h+goG8C3sqgOyOV3Wwq+LDA@mail.gmail.com>
 <202111171728.D85A4E2571@keescook>
 <87h7c9qg7p.fsf_-_@email.froward.int.ebiederm.org>
 <877dd5qfw5.fsf_-_@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877dd5qfw5.fsf_-_@email.froward.int.ebiederm.org>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Nov 18, 2021 at 04:04:58PM -0600, Eric W. Biederman wrote:
> 
> Recently to prevent issues with SECCOMP_RET_KILL and similar signals
> being changed before they are delivered SA_IMMUTABLE was added.
> 
> Unfortunately this broke debuggers[1][2] which reasonably expect to be
> able to trap synchronous SIGTRAP and SIGSEGV even when the target
> process is not configured to handle those signals.
> 
> Update force_sig_to_task to support both the case when we can
> allow the debugger to intercept and possibly ignore the
> signal and the case when it is not safe to let userspace
> known about the signal until the process has exited.
> 
> Reported-by: Kyle Huey <me@kylehuey.com>
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Cc: stable@vger.kernel.org
> [1] https://lkml.kernel.org/r/CAP045AoMY4xf8aC_4QU_-j7obuEPYgTcnQQP3Yxk=2X90jtpjw@mail.gmail.com
> [2] https://lkml.kernel.org/r/20211117150258.GB5403@xsang-OptiPlex-902
> Fixes: 00b06da29cf9 ("signal: Add SA_IMMUTABLE to ensure forced siganls do not get changed")
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>

Thanks! This passes the seccomp self-tests.

Reviewed-by: Kees Cook <keescook@chromium.org>
Tested-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  kernel/signal.c | 23 ++++++++++++++++-------
>  1 file changed, 16 insertions(+), 7 deletions(-)
> 
> diff --git a/kernel/signal.c b/kernel/signal.c
> index 7c4b7ae714d4..02058c983bd6 100644
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -1298,6 +1298,12 @@ int do_send_sig_info(int sig, struct kernel_siginfo *info, struct task_struct *p
>  	return ret;
>  }
>  
> +enum sig_handler {
> +	HANDLER_CURRENT, /* If reachable use the current handler */
> +	HANDLER_SIG_DFL, /* Always use SIG_DFL handler semantics */
> +	HANDLER_EXIT,	 /* Only visible as the proces exit code */
> +};
> +
>  /*
>   * Force a signal that the process can't ignore: if necessary
>   * we unblock the signal and change any SIG_IGN to SIG_DFL.
> @@ -1310,7 +1316,8 @@ int do_send_sig_info(int sig, struct kernel_siginfo *info, struct task_struct *p
>   * that is why we also clear SIGNAL_UNKILLABLE.
>   */
>  static int
> -force_sig_info_to_task(struct kernel_siginfo *info, struct task_struct *t, bool sigdfl)
> +force_sig_info_to_task(struct kernel_siginfo *info, struct task_struct *t,
> +	enum sig_handler handler)
>  {
>  	unsigned long int flags;
>  	int ret, blocked, ignored;
> @@ -1321,9 +1328,10 @@ force_sig_info_to_task(struct kernel_siginfo *info, struct task_struct *t, bool
>  	action = &t->sighand->action[sig-1];
>  	ignored = action->sa.sa_handler == SIG_IGN;
>  	blocked = sigismember(&t->blocked, sig);
> -	if (blocked || ignored || sigdfl) {
> +	if (blocked || ignored || (handler != HANDLER_CURRENT)) {
>  		action->sa.sa_handler = SIG_DFL;
> -		action->sa.sa_flags |= SA_IMMUTABLE;
> +		if (handler == HANDLER_EXIT)
> +			action->sa.sa_flags |= SA_IMMUTABLE;
>  		if (blocked) {
>  			sigdelset(&t->blocked, sig);
>  			recalc_sigpending_and_wake(t);
> @@ -1343,7 +1351,7 @@ force_sig_info_to_task(struct kernel_siginfo *info, struct task_struct *t, bool
>  
>  int force_sig_info(struct kernel_siginfo *info)
>  {
> -	return force_sig_info_to_task(info, current, false);
> +	return force_sig_info_to_task(info, current, HANDLER_CURRENT);
>  }
>  
>  /*
> @@ -1660,7 +1668,7 @@ void force_fatal_sig(int sig)
>  	info.si_code = SI_KERNEL;
>  	info.si_pid = 0;
>  	info.si_uid = 0;
> -	force_sig_info_to_task(&info, current, true);
> +	force_sig_info_to_task(&info, current, HANDLER_SIG_DFL);
>  }
>  
>  /*
> @@ -1693,7 +1701,7 @@ int force_sig_fault_to_task(int sig, int code, void __user *addr
>  	info.si_flags = flags;
>  	info.si_isr = isr;
>  #endif
> -	return force_sig_info_to_task(&info, t, false);
> +	return force_sig_info_to_task(&info, t, HANDLER_CURRENT);
>  }
>  
>  int force_sig_fault(int sig, int code, void __user *addr
> @@ -1813,7 +1821,8 @@ int force_sig_seccomp(int syscall, int reason, bool force_coredump)
>  	info.si_errno = reason;
>  	info.si_arch = syscall_get_arch(current);
>  	info.si_syscall = syscall;
> -	return force_sig_info_to_task(&info, current, force_coredump);
> +	return force_sig_info_to_task(&info, current,
> +		force_coredump ? HANDLER_EXIT : HANDLER_CURRENT);
>  }
>  
>  /* For the crazy architectures that include trap information in
> -- 
> 2.20.1

-- 
Kees Cook
