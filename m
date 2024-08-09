Return-Path: <linux-kselftest+bounces-15089-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C01394D638
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Aug 2024 20:19:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53231282B09
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Aug 2024 18:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ED8314D29B;
	Fri,  9 Aug 2024 18:19:34 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 408D520309;
	Fri,  9 Aug 2024 18:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723227574; cv=none; b=a4oOj501GB4k5j3mURh3V1vA/SpYZL40vhQqGtO8PFTku5KMsevwdiJtgFhSfjISPW44foXvLitSUmlMLL+uUSJQtO0AIsvSejs/iM/6VgV6AgbANpgexvT0lW742RZd+hbwpSPHbTYucFXKiBhZ783T4JOlCpgnXR7SotZ4XyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723227574; c=relaxed/simple;
	bh=FhTN8MVGmHdQhGdUvdXqfTR8ItK/k7hfsYmmMHr2RsU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UmdBsk9rpeaL2YshcoZCu4q++V7EqCJFkkEbP6qDCDgAZ8JiHQWSsIu5QL0mEUlXYApVCqR7njrS2B/iGmflkGCfcIvAi06xF3Hp7opzFJBNLzV7XptYHzmz1edMWulRQCFYiSzhV5XNDp2GHoDT2ACKvH1/7VKMtcQySeSzfHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDC50C32782;
	Fri,  9 Aug 2024 18:19:28 +0000 (UTC)
Date: Fri, 9 Aug 2024 19:19:26 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
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
	Will Deacon <will@kernel.org>, jannh@google.com,
	linux-kselftest@vger.kernel.org, linux-api@vger.kernel.org,
	Kees Cook <kees@kernel.org>
Subject: Re: [PATCH RFT v8 4/9] fork: Add shadow stack support to clone3()
Message-ID: <ZrZdrgOQVHhCyWmA@arm.com>
References: <20240808-clone3-shadow-stack-v8-0-0acf37caf14c@kernel.org>
 <20240808-clone3-shadow-stack-v8-4-0acf37caf14c@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240808-clone3-shadow-stack-v8-4-0acf37caf14c@kernel.org>

On Thu, Aug 08, 2024 at 09:15:25AM +0100, Mark Brown wrote:
> diff --git a/arch/x86/kernel/shstk.c b/arch/x86/kernel/shstk.c
> index 059685612362..d7005974aff5 100644
> --- a/arch/x86/kernel/shstk.c
> +++ b/arch/x86/kernel/shstk.c
> @@ -191,44 +191,105 @@ void reset_thread_features(void)
>  	current->thread.features_locked = 0;
>  }
>  
> -unsigned long shstk_alloc_thread_stack(struct task_struct *tsk, unsigned long clone_flags,
> -				       unsigned long stack_size)
> +int arch_shstk_post_fork(struct task_struct *t, struct kernel_clone_args *args)
> +{
> +	/*
> +	 * SSP is aligned, so reserved bits and mode bit are a zero, just mark
> +	 * the token 64-bit.
> +	 */
> +	struct mm_struct *mm;
> +	unsigned long addr, ssp;
> +	u64 expected;
> +	u64 val;
> +	int ret = -EINVAL;
> +
> +	ssp = args->shadow_stack + args->shadow_stack_size;
> +	addr = ssp - SS_FRAME_SIZE;
> +	expected = ssp | BIT(0);
> +
> +	mm = get_task_mm(t);
> +	if (!mm)
> +		return -EFAULT;
> +
> +	/* This should really be an atomic cmpxchg.  It is not. */
> +	if (access_remote_vm(mm, addr, &val, sizeof(val),
> +			     FOLL_FORCE) != sizeof(val))
> +		goto out;

If we restrict the shadow stack creation only to the CLONE_VM case, we'd
not need the remote vm access, it's in the current mm context already.
More on this below.

> +
> +	if (val != expected)
> +		goto out;
> +	val = 0;
> +	if (access_remote_vm(mm, addr, &val, sizeof(val),
> +			     FOLL_FORCE | FOLL_WRITE) != sizeof(val))
> +		goto out;

I'm confused that we need to consume the token here. I could not find
the default shadow stack allocation doing this, only setting it via
create_rstor_token() (or I did not search enough). In the default case,
is the user consuming it? To me the only difference should been the
default allocation vs the one passed by the user via clone3(), with the
latter maybe requiring the user to set the token initially.

> +
> +	ret = 0;
> +
> +out:
> +	mmput(mm);
> +	return ret;
> +}
> +
> +unsigned long shstk_alloc_thread_stack(struct task_struct *tsk,
> +				       const struct kernel_clone_args *args)
>  {
>  	struct thread_shstk *shstk = &tsk->thread.shstk;
> +	unsigned long clone_flags = args->flags;
>  	unsigned long addr, size;
>  
>  	/*
>  	 * If shadow stack is not enabled on the new thread, skip any
> -	 * switch to a new shadow stack.
> +	 * implicit switch to a new shadow stack and reject attempts to
> +	 * explciitly specify one.

Nit: explicitly.

>  	 */
> -	if (!features_enabled(ARCH_SHSTK_SHSTK))
> +	if (!features_enabled(ARCH_SHSTK_SHSTK)) {
> +		if (args->shadow_stack || args->shadow_stack_size)
> +			return (unsigned long)ERR_PTR(-EINVAL);
> +
>  		return 0;
> +	}
>  
>  	/*
> -	 * For CLONE_VFORK the child will share the parents shadow stack.
> -	 * Make sure to clear the internal tracking of the thread shadow
> -	 * stack so the freeing logic run for child knows to leave it alone.
> +	 * If the user specified a shadow stack then do some basic
> +	 * validation and use it, otherwise fall back to a default
> +	 * shadow stack size if the clone_flags don't indicate an
> +	 * allocation is unneeded.
>  	 */
> -	if (clone_flags & CLONE_VFORK) {
> +	if (args->shadow_stack) {
> +		addr = args->shadow_stack;
> +		size = args->shadow_stack_size;
>  		shstk->base = 0;
>  		shstk->size = 0;
> -		return 0;
> -	}
> +	} else {
> +		/*
> +		 * For CLONE_VFORK the child will share the parents
> +		 * shadow stack.  Make sure to clear the internal
> +		 * tracking of the thread shadow stack so the freeing
> +		 * logic run for child knows to leave it alone.
> +		 */
> +		if (clone_flags & CLONE_VFORK) {
> +			shstk->base = 0;
> +			shstk->size = 0;
> +			return 0;
> +		}

I think we should leave the CLONE_VFORK check on its own independent of
the clone3() arguments. If one passes both CLONE_VFORK and specific
shadow stack address/size, they should be ignored (or maybe return an
error if you want to make it stricter).

>  
> -	/*
> -	 * For !CLONE_VM the child will use a copy of the parents shadow
> -	 * stack.
> -	 */
> -	if (!(clone_flags & CLONE_VM))
> -		return 0;
> +		/*
> +		 * For !CLONE_VM the child will use a copy of the
> +		 * parents shadow stack.
> +		 */
> +		if (!(clone_flags & CLONE_VM))
> +			return 0;

Is the !CLONE_VM case specific only to the default shadow stack
allocation? Sorry if this has been discussed already (or I completely
forgot) but I thought we'd only implement this for the thread creation
case. The typical fork() for a new process should inherit the parent's
layout, so applicable to the clone3() with the shadow stack arguments as
well (which should be ignored or maybe return an error with !CLONE_VM).

[...]
> diff --git a/kernel/fork.c b/kernel/fork.c
> index cc760491f201..18278c72681c 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -128,6 +128,11 @@
>   */
>  #define MAX_THREADS FUTEX_TID_MASK
>  
> +/*
> + * Require that shadow stacks can store at least one element
> + */
> +#define SHADOW_STACK_SIZE_MIN sizeof(void *)
> +
>  /*
>   * Protected counters by write_lock_irq(&tasklist_lock)
>   */
> @@ -2729,6 +2734,19 @@ struct task_struct *create_io_thread(int (*fn)(void *), void *arg, int node)
>  	return copy_process(NULL, 0, node, &args);
>  }
>  
> +static void shstk_post_fork(struct task_struct *p,
> +			    struct kernel_clone_args *args)
> +{
> +	if (!IS_ENABLED(CONFIG_ARCH_HAS_USER_SHADOW_STACK))
> +		return;
> +
> +	if (!args->shadow_stack)
> +		return;
> +
> +	if (arch_shstk_post_fork(p, args) != 0)
> +		force_sig_fault_to_task(SIGSEGV, SEGV_CPERR, NULL, p);
> +}
> +
>  /*
>   *  Ok, this is the main fork-routine.
>   *
> @@ -2790,6 +2808,8 @@ pid_t kernel_clone(struct kernel_clone_args *args)
>  	 */
>  	trace_sched_process_fork(current, p);
>  
> +	shstk_post_fork(p, args);

Do we need this post fork call? Can we not handle the setup via the
copy_thread() path in shstk_alloc_thread_stack()?

-- 
Catalin

