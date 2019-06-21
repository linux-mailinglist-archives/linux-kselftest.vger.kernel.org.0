Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D63E4E62D
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jun 2019 12:35:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726311AbfFUKf6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 21 Jun 2019 06:35:58 -0400
Received: from foss.arm.com ([217.140.110.172]:58074 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726250AbfFUKf5 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 21 Jun 2019 06:35:57 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3505A28;
        Fri, 21 Jun 2019 03:35:57 -0700 (PDT)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 679993F718;
        Fri, 21 Jun 2019 03:35:56 -0700 (PDT)
Date:   Fri, 21 Jun 2019 11:35:54 +0100
From:   Dave Martin <Dave.Martin@arm.com>
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, shuah@kernel.org,
        andreyknvl@google.com
Subject: Re: [PATCH 08/13] kselftest: arm64: mangle_pstate_ssbs_regs
Message-ID: <20190621103554.GP2790@e103592.cambridge.arm.com>
References: <20190613111335.7645-1-cristian.marussi@arm.com>
 <20190613111335.7645-9-cristian.marussi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190613111335.7645-9-cristian.marussi@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Jun 13, 2019 at 12:13:30PM +0100, Cristian Marussi wrote:
> Added a simple mangle testcase which messes with the ucontext_t
> from within the sig_handler, trying to toggle PSTATE SSBS bit.
> Expect SIGILL if SSBS feature unsupported or that the value set in
> PSTATE.SSBS is preserved on test PASS.
> 
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> ---
>  .../arm64/signal/testcases/.gitignore         |  1 +
>  .../testcases/mangle_pstate_ssbs_regs.c       | 41 +++++++++++++++++++
>  2 files changed, 42 insertions(+)
>  create mode 100644 tools/testing/selftests/arm64/signal/testcases/mangle_pstate_ssbs_regs.c
> 
> diff --git a/tools/testing/selftests/arm64/signal/testcases/.gitignore b/tools/testing/selftests/arm64/signal/testcases/.gitignore
> index e7a1d998b650..c2972c3f33ca 100644
> --- a/tools/testing/selftests/arm64/signal/testcases/.gitignore
> +++ b/tools/testing/selftests/arm64/signal/testcases/.gitignore
> @@ -5,3 +5,4 @@ mangle_pstate_invalid_state_toggle
>  mangle_pstate_invalid_mode_el1
>  mangle_pstate_invalid_mode_el2
>  mangle_pstate_invalid_mode_el3
> +mangle_pstate_ssbs_regs
> diff --git a/tools/testing/selftests/arm64/signal/testcases/mangle_pstate_ssbs_regs.c b/tools/testing/selftests/arm64/signal/testcases/mangle_pstate_ssbs_regs.c
> new file mode 100644
> index 000000000000..d997ebf742d9
> --- /dev/null
> +++ b/tools/testing/selftests/arm64/signal/testcases/mangle_pstate_ssbs_regs.c
> @@ -0,0 +1,41 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* Copyright (C) 2019 ARM Limited */
> +
> +#include "test_signals_utils.h"
> +#include "testcases.h"
> +
> +static int mangle_invalid_pstate_ssbs_run(struct tdescr *td,
> +					  siginfo_t *si, ucontext_t *uc)
> +{
> +	ASSERT_GOOD_CONTEXT(uc);
> +
> +	/* toggle bit value */
> +	uc->uc_mcontext.pstate ^= PSR_SSBS_BIT;
> +	/* Save after mangling...it should be preserved */
> +	td->saved_uc = *uc;
> +
> +	return 1;
> +}
> +
> +static int pstate_ssbs_bit_checks(struct tdescr *td)
> +{
> +	uint64_t val = 0;
> +
> +	get_regval(MRS_SSBS_SYSREG, val);
> +	/* pass when preserved */
> +	td->pass = (!!(val & MRS_SSBS_BIT) ==
> +		    !!(td->saved_uc.uc_mcontext.pstate & PSR_SSBS_BIT));

Nit: there's a redundant level of ! here, and the outer () are unnecessary:

	(!!a == !!b) -> !a == !b

[...]

Can we trigger a second signal after the first returns, to grab the
updated ucontext and check SSBS in there directly?

Checking that the updated value is _also_ visible via MRS remains
useful though, so we should keep that.

Cheers
---Dave
