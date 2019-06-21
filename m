Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ADFBC4E62A
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jun 2019 12:35:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726309AbfFUKfg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 21 Jun 2019 06:35:36 -0400
Received: from foss.arm.com ([217.140.110.172]:58042 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726250AbfFUKfg (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 21 Jun 2019 06:35:36 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 98BF5142F;
        Fri, 21 Jun 2019 03:35:35 -0700 (PDT)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E641D3F718;
        Fri, 21 Jun 2019 03:35:34 -0700 (PDT)
Date:   Fri, 21 Jun 2019 11:35:32 +0100
From:   Dave Martin <Dave.Martin@arm.com>
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, shuah@kernel.org,
        andreyknvl@google.com
Subject: Re: [PATCH 05/13] kselftest: arm64: mangle_pstate_invalid_daif_bits
Message-ID: <20190621103532.GM2790@e103592.cambridge.arm.com>
References: <20190613111335.7645-1-cristian.marussi@arm.com>
 <20190613111335.7645-6-cristian.marussi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190613111335.7645-6-cristian.marussi@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Jun 13, 2019 at 12:13:27PM +0100, Cristian Marussi wrote:
> Added a simple mangle testcase which messes with the ucontext_t
> from within the sig_handler, trying to set PSTATE DAIF bits to an
> invalid value (masking everything).
> Expects SIGSEGV on test PASS.
> 
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> ---
>  .../arm64/signal/testcases/.gitignore         |  1 +
>  .../mangle_pstate_invalid_daif_bits.c         | 25 +++++++++++++++++++
>  2 files changed, 26 insertions(+)
>  create mode 100644 tools/testing/selftests/arm64/signal/testcases/mangle_pstate_invalid_daif_bits.c
> 
> diff --git a/tools/testing/selftests/arm64/signal/testcases/.gitignore b/tools/testing/selftests/arm64/signal/testcases/.gitignore
> index a87fb0f0d2cf..a609a08b744f 100644
> --- a/tools/testing/selftests/arm64/signal/testcases/.gitignore
> +++ b/tools/testing/selftests/arm64/signal/testcases/.gitignore
> @@ -1,2 +1,3 @@
>  mangle_sp_misaligned
>  mangle_pc_invalid
> +mangle_pstate_invalid_daif_bits
> diff --git a/tools/testing/selftests/arm64/signal/testcases/mangle_pstate_invalid_daif_bits.c b/tools/testing/selftests/arm64/signal/testcases/mangle_pstate_invalid_daif_bits.c
> new file mode 100644
> index 000000000000..710681cba59c
> --- /dev/null
> +++ b/tools/testing/selftests/arm64/signal/testcases/mangle_pstate_invalid_daif_bits.c
> @@ -0,0 +1,25 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* Copyright (C) 2019 ARM Limited */
> +
> +#include "test_signals_utils.h"
> +#include "testcases.h"
> +
> +static int mangle_invalid_pstate_run(struct tdescr *td, siginfo_t *si,
> +				     ucontext_t *uc)
> +{
> +	ASSERT_GOOD_CONTEXT(uc);
> +
> +	/* This config should trigger a SIGSEGV by Kernel */
> +	uc->uc_mcontext.pstate |= PSR_D_BIT | PSR_A_BIT | PSR_I_BIT | PSR_F_BIT;

It may be worth commenting to mention what we're testing in the kernel
here: in this case, we're checking that valid_native_regs() is called
to police the new pstate value, and to check that it does the right
thing.

Is there a way to check that the SIGSEGV comes from the sigreturn and
not from something else?

It looks like the SIGSEGV should have si_code == SEGV_ACCERR and
si_addr == <sigframe base address> in this case.  uc_mcontext.pc will
also point into sigtramp in the vdso, which we may be able to check
somehow.

We don't have to have a bulletproof check here, but it would be nice to
have some kind of sanity-check at least.

[...]

Cheers
---Dave
