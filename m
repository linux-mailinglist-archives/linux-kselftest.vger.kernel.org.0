Return-Path: <linux-kselftest+bounces-20554-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BEE669AEBBA
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Oct 2024 18:19:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E286E1C22814
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Oct 2024 16:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 896B71AB6CC;
	Thu, 24 Oct 2024 16:19:18 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FD891F5836
	for <linux-kselftest@vger.kernel.org>; Thu, 24 Oct 2024 16:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729786758; cv=none; b=jtNPmYFhUL1X375ZL59aXiiQCapj34cbPc6ffo0wsFxYdovRy46TjLioRURzNheoshEk7jbFPH8wwUDUwdATtwCp20mscxYICQoPx6n+jnYhKpJwI6KMVOvlDMHDg1d5rT+rp8rSECwl3t7W4mn8BkdJZ11m3rpjorYcAUoar2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729786758; c=relaxed/simple;
	bh=u5uC7qF0dq0wID+ajlzRnrBY1BxKs8ocJz9hz8WXcfo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qHiKgdkAiX4erzUmMN0CXvQBlS8pnGYCVXiG3u420FyngOBg2h6DfqCZi36nj+deFz7O//zk13xt3QplS/UAxOfmZALFh0vQVDckPGfilGDdolsXy4TGEo0EPmid2uq06LGoEJhQ/QbVc9Nortp90ytTxfGtivWea0q5yGKajpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 154F6339;
	Thu, 24 Oct 2024 09:19:44 -0700 (PDT)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.69])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 76A263F71E;
	Thu, 24 Oct 2024 09:19:12 -0700 (PDT)
Date: Thu, 24 Oct 2024 17:19:07 +0100
From: Dave Martin <Dave.Martin@arm.com>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Kevin Brodsky <kevin.brodsky@arm.com>,
	linux-arm-kernel@lists.infradead.org, akpm@linux-foundation.org,
	anshuman.khandual@arm.com, aruna.ramakrishna@oracle.com,
	broonie@kernel.org, dave.hansen@linux.intel.com,
	jeffxu@chromium.org, joey.gouly@arm.com, pierre.langlois@arm.com,
	shuah@kernel.org, sroettger@google.com, will@kernel.org,
	linux-kselftest@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH v2 3/5] arm64: signal: Improve POR_EL0 handling to avoid
 uaccess failures
Message-ID: <ZxpzexqNIfys3MnJ@e133380.arm.com>
References: <20241023150511.3923558-1-kevin.brodsky@arm.com>
 <20241023150511.3923558-4-kevin.brodsky@arm.com>
 <ZxoooqtuqTK5CAMR@arm.com>
 <80688edf-83dd-43c6-a1a8-b69acd30f5c3@arm.com>
 <Zxpq0k3b9q8nWrYa@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zxpq0k3b9q8nWrYa@arm.com>

On Thu, Oct 24, 2024 at 04:42:10PM +0100, Catalin Marinas wrote:
> On Thu, Oct 24, 2024 at 04:55:48PM +0200, Kevin Brodsky wrote:
> > On 24/10/2024 12:59, Catalin Marinas wrote:
> > > On Wed, Oct 23, 2024 at 04:05:09PM +0100, Kevin Brodsky wrote:
> > >> +/*
> > >> + * Save the unpriv access state into ua_state and reset it to disable any
> > >> + * restrictions.
> > >> + */
> > >> +static void save_reset_user_access_state(struct user_access_state *ua_state)
> > >> +{
> > >> +	if (system_supports_poe()) {
> > >> +		/*
> > >> +		 * Enable all permissions in all 8 keys
> > >> +		 * (inspired by REPEAT_BYTE())
> > >> +		 */
> > >> +		u64 por_enable_all = (~0u / POE_MASK) * POE_RXW;
> > > I think this should be ~0ul.
> > 
> > It is ~0u on purpose, because unlike in REPEAT_BYTE(), I only wanted the
> > lower 32 bits to be filled with POE_RXW (we only have 8 keys, the top 32
> > bits are RES0). That said, given that D128 has 4-bit pkeys, we could
> > anticipate and fill the top 32 bits too (should make no difference on D64).
> 
> I guess we could leave it as 32-bit for now and remember to update it
> when we enable more keys with D128. Setting the top RES0 bits doesn't
> hurt either since they are already documented in the Arm ARM. Up to you,
> it's fine like above as well.

Can we maybe just have a brute-force loop that constructs the value
using the appropriate #define macros?

The compiler will const-fold it; I'd be prepared to bet that the
generated code would be identical...


> > >> @@ -907,6 +964,7 @@ SYSCALL_DEFINE0(rt_sigreturn)
> > >>  {
> > >>  	struct pt_regs *regs = current_pt_regs();
> > >>  	struct rt_sigframe __user *frame;
> > >> +	struct user_access_state ua_state;
> > >>  
> > >>  	/* Always make any pending restarted system calls return -EINTR */
> > >>  	current->restart_block.fn = do_no_restart_syscall;
> > >> @@ -923,12 +981,14 @@ SYSCALL_DEFINE0(rt_sigreturn)
> > >>  	if (!access_ok(frame, sizeof (*frame)))
> > >>  		goto badframe;
> > >>  
> > >> -	if (restore_sigframe(regs, frame))
> > >> +	if (restore_sigframe(regs, frame, &ua_state))
> > >>  		goto badframe;
> > >>  
> > >>  	if (restore_altstack(&frame->uc.uc_stack))
> > >>  		goto badframe;
> > >>  
> > >> +	restore_user_access_state(&ua_state);
> > >> +
> > >>  	return regs->regs[0];
> > >>  
> > >>  badframe:
> > > The saving part I'm fine with. For restoring, I was wondering whether we
> > > can get a more privileged POR_EL0 if reading the frame somehow failed.
> > > This is largely theoretical, there are other ways to attack like
> > > writing POR_EL0 directly than unmapping/remapping the signal stack.
> > >
> > > What I'd change here is always restore_user_access_state() to
> > > POR_EL0_INIT. Maybe just initialise ua_state above and add the function
> > > call after the badframe label.
> > 
> > I'm not sure I understand. When we enter this function, POR_EL0 is set
> > to whatever the signal handler set it to (POR_EL0_INIT by default).
> > There are then two cases:
> > 1) Everything succeeds, including reading the saved POR_EL0 from the
> > frame. We then call restore_user_access_state(), setting POR_EL0 to the
> > value we've read, and return to userspace.
> > 2) Any uaccess fails (for instance reading POR_EL0). In that case we
> > leave POR_EL0 unchanged and deliver SIGSEGV.
> > 
> > In case 2 POR_EL0 is most likely already set to POR_EL0_INIT, or
> > whatever the signal handler set it to. It's not clear to me that forcing
> > it to POR_EL0_INIT helps much. Either way it's doubtful that the SIGSEGV
> > handler will be able to recover, since the new signal frame we will
> > create for it may be a mix of interrupted state and signal handler state
> > (depending on exactly where we fail).
> 
> If the SIGSEGV delivery succeeds, returning would restore the POR_EL0
> set up by the previous signal handler, potentially more privileged. Does
> it matter? Can it return all the way to the original context?

That seems a valid concern.

It looks a bit like we don't back out the temporary change to POR_EL0
if writing the sigframe fails, so the temporary "allow all" perms might
get saved out into the SIGSEGV sigframe on the alternate signal
stack, and will then be restored as the user thread's POR_EL0 when the
SIGSEGV returns.

(This is all assuming that the force_sig(SIGSEGV) logic works properly
at all...  I'm still trying to puzzle it out!)

Cheers
---Dave

