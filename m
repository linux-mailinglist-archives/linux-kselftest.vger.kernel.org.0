Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F21ECFD2A
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Oct 2019 17:07:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726086AbfJHPHi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Oct 2019 11:07:38 -0400
Received: from foss.arm.com ([217.140.110.172]:38900 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725976AbfJHPHi (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Oct 2019 11:07:38 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C79B81570;
        Tue,  8 Oct 2019 08:07:37 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DB9FA3F68E;
        Tue,  8 Oct 2019 08:07:36 -0700 (PDT)
Date:   Tue, 8 Oct 2019 16:07:34 +0100
From:   Dave Martin <Dave.Martin@arm.com>
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     amit.kachhap@arm.com, andreyknvl@google.com, shuah@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v6 05/11] kselftest: arm64: mangle_pstate_ssbs_regs
Message-ID: <20191008150732.GW27757@arm.com>
References: <20190910123111.33478-1-cristian.marussi@arm.com>
 <20190910123111.33478-6-cristian.marussi@arm.com>
 <20190917160555.GM27757@arm.com>
 <022fce81-ac93-5ccf-a19b-83791e6469f1@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <022fce81-ac93-5ccf-a19b-83791e6469f1@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Oct 07, 2019 at 07:23:19PM +0100, Cristian Marussi wrote:
> Hi
> 
> finally back on this series.
> 
> On 17/09/2019 17:05, Dave Martin wrote:
> > On Tue, Sep 10, 2019 at 01:31:05pm +0100, Cristian Marussi wrote:
> >> Add a simple mangle testcase which messes with the ucontext_t from within
> >> the signal handler, trying to set the PSTATE SSBS bit and verify that
> >> SSBS bit set is preserved across sigreturn.
> >> When available, use MRS SBSS support to set/get SSBS bit, otherwise lookup
> >> PSTATE.SSBS directly.
> >>
> >> Additionally, in order to support this test specific needs:
> >> - extend signal testing framework to allow the definition of a custom
> >>   per test initialization function to be run at the end of test setup
> >>   and before test run routine.
> >> - introduce a set_regval() helper to set system register values in a
> >>   toolchain independent way.
> >> - introduce also a new common utility function: get_current_context()
> >>   which can be used to grab a ucontext without the help of libc, and
> >>   detect if such ucontext has been actively used to jump back.
> >>
> >> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> >> ---
> >> v5 --> v6
> >> - using SIGTRAP as sig_copyctx for get_current_context()
> >> - get_current_context() is now __always_inline
> >> - last minute check for SSBS cleared
> >> - restore volatile usage, dropping useless DSB
> >> - output clobber on *dest_uc
> >> - no abort() on SSSB not cleared
> >> - refactored/relocated test_init() call to be after test_setup()
> >>   [to catch early SIGILL while initializing]
> >> - avoid MRS SSBS when !feats_ok()...use instead PSTATE.SSBS
> >> - refactored SIG_COPYCTX usage to fit new splitted-by-signal layout

[...]

> >> diff --git a/tools/testing/selftests/arm64/signal/test_signals_utils.h b/tools/testing/selftests/arm64/signal/test_signals_utils.h

[...]

> >> +static __always_inline bool get_current_context(struct tdescr *td,
> >> +						ucontext_t *dest_uc)
> >> +{
> >> +	static volatile bool seen_already;
> >> +
> >> +	assert(td && dest_uc);
> >> +	/* it's a genuine invocation..reinit */
> >> +	seen_already = 0;
> > 
> > Nit: can we have "= 0" as an initializer in the declaration above?
> > 
> 
> Not sure if you mean to add a zero initialization to the static
> declaration or to fold this apparently redundant
> 
> >> +	seen_already = 0;
> 
> into the above.
> 
> If you mean the latter folding I think I cannot for the following reasons:
> 
> the static seen_already is placed out of the stack and automatically
> initialized to 0 once for all at program initialization.
> 
> >> +	static volatile bool seen_already;
> 
> After that, seen_already is set to 1 after the context has been
> grabbed using the brk/SIGTRAP trick in order to signify that context
> has been grabbed successfully.  But is is set to 1 only after having
> been checked for ZERO in order to detect if we happened to arrive
> here in the middle of this function as the unexpected result of a
> fake_sigreturn using this context.
>
> >> +	if (seen_already) {
> >> +		fprintf(stdout,
> >> +			"Unexpected successful sigreturn detected: live_uc is stale !\n");
> >> +		return 0;
> >> +	}
> >> +	seen_already = 1;
> 
> So get_current_context returns 1 on success when a good context has
> been grabbed, while returns 0 when in fact returning from a sigreturn
> using a previously grabbed context (in a highly corrupted stack
> frame...so you'll probably want to exit straight away in the caller
> at that point.)
> 
> Now answering finally your (possible) question about the apparently
> redundant
> 
>  >> seen_already = 0;
> 
> what happens if I call regularly two times in sequence this utility
> function in the same program ?
> 
> say at first to grab a context to analyze the PSTATE reported there,
> and maybe again later to grab another context to put onto the stack,
> or to recheck the PSTATE ?
> 
> I would expect NOT to fail and obtain both times a new valid context,
> but my understanding is that in order to be able to do so, I'll have
> to re-initialize to 0 the seen_already flag explicitly on each
> invocation.

My bad -- I'd confused myself and missed the significance of "static"
here.  As you point out, seen_already needs to be static for other
reasons, and reinitialised each time we call this function.

So you were right to ignore this nitpick :)

> >> +	td->live_uc_valid = 0;
> >> +	td->live_sz = sizeof(*dest_uc);
> >> +	memset(dest_uc, 0x00, td->live_sz);
> >> +	td->live_uc = dest_uc;
> >> +	/*
> >> +	 * Grab ucontext_t triggering a SIGTRAP.
> >> +	 *
> >> +	 * Note that:
> >> +	 * - live_uc_valid is declared volatile sig_atomic_t in
> >> +	 *   struct tdescr since it will be changed inside the
> >> +	 *   sig_copyctx handler
> >> +	 * - the additional 'memory' clobber is there to avoid possible
> >> +	 *   compiler's assumption on live_uc_valid, seen-already and
> > 
> > I could be wrong about this, but I'm not sure that the "memory" clobber
> > is sufficient for for seen_already, because of the way that variable is
> > scoped to this function; however, you declare seen_already volatile
> > anyway which should be sufficient.
> > 
> > I suggest you just omit seen_already from this comment.
> > 
> 
> Ok
> 
> 
> >> +	 *   the content pointed by dest_uc, which are all changed inside
> >> +	 *   the signal handler
> >> +	 * - BRK causes a debug exception which is handled by the Kernel
> >> +	 *   and finally causes the SIGTRAP signal to be delivered to this
> >> +	 *   test thread. Since such delivery happens on the ret_to_user()
> >> +	 *   /do_notify_resume() debug exception return-path, we are sure
> >> +	 *   that the registered SIGTRAP handler has been run to completion
> >> +	 *   before the execution path is restored here: as a consequence
> >> +	 *   we can be sure that the volatile sig_atomic_t live_uc_valid
> >> +	 *   carries a meaningful result. Being in a single thread context
> >> +	 *   we'll also be sure that any access to memory modified by the
> >> +	 *   handler (namely ucontext_t) will be visible once returned.
> >> +	 * - note that since we are using a breakpoint instruction here
> >> +	 *   to cause a SIGTRAP, the ucontext_t grabbed from the signal
> >> +	 *   handler would naturally contain a PC pointing exactly to this
> >> +	 *   BRK line, which means that, on return from the signal handler,
> >> +	 *   or if we place the ucontext_t on the stack to fake a sigreturn,
> >> +	 *   we'll end up in an infinite loop of BRK-SIGTRAP-handler.
> >> +	 *   For this reason we take care to artificially move forward the
> >> +	 *   PC to the next instruction while inside the signal handler.
> >> +	 */
> >> +	asm volatile ("brk #666"
> >> +		      : "=m" (*dest_uc)
> > 
> > Make this an input-output argument ("+m")?  The memset() needs to
> > take effect happen before the asm.
> > 
> 
> Ok
> 
> 
> >> +		      :
> >> +		      : "memory");
> >> +
> >> +	/*
> >> +	 * If we get here with seen_already==1 it implies the td->live_uc
> >> +	 * context has been used to get back here....this probably means
> >> +	 * a test has failed to cause a SEGV...anyway live_uc does not
> >> +	 * point to a just acquired copy of ucontext_t...so return 0
> >> +	 */
> >> +	if (seen_already) {
> >> +		fprintf(stdout,
> >> +			"Unexpected successful sigreturn detected: live_uc is stale !\n");
> >> +		return 0;
> >> +	}
> >> +	seen_already = 1;
> >> +
> >> +	return td->live_uc_valid;
> >> +}
> >>  #endif
> >> diff --git a/tools/testing/selftests/arm64/signal/testcases/mangle_pstate_ssbs_regs.c b/tools/testing/selftests/arm64/signal/testcases/mangle_pstate_ssbs_regs.c
> >> new file mode 100644
> >> index 000000000000..e2b87ea4c11f
> >> --- /dev/null
> >> +++ b/tools/testing/selftests/arm64/signal/testcases/mangle_pstate_ssbs_regs.c
> >> @@ -0,0 +1,88 @@
> >> +// SPDX-License-Identifier: GPL-2.0
> >> +/*
> >> + * Copyright (C) 2019 ARM Limited
> >> + *
> >> + * Try to mangle the ucontext from inside a signal handler, setting the
> >> + * SSBS bit to 1 and veryfing that such modification is preserved.
> >> + */
> >> +
> >> +#include <stdio.h>
> >> +#include <stdlib.h>
> >> +#include <signal.h>
> >> +#include <ucontext.h>
> >> +
> >> +#include "test_signals_utils.h"
> >> +#include "testcases.h"
> >> +
> >> +static void mangle_invalid_pstate_ssbs_init(struct tdescr *td)
> >> +{
> >> +	if (feats_ok(td)) {
> >> +		fprintf(stderr, "Clearing SSBS to 0\n");
> >> +		set_regval(SSBS_SYSREG, 0);
> >> +	}
> >> +}
> >> +
> >> +static int mangle_invalid_pstate_ssbs_run(struct tdescr *td,
> >> +					  siginfo_t *si, ucontext_t *uc)
> >> +{
> >> +	ASSERT_GOOD_CONTEXT(uc);
> >> +
> >> +	/*
> >> +	 * If HW_SSBS is supported but we weren't able to clear SSBS during
> >> +	 * test_init, or if something has reset SSBS in the meantime, abort.
> > 
> > What is "HW_SSBS" ?
> > 
> 
> HWCAP_SSBS, I'll fix
> 
> 
> >> +	 */
> >> +	if (feats_ok(td) && (uc->uc_mcontext.pstate & PSR_SSBS_BIT)) {
> >> +		fprintf(stderr,
> >> +			"SSBS unexpectedly NOT zeroed ! Something's wrong. Abort\n");
> >> +		abort();
> >> +	}
> >> +
> >> +	/* set bit value ... should NOT be cleared by Kernel on sigreturn */
> >> +	uc->uc_mcontext.pstate |= PSR_SSBS_BIT;
> >> +	fprintf(stderr, "SSBS set to 1 -- PSTATE: 0x%016llX\n",
> >> +		uc->uc_mcontext.pstate);
> >> +	/* Save after mangling...it should be preserved */
> >> +	td->saved_uc = *uc;
> >> +
> >> +	return 1;
> >> +}
> >> +
> >> +static void pstate_ssbs_bit_checks(struct tdescr *td)
> >> +{
> >> +	uint64_t val = 0;
> >> +	ucontext_t uc;
> >> +
> >> +	/* This check reports some result even if MRS SSBS unsupported */
> >> +	if (get_current_context(td, &uc))
> >> +		fprintf(stderr,
> >> +			"INFO: live_uc - got PSTATE: 0x%016llX -> SSBS %s\n",
> >> +			uc.uc_mcontext.pstate,
> >> +			(td->saved_uc.uc_mcontext.pstate & PSR_SSBS_BIT) ==
> >> +			(uc.uc_mcontext.pstate & PSR_SSBS_BIT) ?
> >> +			"PRESERVED" : "CLEARED");
> > 
> > Don't we subsequently refer to uc even if get_current_context() failed
> > here?
> > 
> 
> Yes, but in fact in this invocation it cannot fail, it can fail only
> once a sigreturn with a previously grabbed context uses it and unexpectedly
> returns.
> Even though the if is redundant in fact here, it is misleading as used now,
> I'll fix checking the retvalue and bailing out with abort() in case
> get_curent_context unexpectedly failed in this conetxt.

OK, that sounds like a cleaner approach, even though I guess you're
correct that the failure is impossible here.
> 
> 
> >> +	/* Choose check method depending of supported features */
> >> +	if (feats_ok(td)) {
> >> +		fprintf(stderr, "Checking with MRS SSBS...\n");
> >> +		get_regval(SSBS_SYSREG, val);
> >> +		fprintf(stderr, "INFO: MRS SSBS - got: 0x%016lX\n", val);
> >> +	} else {
> >> +		fprintf(stderr, "Checking with PSTATE.SSBS...\n");
> >> +		val = uc.uc_mcontext.pstate;
> >> +	}
> >> +	/* pass when preserved */
> >> +	td->pass = (val & PSR_SSBS_BIT) ==
> >> +		   (td->saved_uc.uc_mcontext.pstate & PSR_SSBS_BIT);
> > 
> > Does this mean the test fails when SSBS isn't supported at all?  That
> > doesn't seem right.
> > 
> > I think trying to handle both levels of SSBS support within the same
> > test is complicating things here.  The purpose of this is to check
> > that sigreturn doesn't mask out the SSBS bit when it shouldn't: we don't
> > care whether the SSBS architecture feature actually works.
> > 
> > So, would it be simpler to drop the MSR/MRS direct access to the SSBS
> > bit?
> > 
> > Instead, we could predicate this test on whether ID_AA64PFR1_EL1.SSBS
> >> = 1 instead of HWCAP_SSBS, and we could just check that run() can
> > successfully _toggle_ uc->uc_mcontext.pstate ^= PSR_SSBS_BIT, with the
> > change checked via a subsequent get_current_context().
> > 
> 
> Ok I'll check on ID_AA64PFR1_EL1.SSBS >= 1 instead of
> HWCAP_SSBS,since it is all I need to be able to use PSTATE.SSBS (with
> .SSBS=2 I've got also MRS/MSR which does NOT hurt)
> 
> I'll SKIP if support is missing returning KSFT_SKIP (extending
> test_init related logic for this)
> 
> > In other words, we no longer try to initialise SSBS to a particular
> > value.  Instead, we just check the we can change the bit.
> > 
> > Does that make sense?
> > 
> 
> Yes but I'll have anyway to test by setting to SSBS in the ucontext 
> (only when SSBS supported as said), and verify that is NOT cleared, because
> if I toggle the bit 1-->0 then I would have nothing to check really.
> (I made this error already in a previous iteration...)

Hmmm, OK, I'll take a another look when reviewing v7.

Cheers
---Dave
