Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 498CB4E62F
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jun 2019 12:36:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbfFUKgK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 21 Jun 2019 06:36:10 -0400
Received: from foss.arm.com ([217.140.110.172]:58096 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726250AbfFUKgK (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 21 Jun 2019 06:36:10 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2412C28;
        Fri, 21 Jun 2019 03:36:09 -0700 (PDT)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 570743F718;
        Fri, 21 Jun 2019 03:36:08 -0700 (PDT)
Date:   Fri, 21 Jun 2019 11:36:06 +0100
From:   Dave Martin <Dave.Martin@arm.com>
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, shuah@kernel.org,
        andreyknvl@google.com
Subject: Re: [PATCH 10/13] kselftest: arm64: fake_sigreturn_bad_magic
Message-ID: <20190621103606.GR2790@e103592.cambridge.arm.com>
References: <20190613111335.7645-1-cristian.marussi@arm.com>
 <20190613111335.7645-11-cristian.marussi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190613111335.7645-11-cristian.marussi@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Jun 13, 2019 at 12:13:32PM +0100, Cristian Marussi wrote:
> Added a simple fake_sigreturn testcase which builds a ucontext_t
> with a bad magic header and place it onto the stack.
> Expects a SIGSEGV on test PASS.
> 
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> ---
>  .../arm64/signal/testcases/.gitignore         |  1 +
>  .../testcases/fake_sigreturn_bad_magic.c      | 42 +++++++++++++++++++
>  2 files changed, 43 insertions(+)
>  create mode 100644 tools/testing/selftests/arm64/signal/testcases/fake_sigreturn_bad_magic.c
> 
> diff --git a/tools/testing/selftests/arm64/signal/testcases/.gitignore b/tools/testing/selftests/arm64/signal/testcases/.gitignore
> index 3e6b26be6727..c353b7bd899d 100644
> --- a/tools/testing/selftests/arm64/signal/testcases/.gitignore
> +++ b/tools/testing/selftests/arm64/signal/testcases/.gitignore
> @@ -7,3 +7,4 @@ mangle_pstate_invalid_mode_el2
>  mangle_pstate_invalid_mode_el3
>  mangle_pstate_ssbs_regs
>  fake_sigreturn_misaligned
> +fake_sigreturn_bad_magic
> diff --git a/tools/testing/selftests/arm64/signal/testcases/fake_sigreturn_bad_magic.c b/tools/testing/selftests/arm64/signal/testcases/fake_sigreturn_bad_magic.c
> new file mode 100644
> index 000000000000..de81ea10393f
> --- /dev/null
> +++ b/tools/testing/selftests/arm64/signal/testcases/fake_sigreturn_bad_magic.c
> @@ -0,0 +1,42 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* Copyright (C) 2019 ARM Limited */
> +
> +#include <asm/sigcontext.h>
> +#include <ucontext.h>
> +#include <stdio.h>
> +
> +#include "test_signals_utils.h"
> +#include "testcases.h"
> +
> +struct a_sigframe sf;
> +
> +static int fake_sigreturn_bad_magic_run(struct tdescr *td,
> +					siginfo_t *si, ucontext_t *uc)
> +{
> +	struct _aarch64_ctx *head = GET_SF_RESV_HEAD(sf);
> +
> +	/* just to fill the ucontext_t with something real */
> +	if (!get_current_context(td, &sf.uc))
> +		return 1;
> +
> +	/* find the terminator, preserving existig headers */
> +	head = get_terminator(head, GET_SF_RESV_SIZE(sf), NULL);
> +	if (head) {
> +		head->magic = 0xdeadbeef;
> +		head->size = 128;

How can we be sure this won't overrun the end of the sigframe, once
the new terminator is appended?

If there is extra_context in the frame, the frame is only as large as
needed, so adding another record will always overrun the size of the
frame in that case.

I suggest splitting this test into a few cases, something like the
following.

(Note, some of these are already covered by your tests.  I'm just trying
to give the broad view here.)

1) Add a bogus record that doesn't overrun the frame.

2) Add a bogus record that does overrun the frame.

3) Add a record with a bogus size (i.e., not a multiple of 16 bytes, or
smaller than _aarch64_ctx).

3) Hack the size field of an existing record so that it overruns the
frame.  Thee are two subcases here: a record big enough that the next
_aarch64_ctx doesn't fit (probably already tested by
fake_sigreturn_overflow_reserved), and a record that overruns the frame
all by itself (tested by fake_sigreturn_bad_size, but it would be good
to check the exact boundary condition -- see my comments on that patch).

When checking that the kernel rejects an _aarch64_ctx header that
overruns the end of the frame, we should nonetheless write data for it
that looks valid, so that we know the kernel is rejecting it because of
the overrun and not because the header contents are invalid.

4) Delete a required record from the frame (say, fpsimd_context).
Or just delete everything.


For this series, maybe just do (1): this test nearly does that.

If there is extra_context, we can delete it and replace it with our
bogus record: this can't overrun if the bogus record's size is no bigger
than extra_context.

We should have tests to cover the other cases, but they can be TODO for
now.

[...]

Cheers
---Dave
