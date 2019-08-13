Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2FE2F8BE6A
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Aug 2019 18:25:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727504AbfHMQYz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 13 Aug 2019 12:24:55 -0400
Received: from foss.arm.com ([217.140.110.172]:40016 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727714AbfHMQYz (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 13 Aug 2019 12:24:55 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7CB2F337;
        Tue, 13 Aug 2019 09:24:54 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B01F23F706;
        Tue, 13 Aug 2019 09:24:53 -0700 (PDT)
Date:   Tue, 13 Aug 2019 17:24:51 +0100
From:   Dave Martin <Dave.Martin@arm.com>
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, shuah@kernel.org,
        andreyknvl@google.com
Subject: Re: [PATCH v3 04/11] kselftest: arm64: mangle_pstate_invalid_mode_el
Message-ID: <20190813162451.GB10425@arm.com>
References: <20190802170300.20662-1-cristian.marussi@arm.com>
 <20190802170300.20662-5-cristian.marussi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190802170300.20662-5-cristian.marussi@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Aug 02, 2019 at 06:02:53PM +0100, Cristian Marussi wrote:
> Added 3 simple mangle testcases that mess with the ucontext_t

Add

> from within the sig_handler, trying to toggle PSTATE mode bits to

signal handler

> trick the system into switching to EL1/EL2/EL3. Expects SIGSEGV
> on test PASS.
> 
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> ---
>  .../arm64/signal/testcases/.gitignore         |  3 ++
>  .../mangle_pstate_invalid_mode_el1.c          | 29 +++++++++++++++++++
>  .../mangle_pstate_invalid_mode_el2.c          | 29 +++++++++++++++++++
>  .../mangle_pstate_invalid_mode_el3.c          | 29 +++++++++++++++++++
>  4 files changed, 90 insertions(+)
>  create mode 100644 tools/testing/selftests/arm64/signal/testcases/mangle_pstate_invalid_mode_el1.c
>  create mode 100644 tools/testing/selftests/arm64/signal/testcases/mangle_pstate_invalid_mode_el2.c
>  create mode 100644 tools/testing/selftests/arm64/signal/testcases/mangle_pstate_invalid_mode_el3.c
> 
> diff --git a/tools/testing/selftests/arm64/signal/testcases/.gitignore b/tools/testing/selftests/arm64/signal/testcases/.gitignore
> index 8a0a29f0cc2a..226bb179b673 100644
> --- a/tools/testing/selftests/arm64/signal/testcases/.gitignore
> +++ b/tools/testing/selftests/arm64/signal/testcases/.gitignore
> @@ -1,2 +1,5 @@
>  mangle_pstate_invalid_compat_toggle
>  mangle_pstate_invalid_daif_bits
> +mangle_pstate_invalid_mode_el1
> +mangle_pstate_invalid_mode_el2
> +mangle_pstate_invalid_mode_el3

What about having

	!*.[ch]
	mangle_*

rather than having to update .gitignore to list every test executable?

> diff --git a/tools/testing/selftests/arm64/signal/testcases/mangle_pstate_invalid_mode_el1.c b/tools/testing/selftests/arm64/signal/testcases/mangle_pstate_invalid_mode_el1.c
> new file mode 100644
> index 000000000000..07aed7624383
> --- /dev/null
> +++ b/tools/testing/selftests/arm64/signal/testcases/mangle_pstate_invalid_mode_el1.c
> @@ -0,0 +1,29 @@
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
> +	/*
> +	 * This config should trigger a SIGSEGV by Kernel
> +	 * when checking valid_user_regs()
> +	 */
> +	uc->uc_mcontext.pstate &= ~PSR_MODE_MASK;
> +	uc->uc_mcontext.pstate |= PSR_MODE_EL1t;
> +
> +	return 1;
> +}
> +
> +struct tdescr tde = {
> +		.sanity_disabled = true,
> +		.name = "MANGLE_PSTATE_INVALID_MODE_EL1t",
> +		.descr = "Mangling uc_mcontext with INVALID MODE EL1t",
> +		.sig_trig = SIGUSR1,
> +		.sig_ok = SIGSEGV,
> +		.run = mangle_invalid_pstate_run,
> +};

These tests seem identical except for the EL number.
Can we macro-ise them?

mangle_pstate_invalid_mode_el1.c could become

--8<--

#include "mangle_pstate_invalid_mode.h"

DEFINE_TESTCASE_MANGLE_PSTATE_INVALID_MODE(1)

-->8--

(for example).

[...]

Cheers
---Dave
