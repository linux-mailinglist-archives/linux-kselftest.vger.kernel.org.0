Return-Path: <linux-kselftest+bounces-20265-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E11879A6AC9
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Oct 2024 15:44:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12CE21C220B3
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Oct 2024 13:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C86B1F130A;
	Mon, 21 Oct 2024 13:43:13 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 868301DFFB
	for <linux-kselftest@vger.kernel.org>; Mon, 21 Oct 2024 13:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729518193; cv=none; b=RSZWbwgjhspRbUoiX4JhQ6aeIuOwmSjJ0sWZI4yK9/L9jqk3no4De1EOe/VpDnlbpQRYelA3i81YuF5Q1UIN5z3zkhxRN0e7vzVkG4dx3Gtwc661XYPRHRm/VaVfcQabNsixHj5eiTAzZILI/V6isXy0cIWpxCyhl/Vgqlllp2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729518193; c=relaxed/simple;
	bh=oVQPdJOJgOtZjCWv8MMMz2YcdRPvVM+f6I5xQyISdBg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DG/xyqZN1s8SD8R/WFZcS2BuQHBabqUjrah1QsnGbhx64fuyHzUENbq9RjDPUqIAyQ0u3z/eaHgOgymEDYdIGCfR6llqvCYDfyQ1ztgsQoioXgCAWnsBU/3rXKbomGNomFJCgsPEXpirp8coSTWPp/QU9UZLhOmdI9EOcpE32VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 74CCCDA7;
	Mon, 21 Oct 2024 06:43:39 -0700 (PDT)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.69])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 703613F73B;
	Mon, 21 Oct 2024 06:43:07 -0700 (PDT)
Date: Mon, 21 Oct 2024 14:43:04 +0100
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
Message-ID: <ZxZaaOEIVpSEv7C/@e133380.arm.com>
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

"user_access" seemed natural to me: it parses equally as "[user
access]" (i.e., uaccess) and "[user] access" (i.e., access by, to, or
on behalf of user(space)).

Introducing an architectural term when there is already a generic OS
and Linux kernel term that means the right thing seemed not to improve
readability, but I guess it's a matter of opinion.

Anyway, it doesn't really matter.

> 
> > Same elsewhere.
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
> 
> [1] https://lore.kernel.org/linux-arm-kernel/Zw6D2waVyIwYE7wd@arm.com/
> 
> >>  
> >>  	if (get_sigframe(&user, ksig, regs))
> >>  		return 1;
> > [...]

^

Ah, good point.  The save_reset_unpriv_access_state(&ua_state) call
probably belong just before the first __put_user() then.

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

Certainly if that struct grows more state, then the factoring will
help in future.  I wasn't clear on how we expect this all to evolve.

Either way, this is basically a non-issue, and keeping the symmetry is
probably a good idea.

Cheers
---Dave

