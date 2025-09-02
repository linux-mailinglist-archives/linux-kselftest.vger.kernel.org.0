Return-Path: <linux-kselftest+bounces-40650-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E575DB40EF2
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 23:02:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8292E1B6453C
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 21:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AD5F2DECB4;
	Tue,  2 Sep 2025 21:02:18 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC5017993;
	Tue,  2 Sep 2025 21:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756846937; cv=none; b=C9E6ekomjSL/sYPZVJBUHWVY/RJ5GlD/LvYtNCAwcyeJreyXlPsgkfD2cBSifrUCqCguRlla8LilKSfQ7qXhkHe36rPKaVhjGqnOSDBnpX3RH17Z33BXX5P9bSLNu5OxbxEOxANtEYgiStD5PxVMe9dRngO1hWe6/sX6Bh6tBfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756846937; c=relaxed/simple;
	bh=bTvqiSjrm36IbSFYAuBFQVu2vRcyjUYrcLKgnn8/J0I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=raP8qISqJlrKq4MRTyoGqOCFPSftIaAO8hcbPD8Vz15RB4SpejR7L9acBPkXcvoMlMG2+x6AIZDsIXW46I7fFxf1peImo9zt53qmnrkOLkTeqDV1R6NqaOWOYDZd5w+E4dgyeGYAWutqKgzGR/gxrSXyPnHo8N85jMdgITUXOcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FEEFC4CEED;
	Tue,  2 Sep 2025 21:02:10 +0000 (UTC)
Date: Tue, 2 Sep 2025 22:02:07 +0100
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
	Andrew Morton <akpm@linux-foundation.org>,
	Yury Khrustalev <yury.khrustalev@arm.com>,
	Wilco Dijkstra <wilco.dijkstra@arm.com>,
	linux-kselftest@vger.kernel.org, linux-api@vger.kernel.org,
	Kees Cook <kees@kernel.org>
Subject: Re: [PATCH v20 4/8] fork: Add shadow stack support to clone3()
Message-ID: <aLdbT67auUpaOj2T@arm.com>
References: <20250902-clone3-shadow-stack-v20-0-4d9fff1c53e7@kernel.org>
 <20250902-clone3-shadow-stack-v20-4-4d9fff1c53e7@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250902-clone3-shadow-stack-v20-4-4d9fff1c53e7@kernel.org>

On Tue, Sep 02, 2025 at 11:21:48AM +0100, Mark Brown wrote:
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

In theory, I don't think we need the get_task_mm() -> mmget() since
copy_mm() early on already did this and the task can't disappear from
underneath while we are creating it.

> +
> +	mmap_read_lock(mm);
> +
> +	addr = untagged_addr_remote(mm, args->shadow_stack_token);
> +	page = get_user_page_vma_remote(mm, addr, FOLL_FORCE | FOLL_WRITE,
> +					&vma);

However, I wonder whether it makes sense to use the remote mm access
here at all. Does this code ever run without CLONE_VM? If not, this is
all done within the current mm context.

I can see the x86 shstk_alloc_thread_stack() returns early if !CLONE_VM.
Similarly on arm64. I think the behaviour is preserved with this series
but I'm not entirely sure from the contextual diff (I need to apply the
patches locally).

Otherwise the patch looks fine (well, even the above wouldn't fail, I
just find it strange that we pretend it's a remote mm but on the default
allocation path like alloc_gcs() we go for current->mm).


BTW, if you repost, it might be worth cross-posting to linux-arm-kernel
for wider exposure as not everyone reads LKML (and you can drop
Szabolcs, his arm address is no longer valid).

-- 
Catalin

