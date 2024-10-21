Return-Path: <linux-kselftest+bounces-20271-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 861279A6C57
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Oct 2024 16:39:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B44DA1C2128D
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Oct 2024 14:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E263B1F7092;
	Mon, 21 Oct 2024 14:38:56 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A22E41EABA5
	for <linux-kselftest@vger.kernel.org>; Mon, 21 Oct 2024 14:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729521536; cv=none; b=Kn9aBHl6dZ3nYFBGdiF/ewl2vB/tH1LxD0epx+0mSev6jmXHEYJNgOKtRGVTxJq7Hp892OeJjJ3Iw6/UlOXhhGkCba7Mg5ACfZZKGNr6UHpVm5lzASVW0LRaVdvAPXDNzZlo7zBkORMrQOnrQ3p11HbEOT2UQpK/EUUUytRdGMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729521536; c=relaxed/simple;
	bh=6lZdtEcnPJwYg1xe70N7gw4qU36YKMv2EUWdp88dy8U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AVxKOdVfjPxwp3CkOVGt2WbPUPU+T1gy3W+9+6ndh6GsLGn3IG8HQbWuohZgLGtQ+969Jl0BbjL7ujdi/LbzsaZTZXao9+UK5ENZ9KfjS2fGW+Qk2Ddp4skr7Osb39vWy0DwFycBulJWJEn5fC59XIxPHMtt2bMcoh0tbBPy/6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9CF9CDA7;
	Mon, 21 Oct 2024 07:39:22 -0700 (PDT)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.69])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 983893F73B;
	Mon, 21 Oct 2024 07:38:50 -0700 (PDT)
Date: Mon, 21 Oct 2024 15:38:47 +0100
From: Dave Martin <Dave.Martin@arm.com>
To: Kevin Brodsky <kevin.brodsky@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, akpm@linux-foundation.org,
	anshuman.khandual@arm.com, aruna.ramakrishna@oracle.com,
	broonie@kernel.org, catalin.marinas@arm.com,
	dave.hansen@linux.intel.com, jeffxu@chromium.org,
	joey.gouly@arm.com, shuah@kernel.org, will@kernel.org,
	linux-kselftest@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH 3/5] arm64: signal: Improve POR_EL0 handling to avoid
 uaccess failures
Message-ID: <ZxZnd62nJDZflCXv@e133380.arm.com>
References: <20241017133909.3837547-1-kevin.brodsky@arm.com>
 <20241017133909.3837547-4-kevin.brodsky@arm.com>
 <ZxEzAzmlIG66ZPVn@e133380.arm.com>
 <cf75979b-b94f-46cf-a8d0-37e5843a0d29@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cf75979b-b94f-46cf-a8d0-37e5843a0d29@arm.com>

Hi,

Just in case the reply I thought I'd sent to this evaporated (or I
imagined it):

On Mon, Oct 21, 2024 at 12:06:07PM +0200, Kevin Brodsky wrote:
> On 17/10/2024 17:53, Dave Martin wrote:
> > [...]
> >> +/*
> >> + * Save the unpriv access state into ua_state and reset it to disable any
> >> + * restrictions.
> >> + */
> >> +static void save_reset_unpriv_access_state(struct unpriv_access_state *ua_state)
> > Would _user_ be more consistent naming than _unpriv_ ?
> 
> I did ponder on the naming. I considered user_access/uaccess instead of
> unpriv_access, but my concern is that it might imply that only uaccess
> is concerned, while in reality loads/stores that userspace itself
> executes are impacted too. I thought using the "unpriv" terminology from
> the Arm ARM (used for stage 1 permissions) might avoid such
> misunderstanding. I'm interested to hear opinions on this, maybe
> accuracy sacrifices readability.
> 
> > Same elsewhere.

I think "user" covers these meanings, though including the word
"access" makes it sound like this is specific to uaccess.

Maybe something like:

save_reset_user_permissions()
restore_user_permissions()

would make sense?  (But again, it's not a big deal.)

> >
> >> +{
> >> +	if (system_supports_poe()) {
> >> +		/*
> >> +		 * Enable all permissions in all 8 keys
> >> +		 * (inspired by REPEAT_BYTE())
> >> +		 */
> >> +		u64 por_enable_all = (~0u / POE_MASK) * POE_RXW;
> > Yikes!
> >
> > Seriously though, why are we granting permissions that the signal
> > handler isn't itself going to have over its own stack?
> >
> > I think the logical thing to do is to think of the write/read of the
> > signal frame as being done on behalf of the signal handler, so the
> > permissions should be those we're going to give the signal handler:
> > not less, and (so far as we can approximate) not more.
> 
> Will continue that discussion on the cover letter.
> 
> >
> >> +
> >> +		ua_state->por_el0 = read_sysreg_s(SYS_POR_EL0);
> >> +		write_sysreg_s(por_enable_all, SYS_POR_EL0);
> >> +		/* Ensure that any subsequent uaccess observes the updated value */
> >> +		isb();
> >> +	}
> >> +}
> >> +
> >> +/*
> >> + * Set the unpriv access state for invoking the signal handler.
> >> + *
> >> + * No uaccess should be done after that function is called.
> >> + */
> >> +static void set_handler_unpriv_access_state(void)
> >> +{
> >> +	if (system_supports_poe())
> >> +		write_sysreg_s(POR_EL0_INIT, SYS_POR_EL0);
> >> +
> > Spurious blank line?
> 
> Thanks!
> 
> >> +}
> > [...]
> >
> >> @@ -1252,9 +1310,11 @@ static int setup_rt_frame(int usig, struct ksignal *ksig, sigset_t *set,
> >>  {
> >>  	struct rt_sigframe_user_layout user;
> >>  	struct rt_sigframe __user *frame;
> >> +	struct unpriv_access_state ua_state;
> >>  	int err = 0;
> >>  
> >>  	fpsimd_signal_preserve_current_state();
> >> +	save_reset_unpriv_access_state(&ua_state);
> > (Trivial nit: maybe put the blank line before this rather than after?
> > This has nothing to do with "settling" the kernel's internal context
> > switch state, and a lot to do with generaing the signal frame...)
> 
> In fact considering the concern Catalin brought up with POR_EL0 being
> reset even when we fail to deliver the signal [1], I'm realising this
> call should be moved after get_sigframe(), since the latter doesn't use
> uaccess and can fail.

Good point...

> [1] https://lore.kernel.org/linux-arm-kernel/Zw6D2waVyIwYE7wd@arm.com/
> 
> >>  
> >>  	if (get_sigframe(&user, ksig, regs))
> >>  		return 1;
> > [...]

I guess the call can be pushed to just before the first __put_user(),
after here?

> >
> >> @@ -1273,6 +1333,7 @@ static int setup_rt_frame(int usig, struct ksignal *ksig, sigset_t *set,
> >>  			regs->regs[1] = (unsigned long)&frame->info;
> >>  			regs->regs[2] = (unsigned long)&frame->uc;
> >>  		}
> >> +		set_handler_unpriv_access_state();
> > This bit feels prematurely factored?  We don't have separate functions
> > for the other low-level preparation done here...
> 
> I preferred to have a consistent API for all manipulations of POR_EL0,
> the idea being that if more registers are added to struct
> unpriv_access_state, only the *unpriv_access* helpers need to be amended.
> 
> > It works either way though, and I don't have a strong view.
> >
> > Overall, this all looks reasonable.

Keeping the symmetry seems generally a good idea, especially if we
expect that struct to grow more state over time.  I wasn't sure how we
anticipiate this evolving.

[...]

Cheers
---Dave

