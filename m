Return-Path: <linux-kselftest+bounces-474-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F8B47F5C47
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Nov 2023 11:29:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DC7E1C20CAD
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Nov 2023 10:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30298224F2;
	Thu, 23 Nov 2023 10:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WoXweuAQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C568224C2;
	Thu, 23 Nov 2023 10:28:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A234DC433C7;
	Thu, 23 Nov 2023 10:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700735337;
	bh=YhnOgKb2HAgfRZJlLItv/GqeZsKs3OM8UHl1ijMKxjM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WoXweuAQESjvyceY8KEXy9vCgVDJkmCItfhpir1XxYQcnSSejtSjt13FT3Convr5U
	 ONbXwgvG73PvCRDQ1IMXL7tFGiL1eMSucELyRykTDVB/b2YPZnUesA9rIP6PwTVYQn
	 CoE+cpRlX29/eUf0oOIQeEEaOVKNWXX2XaSYtgl3S9E1G/bSsC8C5nRgULd0/Pc2Xh
	 nLfNaZFeALOnbTOOV6YyihvwNox5lHj8nlj/uEicsDm8TcAeSpRU+uoYgnylZmUPdE
	 j7RAdjICN0gKyZKWhki8TLcmNct8xSSWUZEnY0P642dS6l2S1e+/7leDr8y3gQF1yp
	 cDWcg8BfeBxcQ==
Date: Thu, 23 Nov 2023 11:28:47 +0100
From: Christian Brauner <brauner@kernel.org>
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
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Kees Cook <keescook@chromium.org>,
	jannh@google.com, linux-kselftest@vger.kernel.org,
	linux-api@vger.kernel.org
Subject: Re: [PATCH RFT v3 2/5] fork: Add shadow stack support to clone3()
Message-ID: <20231123-derivate-freikarte-6de8984caf85@brauner>
References: <20231120-clone3-shadow-stack-v3-0-a7b8ed3e2acc@kernel.org>
 <20231120-clone3-shadow-stack-v3-2-a7b8ed3e2acc@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231120-clone3-shadow-stack-v3-2-a7b8ed3e2acc@kernel.org>

On Mon, Nov 20, 2023 at 11:54:30PM +0000, Mark Brown wrote:
> Unlike with the normal stack there is no API for configuring the the shadow
> stack for a new thread, instead the kernel will dynamically allocate a new
> shadow stack with the same size as the normal stack. This appears to be due
> to the shadow stack series having been in development since before the more
> extensible clone3() was added rather than anything more deliberate.
> 
> Add a parameter to clone3() specifying the size of a shadow stack for
> the newly created process.  If no shadow stack is specified then the
> existing implicit allocation behaviour is maintained.
> 
> If the architecture does not support shadow stacks the shadow stack size
> parameter must be zero, architectures that do support the feature are
> expected to enforce the same requirement on individual systems that lack
> shadow stack support.
> 
> Update the existing x86 implementation to pay attention to the newly added
> arguments, in order to maintain compatibility we use the existing behaviour
> if no shadow stack is specified. Minimal validation is done of the supplied
> parameters, detailed enforcement is left to when the thread is executed.
> Since we are now using more fields from the kernel_clone_args we pass that
> into the shadow stack code rather than individual fields.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  arch/x86/include/asm/shstk.h | 11 ++++++---
>  arch/x86/kernel/process.c    |  2 +-
>  arch/x86/kernel/shstk.c      | 59 ++++++++++++++++++++++++++++++--------------
>  include/linux/sched/task.h   |  1 +
>  include/uapi/linux/sched.h   |  4 +++
>  kernel/fork.c                | 22 +++++++++++++++--
>  6 files changed, 74 insertions(+), 25 deletions(-)
> 
> diff --git a/arch/x86/include/asm/shstk.h b/arch/x86/include/asm/shstk.h
> index 42fee8959df7..8be7b0a909c3 100644
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
> @@ -26,8 +27,10 @@ static inline long shstk_prctl(struct task_struct *task, int option,
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
> index b6f4e8399fca..a9ca80ea5056 100644
> --- a/arch/x86/kernel/process.c
> +++ b/arch/x86/kernel/process.c
> @@ -207,7 +207,7 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
>  	 * is disabled, new_ssp will remain 0, and fpu_clone() will know not to
>  	 * update it.
>  	 */
> -	new_ssp = shstk_alloc_thread_stack(p, clone_flags, args->stack_size);
> +	new_ssp = shstk_alloc_thread_stack(p, args);
>  	if (IS_ERR_VALUE(new_ssp))
>  		return PTR_ERR((void *)new_ssp);
>  
> diff --git a/arch/x86/kernel/shstk.c b/arch/x86/kernel/shstk.c
> index 59e15dd8d0f8..a14f47d70dfb 100644
> --- a/arch/x86/kernel/shstk.c
> +++ b/arch/x86/kernel/shstk.c
> @@ -191,38 +191,61 @@ void reset_thread_features(void)
>  	current->thread.features_locked = 0;
>  }
>  
> -unsigned long shstk_alloc_thread_stack(struct task_struct *tsk, unsigned long clone_flags,
> -				       unsigned long stack_size)
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
>  	 */
> -	if (!features_enabled(ARCH_SHSTK_SHSTK))
> -		return 0;
> +	if (!features_enabled(ARCH_SHSTK_SHSTK)) {
> +		if (args->shadow_stack_size)
> +			return (unsigned long)ERR_PTR(-EINVAL);
>  
> -	/*
> -	 * For CLONE_VFORK the child will share the parents shadow stack.
> -	 * Make sure to clear the internal tracking of the thread shadow
> -	 * stack so the freeing logic run for child knows to leave it alone.
> -	 */
> -	if (clone_flags & CLONE_VFORK) {
> -		shstk->base = 0;
> -		shstk->size = 0;
>  		return 0;
>  	}
>  
>  	/*
> -	 * For !CLONE_VM the child will use a copy of the parents shadow
> -	 * stack.
> +	 * If the user specified a shadow stack then do some basic
> +	 * validation and use it, otherwise fall back to a default
> +	 * shadow stack size if the clone_flags don't indicate an
> +	 * allocation is unneeded.
>  	 */
> -	if (!(clone_flags & CLONE_VM))
> -		return 0;
> +	if (args->shadow_stack_size) {
> +		size = args->shadow_stack_size;
> +
> +		if (size < 8)
> +			return (unsigned long)ERR_PTR(-EINVAL);

It would probably be useful to add a
#define SHADOW_STACK_SIZE_MIN 8
instead of a raw number here.

Any reasonably maximum that should be assumed here? IOW, what happens if
userspace starts specifying 4G shadow_stack_size with each clone3() call
for lolz?

And I think we should move the shadow_stack_size validation into
clone3_shadow_stack_valid() instead of having each architecture do it's
own thing in their own handler. IOW, share as much common code as
possible. Another reason to wait for that arm support to land...

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

Why is the CLONE_VFORK handling only necessary if shadow_stack_size is
unset? In general, a comment or explanation on the interaction between
CLONE_VFORK and shadow_stack_size would be helpful.

> +
> +		/*
> +		 * For !CLONE_VM the child will use a copy of the
> +		 * parents shadow stack.
> +		 */
> +		if (!(clone_flags & CLONE_VM))
> +			return 0;
> +
> +		size = args->stack_size;
> +
> +	}
>  
> -	size = adjust_shstk_size(stack_size);
> +	size = adjust_shstk_size(size);
>  	addr = alloc_shstk(0, size, 0, false);
>  	if (IS_ERR_VALUE(addr))
>  		return addr;
> diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
> index a23af225c898..e86a09cfccd8 100644
> --- a/include/linux/sched/task.h
> +++ b/include/linux/sched/task.h
> @@ -41,6 +41,7 @@ struct kernel_clone_args {
>  	void *fn_arg;
>  	struct cgroup *cgrp;
>  	struct css_set *cset;
> +	unsigned long shadow_stack_size;
>  };
>  
>  /*
> diff --git a/include/uapi/linux/sched.h b/include/uapi/linux/sched.h
> index 3bac0a8ceab2..a998b6d0c897 100644
> --- a/include/uapi/linux/sched.h
> +++ b/include/uapi/linux/sched.h
> @@ -84,6 +84,8 @@
>   *                kernel's limit of nested PID namespaces.
>   * @cgroup:       If CLONE_INTO_CGROUP is specified set this to
>   *                a file descriptor for the cgroup.
> + * @shadow_stack_size: Specify the size of the shadow stack to allocate
> + *                     for the child process.
>   *
>   * The structure is versioned by size and thus extensible.
>   * New struct members must go at the end of the struct and
> @@ -101,12 +103,14 @@ struct clone_args {
>  	__aligned_u64 set_tid;
>  	__aligned_u64 set_tid_size;
>  	__aligned_u64 cgroup;
> +	__aligned_u64 shadow_stack_size;
>  };
>  #endif
>  
>  #define CLONE_ARGS_SIZE_VER0 64 /* sizeof first published struct */
>  #define CLONE_ARGS_SIZE_VER1 80 /* sizeof second published struct */
>  #define CLONE_ARGS_SIZE_VER2 88 /* sizeof third published struct */
> +#define CLONE_ARGS_SIZE_VER3 96 /* sizeof fourth published struct */
>  
>  /*
>   * Scheduling policies
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 10917c3e1f03..b8ca8194bca5 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -3067,7 +3067,9 @@ noinline static int copy_clone_args_from_user(struct kernel_clone_args *kargs,
>  		     CLONE_ARGS_SIZE_VER1);
>  	BUILD_BUG_ON(offsetofend(struct clone_args, cgroup) !=
>  		     CLONE_ARGS_SIZE_VER2);
> -	BUILD_BUG_ON(sizeof(struct clone_args) != CLONE_ARGS_SIZE_VER2);
> +	BUILD_BUG_ON(offsetofend(struct clone_args, shadow_stack_size) !=
> +		     CLONE_ARGS_SIZE_VER3);
> +	BUILD_BUG_ON(sizeof(struct clone_args) != CLONE_ARGS_SIZE_VER3);
>  
>  	if (unlikely(usize > PAGE_SIZE))
>  		return -E2BIG;
> @@ -3110,6 +3112,7 @@ noinline static int copy_clone_args_from_user(struct kernel_clone_args *kargs,
>  		.tls		= args.tls,
>  		.set_tid_size	= args.set_tid_size,
>  		.cgroup		= args.cgroup,
> +		.shadow_stack_size	= args.shadow_stack_size,

Mild personal ocd: Can you keep the all aligned, please?

>  	};
>  
>  	if (args.set_tid &&
> @@ -3150,6 +3153,21 @@ static inline bool clone3_stack_valid(struct kernel_clone_args *kargs)
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
> +	if (!kargs->shadow_stack_size)
> +		return true;
> +
> +	/* The architecture must check support on the specific machine */
> +	return IS_ENABLED(CONFIG_ARCH_HAS_USER_SHADOW_STACK);
> +}
> +
>  static bool clone3_args_valid(struct kernel_clone_args *kargs)
>  {
>  	/* Verify that no unknown flags are passed along. */
> @@ -3172,7 +3190,7 @@ static bool clone3_args_valid(struct kernel_clone_args *kargs)
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
> 2.30.2
> 

