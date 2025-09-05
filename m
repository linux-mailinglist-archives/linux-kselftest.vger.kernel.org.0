Return-Path: <linux-kselftest+bounces-40850-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE1DFB45C69
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Sep 2025 17:23:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 456A33B5BE6
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Sep 2025 15:22:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23FAA1E4BE;
	Fri,  5 Sep 2025 15:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ucFN/EHx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD9031B81B;
	Fri,  5 Sep 2025 15:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757085729; cv=none; b=YrfHnohHq3Wvq/22BRl6iYlmZSSz+yGXuyDI77f/QNATmlWTHqqIkmOJMQZYTkrRwGBr18dsFxglRZWtOJplgnEovY9+78vfPTl9QTbofIV10vQbvjjaIHSI1HoYsj3zi+Sqm7glxOSHsV+TYnRJ6YbpyXqcV3pnWjRB0o7ICfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757085729; c=relaxed/simple;
	bh=orDcQO2mDFt/Rptp+4dd8KE/+8XnTzh2xclKPDGcdAA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o9B8e+qLwwa01F+l3/xHLHoELDsw9T/0l2WPlrevU1Pl1ZK3i+wA5kXVEV4xY4ah51lcoTEijIwQfqUyOYYjn4LzmQWu+6Q5l8wAI0oTbGywIjJnR1sx7r8tU9i8OFjmm4feQWKVWWnZkqGsjanMPpJ/X7JYmpvVricUyYy5xH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ucFN/EHx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02E30C4CEF1;
	Fri,  5 Sep 2025 15:22:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757085728;
	bh=orDcQO2mDFt/Rptp+4dd8KE/+8XnTzh2xclKPDGcdAA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ucFN/EHxwALbURefdw2BY5zRoU/XnFHpqTKAApN4gEryGH+SP+hQ+hq0IQGTBQ5a0
	 MOgZTTDgXIIuk7GXs5Y93iRmazAz+URTCgTVA60pWfs9bZl1ZWUi/6UbxjHIWRAutw
	 nIFM2azElvDbYRzJMGswrYcTuH3Fw/Ab1AvgpebOxN6QUkAPnXYUjjB3uSnrJ6ytlp
	 PTRLXOvCkyNTL8khBjvDG/6Huniy46/AcSdGbF0FfVZYEPZcjfVox/sx5vULh4fgAu
	 J0aL7ORQNfdDhfx9YCpJuL5//4klhHLc5ZBrRLJpNRUQBuy4stYb/GarKz+6/QN3qp
	 EvyybGv77F2Sw==
Date: Fri, 5 Sep 2025 17:21:59 +0200
From: Christian Brauner <brauner@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: "Rick P. Edgecombe" <rick.p.edgecombe@intel.com>, 
	Deepak Gupta <debug@rivosinc.com>, Szabolcs Nagy <Szabolcs.Nagy@arm.com>, 
	"H.J. Lu" <hjl.tools@gmail.com>, Florian Weimer <fweimer@redhat.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, jannh@google.com, 
	Andrew Morton <akpm@linux-foundation.org>, Yury Khrustalev <yury.khrustalev@arm.com>, 
	Wilco Dijkstra <wilco.dijkstra@arm.com>, linux-kselftest@vger.kernel.org, linux-api@vger.kernel.org, 
	Kees Cook <kees@kernel.org>
Subject: Re: [PATCH v20 4/8] fork: Add shadow stack support to clone3()
Message-ID: <20250905-nutria-befund-2f3e92003734@brauner>
References: <20250902-clone3-shadow-stack-v20-0-4d9fff1c53e7@kernel.org>
 <20250902-clone3-shadow-stack-v20-4-4d9fff1c53e7@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250902-clone3-shadow-stack-v20-4-4d9fff1c53e7@kernel.org>

On Tue, Sep 02, 2025 at 11:21:48AM +0100, Mark Brown wrote:
> Unlike with the normal stack there is no API for configuring the shadow
> stack for a new thread, instead the kernel will dynamically allocate a
> new shadow stack with the same size as the normal stack. This appears to
> be due to the shadow stack series having been in development since
> before the more extensible clone3() was added rather than anything more
> deliberate.
> 
> Add a parameter to clone3() specifying a shadow stack pointer to use
> for the new thread, this is inconsistent with the way we specify the
> normal stack but during review concerns were expressed about having to
> identify where the shadow stack pointer should be placed especially in
> cases where the shadow stack has been previously active.  If no shadow
> stack is specified then the existing implicit allocation behaviour is
> maintained.
> 
> If a shadow stack pointer is specified then it is required to have an
> architecture defined token placed on the stack, this will be consumed by
> the new task, the shadow stack is specified by pointing to this token.  If
> no valid token is present then this will be reported with -EINVAL.  This
> token prevents new threads being created pointing at the shadow stack of
> an existing running thread.  On architectures with support for userspace
> pivoting of shadow stacks it is expected that the same format and placement
> of tokens will be used, this is the case for arm64 and x86.
> 
> If the architecture does not support shadow stacks the shadow stack
> pointer must be not be specified, architectures that do support the
> feature are expected to enforce the same requirement on individual
> systems that lack shadow stack support.
> 
> Update the existing arm64 and x86 implementations to pay attention to
> the newly added arguments, in order to maintain compatibility we use the
> existing behaviour if no shadow stack is specified. Since we are now
> using more fields from the kernel_clone_args we pass that into the
> shadow stack code rather than individual fields.
> 
> Portions of the x86 architecture code were written by Rick Edgecombe.
> 
> Acked-by: Yury Khrustalev <yury.khrustalev@arm.com>
> Tested-by: Yury Khrustalev <yury.khrustalev@arm.com>
> Tested-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> Reviewed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  arch/arm64/mm/gcs.c              | 47 +++++++++++++++++++-
>  arch/x86/include/asm/shstk.h     | 11 +++--
>  arch/x86/kernel/process.c        |  2 +-
>  arch/x86/kernel/shstk.c          | 53 ++++++++++++++++++++---
>  include/asm-generic/cacheflush.h | 11 +++++
>  include/linux/sched/task.h       | 17 ++++++++
>  include/uapi/linux/sched.h       |  9 ++--
>  kernel/fork.c                    | 93 ++++++++++++++++++++++++++++++++++------
>  8 files changed, 217 insertions(+), 26 deletions(-)
> 
> diff --git a/arch/arm64/mm/gcs.c b/arch/arm64/mm/gcs.c
> index 3abcbf9adb5c..249ff05bca45 100644
> --- a/arch/arm64/mm/gcs.c
> +++ b/arch/arm64/mm/gcs.c
> @@ -43,8 +43,23 @@ int gcs_alloc_thread_stack(struct task_struct *tsk,
>  {
>  	unsigned long addr, size;
>  
> -	if (!system_supports_gcs())
> +	if (!system_supports_gcs()) {
> +		if (args->shadow_stack_token)
> +			return -EINVAL;
> +
>  		return 0;
> +	}
> +
> +	/*
> +	 * If the user specified a GCS then use it, otherwise fall
> +	 * back to a default allocation strategy. Validation is done
> +	 * in arch_shstk_validate_clone().
> +	 */
> +	if (args->shadow_stack_token) {
> +		tsk->thread.gcs_base = 0;
> +		tsk->thread.gcs_size = 0;
> +		return 0;
> +	}
>  
>  	if (!task_gcs_el0_enabled(tsk))
>  		return 0;
> @@ -68,6 +83,36 @@ int gcs_alloc_thread_stack(struct task_struct *tsk,
>  	return 0;
>  }
>  
> +static bool gcs_consume_token(struct vm_area_struct *vma, struct page *page,
> +			      unsigned long user_addr)
> +{
> +	u64 expected = GCS_CAP(user_addr);
> +	u64 *token = page_address(page) + offset_in_page(user_addr);
> +
> +	if (!cmpxchg_to_user_page(vma, page, user_addr, token, expected, 0))
> +		return false;
> +	set_page_dirty_lock(page);
> +
> +	return true;
> +}
> +
> +int arch_shstk_validate_clone(struct task_struct *tsk,
> +			      struct vm_area_struct *vma,
> +			      struct page *page,
> +			      struct kernel_clone_args *args)
> +{
> +	unsigned long gcspr_el0;
> +	int ret = 0;
> +
> +	gcspr_el0 = args->shadow_stack_token;
> +	if (!gcs_consume_token(vma, page, gcspr_el0))
> +		return -EINVAL;
> +
> +	tsk->thread.gcspr_el0 = gcspr_el0 + sizeof(u64);
> +
> +	return ret;
> +}
> +
>  SYSCALL_DEFINE3(map_shadow_stack, unsigned long, addr, unsigned long, size, unsigned int, flags)
>  {
>  	unsigned long alloc_size;
> diff --git a/arch/x86/include/asm/shstk.h b/arch/x86/include/asm/shstk.h
> index ba6f2fe43848..827e983430aa 100644
> --- a/arch/x86/include/asm/shstk.h
> +++ b/arch/x86/include/asm/shstk.h
> @@ -6,6 +6,7 @@
>  #include <linux/types.h>
>  
>  struct task_struct;
> +struct kernel_clone_args;
>  struct ksignal;
>  
>  #ifdef CONFIG_X86_USER_SHADOW_STACK
> @@ -16,8 +17,8 @@ struct thread_shstk {
>  
>  long shstk_prctl(struct task_struct *task, int option, unsigned long arg2);
>  void reset_thread_features(void);
> -unsigned long shstk_alloc_thread_stack(struct task_struct *p, unsigned long clone_flags,
> -				       unsigned long stack_size);
> +unsigned long shstk_alloc_thread_stack(struct task_struct *p,
> +				       const struct kernel_clone_args *args);
>  void shstk_free(struct task_struct *p);
>  int setup_signal_shadow_stack(struct ksignal *ksig);
>  int restore_signal_shadow_stack(void);
> @@ -28,8 +29,10 @@ static inline long shstk_prctl(struct task_struct *task, int option,
>  			       unsigned long arg2) { return -EINVAL; }
>  static inline void reset_thread_features(void) {}
>  static inline unsigned long shstk_alloc_thread_stack(struct task_struct *p,
> -						     unsigned long clone_flags,
> -						     unsigned long stack_size) { return 0; }
> +						     const struct kernel_clone_args *args)
> +{
> +	return 0;
> +}
>  static inline void shstk_free(struct task_struct *p) {}
>  static inline int setup_signal_shadow_stack(struct ksignal *ksig) { return 0; }
>  static inline int restore_signal_shadow_stack(void) { return 0; }
> diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
> index 1b7960cf6eb0..0a54af6c60df 100644
> --- a/arch/x86/kernel/process.c
> +++ b/arch/x86/kernel/process.c
> @@ -209,7 +209,7 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
>  	 * is disabled, new_ssp will remain 0, and fpu_clone() will know not to
>  	 * update it.
>  	 */
> -	new_ssp = shstk_alloc_thread_stack(p, clone_flags, args->stack_size);
> +	new_ssp = shstk_alloc_thread_stack(p, args);
>  	if (IS_ERR_VALUE(new_ssp))
>  		return PTR_ERR((void *)new_ssp);
>  
> diff --git a/arch/x86/kernel/shstk.c b/arch/x86/kernel/shstk.c
> index 2ddf23387c7e..9926d58e5d41 100644
> --- a/arch/x86/kernel/shstk.c
> +++ b/arch/x86/kernel/shstk.c
> @@ -191,18 +191,61 @@ void reset_thread_features(void)
>  	current->thread.features_locked = 0;
>  }
>  
> -unsigned long shstk_alloc_thread_stack(struct task_struct *tsk, unsigned long clone_flags,
> -				       unsigned long stack_size)
> +int arch_shstk_validate_clone(struct task_struct *t,
> +			      struct vm_area_struct *vma,
> +			      struct page *page,
> +			      struct kernel_clone_args *args)
> +{
> +	void *maddr = page_address(page);
> +	unsigned long token;
> +	int offset;
> +	u64 expected;
> +
> +	/*
> +	 * kernel_clone_args() verification assures token address is 8
> +	 * byte aligned.
> +	 */
> +	token = args->shadow_stack_token;
> +	expected = (token + SS_FRAME_SIZE) | BIT(0);
> +	offset = offset_in_page(token);
> +
> +	if (!cmpxchg_to_user_page(vma, page, token, (unsigned long *)(maddr + offset),
> +				  expected, 0))
> +		return -EINVAL;
> +	set_page_dirty_lock(page);
> +
> +	return 0;
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
> +	 * explicitly specify one.
>  	 */
> -	if (!features_enabled(ARCH_SHSTK_SHSTK))
> +	if (!features_enabled(ARCH_SHSTK_SHSTK)) {
> +		if (args->shadow_stack_token)
> +			return (unsigned long)ERR_PTR(-EINVAL);
> +
>  		return 0;
> +	}
> +
> +	/*
> +	 * If the user specified a shadow stack then use it, otherwise
> +	 * fall back to a default allocation strategy. Validation is
> +	 * done in arch_shstk_validate_clone().
> +	 */
> +	if (args->shadow_stack_token) {
> +		shstk->base = 0;
> +		shstk->size = 0;
> +		return args->shadow_stack_token + 8;
> +	}
>  
>  	/*
>  	 * For CLONE_VFORK the child will share the parents shadow stack.
> @@ -222,7 +265,7 @@ unsigned long shstk_alloc_thread_stack(struct task_struct *tsk, unsigned long cl
>  	if (!(clone_flags & CLONE_VM))
>  		return 0;
>  
> -	size = adjust_shstk_size(stack_size);
> +	size = adjust_shstk_size(args->stack_size);
>  	addr = alloc_shstk(0, size, 0, false);
>  	if (IS_ERR_VALUE(addr))
>  		return addr;
> diff --git a/include/asm-generic/cacheflush.h b/include/asm-generic/cacheflush.h
> index 7ee8a179d103..96cc0c7a5c90 100644
> --- a/include/asm-generic/cacheflush.h
> +++ b/include/asm-generic/cacheflush.h
> @@ -124,4 +124,15 @@ static inline void flush_cache_vunmap(unsigned long start, unsigned long end)
>  	} while (0)
>  #endif
>  
> +#ifndef cmpxchg_to_user_page
> +#define cmpxchg_to_user_page(vma, page, vaddr, ptr, old, new)  \
> +({							  \
> +	bool ret;						  \
> +								  \
> +	ret = try_cmpxchg(ptr, &old, new);			  \
> +	flush_icache_user_page(vma, page, vaddr, sizeof(*ptr));	  \
> +	ret;							  \
> +})
> +#endif
> +
>  #endif /* _ASM_GENERIC_CACHEFLUSH_H */
> diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
> index ea41795a352b..b501f752fc9a 100644
> --- a/include/linux/sched/task.h
> +++ b/include/linux/sched/task.h
> @@ -16,6 +16,7 @@ struct task_struct;
>  struct rusage;
>  union thread_union;
>  struct css_set;
> +struct vm_area_struct;
>  
>  /* All the bits taken by the old clone syscall. */
>  #define CLONE_LEGACY_FLAGS 0xffffffffULL
> @@ -44,6 +45,7 @@ struct kernel_clone_args {
>  	struct cgroup *cgrp;
>  	struct css_set *cset;
>  	unsigned int kill_seq;
> +	unsigned long shadow_stack_token;
>  };
>  
>  /*
> @@ -226,4 +228,19 @@ static inline void task_unlock(struct task_struct *p)
>  
>  DEFINE_GUARD(task_lock, struct task_struct *, task_lock(_T), task_unlock(_T))
>  
> +#ifdef CONFIG_ARCH_HAS_USER_SHADOW_STACK
> +int arch_shstk_validate_clone(struct task_struct *p,
> +			      struct vm_area_struct *vma,
> +			      struct page *page,
> +			      struct kernel_clone_args *args);
> +#else
> +static inline int arch_shstk_validate_clone(struct task_struct *p,
> +					    struct vm_area_struct *vma,
> +					    struct page *page,
> +					    struct kernel_clone_args *args)
> +{
> +	return 0;
> +}
> +#endif
> +
>  #endif /* _LINUX_SCHED_TASK_H */
> diff --git a/include/uapi/linux/sched.h b/include/uapi/linux/sched.h
> index 359a14cc76a4..9cf5c419e109 100644
> --- a/include/uapi/linux/sched.h
> +++ b/include/uapi/linux/sched.h
> @@ -84,6 +84,7 @@
>   *                kernel's limit of nested PID namespaces.
>   * @cgroup:       If CLONE_INTO_CGROUP is specified set this to
>   *                a file descriptor for the cgroup.
> + * @shadow_stack_token: Pointer to shadow stack token at top of stack.
>   *
>   * The structure is versioned by size and thus extensible.
>   * New struct members must go at the end of the struct and
> @@ -101,12 +102,14 @@ struct clone_args {
>  	__aligned_u64 set_tid;
>  	__aligned_u64 set_tid_size;
>  	__aligned_u64 cgroup;
> +	__aligned_u64 shadow_stack_token;
>  };
>  #endif
>  
> -#define CLONE_ARGS_SIZE_VER0 64 /* sizeof first published struct */
> -#define CLONE_ARGS_SIZE_VER1 80 /* sizeof second published struct */
> -#define CLONE_ARGS_SIZE_VER2 88 /* sizeof third published struct */
> +#define CLONE_ARGS_SIZE_VER0  64 /* sizeof first published struct */
> +#define CLONE_ARGS_SIZE_VER1  80 /* sizeof second published struct */
> +#define CLONE_ARGS_SIZE_VER2  88 /* sizeof third published struct */
> +#define CLONE_ARGS_SIZE_VER3  96 /* sizeof fourth published struct */
>  
>  /*
>   * Scheduling policies
> diff --git a/kernel/fork.c b/kernel/fork.c
> index af673856499d..d484ebeded33 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -1907,6 +1907,51 @@ static bool need_futex_hash_allocate_default(u64 clone_flags)
>  	return true;
>  }
>  
> +static int shstk_validate_clone(struct task_struct *p,
> +				struct kernel_clone_args *args)
> +{
> +	struct mm_struct *mm;
> +	struct vm_area_struct *vma;
> +	struct page *page;
> +	unsigned long addr;
> +	int ret;
> +
> +	if (!IS_ENABLED(CONFIG_ARCH_HAS_USER_SHADOW_STACK))
> +		return 0;
> +
> +	if (!args->shadow_stack_token)
> +		return 0;
> +
> +	mm = get_task_mm(p);
> +	if (!mm)
> +		return -EFAULT;
> +
> +	mmap_read_lock(mm);
> +
> +	addr = untagged_addr_remote(mm, args->shadow_stack_token);
> +	page = get_user_page_vma_remote(mm, addr, FOLL_FORCE | FOLL_WRITE,
> +					&vma);
> +	if (IS_ERR(page)) {
> +		ret = -EFAULT;
> +		goto out;
> +	}
> +
> +	if (!(vma->vm_flags & VM_SHADOW_STACK) ||
> +	    !(vma->vm_flags & VM_WRITE)) {
> +		ret = -EFAULT;
> +		goto out_page;
> +	}
> +
> +	ret = arch_shstk_validate_clone(p, vma, page, args);
> +
> +out_page:
> +	put_page(page);
> +out:
> +	mmap_read_unlock(mm);
> +	mmput(mm);
> +	return ret;
> +}
> +
>  /*
>   * This creates a new process as a copy of the old one,
>   * but does not actually start it yet.
> @@ -2182,6 +2227,9 @@ __latent_entropy struct task_struct *copy_process(
>  	if (retval)
>  		goto bad_fork_cleanup_namespaces;
>  	retval = copy_thread(p, args);
> +	if (retval)
> +		goto bad_fork_cleanup_io;
> +	retval = shstk_validate_clone(p, args);
>  	if (retval)
>  		goto bad_fork_cleanup_io;
>  
> @@ -2763,7 +2811,9 @@ static noinline int copy_clone_args_from_user(struct kernel_clone_args *kargs,
>  		     CLONE_ARGS_SIZE_VER1);
>  	BUILD_BUG_ON(offsetofend(struct clone_args, cgroup) !=
>  		     CLONE_ARGS_SIZE_VER2);
> -	BUILD_BUG_ON(sizeof(struct clone_args) != CLONE_ARGS_SIZE_VER2);
> +	BUILD_BUG_ON(offsetofend(struct clone_args, shadow_stack_token) !=
> +		     CLONE_ARGS_SIZE_VER3);
> +	BUILD_BUG_ON(sizeof(struct clone_args) != CLONE_ARGS_SIZE_VER3);
>  
>  	if (unlikely(usize > PAGE_SIZE))
>  		return -E2BIG;
> @@ -2796,16 +2846,17 @@ static noinline int copy_clone_args_from_user(struct kernel_clone_args *kargs,
>  		return -EINVAL;
>  
>  	*kargs = (struct kernel_clone_args){
> -		.flags		= args.flags,
> -		.pidfd		= u64_to_user_ptr(args.pidfd),
> -		.child_tid	= u64_to_user_ptr(args.child_tid),
> -		.parent_tid	= u64_to_user_ptr(args.parent_tid),
> -		.exit_signal	= args.exit_signal,
> -		.stack		= args.stack,
> -		.stack_size	= args.stack_size,
> -		.tls		= args.tls,
> -		.set_tid_size	= args.set_tid_size,
> -		.cgroup		= args.cgroup,
> +		.flags			= args.flags,
> +		.pidfd			= u64_to_user_ptr(args.pidfd),
> +		.child_tid		= u64_to_user_ptr(args.child_tid),
> +		.parent_tid		= u64_to_user_ptr(args.parent_tid),
> +		.exit_signal		= args.exit_signal,
> +		.stack			= args.stack,
> +		.stack_size		= args.stack_size,
> +		.tls			= args.tls,
> +		.set_tid_size		= args.set_tid_size,
> +		.cgroup			= args.cgroup,
> +		.shadow_stack_token	= args.shadow_stack_token,

I'm not sure why this has to be named "shadow_stack_token" I think
that's just confusing and we should just call it "shadow_stack" and be
done with it. It's also a bit long of a field name imho.

I have a kernel-6.18.clone3 branch
https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git/log/?h=kernel-6.18.clone3
because there's another cross-arch cleanup that cleans up copy_thread(),
copy_sighand(), and copy_process() and - surprisingly - also adds
clone3() support for nios2...

Anyway, if you just want me to slap it on top of that branch then I can
simply rename while applying so no need to resend in that case.

>  	};
>  
>  	if (args.set_tid &&
> @@ -2846,6 +2897,24 @@ static inline bool clone3_stack_valid(struct kernel_clone_args *kargs)
>  	return true;
>  }
>  
> +/**
> + * clone3_shadow_stack_valid - check and prepare shadow stack
> + * @kargs: kernel clone args
> + *
> + * Verify that shadow stacks are only enabled if supported.
> + */
> +static inline bool clone3_shadow_stack_valid(struct kernel_clone_args *kargs)
> +{
> +	if (!kargs->shadow_stack_token)
> +		return true;
> +
> +	if (!IS_ALIGNED(kargs->shadow_stack_token, sizeof(void *)))
> +		return false;
> +
> +	/* Fail if the kernel wasn't built with shadow stacks */
> +	return IS_ENABLED(CONFIG_ARCH_HAS_USER_SHADOW_STACK);
> +}
> +
>  static bool clone3_args_valid(struct kernel_clone_args *kargs)
>  {
>  	/* Verify that no unknown flags are passed along. */
> @@ -2868,7 +2937,7 @@ static bool clone3_args_valid(struct kernel_clone_args *kargs)
>  	    kargs->exit_signal)
>  		return false;
>  
> -	if (!clone3_stack_valid(kargs))
> +	if (!clone3_stack_valid(kargs) || !clone3_shadow_stack_valid(kargs))
>  		return false;
>  
>  	return true;
> 
> -- 
> 2.39.5
> 

