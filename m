Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E342D0064
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Oct 2019 20:02:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726439AbfJHSBQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Oct 2019 14:01:16 -0400
Received: from foss.arm.com ([217.140.110.172]:42628 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726384AbfJHSBQ (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Oct 2019 14:01:16 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C8DAC15BE;
        Tue,  8 Oct 2019 11:01:15 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E1B683F6C4;
        Tue,  8 Oct 2019 11:01:14 -0700 (PDT)
Date:   Tue, 8 Oct 2019 19:01:12 +0100
From:   Dave Martin <Dave.Martin@arm.com>
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, shuah@kernel.org,
        amit.kachhap@arm.com, andreyknvl@google.com
Subject: Re: [PATCH v7 05/11] kselftest: arm64: mangle_pstate_ssbs_regs
Message-ID: <20191008180112.GY27757@arm.com>
References: <20191007182954.25730-1-cristian.marussi@arm.com>
 <20191007182954.25730-6-cristian.marussi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191007182954.25730-6-cristian.marussi@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Oct 07, 2019 at 07:29:48pm +0100, Cristian Marussi wrote:
> Add a simple mangle testcase which messes with the ucontext_t from within
> the signal handler, trying to set the PSTATE SSBS bit and verify that
> SSBS bit set is preserved across sigreturn.
> Lookup PSTATE.SSBS directly using dedicated helper to grab PSTATE from a
> live sigframe.
> 
> Additionally, in order to support this test specific needs:
> - extend signal testing framework to allow the definition of a custom
>   per test initialization function to be run at the end of test setup
>   and before test run routine. This will support also test SKIP.
> - introduce also a new common utility function: get_current_context()
>   which can be used to grab a ucontext without the help of libc, and
>   detect if such ucontext has been actively used to jump back.
> 
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> ---
> v6 --> v7
> - fixed missing header for memcpy
> - fixed misleading comment in get_current_context()
> - fixed retvalue checks on get_current_context() invocation
> - extend test_init()/test_result() and .init to report KSFT_SKIP
> - SKIP mangle_pstate_ssbs_regs if SSBS not supported at all
> - check SSBS support looking up ID_AA64PFR1_EL1.SSBS in test_init()
>   instead of using MRS/MSR

[...]

> diff --git a/tools/testing/selftests/arm64/signal/test_signals.c b/tools/testing/selftests/arm64/signal/test_signals.c
> index cb970346b280..416b1ff43199 100644
> --- a/tools/testing/selftests/arm64/signal/test_signals.c
> +++ b/tools/testing/selftests/arm64/signal/test_signals.c
> @@ -19,11 +19,11 @@ int main(int argc, char *argv[])
>  	current = &tde;
>  
>  	ksft_print_msg("%s :: %s\n", current->name, current->descr);
> -	if (test_setup(current)) {
> +	if (test_setup(current) && test_init(current)) {
>  		test_run(current);
> -		test_result(current);
>  		test_cleanup(current);
>  	}
> +	test_result(current);
>  
> -	return current->pass ? KSFT_PASS : KSFT_FAIL;
> +	return current->result;
>  }
> diff --git a/tools/testing/selftests/arm64/signal/test_signals.h b/tools/testing/selftests/arm64/signal/test_signals.h
> index f712b5daa10b..ad8175806034 100644
> --- a/tools/testing/selftests/arm64/signal/test_signals.h
> +++ b/tools/testing/selftests/arm64/signal/test_signals.h
> @@ -27,13 +27,25 @@
>  	: "memory");					\
>  }
>  
> +#define set_regval(regname, in)				\
> +{							\
> +	asm volatile("msr " __stringify(regname) ", %0" \
> +	:						\
> +	: "r" (in)					\
> +	: "memory");					\
> +}

Unused macro?  Now that the test doesn't try to change the SSBS state
via MSR, I don't think anything else is using this.

[...]

> diff --git a/tools/testing/selftests/arm64/signal/testcases/mangle_pstate_ssbs_regs.c b/tools/testing/selftests/arm64/signal/testcases/mangle_pstate_ssbs_regs.c
> new file mode 100644
> index 000000000000..780161dbd7c0
> --- /dev/null
> +++ b/tools/testing/selftests/arm64/signal/testcases/mangle_pstate_ssbs_regs.c
> @@ -0,0 +1,92 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2019 ARM Limited
> + *
> + * Try to mangle the ucontext from inside a signal handler, setting the
> + * SSBS bit to 1 and veryfing that such modification is preserved.
> + */
> +
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <signal.h>
> +#include <ucontext.h>
> +
> +#include <kselftest.h>
> +
> +#include "test_signals_utils.h"
> +#include "testcases.h"
> +
> +static bool mangle_invalid_pstate_ssbs_init(struct tdescr *td)
> +{
> +	bool ret;
> +
> +	ret = feats_ok(td);
> +	if (!ret) {
> +		fprintf(stderr, "%s: unsupported feature - SKIP.\n", td->name);
> +		td->result = KSFT_SKIP;
> +	}
> +
> +	return ret;
> +}
> +
> +static int mangle_invalid_pstate_ssbs_run(struct tdescr *td,
> +					  siginfo_t *si, ucontext_t *uc)
> +{
> +	ASSERT_GOOD_CONTEXT(uc);
> +
> +	/* set bit value ... should NOT be cleared by Kernel on sigreturn */
> +	uc->uc_mcontext.pstate |= PSR_SSBS_BIT;
> +	fprintf(stderr, "SSBS set to 1 -- PSTATE: 0x%016llX\n",
> +		uc->uc_mcontext.pstate);
> +	/* Save after mangling...it should be preserved */
> +	td->saved_uc = *uc;

Hmmm, now I'm wondering about how things like
prctl(PR_SET_SPECULATION_CTRL) are supposed to interact with other ways
of manipulating PSTATE.SSBS.  Before we've answered this, we don't know
what result to expect from this test in various configurations...

To avoid this series depending on answering that question immediately,
can we drop this test from the series for now?

To reduce rework effort, maybe keep this patch in its current position
in the series, with just the utility code, but drop the testcase.

Sorry for the churn -- I didn't think of this issue earlier :(

[...]

Cheers
---Dave
