Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD5168BE70
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Aug 2019 18:25:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726808AbfHMQZy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 13 Aug 2019 12:25:54 -0400
Received: from foss.arm.com ([217.140.110.172]:40094 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726802AbfHMQZy (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 13 Aug 2019 12:25:54 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D1F3B337;
        Tue, 13 Aug 2019 09:25:53 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 11D223F706;
        Tue, 13 Aug 2019 09:25:52 -0700 (PDT)
Date:   Tue, 13 Aug 2019 17:25:50 +0100
From:   Dave Martin <Dave.Martin@arm.com>
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, shuah@kernel.org,
        andreyknvl@google.com
Subject: Re: [PATCH v3 07/11] kselftest: arm64:
 fake_sigreturn_bad_size_for_magic0
Message-ID: <20190813162550.GE10425@arm.com>
References: <20190802170300.20662-1-cristian.marussi@arm.com>
 <20190802170300.20662-8-cristian.marussi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190802170300.20662-8-cristian.marussi@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Aug 02, 2019 at 06:02:56PM +0100, Cristian Marussi wrote:
> Added a simple fake_sigreturn testcase which builds a ucontext_t

Add

> with a badly sized magic0 header and place it onto the stack.

I usually call a record with magic number 0 a "terminator record".

> Expects a SIGSEGV on test PASS.
> 
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> ---
>  .../arm64/signal/testcases/.gitignore         |  1 +
>  .../fake_sigreturn_bad_size_for_magic0.c      | 57 +++++++++++++++++++
>  2 files changed, 58 insertions(+)
>  create mode 100644 tools/testing/selftests/arm64/signal/testcases/fake_sigreturn_bad_size_for_magic0.c
> 
> diff --git a/tools/testing/selftests/arm64/signal/testcases/.gitignore b/tools/testing/selftests/arm64/signal/testcases/.gitignore
> index 0ea6fdc3765c..cf2a73599818 100644
> --- a/tools/testing/selftests/arm64/signal/testcases/.gitignore
> +++ b/tools/testing/selftests/arm64/signal/testcases/.gitignore
> @@ -5,3 +5,4 @@ mangle_pstate_invalid_mode_el2
>  mangle_pstate_invalid_mode_el3
>  mangle_pstate_ssbs_regs
>  fake_sigreturn_bad_magic
> +fake_sigreturn_bad_size_for_magic0
> diff --git a/tools/testing/selftests/arm64/signal/testcases/fake_sigreturn_bad_size_for_magic0.c b/tools/testing/selftests/arm64/signal/testcases/fake_sigreturn_bad_size_for_magic0.c
> new file mode 100644
> index 000000000000..2f53c4740c85
> --- /dev/null
> +++ b/tools/testing/selftests/arm64/signal/testcases/fake_sigreturn_bad_size_for_magic0.c
> @@ -0,0 +1,57 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* Copyright (C) 2019 ARM Limited */
> +

#include <signal.h> ?

> +#include <stdio.h>
> +#include <ucontext.h>
> +
> +#include "test_signals_utils.h"
> +#include "testcases.h"
> +
> +struct fake_sigframe sf;
> +
> +#define MIN_SZ_ALIGN	16
> +
> +static int fake_sigreturn_bad_size_for_magic0_run(struct tdescr *td,
> +						  siginfo_t *si, ucontext_t *uc)
> +{
> +	size_t resv_sz, offset;
> +	struct _aarch64_ctx *shead = GET_SF_RESV_HEAD(sf), *head;
> +
> +	/* just to fill the ucontext_t with something real */
> +	if (!get_current_context(td, &sf.uc))
> +		return 1;
> +
> +	resv_sz = GET_SF_RESV_SIZE(sf);
> +	/*
> +	 * find the terminator, preserving existing headers
> +	 * and verify amount of spare room in __reserved area.
> +	 */
> +	head = get_terminator(shead, resv_sz, &offset);
> +	/*
> +	 * try stripping extra_context header when low on space:
> +	 * we need at least HDR_SZ + 16 space for the bad sized terminator.
> +	 */
> +	if (head && resv_sz - offset < HDR_SZ + MIN_SZ_ALIGN) {
> +		fprintf(stderr, "Low on space:%zd. Discarding extra_context.\n",
> +			resv_sz - offset);
> +		head = get_header(shead, EXTRA_MAGIC, resv_sz, &offset);
> +	}
> +	/* just give up and timeout if still not enough space */
> +	if (head && resv_sz - offset >= HDR_SZ + MIN_SZ_ALIGN) {
> +		head->magic = 0;
> +		head->size = MIN_SZ_ALIGN;

This is different from the amount of space we tested for
(HDR_SZ + MIN_SZ_ALIGN) earlier.

I'm not sure it matters which we use, but we should be consistent.

I suggest sticking with HDR_SZ, unless there's something I've missed.

[...]

Cheers
---Dave
