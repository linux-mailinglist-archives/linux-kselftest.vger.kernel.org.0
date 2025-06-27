Return-Path: <linux-kselftest+bounces-35986-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94090AEBE5B
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Jun 2025 19:19:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D9AF7AE1A9
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Jun 2025 17:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FAB31DF244;
	Fri, 27 Jun 2025 17:19:42 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DE911A5B86;
	Fri, 27 Jun 2025 17:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751044782; cv=none; b=R+hHD0OUc+m8CXC+Odz93pjNZxHM/YFllXg71ZswcCTQDPhqJeSXVwQ3SI0TmtwB/3fgKz2+QpfSNozC1P20GT9M4er/jkhecT1CzRO6/LaNACv5BB3pH6r4IAxYbrLr+uVL7F7HKi1BBBjGw/ZnBPSzkQCEV6i+X63/mBRkVTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751044782; c=relaxed/simple;
	bh=rCcbxMhqpoQ6osINMU5jCxlvC/HTzhRZbLAl8Q/QT3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YNgzAlJw3axPrtLAPqpsWwx3MsUd9tjIuNRNFlQloS5f3/oQPCOjOgX3u7WUIJbI90NvF0ekHV+mzCFn0MJ8HgRJLiIdvLr9mefgh8bxyv8+CxymTEJUq72uR/rH7ludQ/YQwQAgcnjQDPp/azMF9tuBDAFuCTu6dDW+pHq9iAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8082C4CEE3;
	Fri, 27 Jun 2025 17:19:35 +0000 (UTC)
Date: Fri, 27 Jun 2025 18:19:33 +0100
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
	Yury Khrustalev <yury.khrustalev@arm.com>,
	Wilco Dijkstra <wilco.dijkstra@arm.com>,
	linux-kselftest@vger.kernel.org, linux-api@vger.kernel.org,
	Kees Cook <kees@kernel.org>
Subject: Re: [PATCH RFT v17 4/8] fork: Add shadow stack support to clone3()
Message-ID: <aF7SpWSKfjEFTHBk@arm.com>
References: <20250609-clone3-shadow-stack-v17-0-8840ed97ff6f@kernel.org>
 <20250609-clone3-shadow-stack-v17-4-8840ed97ff6f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250609-clone3-shadow-stack-v17-4-8840ed97ff6f@kernel.org>
X-TUID: NZDNe86Lhaxu

On Mon, Jun 09, 2025 at 01:54:05PM +0100, Mark Brown wrote:
> +int arch_shstk_validate_clone(struct task_struct *tsk,
> +			      struct vm_area_struct *vma,
> +			      struct page *page,
> +			      struct kernel_clone_args *args)
> +{
> +	unsigned long gcspr_el0;
> +	int ret = 0;
> +
> +	/* Ensure that a token written as a result of a pivot is visible */
> +	gcsb_dsync();
> +	gcspr_el0 = args->shadow_stack_token;
> +	if (!gcs_consume_token(vma, page, gcspr_el0))
> +		return -EINVAL;
> +
> +	tsk->thread.gcspr_el0 = gcspr_el0 + sizeof(u64);
> +
> +	/* Ensure that our token consumption visible */
> +	gcsb_dsync();
> +
> +	return ret;
> +}

What are the scenarios where we need the barriers? We have one via
map_shadow_stack() that would cover the first one. IIUC, GCSSS2 also
generates a GCSB event (or maybe I got it all wrong; I need to read the
spec).

> diff --git a/kernel/fork.c b/kernel/fork.c
> index 1ee8eb11f38b..89c19996235d 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -1902,6 +1902,51 @@ static bool need_futex_hash_allocate_default(u64 clone_flags)
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

I think down the line, get_user_page_vma_remote() already does an
untagged_addr_remote(). But it does it after the vma look-up, so we
still need the untagging early.

That said, would we ever allowed a tagged pointer for the shadow stack?

> @@ -2840,6 +2891,27 @@ static inline bool clone3_stack_valid(struct kernel_clone_args *kargs)
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
> +	/*
> +	 * The architecture must check support on the specific
> +	 * machine.
> +	 */
> +	return IS_ENABLED(CONFIG_ARCH_HAS_USER_SHADOW_STACK);

I don't understand the comment here. It implies some kind of fallback
for further arch checks but it's just a return.

BTW, clone3_stack_valid() has an access_ok() check as well. Shall we add
it here? That's where the size would have come in handy but IIUC the
decision was to drop it (fine by me, just validate that the token is
accessible).

-- 
Catalin

