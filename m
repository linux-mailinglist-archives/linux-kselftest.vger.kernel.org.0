Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2E4D440FCB
	for <lists+linux-kselftest@lfdr.de>; Sun, 31 Oct 2021 18:40:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbhJaRnD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 31 Oct 2021 13:43:03 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:46966
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230192AbhJaRnB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 31 Oct 2021 13:43:01 -0400
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id CC8E63F1A3
        for <linux-kselftest@vger.kernel.org>; Sun, 31 Oct 2021 17:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1635702021;
        bh=CRAiFS1cKz+cJsqMGNZZJACSB/KL6YFLVva91SNe05Y=;
        h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
         Content-Type:In-Reply-To;
        b=v4pXO7t4Jmet2uBFpNpcZxF8Kf+vJo+XydC/oW8wz/g90s1k76Aa5VDpV3weKDp+r
         khcKkMIuvmVuP2TiXipv7qNZRFwEoIC8imIMPAu4RYB8naCfjq/G0odaHxiOb8GeVr
         18Ufqd4BFVZCYC7wZdD9KLjQ8ZJmz4IXdsx15lU6cbqzxLafFs/L57vM49M/+UNZOW
         7VLUZKDa9abbNLGftZYPTmTVYaxvGoKpkB8Wh3pZO409ybldyUs7L4SUgtVhO/0/VE
         QOv4FHfijjdLFbUdGB1b+JZXpuBbnNrjqOlmVbxvG/yjRRDBz4rzXvMXJtFH3sAHCa
         RyK2Ud+5i2XcQ==
Received: by mail-ed1-f70.google.com with SMTP id t18-20020a056402021200b003db9e6b0e57so13537270edv.10
        for <linux-kselftest@vger.kernel.org>; Sun, 31 Oct 2021 10:40:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CRAiFS1cKz+cJsqMGNZZJACSB/KL6YFLVva91SNe05Y=;
        b=YEHxY5jnXT4hriWtZ5e1DqOifzqrslOO8oHiriPunHlPpz+bzaPuzGDM0GQewE/CCY
         zCGmMTpoh5RLHXXAv2Wfkdr5ia2y58n4Ft6jFxsZM4qTboiPzis9PbtHfOevSG0fa+3j
         4lafnIOpIhTnNbhusIQSnEWNJP/bWWs/PT5UxKolIC5Km8/dKEprNL89N6WkIvNGCxF9
         q/XCVjhR/B3tsELeLc8FtKdrLfGoirwjImhBV9zgB2vy8fn7J9gqqVEfVMMMPxJeU0f9
         j6VVV+lt0wa0ZgXQA4/VCvAChGMiss2D11yXhb0DzTZZP9/JhZycuPkOzN+PUEbqBoyu
         v0aw==
X-Gm-Message-State: AOAM5317D1z/az21Wq3fDztb33XxhXXDwOM5w6bIj5AGpeVxXOlT5arl
        jBcCRnaZS5DAqUwRf60PuVvukjAhchpR2Zoi8tmR0Wu97L5f8HVL5XY72MZlt311mg6EFV/5bsZ
        lwxaRQUuTSUULZEDvxo5BOZvyolcglNZ+DlweKXzzN9lZzA==
X-Received: by 2002:a05:6402:3512:: with SMTP id b18mr33560110edd.15.1635702021473;
        Sun, 31 Oct 2021 10:40:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwxtZsccnVYGZSxvzQx65pspDj7+afH+kZC2jBUN05hv/1SGDsw94p/ES6HAcpn2odiZ0W8Tg==
X-Received: by 2002:a05:6402:3512:: with SMTP id b18mr33560092edd.15.1635702021288;
        Sun, 31 Oct 2021 10:40:21 -0700 (PDT)
Received: from localhost ([2001:67c:1560:8007::aac:c1b6])
        by smtp.gmail.com with ESMTPSA id t25sm1766673edv.31.2021.10.31.10.40.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Oct 2021 10:40:20 -0700 (PDT)
Date:   Sun, 31 Oct 2021 18:40:19 +0100
From:   Andrea Righi <andrea.righi@canonical.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Kees Cook <keescook@chromium.org>, Shuah Khan <shuah@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        linux-kselftest@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] signal: Add SA_IMMUTABLE to ensure forced siganls do not
 get changed
Message-ID: <YX7VA1JZaYkTQeSi@arighi-desktop>
References: <YXrN+Hnl9pSOsWlA@arighi-desktop>
 <202110280955.B18CB67@keescook>
 <878rydm56l.fsf@disp2133>
 <202110281136.5CE65399A7@keescook>
 <87k0hvkgvj.fsf_-_@disp2133>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87k0hvkgvj.fsf_-_@disp2133>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Oct 29, 2021 at 10:09:04AM -0500, Eric W. Biederman wrote:
> 
> As Andy pointed out that there are races between
> force_sig_info_to_task and sigaction[1] when force_sig_info_task.  As
> Kees discovered[2] ptrace is also able to change these signals.
> 
> In the case of seeccomp killing a process with a signal it is a
> security violation to allow the signal to be caught or manipulated.
> 
> Solve this problem by introducing a new flag SA_IMMUTABLE that
> prevents sigaction and ptrace from modifying these forced signals.
> This flag is carefully made kernel internal so that no new ABI is
> introduced.
> 
> Longer term I think this can be solved by guaranteeing short circuit
> delivery of signals in this case.  Unfortunately reliable and
> guaranteed short circuit delivery of these signals is still a ways off
> from being implemented, tested, and merged.  So I have implemented a much
> simpler alternative for now.
> 
> [1] https://lkml.kernel.org/r/b5d52d25-7bde-4030-a7b1-7c6f8ab90660@www.fastmail.com
> [2] https://lkml.kernel.org/r/202110281136.5CE65399A7@keescook
> Cc: stable@vger.kernel.org
> Fixes: 307d522f5eb8 ("signal/seccomp: Refactor seccomp signal and coredump generation")
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
> ---

FWIW I've tested this patch and I confirm that it fixes the failure that
I reported with the seccomp_bpf selftest.

Tested-by: Andrea Righi <andrea.righi@canonical.com>

Thanks!
-Andrea

> 
> I have tested this patch and this changed works for me to fix the issue.
> 
> I believe this closes all of the races that force_sig_info_to_task
> has when sigdfl is specified.  So this should be enough for anything
> that needs a guaranteed that userspace can not race with the kernel
> is handled.
> 
> Can folks look this over and see if I missed something?
> Thank you,
> Eric
> 
> 
>  include/linux/signal_types.h           | 3 +++
>  include/uapi/asm-generic/signal-defs.h | 1 +
>  kernel/signal.c                        | 8 +++++++-
>  3 files changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/signal_types.h b/include/linux/signal_types.h
> index 34cb28b8f16c..927f7c0e5bff 100644
> --- a/include/linux/signal_types.h
> +++ b/include/linux/signal_types.h
> @@ -70,6 +70,9 @@ struct ksignal {
>  	int sig;
>  };
>  
> +/* Used to kill the race between sigaction and forced signals */
> +#define SA_IMMUTABLE		0x008000000
> +
>  #ifndef __ARCH_UAPI_SA_FLAGS
>  #ifdef SA_RESTORER
>  #define __ARCH_UAPI_SA_FLAGS	SA_RESTORER
> diff --git a/include/uapi/asm-generic/signal-defs.h b/include/uapi/asm-generic/signal-defs.h
> index fe929e7b77ca..7572f2f46ee8 100644
> --- a/include/uapi/asm-generic/signal-defs.h
> +++ b/include/uapi/asm-generic/signal-defs.h
> @@ -45,6 +45,7 @@
>  #define SA_UNSUPPORTED	0x00000400
>  #define SA_EXPOSE_TAGBITS	0x00000800
>  /* 0x00010000 used on mips */
> +/* 0x00800000 used for internal SA_IMMUTABLE */
>  /* 0x01000000 used on x86 */
>  /* 0x02000000 used on x86 */
>  /*
> diff --git a/kernel/signal.c b/kernel/signal.c
> index 6a5e1802b9a2..056a107e3cbc 100644
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -1336,6 +1336,7 @@ force_sig_info_to_task(struct kernel_siginfo *info, struct task_struct *t, bool
>  	blocked = sigismember(&t->blocked, sig);
>  	if (blocked || ignored || sigdfl) {
>  		action->sa.sa_handler = SIG_DFL;
> +		action->sa.sa_flags |= SA_IMMUTABLE;
>  		if (blocked) {
>  			sigdelset(&t->blocked, sig);
>  			recalc_sigpending_and_wake(t);
> @@ -2760,7 +2761,8 @@ bool get_signal(struct ksignal *ksig)
>  		if (!signr)
>  			break; /* will return 0 */
>  
> -		if (unlikely(current->ptrace) && signr != SIGKILL) {
> +		if (unlikely(current->ptrace) && (signr != SIGKILL) &&
> +		    !(sighand->action[signr -1].sa.sa_flags & SA_IMMUTABLE)) {
>  			signr = ptrace_signal(signr, &ksig->info);
>  			if (!signr)
>  				continue;
> @@ -4110,6 +4112,10 @@ int do_sigaction(int sig, struct k_sigaction *act, struct k_sigaction *oact)
>  	k = &p->sighand->action[sig-1];
>  
>  	spin_lock_irq(&p->sighand->siglock);
> +	if (k->sa.sa_flags & SA_IMMUTABLE) {
> +		spin_unlock_irq(&p->sighand->siglock);
> +		return -EINVAL;
> +	}
>  	if (oact)
>  		*oact = *k;
>  
> -- 
> 2.20.1
