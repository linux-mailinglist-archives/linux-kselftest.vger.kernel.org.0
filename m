Return-Path: <linux-kselftest+bounces-19976-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EFB149A276B
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 17:53:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72A9A1F2336A
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 15:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D42561DE893;
	Thu, 17 Oct 2024 15:53:49 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D206517DFEF
	for <linux-kselftest@vger.kernel.org>; Thu, 17 Oct 2024 15:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729180429; cv=none; b=IosvvKbvrRf5oIouaWfZF/Xv9RsYOKKuBqPpnr6HnvMMfcPKJ7rAx3A79U/KXh1YBZyUc3/SxpLVyrO5PIVT/iVBqz8wx7vJ3fe5KbYrVSFUPPT03/WvtRS4UzBtpYBljToSgI3f6NbyKuzGQmSsJlbs1uAuVdqqdN+uEQnS0iQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729180429; c=relaxed/simple;
	bh=2VJW7IFSkxaTqHNgZI/NOcFksD5EE0g9e/t8mapbsw0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C5ot4iSf/KcdJNx7bMqo59f0BXcpUFHUWyLXfjLb8YHjsA9TCZ70zIfjM7DHy54oM/NjrMtYMbICM+pjcKsPxKLcoH8S5GYxOzoihUgoO1MWArZ/axI/L/eY5VfKisfvipmO4WO6OoBMP8LXj4EYWeUMB1WyWGjIE0X53QBnVXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DA95CFEC;
	Thu, 17 Oct 2024 08:54:13 -0700 (PDT)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.51])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2BBCE3F71E;
	Thu, 17 Oct 2024 08:53:42 -0700 (PDT)
Date: Thu, 17 Oct 2024 16:53:39 +0100
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
Message-ID: <ZxEzAzmlIG66ZPVn@e133380.arm.com>
References: <20241017133909.3837547-1-kevin.brodsky@arm.com>
 <20241017133909.3837547-4-kevin.brodsky@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241017133909.3837547-4-kevin.brodsky@arm.com>

On Thu, Oct 17, 2024 at 02:39:07PM +0100, Kevin Brodsky wrote:
> TL;DR: reset POR_EL0 to "allow all" before writing the signal frame,
> preventing spurious uaccess failures.
> 
> When POE is supported, the POR_EL0 register constrains memory
> accesses based on the target page's POIndex (pkey). This raises the
> question: what constraints should apply to a signal handler? The
> current answer is that POR_EL0 is reset to POR_EL0_INIT when
> invoking the handler, giving it full access to POIndex 0. This is in
> line with x86's MPK support and remains unchanged.
> 
> This is only part of the story, though. POR_EL0 constrains all
> unprivileged memory accesses, meaning that uaccess routines such as
> put_user() are also impacted. As a result POR_EL0 may prevent the
> signal frame from being written to the signal stack (ultimately
> causing a SIGSEGV). This is especially concerning when an alternate
> signal stack is used, because userspace may want to prevent access
> to it outside of signal handlers. There is currently no provision
> for that: POR_EL0 is reset after writing to the stack, and
> POR_EL0_INIT only enables access to POIndex 0.

This all seems a bit convoluted.

The issues seem to boil down to: the signal frame is read and written
on behalf of the signal handler, and so should be done with consistent
permissions to those the signal handler gets (instead of whatever
random prevailing permissions were specified in POR_EL0 before signal
delivery... and were possibly responsible for triggering the signal in
the first place.)

The need to save/restore POR_EL0 via staging storage seems to follow on
naturally from that, since if POR_EL0 was independent of uaccess then
this patch would be redundant...

> 
> This patch ensures that POR_EL0 is reset to its most permissive

Is this right?  See my comment on save_reset_unpriv_access_state()
below.

> state before the signal stack is accessed. Once the signal frame has
> been fully written, POR_EL0 is still set to POR_EL0_INIT - it is up
> to the signal handler to enable access to additional pkeys if
> needed. As to sigreturn(), it expects having access to the stack
> like any other syscall; we only need to ensure that POR_EL0 is
> restored from the signal frame after all uaccess calls. This
> approach is in line with the recent x86/pkeys series [1].
> 
> Resetting POR_EL0 early introduces some complications, in that we
> can no longer read the register directly in preserve_poe_context().
> This is addressed by introducing a struct (unpriv_access_state)
> and helpers to manage any such register impacting uaccess. Things
> look like this on signal delivery:
> 1. Save original POR_EL0 into struct [save_reset_unpriv_access_state()]
> 2. Set POR_EL0 to "allow all"  [save_reset_unpriv_access_state()]
> 3. Create signal frame
> 4. Write saved POR_EL0 value to the signal frame [preserve_poe_context()]
> 5. Finalise signal frame
> 6. Set POR_EL0 to POR_EL0_INIT [set_handler_unpriv_access_state()]
> 
> The return path (sys_rt_sigreturn) doesn't strictly require any change
> since restore_poe_context() is already called last. However, to
> avoid uaccess calls being accidentally added after that point, we
> use the same approach as in the delivery path, i.e. separating
> uaccess from writing to the register:
> 1. Read saved POR_EL0 value from the signal frame [restore_poe_context()]
> 2. Set POR_EL0 to the saved value [restore_unpriv_access_state()]
> 
> [1] https://lore.kernel.org/lkml/20240802061318.2140081-1-aruna.ramakrishna@oracle.com/
> 
> Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
> ---
>  arch/arm64/kernel/signal.c | 89 ++++++++++++++++++++++++++++++++------
>  1 file changed, 75 insertions(+), 14 deletions(-)
> 
> diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
> index f5fb48dabebe..3548146084b3 100644
> --- a/arch/arm64/kernel/signal.c
> +++ b/arch/arm64/kernel/signal.c
> @@ -66,9 +66,64 @@ struct rt_sigframe_user_layout {
>  	unsigned long end_offset;
>  };
>  
> +/*
> + * Holds any EL0-controlled state that influences unprivileged memory accesses.
> + * This includes both accesses done in userspace and uaccess done in the kernel.
> + *
> + * This state needs to be carefully managed to ensure that it doesn't cause
> + * uaccess to fail when setting up the signal frame, and the signal handler
> + * itself also expects a well-defined state when entered.
> + */
> +struct unpriv_access_state {
> +	u64 por_el0;
> +};
> +
>  #define TERMINATOR_SIZE round_up(sizeof(struct _aarch64_ctx), 16)
>  #define EXTRA_CONTEXT_SIZE round_up(sizeof(struct extra_context), 16)
>  
> +/*
> + * Save the unpriv access state into ua_state and reset it to disable any
> + * restrictions.
> + */
> +static void save_reset_unpriv_access_state(struct unpriv_access_state *ua_state)

Would _user_ be more consistent naming than _unpriv_ ?

Same elsewhere.

> +{
> +	if (system_supports_poe()) {
> +		/*
> +		 * Enable all permissions in all 8 keys
> +		 * (inspired by REPEAT_BYTE())
> +		 */
> +		u64 por_enable_all = (~0u / POE_MASK) * POE_RXW;

Yikes!

Seriously though, why are we granting permissions that the signal
handler isn't itself going to have over its own stack?

I think the logical thing to do is to think of the write/read of the
signal frame as being done on behalf of the signal handler, so the
permissions should be those we're going to give the signal handler:
not less, and (so far as we can approximate) not more.

> +
> +		ua_state->por_el0 = read_sysreg_s(SYS_POR_EL0);
> +		write_sysreg_s(por_enable_all, SYS_POR_EL0);
> +		/* Ensure that any subsequent uaccess observes the updated value */
> +		isb();
> +	}
> +}
> +
> +/*
> + * Set the unpriv access state for invoking the signal handler.
> + *
> + * No uaccess should be done after that function is called.
> + */
> +static void set_handler_unpriv_access_state(void)
> +{
> +	if (system_supports_poe())
> +		write_sysreg_s(POR_EL0_INIT, SYS_POR_EL0);
> +

Spurious blank line?

> +}

[...]

> @@ -1252,9 +1310,11 @@ static int setup_rt_frame(int usig, struct ksignal *ksig, sigset_t *set,
>  {
>  	struct rt_sigframe_user_layout user;
>  	struct rt_sigframe __user *frame;
> +	struct unpriv_access_state ua_state;
>  	int err = 0;
>  
>  	fpsimd_signal_preserve_current_state();
> +	save_reset_unpriv_access_state(&ua_state);

(Trivial nit: maybe put the blank line before this rather than after?
This has nothing to do with "settling" the kernel's internal context
switch state, and a lot to do with generaing the signal frame...)

>  
>  	if (get_sigframe(&user, ksig, regs))
>  		return 1;

[...]

> @@ -1273,6 +1333,7 @@ static int setup_rt_frame(int usig, struct ksignal *ksig, sigset_t *set,
>  			regs->regs[1] = (unsigned long)&frame->info;
>  			regs->regs[2] = (unsigned long)&frame->uc;
>  		}
> +		set_handler_unpriv_access_state();

This bit feels prematurely factored?  We don't have separate functions
for the other low-level preparation done here...

It works either way though, and I don't have a strong view.

Overall, this all looks reasonable.

Cheers
---Dave

