Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C4258A8163
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Sep 2019 13:49:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728021AbfIDLtF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 4 Sep 2019 07:49:05 -0400
Received: from foss.arm.com ([217.140.110.172]:52720 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727125AbfIDLtF (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 4 Sep 2019 07:49:05 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5DBFE337;
        Wed,  4 Sep 2019 04:49:04 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 76ABB3F246;
        Wed,  4 Sep 2019 04:49:03 -0700 (PDT)
Date:   Wed, 4 Sep 2019 12:49:01 +0100
From:   Dave Martin <Dave.Martin@arm.com>
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, shuah@kernel.org,
        amit.kachhap@arm.com, andreyknvl@google.com
Subject: Re: [PATCH v5 07/11] kselftest: arm64:
 fake_sigreturn_bad_size_for_magic0
Message-ID: <20190904114901.GX27757@arm.com>
References: <20190902112932.36129-1-cristian.marussi@arm.com>
 <20190902112932.36129-8-cristian.marussi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190902112932.36129-8-cristian.marussi@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Sep 02, 2019 at 12:29:28pm +0100, Cristian Marussi wrote:
> Add a simple fake_sigreturn testcase which builds a ucontext_t with a
> badly sized terminator record and place it onto the stack.
> Expects a SIGSEGV on test PASS.
> 
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> ---
> v3 --> v4
> - fix commit
> - add signal.h include
> - using new get_starting_head() helper
> - added test description
> ---
>  .../fake_sigreturn_bad_size_for_magic0.c      | 49 +++++++++++++++++++
>  1 file changed, 49 insertions(+)
>  create mode 100644 tools/testing/selftests/arm64/signal/testcases/fake_sigreturn_bad_size_for_magic0.c
> 
> diff --git a/tools/testing/selftests/arm64/signal/testcases/fake_sigreturn_bad_size_for_magic0.c b/tools/testing/selftests/arm64/signal/testcases/fake_sigreturn_bad_size_for_magic0.c
> new file mode 100644
> index 000000000000..25017fe18214
> --- /dev/null
> +++ b/tools/testing/selftests/arm64/signal/testcases/fake_sigreturn_bad_size_for_magic0.c
> @@ -0,0 +1,49 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2019 ARM Limited
> + *
> + * Place a fake sigframe on the stack including a badly sized terminator
> + * record: on sigreturn Kernel must spot this attempt and the test case
> + * is expected to be terminated via SEGV.
> + */
> +
> +#include <signal.h>
> +#include <ucontext.h>
> +
> +#include "test_signals_utils.h"
> +#include "testcases.h"
> +
> +struct fake_sigframe sf;
> +
> +static int fake_sigreturn_bad_size_for_magic0_run(struct tdescr *td,
> +						  siginfo_t *si, ucontext_t *uc)
> +{
> +	size_t resv_sz, need_sz;
> +	struct _aarch64_ctx *shead = GET_SF_RESV_HEAD(sf), *head;
> +
> +	/* just to fill the ucontext_t with something real */
> +	if (!get_current_context(td, &sf.uc))
> +		return 1;
> +
> +	resv_sz = GET_SF_RESV_SIZE(sf);
> +	/* at least HDR_SZ for the badly sized terminator. */
> +	need_sz = HDR_SZ;

Nit: do we need the resv_sz and need_sz variables here?

> +	head = get_starting_head(shead, need_sz, resv_sz, NULL);
> +	if (head) {

Perhaps we could fail immediately rather than relying on timeout here?

Probably not a huge deal though.

> +		head->magic = 0;
> +		head->size = HDR_SZ;
> +
> +		ASSERT_BAD_CONTEXT(&sf.uc);
> +		fake_sigreturn(&sf, sizeof(sf), 0);
> +	}
> +
> +	return 1;
> +}
> +
> +struct tdescr tde = {
> +		.name = "FAKE_SIGRETURN_BAD_SIZE_FOR_TERMINATOR",
> +		.descr = "Trigger a sigreturn using non-zero size terminator",
> +		.sig_ok = SIGSEGV,
> +		.timeout = 3,
> +		.run = fake_sigreturn_bad_size_for_magic0_run,
> +};

Either way,

Reviewed-by: Dave Martin <Dave.Martin@arm.com>
