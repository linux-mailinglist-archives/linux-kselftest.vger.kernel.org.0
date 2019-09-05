Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A74AFAA355
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2019 14:39:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731294AbfIEMjJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 5 Sep 2019 08:39:09 -0400
Received: from foss.arm.com ([217.140.110.172]:44358 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730959AbfIEMjI (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 5 Sep 2019 08:39:08 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CA27D28;
        Thu,  5 Sep 2019 05:39:07 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E1A363F718;
        Thu,  5 Sep 2019 05:39:06 -0700 (PDT)
Date:   Thu, 5 Sep 2019 13:39:04 +0100
From:   Dave Martin <Dave.Martin@arm.com>
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     amit.kachhap@arm.com, andreyknvl@google.com, shuah@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v5 09/11] kselftest: arm64:
 fake_sigreturn_duplicated_fpsimd
Message-ID: <20190905123904.GD27757@arm.com>
References: <20190902112932.36129-1-cristian.marussi@arm.com>
 <20190902112932.36129-10-cristian.marussi@arm.com>
 <20190904114923.GZ27757@arm.com>
 <f29dbde7-90eb-3a06-71a0-e434afa9f89d@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f29dbde7-90eb-3a06-71a0-e434afa9f89d@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Sep 05, 2019 at 01:15:58PM +0100, Cristian Marussi wrote:
> Hi
> 
> On 04/09/2019 12:49, Dave Martin wrote:
> > On Mon, Sep 02, 2019 at 12:29:30pm +0100, Cristian Marussi wrote:
> >> Add a simple fake_sigreturn testcase which builds a ucontext_t with
> >> an anomalous additional fpsimd_context and place it onto the stack.
> >> Expects a SIGSEGV on test PASS.
> >>
> >> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> >> ---
> >> v3 --> v4
> >> - fix commit
> >> - missing include
> >> - using new get_starting_head() helper
> >> - added test description
> >> ---
> >>  .../fake_sigreturn_duplicated_fpsimd.c        | 52 +++++++++++++++++++
> >>  1 file changed, 52 insertions(+)
> >>  create mode 100644 tools/testing/selftests/arm64/signal/testcases/fake_sigreturn_duplicated_fpsimd.c
> >>
> >> diff --git a/tools/testing/selftests/arm64/signal/testcases/fake_sigreturn_duplicated_fpsimd.c b/tools/testing/selftests/arm64/signal/testcases/fake_sigreturn_duplicated_fpsimd.c
> >> new file mode 100644
> >> index 000000000000..c7122c44f53f
> >> --- /dev/null
> >> +++ b/tools/testing/selftests/arm64/signal/testcases/fake_sigreturn_duplicated_fpsimd.c
> >> @@ -0,0 +1,52 @@
> >> +// SPDX-License-Identifier: GPL-2.0
> >> +/*
> >> + * Copyright (C) 2019 ARM Limited
> >> + *
> >> + * Place a fake sigframe on the stack including an additional FPSIMD
> >> + * record: on sigreturn Kernel must spot this attempt and the test
> >> + * case is expected to be terminated via SEGV.
> >> + */
> >> +
> >> +#include <signal.h>
> >> +#include <ucontext.h>
> >> +
> >> +#include "test_signals_utils.h"
> >> +#include "testcases.h"
> >> +
> >> +struct fake_sigframe sf;
> >> +
> >> +static int fake_sigreturn_duplicated_fpsimd_run(struct tdescr *td,
> >> +						siginfo_t *si, ucontext_t *uc)
> >> +{
> >> +	size_t resv_sz, need_sz;
> >> +	struct _aarch64_ctx *shead = GET_SF_RESV_HEAD(sf), *head;
> >> +
> >> +	/* just to fill the ucontext_t with something real */
> >> +	if (!get_current_context(td, &sf.uc))
> >> +		return 1;
> >> +
> >> +	resv_sz = GET_SF_RESV_SIZE(sf);
> >> +	need_sz = HDR_SZ + sizeof(struct fpsimd_context);
> > 
> > Nit: Maybe write this sum in the same order as the records we're going 
> > o append, i.e.:
> > 
> > 	need_sz = sizeof(struct fpsimd_context) + HDR_SZ; /* for terminator */
> 
> Ok
> 
> > 
> > Also, maybe fail this test if there is no fpsimd_context in the initial
> > frame from get_current_context(): that would be a kernel bug, but we
> > wouldn't be giving fake_sigreturn() duplicate fpsimd_contexts in that
> > case -- so this test wouldn't test the thing it's supposed to test.
> > 
> 
> Any context grabbed by get_current_context() is verified at first to be sane
> when is copied in the handler by ASSERT_GOOD_CONTEXT()
> 
> >   } else if (signum == sig_copyctx && current->live_uc) {
> >                 memcpy(current->live_uc, uc, current->live_sz);
> >                 ASSERT_GOOD_CONTEXT(current->live_uc);
> >                 current->live_uc_valid = 1;
> 
> A missing fpsimd in the original sigframe would lead to an abort()
> straight away while preparing the test, and the test will fail.

OK, but there is no abort() in ASSERT_GOOD_CONTEXT(), only assert(0).
Can you add an abort() after the assert() in there in patch 2?

People probably aren't going to be building the tests with -DNDEBUG, but
we should avoid unnecessary surprises...

Cheers
---Dave
