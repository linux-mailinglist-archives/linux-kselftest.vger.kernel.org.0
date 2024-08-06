Return-Path: <linux-kselftest+bounces-14888-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E7D7949A58
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Aug 2024 23:43:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E126B2839EF
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Aug 2024 21:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D2F916A94B;
	Tue,  6 Aug 2024 21:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DJj6fYZH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC22149C74;
	Tue,  6 Aug 2024 21:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722980603; cv=none; b=LMrRo+UciaCkQyNhyuDiovPGoQ8A8OoDjc+Eq9lxtpVEE/bko5QG4oOgRW+S/mjuARfBtsiVzcU7Qd5I1oPb8NQd81Wk1G+bB+KltZI14k+BaKkcaOORzQ4+jQH1+o9hd1sWgyP91bP2JF6k8ybTFmrPt7ufFJ3jZ66QTRttQSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722980603; c=relaxed/simple;
	bh=ZGkkvxdzIsgtwHZd32zcWU29Y4Hg+7l4aRKBuBmrEs8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jalGHuAA6TzpOy5NTfaoii0LMghB/2kXElHeyk5g+mdikNuOFrhDh5sBNka0LC+fuHvEBPUtMTLfA6OOOOwyLSYDYBYpBii/KLmKDXdwn8/QtvyAkTUJFfO4uZNA4pbWeitO4z5njZw6rKO4qVRIfS9qhsjKisuw7rCg7VEso3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DJj6fYZH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1EB7C32786;
	Tue,  6 Aug 2024 21:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722980603;
	bh=ZGkkvxdzIsgtwHZd32zcWU29Y4Hg+7l4aRKBuBmrEs8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DJj6fYZHnNcB0wDMLUpKRx/5yAIa6IEavtlewKA4HrplCIcF+C33AG1uE2ftedYGi
	 CrH+O96GjHIkYLKv2ocexgEPOGI7obhwnF7cOGET9kahd3cbm+4KiXqNG6lLfFyb9r
	 e6Ch16eSS+DVbCSBsbLPGdM8zomYACAOGsfzP6i4XKL6fQQ2BkyUH3Y6rL3eqIZCPq
	 6GwCfF/fKtlvKGO7khVBKGPXzdQ6HYPSDkE3+0Wo5D+LTUCW98X0TLvMPg5Aod2eiY
	 mYeDUp9tHFaLirXaAobY514UX5sYlvk8Vib/jnXIiIixjmbr+SlDgs1GVsU4PVzljL
	 YiY9kfAVhOkjQ==
Date: Tue, 6 Aug 2024 14:43:22 -0700
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
Message-ID: <202408061434.1B746423@keescook>
References: <20240731-clone3-shadow-stack-v7-0-a9532eebfb1d@kernel.org>
 <20240731-clone3-shadow-stack-v7-9-a9532eebfb1d@kernel.org>
 <202408052046.00BC7CBC@keescook>
 <b172c2c1-42d3-4c50-8065-9bd4ae21ffea@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b172c2c1-42d3-4c50-8065-9bd4ae21ffea@sirena.org.uk>

On Tue, Aug 06, 2024 at 09:10:28PM +0100, Mark Brown wrote:
> On Mon, Aug 05, 2024 at 08:54:54PM -0700, Kees Cook wrote:
> 
> >   # Running test 'Shadow stack on system with shadow stack'
> >   # [5496] Trying clone3() with flags 0 (size 0)
> >   # I am the parent (5496). My child's pid is 5505
> >   # Child exited with signal 11
> >   # [5496] clone3() with flags says: 11 expected 0
> >   # [5496] Result (11) is different than expected (0)
> >   not ok 20 Shadow stack on system with shadow stack
> 
> > The child segfaults immediately, it seems?
> 
> Does this help:
> 
> diff --git a/arch/x86/kernel/shstk.c b/arch/x86/kernel/shstk.c
> index 1755fa21e6fb..27acbdf44c5f 100644
> --- a/arch/x86/kernel/shstk.c
> +++ b/arch/x86/kernel/shstk.c
> @@ -198,13 +198,14 @@ int arch_shstk_post_fork(struct task_struct *t, struct kernel_clone_args *args)
>  	 * the token 64-bit.
>  	 */
>  	struct mm_struct *mm;
> -	unsigned long addr;
> +	unsigned long addr, ssp;
>  	u64 expected;
>  	u64 val;
> -	int ret = -EINVAL;;
> +	int ret = -EINVAL;
>  
> -	addr = args->shadow_stack + args->shadow_stack_size - sizeof(u64);
> -	expected = (addr - SS_FRAME_SIZE) | BIT(0);
> +	ssp = args->shadow_stack + args->shadow_stack_size;
> +	addr = ssp - SS_FRAME_SIZE;
> +	expected = ssp | BIT(0);
>  
>  	mm = get_task_mm(t);
>  	if (!mm)

Yes indeed! This passes now.

"Shadow stack with no token" still crashes the parent. It seems to
crash in waitpid(). Under gdb it hangs instead, showing it's in glibc's
__GI___wait4(). Ah, it's crashing at c3 (ret), so shadow stack problem,
I imagine.

Does waitpid() need to be open-coded like the clone3() call too?

-- 
Kees Cook

