Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12BC74E632
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jun 2019 12:36:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726339AbfFUKgV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 21 Jun 2019 06:36:21 -0400
Received: from foss.arm.com ([217.140.110.172]:58122 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726299AbfFUKgV (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 21 Jun 2019 06:36:21 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 07EB01478;
        Fri, 21 Jun 2019 03:36:21 -0700 (PDT)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3ADA33F718;
        Fri, 21 Jun 2019 03:36:20 -0700 (PDT)
Date:   Fri, 21 Jun 2019 11:36:18 +0100
From:   Dave Martin <Dave.Martin@arm.com>
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, shuah@kernel.org,
        andreyknvl@google.com
Subject: Re: [PATCH 12/13] kselftest: arm64:
 fake_sigreturn_bad_size_for_magic0
Message-ID: <20190621103618.GT2790@e103592.cambridge.arm.com>
References: <20190613111335.7645-1-cristian.marussi@arm.com>
 <20190613111335.7645-13-cristian.marussi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190613111335.7645-13-cristian.marussi@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Jun 13, 2019 at 12:13:34PM +0100, Cristian Marussi wrote:
> Added a simple fake_sigreturn testcase which builds a ucontext_t
> with a badly sized magic0 header and place it onto the stack.
> Expects a SIGSEGV on test PASS.
> 
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> ---
>  .../arm64/signal/testcases/.gitignore         |  1 +
>  .../fake_sigreturn_bad_size_for_magic0.c      | 44 +++++++++++++++++++
>  2 files changed, 45 insertions(+)
>  create mode 100644 tools/testing/selftests/arm64/signal/testcases/fake_sigreturn_bad_size_for_magic0.c
> 
> diff --git a/tools/testing/selftests/arm64/signal/testcases/.gitignore b/tools/testing/selftests/arm64/signal/testcases/.gitignore
> index 9ad1735e0018..66ba865b3b7e 100644
> --- a/tools/testing/selftests/arm64/signal/testcases/.gitignore
> +++ b/tools/testing/selftests/arm64/signal/testcases/.gitignore
> @@ -9,3 +9,4 @@ mangle_pstate_ssbs_regs
>  fake_sigreturn_misaligned
>  fake_sigreturn_bad_magic
>  fake_sigreturn_bad_size
> +fake_sigreturn_bad_size_for_magic0
> diff --git a/tools/testing/selftests/arm64/signal/testcases/fake_sigreturn_bad_size_for_magic0.c b/tools/testing/selftests/arm64/signal/testcases/fake_sigreturn_bad_size_for_magic0.c
> new file mode 100644
> index 000000000000..703909959473
> --- /dev/null
> +++ b/tools/testing/selftests/arm64/signal/testcases/fake_sigreturn_bad_size_for_magic0.c
> @@ -0,0 +1,44 @@
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
> +static int fake_sigreturn_bad_size_for_magic0_run(struct tdescr *td,
> +						  siginfo_t *si, ucontext_t *uc)
> +{
> +	struct _aarch64_ctx *head = GET_SF_RESV_HEAD(sf);
> +
> +	/* just to fill the ucontext_t with something real */
> +	if (!get_current_context(td, &sf.uc))
> +		return 1;
> +
> +	/*
> +	 * Jump to the free slot...we must preserve existing
> +	 * magics like fpsimd in order no to SEGV anyway
> +	 */
> +	head = get_terminator(head, GET_SF_RESV_SIZE(sf), NULL);
> +	if (head) {
> +		head->magic = 0;
> +		head->size = 256;

What if this overruns the signal frame?  We want to know that the kernel
is rejecting the terminator because its size is wrong, not because the
size overruns the frame or is invalid is some other way.

For example, if the kernel code were refactored to check that the record
fits in the frame first, before looking at the magic, then this test
could pass for the wrong reason.

[...]

Cheers
---Dave
