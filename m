Return-Path: <linux-kselftest+bounces-752-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4BE27FC7DC
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Nov 2023 22:24:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2302FB20EA3
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Nov 2023 21:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A2EA42A95;
	Tue, 28 Nov 2023 21:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="q9PB9c8/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E07D84C25
	for <linux-kselftest@vger.kernel.org>; Tue, 28 Nov 2023 13:24:01 -0800 (PST)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-1fa1ec476f1so2407822fac.2
        for <linux-kselftest@vger.kernel.org>; Tue, 28 Nov 2023 13:24:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1701206641; x=1701811441; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4MY36XUOmXD7TRhzMNFRbou/xNiTRxYnsiuYoe/9vH0=;
        b=q9PB9c8/mS9Cqs/pqyS3Mh05czIr8dWMNvelOdhWC0oKKSPB220tpYEFocReSdKYk0
         Y6dfzGhKu8JhDabIpchhi/W3G8aG8/6fWPQucX5yTxhP3+t9f0bNL79dFwFK2POaqjJV
         3b2sEXrfNaaClwR8LlbJJBCv8qwB4jGEVZSEGcrzDIQ/WdZQg2baFFkzbP9bfqJDv3L/
         gc5tbFpxD0yK2Reh/k+TDpdfZYtsQ013FhTc5CR9LtDu02p3hbqE1vfQMOWRjlX+yPJM
         9XaDyUxhHGqH9zjn9yoslCkD6k5QRCbcpZnVoBR4pKCNjqVJ4FfptDrlkKpVtEkSpY/Y
         QB4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701206641; x=1701811441;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4MY36XUOmXD7TRhzMNFRbou/xNiTRxYnsiuYoe/9vH0=;
        b=r0W/edLy0G/CEeX9Gdz46EqK/WIrxB4zqFH0pg3syWREhZiAgi96pmWs9KlLQIXHI2
         f6viErNawQEpmbN0D45LnG98uaKQwZUTiZMQU8X7mDVbyV8ssr0iM1TwgtQRaHrCk1YJ
         OdX2A9SNyHxILK+Dy8HtTfDznjVnranlo1QNllNylU1Bw/N6UJR8inD7iJzdaBT0mKEZ
         ofB0hyUAH2r42qCMYWa2f6o9egXEiJVaQPdrPi6uwnNdIO9DiGbEhhKWsK274JB0kPoa
         ZxbVbftKFhxf0FZUpTB4C5oOCqqq97PVvtuRuxWPGzRx9ILJsKmyp6FxjlWZw2tsAGu4
         B7uQ==
X-Gm-Message-State: AOJu0Yx0fAYcdwA6R+4BoIZHOA6hDtNVt0avwEgbY9ehUvKtzGkTMHFA
	D72gqUwQ5JOb43U+7cjSPJhHyQ==
X-Google-Smtp-Source: AGHT+IHqcR9D9braDY0YWWAci7hQUd4tP4Ci6dTK2hgrx6ZnFoZpjFWTZRG+IihHEWJHVL4m2dMjFA==
X-Received: by 2002:a05:6871:4e46:b0:1f9:f527:8865 with SMTP id uj6-20020a0568714e4600b001f9f5278865mr18249736oab.52.1701206641031;
        Tue, 28 Nov 2023 13:24:01 -0800 (PST)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id lm24-20020a0568703d9800b001fa24002089sm2014044oab.30.2023.11.28.13.23.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 13:24:00 -0800 (PST)
Date: Tue, 28 Nov 2023 13:23:57 -0800
From: Deepak Gupta <debug@rivosinc.com>
To: Mark Brown <broonie@kernel.org>
Cc: "Rick P. Edgecombe" <rick.p.edgecombe@intel.com>,
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
	Christian Brauner <brauner@kernel.org>,
	Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Kees Cook <keescook@chromium.org>,
	jannh@google.com, linux-kselftest@vger.kernel.org,
	linux-api@vger.kernel.org
Subject: Re: [PATCH RFT v4 2/5] fork: Add shadow stack support to clone3()
Message-ID: <ZWZabbeK942FToNs@debug.ba.rivosinc.com>
References: <20231128-clone3-shadow-stack-v4-0-8b28ffe4f676@kernel.org>
 <20231128-clone3-shadow-stack-v4-2-8b28ffe4f676@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20231128-clone3-shadow-stack-v4-2-8b28ffe4f676@kernel.org>

On Tue, Nov 28, 2023 at 06:22:40PM +0000, Mark Brown wrote:
>Unlike with the normal stack there is no API for configuring the the shadow
>stack for a new thread, instead the kernel will dynamically allocate a new
>shadow stack with the same size as the normal stack. This appears to be due
>to the shadow stack series having been in development since before the more
>extensible clone3() was added rather than anything more deliberate.
>
>Add a parameter to clone3() specifying the size of a shadow stack for
>the newly created process.  If no shadow stack is specified then the
>existing implicit allocation behaviour is maintained.
>
>If the architecture does not support shadow stacks the shadow stack size
>parameter must be zero, architectures that do support the feature are
>expected to enforce the same requirement on individual systems that lack
>shadow stack support.
>
>Update the existing x86 implementation to pay attention to the newly added
>arguments, in order to maintain compatibility we use the existing behaviour
>if no shadow stack is specified. Minimal validation is done of the supplied
>parameters, detailed enforcement is left to when the thread is executed.
>Since we are now using more fields from the kernel_clone_args we pass that
>into the shadow stack code rather than individual fields.
>
>Signed-off-by: Mark Brown <broonie@kernel.org>
>---
> arch/x86/include/asm/shstk.h | 11 +++++----
> arch/x86/kernel/process.c    |  2 +-
> arch/x86/kernel/shstk.c      | 56 ++++++++++++++++++++++++++++++--------------
> include/linux/sched/task.h   |  1 +
> include/uapi/linux/sched.h   |  4 ++++
> kernel/fork.c                | 53 +++++++++++++++++++++++++++++++----------
> 6 files changed, 92 insertions(+), 35 deletions(-)
>
>diff --git a/arch/x86/include/asm/shstk.h b/arch/x86/include/asm/shstk.h
>index 42fee8959df7..8be7b0a909c3 100644
>--- a/arch/x86/include/asm/shstk.h
>+++ b/arch/x86/include/asm/shstk.h
>@@ -6,6 +6,7 @@
> #include <linux/types.h>
>
> struct task_struct;
>+struct kernel_clone_args;
> struct ksignal;
>
> #ifdef CONFIG_X86_USER_SHADOW_STACK
>@@ -16,8 +17,8 @@ struct thread_shstk {
>
> long shstk_prctl(struct task_struct *task, int option, unsigned long arg2);
> void reset_thread_features(void);
>-unsigned long shstk_alloc_thread_stack(struct task_struct *p, unsigned long clone_flags,
>-				       unsigned long stack_size);
>+unsigned long shstk_alloc_thread_stack(struct task_struct *p,
>+				       const struct kernel_clone_args *args);
> void shstk_free(struct task_struct *p);
> int setup_signal_shadow_stack(struct ksignal *ksig);
> int restore_signal_shadow_stack(void);
>@@ -26,8 +27,10 @@ static inline long shstk_prctl(struct task_struct *task, int option,
> 			       unsigned long arg2) { return -EINVAL; }
> static inline void reset_thread_features(void) {}
> static inline unsigned long shstk_alloc_thread_stack(struct task_struct *p,
>-						     unsigned long clone_flags,
>-						     unsigned long stack_size) { return 0; }
>+						     const struct kernel_clone_args *args)
>+{
>+	return 0;
>+}
> static inline void shstk_free(struct task_struct *p) {}
> static inline int setup_signal_shadow_stack(struct ksignal *ksig) { return 0; }
> static inline int restore_signal_shadow_stack(void) { return 0; }
>diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
>index b6f4e8399fca..a9ca80ea5056 100644
>--- a/arch/x86/kernel/process.c
>+++ b/arch/x86/kernel/process.c
>@@ -207,7 +207,7 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
> 	 * is disabled, new_ssp will remain 0, and fpu_clone() will know not to
> 	 * update it.
> 	 */
>-	new_ssp = shstk_alloc_thread_stack(p, clone_flags, args->stack_size);
>+	new_ssp = shstk_alloc_thread_stack(p, args);
> 	if (IS_ERR_VALUE(new_ssp))
> 		return PTR_ERR((void *)new_ssp);
>
>diff --git a/arch/x86/kernel/shstk.c b/arch/x86/kernel/shstk.c
>index 59e15dd8d0f8..0d1325d2d94a 100644
>--- a/arch/x86/kernel/shstk.c
>+++ b/arch/x86/kernel/shstk.c
>@@ -191,38 +191,58 @@ void reset_thread_features(void)
> 	current->thread.features_locked = 0;
> }
>
>-unsigned long shstk_alloc_thread_stack(struct task_struct *tsk, unsigned long clone_flags,
>-				       unsigned long stack_size)
>+unsigned long shstk_alloc_thread_stack(struct task_struct *tsk,
>+				       const struct kernel_clone_args *args)
> {
> 	struct thread_shstk *shstk = &tsk->thread.shstk;
>+	unsigned long clone_flags = args->flags;
> 	unsigned long addr, size;
>
> 	/*
> 	 * If shadow stack is not enabled on the new thread, skip any
>-	 * switch to a new shadow stack.
>+	 * implicit switch to a new shadow stack and reject attempts to
>+	 * explciitly specify one.
> 	 */
>-	if (!features_enabled(ARCH_SHSTK_SHSTK))
>-		return 0;
>+	if (!features_enabled(ARCH_SHSTK_SHSTK)) {
>+		if (args->shadow_stack_size)
>+			return (unsigned long)ERR_PTR(-EINVAL);
>
>-	/*
>-	 * For CLONE_VFORK the child will share the parents shadow stack.
>-	 * Make sure to clear the internal tracking of the thread shadow
>-	 * stack so the freeing logic run for child knows to leave it alone.
>-	 */
>-	if (clone_flags & CLONE_VFORK) {
>-		shstk->base = 0;
>-		shstk->size = 0;
> 		return 0;
> 	}
>
> 	/*
>-	 * For !CLONE_VM the child will use a copy of the parents shadow
>-	 * stack.
>+	 * If the user specified a shadow stack then do some basic
>+	 * validation and use it, otherwise fall back to a default
>+	 * shadow stack size if the clone_flags don't indicate an
>+	 * allocation is unneeded.
> 	 */
>-	if (!(clone_flags & CLONE_VM))
>-		return 0;
>+	if (args->shadow_stack_size) {
>+		size = args->shadow_stack_size;
>+	} else {
>+		/*
>+		 * For CLONE_VFORK the child will share the parents
>+		 * shadow stack.  Make sure to clear the internal
>+		 * tracking of the thread shadow stack so the freeing
>+		 * logic run for child knows to leave it alone.
>+		 */
>+		if (clone_flags & CLONE_VFORK) {
>+			shstk->base = 0;
>+			shstk->size = 0;
>+			return 0;
>+		}
>+
>+		/*
>+		 * For !CLONE_VM the child will use a copy of the
>+		 * parents shadow stack.
>+		 */
>+		if (!(clone_flags & CLONE_VM))
>+			return 0;
>+
>+		size = args->stack_size;
>+
>+	}
>
>-	size = adjust_shstk_size(stack_size);
>+	size = adjust_shstk_size(size);
> 	addr = alloc_shstk(0, size, 0, false);
> 	if (IS_ERR_VALUE(addr))
> 		return addr;
>diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
>index a23af225c898..e86a09cfccd8 100644
>--- a/include/linux/sched/task.h
>+++ b/include/linux/sched/task.h
>@@ -41,6 +41,7 @@ struct kernel_clone_args {
> 	void *fn_arg;
> 	struct cgroup *cgrp;
> 	struct css_set *cset;
>+	unsigned long shadow_stack_size;
> };
>
> /*
>diff --git a/include/uapi/linux/sched.h b/include/uapi/linux/sched.h
>index 3bac0a8ceab2..a998b6d0c897 100644
>--- a/include/uapi/linux/sched.h
>+++ b/include/uapi/linux/sched.h
>@@ -84,6 +84,8 @@
>  *                kernel's limit of nested PID namespaces.
>  * @cgroup:       If CLONE_INTO_CGROUP is specified set this to
>  *                a file descriptor for the cgroup.
>+ * @shadow_stack_size: Specify the size of the shadow stack to allocate
>+ *                     for the child process.
>  *
>  * The structure is versioned by size and thus extensible.
>  * New struct members must go at the end of the struct and
>@@ -101,12 +103,14 @@ struct clone_args {
> 	__aligned_u64 set_tid;
> 	__aligned_u64 set_tid_size;
> 	__aligned_u64 cgroup;
>+	__aligned_u64 shadow_stack_size;
> };
> #endif
>
> #define CLONE_ARGS_SIZE_VER0 64 /* sizeof first published struct */
> #define CLONE_ARGS_SIZE_VER1 80 /* sizeof second published struct */
> #define CLONE_ARGS_SIZE_VER2 88 /* sizeof third published struct */
>+#define CLONE_ARGS_SIZE_VER3 96 /* sizeof fourth published struct */
>
> /*
>  * Scheduling policies
>diff --git a/kernel/fork.c b/kernel/fork.c
>index 10917c3e1f03..35131acd43d2 100644
>--- a/kernel/fork.c
>+++ b/kernel/fork.c
>@@ -121,6 +121,11 @@
>  */
> #define MAX_THREADS FUTEX_TID_MASK
>
>+/*
>+ * Require that shadow stacks can store at least one element
>+ */
>+#define SHADOW_STACK_SIZE_MIN 8

nit:
Sorry, should've mentioned it earlier.
Can this be "#define SHADOW_STACK_SIZE_MIN sizeof(unsigned long)"


>+
> /*
>  * Protected counters by write_lock_irq(&tasklist_lock)
>  */
>@@ -3067,7 +3072,9 @@ noinline static int copy_clone_args_from_user(struct kernel_clone_args *kargs,
> 		     CLONE_ARGS_SIZE_VER1);
> 	BUILD_BUG_ON(offsetofend(struct clone_args, cgroup) !=
> 		     CLONE_ARGS_SIZE_VER2);
>-	BUILD_BUG_ON(sizeof(struct clone_args) != CLONE_ARGS_SIZE_VER2);

