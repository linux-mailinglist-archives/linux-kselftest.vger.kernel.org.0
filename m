Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 814C25E058
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Jul 2019 10:56:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbfGCI4j (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 3 Jul 2019 04:56:39 -0400
Received: from foss.arm.com ([217.140.110.172]:41654 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726400AbfGCI4j (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 3 Jul 2019 04:56:39 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E55C6344;
        Wed,  3 Jul 2019 01:56:38 -0700 (PDT)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 23DE83F718;
        Wed,  3 Jul 2019 01:56:38 -0700 (PDT)
Date:   Wed, 3 Jul 2019 09:56:36 +0100
From:   Dave Martin <Dave.Martin@arm.com>
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     andreyknvl@google.com, shuah@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 08/13] kselftest: arm64: mangle_pstate_ssbs_regs
Message-ID: <20190703085633.GQ2790@e103592.cambridge.arm.com>
References: <20190613111335.7645-1-cristian.marussi@arm.com>
 <20190613111335.7645-9-cristian.marussi@arm.com>
 <20190621103554.GP2790@e103592.cambridge.arm.com>
 <b4365458-2034-2f06-4235-a101f17d4751@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b4365458-2034-2f06-4235-a101f17d4751@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jul 02, 2019 at 04:51:38PM +0100, Cristian Marussi wrote:
> Hi
> 
> On 6/21/19 11:35 AM, Dave Martin wrote:
> > On Thu, Jun 13, 2019 at 12:13:30PM +0100, Cristian Marussi wrote:
> >> Added a simple mangle testcase which messes with the ucontext_t
> >> from within the sig_handler, trying to toggle PSTATE SSBS bit.
> >> Expect SIGILL if SSBS feature unsupported or that the value set in
> >> PSTATE.SSBS is preserved on test PASS.
> >>
> >> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> >> ---
> >>   .../arm64/signal/testcases/.gitignore         |  1 +
> >>   .../testcases/mangle_pstate_ssbs_regs.c       | 41 +++++++++++++++++++
> >>   2 files changed, 42 insertions(+)
> >>   create mode 100644 tools/testing/selftests/arm64/signal/testcases/mangle_pstate_ssbs_regs.c
> >>
> >> diff --git a/tools/testing/selftests/arm64/signal/testcases/.gitignore b/tools/testing/selftests/arm64/signal/testcases/.gitignore
> >> index e7a1d998b650..c2972c3f33ca 100644
> >> --- a/tools/testing/selftests/arm64/signal/testcases/.gitignore
> >> +++ b/tools/testing/selftests/arm64/signal/testcases/.gitignore
> >> @@ -5,3 +5,4 @@ mangle_pstate_invalid_state_toggle
> >>   mangle_pstate_invalid_mode_el1
> >>   mangle_pstate_invalid_mode_el2
> >>   mangle_pstate_invalid_mode_el3
> >> +mangle_pstate_ssbs_regs
> >> diff --git a/tools/testing/selftests/arm64/signal/testcases/mangle_pstate_ssbs_regs.c b/tools/testing/selftests/arm64/signal/testcases/mangle_pstate_ssbs_regs.c
> >> new file mode 100644
> >> index 000000000000..d997ebf742d9
> >> --- /dev/null
> >> +++ b/tools/testing/selftests/arm64/signal/testcases/mangle_pstate_ssbs_regs.c
> >> @@ -0,0 +1,41 @@
> >> +/* SPDX-License-Identifier: GPL-2.0 */
> >> +/* Copyright (C) 2019 ARM Limited */
> >> +
> >> +#include "test_signals_utils.h"
> >> +#include "testcases.h"
> >> +
> >> +static int mangle_invalid_pstate_ssbs_run(struct tdescr *td,
> >> +					  siginfo_t *si, ucontext_t *uc)
> >> +{
> >> +	ASSERT_GOOD_CONTEXT(uc);
> >> +
> >> +	/* toggle bit value */
> >> +	uc->uc_mcontext.pstate ^= PSR_SSBS_BIT;
> >> +	/* Save after mangling...it should be preserved */
> >> +	td->saved_uc = *uc;
> >> +
> >> +	return 1;
> >> +}
> >> +
> >> +static int pstate_ssbs_bit_checks(struct tdescr *td)
> >> +{
> >> +	uint64_t val = 0;
> >> +
> >> +	get_regval(MRS_SSBS_SYSREG, val);
> >> +	/* pass when preserved */
> >> +	td->pass = (!!(val & MRS_SSBS_BIT) ==
> >> +		    !!(td->saved_uc.uc_mcontext.pstate & PSR_SSBS_BIT));
> > 
> > Nit: there's a redundant level of ! here, and the outer () are unnecessary:
> > 
> > 	(!!a == !!b) -> !a == !b
> >
> 
> This was me badly convinced (not sure where I got this) that the bitpos 
> of PSR_SSBS_BIT in pstate was different from the bitpos as reported in 
> the output of MRS SSBS, so I was trying to normalize the comparison to 1 
> == 1 or 0 == 0
> 
> ...but in fact bitpos is the same between PSTATE and MSR SSBS so it can 
> be compared directly.

Since the #defines are separate, it may be more readable to avoid
assuming that they have the same value (even if they do).

But I'm happy either way.

> > [...]
> > 
> > Can we trigger a second signal after the first returns, to grab the
> > updated ucontext and check SSBS in there directly?
> > 
> > Checking that the updated value is _also_ visible via MRS remains
> > useful though, so we should keep that.
> > 
> 
> I have added an informational message that reports the PSTATE and the 
> status of SSBS as grabbed from uc via an induced SIGUSR2.
> Test outcome is anyway  determined on MRS SSBS result.

OK, sounds reasonable.

> If HWCAP_SSBS is available the feature is considered available and so 
> MRS SSBS MUST work.

Yup

> If instead feature is NOT supported as stated in HWCAP_SSBS the test is 
> anyway run but the MRS SSBS is expected to cause a SIGILL (COULD not 
> SHOULD...since HW_CAP could be reporting wrong caps and so MRS SSBS will 
> still work)

Probably reasonable.  I don't recall whether the architecture actually
guarantees a SIGILL though, or whether other things could happen (such
as executing as a NOP, or reading a fixed value such as 0).

Can this MRS be trapped?  I'm wondering whether it will still just
execute normally if running on hardware that has it, but on an old
kernel that doesn't report HWCAP_SSBS.  Some of the other tests may
fail on such a kernel though -- valid_user_regs() would probaly
mask the bit out when setting the register through sigreturn or ptrace.

> Moreover I fixed a small glitch: I was toggling the SSBS bit in uc 
> PSTATE, BUT this make no sense...toggling to zero there's NO way I can 
> check if Kernel preserve it to zero...so now I'm setting to 1 and then 
> check if it has been preserved by Kernel

Well, I guess you can check both ways, but the bit was previously RES0,
so if the kernel masks it out it should be stuck at 0.

So agreed, attempting to set it to 1 is the more interesting test.

Cheers
---Dave
