Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6FEFD4E62C
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jun 2019 12:35:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726339AbfFUKfv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 21 Jun 2019 06:35:51 -0400
Received: from foss.arm.com ([217.140.110.172]:58066 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726250AbfFUKfv (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 21 Jun 2019 06:35:51 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 516F328;
        Fri, 21 Jun 2019 03:35:50 -0700 (PDT)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 843CB3F718;
        Fri, 21 Jun 2019 03:35:49 -0700 (PDT)
Date:   Fri, 21 Jun 2019 11:35:47 +0100
From:   Dave Martin <Dave.Martin@arm.com>
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, shuah@kernel.org,
        andreyknvl@google.com
Subject: Re: [PATCH 07/13] kselftest: arm64: mangle_pstate_invalid_mode_el?
Message-ID: <20190621103547.GO2790@e103592.cambridge.arm.com>
References: <20190613111335.7645-1-cristian.marussi@arm.com>
 <20190613111335.7645-8-cristian.marussi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190613111335.7645-8-cristian.marussi@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

^ Subject line seems to end with a ?

Typo?

On Thu, Jun 13, 2019 at 12:13:29PM +0100, Cristian Marussi wrote:
> Added 3 simple mangle testcases that mess with the ucontext_t
> from within the sig_handler, trying to toggle PSTATE mode bits to
> trick the system into switching to EL1/EL2/EL3.
> Expects SIGSEGV on test PASS.

For good measure, we may as well also test for the "h" modes.

I wonder whether this can be macro-ised somehow, since the tests are
identical except for the pstate mode field value and the name?

> 
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> ---
>  .../arm64/signal/testcases/.gitignore         |  3 +++
>  .../mangle_pstate_invalid_mode_el1.c          | 25 +++++++++++++++++++
>  .../mangle_pstate_invalid_mode_el2.c          | 25 +++++++++++++++++++
>  .../mangle_pstate_invalid_mode_el3.c          | 25 +++++++++++++++++++
>  4 files changed, 78 insertions(+)
>  create mode 100644 tools/testing/selftests/arm64/signal/testcases/mangle_pstate_invalid_mode_el1.c
>  create mode 100644 tools/testing/selftests/arm64/signal/testcases/mangle_pstate_invalid_mode_el2.c
>  create mode 100644 tools/testing/selftests/arm64/signal/testcases/mangle_pstate_invalid_mode_el3.c
> 
> diff --git a/tools/testing/selftests/arm64/signal/testcases/.gitignore b/tools/testing/selftests/arm64/signal/testcases/.gitignore
> index 91f7aee4b666..e7a1d998b650 100644
> --- a/tools/testing/selftests/arm64/signal/testcases/.gitignore
> +++ b/tools/testing/selftests/arm64/signal/testcases/.gitignore
> @@ -2,3 +2,6 @@ mangle_sp_misaligned
>  mangle_pc_invalid
>  mangle_pstate_invalid_daif_bits
>  mangle_pstate_invalid_state_toggle
> +mangle_pstate_invalid_mode_el1
> +mangle_pstate_invalid_mode_el2
> +mangle_pstate_invalid_mode_el3
> diff --git a/tools/testing/selftests/arm64/signal/testcases/mangle_pstate_invalid_mode_el1.c b/tools/testing/selftests/arm64/signal/testcases/mangle_pstate_invalid_mode_el1.c
> new file mode 100644
> index 000000000000..9f5bde2e287f
> --- /dev/null
> +++ b/tools/testing/selftests/arm64/signal/testcases/mangle_pstate_invalid_mode_el1.c
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
> +	uc->uc_mcontext.pstate |= PSR_MODE_EL1t;

For cleanliness, should we mask out the old mode field first, even if
we expect it to be initiall zero?

[...]

Cheers
---Dave
