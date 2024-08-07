Return-Path: <linux-kselftest+bounces-14942-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D80F94AF99
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Aug 2024 20:23:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D7F11F22D55
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Aug 2024 18:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1B341411DF;
	Wed,  7 Aug 2024 18:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hSMXXN5W"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2FCA13BC12;
	Wed,  7 Aug 2024 18:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723054985; cv=none; b=B1Zz8BQtjG4bp71a4bZJs62oGLa/8Xd8NorEdZCNK8qmEtmdtlXcmNvfVigWnha6YdFe7ePQ93XvQm7rIOMPADVYU0JTYBkRYCIx4wYXxYjG5Q3Sx80I7RCsFhzih4vh/qXr72vp8kOxaDHx2vPh40CsV9xkyAtnvr2XxgBnALE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723054985; c=relaxed/simple;
	bh=GIIg4NFIrWlEe7X4kkyZwtgzGRqAM7FVGbehXNHySJM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XGIpKMFk9VXImc8/xx1dUWNz6NDGFhzrhueKaKdeNt3u0LQz93BOmbitHDR4+Ox4zrWLEZrALK1EoOexg/rgDKlAoPrg0hdvhYzwiMELDl3BC1cFM7qj7iZzVQDJtuxJwXnWTivnSlcFaBQtK1UauU497MYp7NlWNwpU4kzxt3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hSMXXN5W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20C88C32781;
	Wed,  7 Aug 2024 18:23:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723054985;
	bh=GIIg4NFIrWlEe7X4kkyZwtgzGRqAM7FVGbehXNHySJM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hSMXXN5WZgmqR5swHaeSWo+Yrd3zD8zgE3QW9R5c7BKFe/hdDsHjtUVoWfZfNfk6L
	 FcEC+vd01QZ9i3zQ4f8/x2hhaa2DUKqd86l7iKQgypCapFRehb7nPE4x72kbeht9/Y
	 pwbgZh0pB4GJSwH/wqkkOKFl8ADQ1B+stF0HJ7PKezKHyIRv5WnQBEzmG6UyWW6Byx
	 boD5JmBlopWVG/yvTqCrKFI95TRF7RE7OBJuOsgOS5IEhGbQEwOVeeYyElNGDwu3FF
	 VdarA/uixhVskB8FMrdWaftoeG4Y8tDfNLaCZ+g6Bezq7xsYvH1DpGrrQmie/V7v8F
	 +5RpRABVtRgYg==
Date: Wed, 7 Aug 2024 11:23:04 -0700
From: Kees Cook <kees@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: "Rick P. Edgecombe" <rick.p.edgecombe@intel.com>,
	Deepak Gupta <debug@rivosinc.com>,
	Szabolcs Nagy <Szabolcs.Nagy@arm.com>,
	"H.J. Lu" <hjl.tools@gmail.com>,
	Florian Weimer <fweimer@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, jannh@google.com,
	linux-kselftest@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [PATCH RFT v7 9/9] selftests/clone3: Test shadow stack support
Message-ID: <202408071118.0C8A04C42@keescook>
References: <20240731-clone3-shadow-stack-v7-0-a9532eebfb1d@kernel.org>
 <20240731-clone3-shadow-stack-v7-9-a9532eebfb1d@kernel.org>
 <202408052046.00BC7CBC@keescook>
 <19ee6fc9-94d7-4420-abd3-7cfdf612df0c@sirena.org.uk>
 <202408062022.34F3558@keescook>
 <e5e5c0fc-3425-4020-ae7c-4b7fd0f1f263@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e5e5c0fc-3425-4020-ae7c-4b7fd0f1f263@sirena.org.uk>

On Wed, Aug 07, 2024 at 01:39:27PM +0100, Mark Brown wrote:
> On Tue, Aug 06, 2024 at 10:08:44PM -0700, Kees Cook wrote:
> > On Tue, Aug 06, 2024 at 04:10:02PM +0100, Mark Brown wrote:
> 
> > > >   # Running test 'Shadow stack with no token'
> 
> > It took me a while to figure out where a thread switches shstk (even
> > without this series):
> 
> > kernel_clone, copy_process, copy_thread, fpu_clone, update_fpu_shstk
> > (and shstk_alloc_thread_stack is called just before update_fpu_shstk).
> 
> > I don't understand the token consumption in arch_shstk_post_fork(). This
> > wasn't needed before with the fixed-size new shstk, why is it needed
> > now?
> 
> Concerns were raised on earlier rounds of review that since instead of
> allocating the shadow stack as part of creating the new thread we are
> using a previously allocated shadow stack someone could use this as part
> of an exploit.  You could just jump on top of any existing shadow stack
> and cause writes to it.
> 
> > Anyway, my attempt to trace the shstk changes for the test:
> 
> > write(1, "TAP version 13\n", 15)        = 15
> > write(1, "1..2\n", 5)                   = 5
> > clone3({flags=0, exit_signal=18446744073709551615, stack=NULL, stack_size=0}, 104) = -1 EINVAL (Invalid argument)
> > write(1, "# clone3() syscall supported\n", 29) = 29
> > map_shadow_stack(NULL, 4096, 0)         = 125837480497152
> > write(1, "# Shadow stack supportd\n", 24) = 24
> > write(1, "# Running test 'Shadow stack wit"..., 44) = 44
> > getpid()                                = 4943
> > write(1, "# [4943] Trying clone3() with fl"..., 51) = 51
> > map_shadow_stack(NULL, 4096, 0)         = 125837480488960
> > clone3({flags=CLONE_VM, exit_signal=SIGCHLD, stack=NULL, stack_size=0, /* bytes 88..103 */ "\x00\xf0\x52\xd2\x72\x72\x00\x00\x00\x10\x00\x00\x00\x00\x00\x00"} => {/* bytes 88..103 */ "\x00\xf0\x52\xd2\x72\x72\x00\x00\x00\x10\x00\x00\x00\x00\x00\x00"}, 104) = 4944
> > getpid()                                = 4943
> > write(1, "# I am the parent (4943). My chi"..., 49strace: Process 4944 attached
> > ) = 49
> > [pid  4944] --- SIGSEGV {si_signo=SIGSEGV, si_code=SEGV_CPERR, si_addr=NULL} ---
> > [pid  4943] wait4(-1,  <unfinished ...>
> > [pid  4944] +++ killed by SIGSEGV (core dumped) +++
> 
> So we created the thread, then before we get to the wait4() in the
> parent we start delivering a SEGV_CPERR to the child.  The flow for the
> child is as expected.
> 
> > <... wait4 resumed>[{WIFSIGNALED(s) && WTERMSIG(s) == SIGSEGV && WCOREDUMP(s)}], __WALL, NULL) = 4944
> > --- SIGCHLD {si_signo=SIGCHLD, si_code=CLD_DUMPED, si_pid=4944, si_uid=0, si_status=SIGSEGV, si_utime=0, si_stime=0} ---
> > --- SIGSEGV {si_signo=SIGSEGV, si_code=SEGV_MAPERR, si_addr=0x7272d21fffe8} ---
> > +++ killed by SIGSEGV (core dumped) +++
> 
> Then the parent gets an ordinary segfault, not a shadow stack specific
> one, like some memory got deallocated underneath it or a pointer got
> corrupted.
> 
> > [  569.153288] shstk_setup: clone3[4943] ssp:7272d2200000
> > [  569.153998] process: copy_thread: clone3[4943] new_ssp:7272d2530000
> > [  569.154002] update_fpu_shstk: clone3[4943] ssp:7272d2530000
> > [  569.154008] shstk_post_fork: clone3[4944]
> > [  569.154011] shstk_post_fork: clone3[4944] sending SIGSEGV post fork
> 
> > I don't see an update_fpu_shstk for 4944? Should I with this test?
> 
> I'd only expect to see one update, my understanding is that that update
> is for the child but happening in the context of the parent as the hild
> is not yet started.

What's weird here that I don't understand is that the parent is 4943, so
this report makes sense:

> > [  569.153288] shstk_setup: clone3[4943] ssp:7272d2200000

The child is 4944, yet I see:

> > [  569.153998] process: copy_thread: clone3[4943] new_ssp:7272d2530000
> > [  569.154002] update_fpu_shstk: clone3[4943] ssp:7272d2530000

These map to my logging:

copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
	...
	new_ssp = shstk_alloc_thread_stack(p, args);
	pr_err("%s: %s[%d] new_ssp:%lx\n", __func__, p->comm, task_pid_nr(p), new_ssp);

and

update_fpu_shstk(struct task_struct *dst, unsigned long ssp)
	...
        xstate->user_ssp = (u64)ssp;
	pr_err("%s: %s[%d] ssp:%lx\n", __func__, dst->comm, task_pid_nr(dst), ssp);

The child should be "p" (and "dst") here -- stuff is being copied from
current to p, but p is reporting itself as 4943 here? (Oh, this is
reporting pid, not tid... I bet that's what I've got wrong.)

> Does this help:
> 
> diff --git a/arch/x86/kernel/shstk.c b/arch/x86/kernel/shstk.c
> index 27acbdf44c5f..d7005974aff5 100644
> --- a/arch/x86/kernel/shstk.c
> +++ b/arch/x86/kernel/shstk.c
> @@ -258,6 +258,8 @@ unsigned long shstk_alloc_thread_stack(struct task_struct *tsk,
>  	if (args->shadow_stack) {
>  		addr = args->shadow_stack;
>  		size = args->shadow_stack_size;
> +		shstk->base = 0;
> +		shstk->size = 0;
>  	} else {
>  		/*
>  		 * For CLONE_VFORK the child will share the parents

I'll fix my reporting and give this patch a try too. Thanks!

-Kees

-- 
Kees Cook

