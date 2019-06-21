Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 448904E631
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jun 2019 12:36:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726309AbfFUKgQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 21 Jun 2019 06:36:16 -0400
Received: from foss.arm.com ([217.140.110.172]:58108 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726250AbfFUKgP (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 21 Jun 2019 06:36:15 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 00C4228;
        Fri, 21 Jun 2019 03:36:15 -0700 (PDT)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 335413F718;
        Fri, 21 Jun 2019 03:36:14 -0700 (PDT)
Date:   Fri, 21 Jun 2019 11:36:12 +0100
From:   Dave Martin <Dave.Martin@arm.com>
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, shuah@kernel.org,
        andreyknvl@google.com
Subject: Re: [PATCH 11/13] kselftest: arm64: fake_sigreturn_bad_size
Message-ID: <20190621103612.GS2790@e103592.cambridge.arm.com>
References: <20190613111335.7645-1-cristian.marussi@arm.com>
 <20190613111335.7645-12-cristian.marussi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190613111335.7645-12-cristian.marussi@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Jun 13, 2019 at 12:13:33PM +0100, Cristian Marussi wrote:
> Added a simple fake_sigreturn testcase which builds a ucontext_t
> with a badly sized header and place it onto the stack.
> Expects a SIGSEGV on test PASS.
> 
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> ---
>  .../arm64/signal/testcases/.gitignore         |  1 +
>  .../testcases/fake_sigreturn_bad_size.c       | 40 +++++++++++++++++++
>  2 files changed, 41 insertions(+)
>  create mode 100644 tools/testing/selftests/arm64/signal/testcases/fake_sigreturn_bad_size.c
> 
> diff --git a/tools/testing/selftests/arm64/signal/testcases/.gitignore b/tools/testing/selftests/arm64/signal/testcases/.gitignore
> index c353b7bd899d..9ad1735e0018 100644
> --- a/tools/testing/selftests/arm64/signal/testcases/.gitignore
> +++ b/tools/testing/selftests/arm64/signal/testcases/.gitignore
> @@ -8,3 +8,4 @@ mangle_pstate_invalid_mode_el3
>  mangle_pstate_ssbs_regs
>  fake_sigreturn_misaligned
>  fake_sigreturn_bad_magic
> +fake_sigreturn_bad_size
> diff --git a/tools/testing/selftests/arm64/signal/testcases/fake_sigreturn_bad_size.c b/tools/testing/selftests/arm64/signal/testcases/fake_sigreturn_bad_size.c
> new file mode 100644
> index 000000000000..d54f79d63bf6
> --- /dev/null
> +++ b/tools/testing/selftests/arm64/signal/testcases/fake_sigreturn_bad_size.c
> @@ -0,0 +1,40 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* Copyright (C) 2019 ARM Limited */
> +
> +#include <asm/sigcontext.h>
> +#include <ucontext.h>
> +
> +#include "test_signals_utils.h"
> +#include "testcases.h"
> +
> +struct a_sigframe sf;
> +
> +static int fake_sigreturn_bad_size_run(struct tdescr *td,
> +				       siginfo_t *si, ucontext_t *uc)
> +{
> +	struct _aarch64_ctx *head = GET_SF_RESV_HEAD(sf);
> +
> +	/* just to fill the ucontext_t with something real */
> +	if (!get_current_context(td, &sf.uc))
> +		return 1;
> +
> +	/* Tampering size to an unplausible number should cause a SEGV */
> +	head = get_terminator(head, GET_SF_RESV_SIZE(sf), NULL);
> +	if (head) {
> +		head->magic = ESR_MAGIC;

Add a comment to say why we're using this magic?

> +		head->size = GET_SF_RESV_SIZE(sf) * 2;

If we have extra_context, this might not be an invalid size, because
extra_context can be much larger than sizeof(__reserved) ... but also
we will overrun anyway, because extra_context should already be only
just large enough to accommodate the original terminator.

As with the previous test, we should probably throw away the
extra_context record (if any) and replace it with this new record.

We should check the actual boundary condition here, rather than just
testing with a giant size: we want to make the kernel detects any
overrun, however small.

We should also write a valid terminator after the new record, so
that we know the kernel is detecting the size overrun instead of
rejecting the next record because it is garbage.

> +
> +		ASSERT_BAD_CONTEXT(&sf.uc);
> +		fake_sigreturn(&sf, sizeof(sf), 16);
> +	}
> +
> +	return 1;
> +}

[...]

Cheers
---Dave
