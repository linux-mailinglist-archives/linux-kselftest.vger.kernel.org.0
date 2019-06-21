Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4EEB4E629
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jun 2019 12:35:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726289AbfFUKf3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 21 Jun 2019 06:35:29 -0400
Received: from foss.arm.com ([217.140.110.172]:58030 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726250AbfFUKf3 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 21 Jun 2019 06:35:29 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 047EE1478;
        Fri, 21 Jun 2019 03:35:29 -0700 (PDT)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 373F03F718;
        Fri, 21 Jun 2019 03:35:28 -0700 (PDT)
Date:   Fri, 21 Jun 2019 11:35:26 +0100
From:   Dave Martin <Dave.Martin@arm.com>
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, shuah@kernel.org,
        andreyknvl@google.com
Subject: Re: [PATCH 04/13] kselftest: arm64: mangle_pc_invalid
Message-ID: <20190621103526.GL2790@e103592.cambridge.arm.com>
References: <20190613111335.7645-1-cristian.marussi@arm.com>
 <20190613111335.7645-5-cristian.marussi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190613111335.7645-5-cristian.marussi@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Jun 13, 2019 at 12:13:26PM +0100, Cristian Marussi wrote:
> Added a simple mangle testcase which messes with the ucontext_t
> from within the sig_handler, trying to badly modify the PC to point
> toward Kernel land.
> Expects SIGSEGV on test PASS.
> 
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> ---
>  .../arm64/signal/testcases/.gitignore         |  1 +
>  .../signal/testcases/mangle_pc_invalid.c      | 24 +++++++++++++++++++
>  2 files changed, 25 insertions(+)
>  create mode 100644 tools/testing/selftests/arm64/signal/testcases/mangle_pc_invalid.c
> 
> diff --git a/tools/testing/selftests/arm64/signal/testcases/.gitignore b/tools/testing/selftests/arm64/signal/testcases/.gitignore
> index 7f7414d241f2..a87fb0f0d2cf 100644
> --- a/tools/testing/selftests/arm64/signal/testcases/.gitignore
> +++ b/tools/testing/selftests/arm64/signal/testcases/.gitignore
> @@ -1 +1,2 @@
>  mangle_sp_misaligned
> +mangle_pc_invalid
> diff --git a/tools/testing/selftests/arm64/signal/testcases/mangle_pc_invalid.c b/tools/testing/selftests/arm64/signal/testcases/mangle_pc_invalid.c
> new file mode 100644
> index 000000000000..0024032528bc
> --- /dev/null
> +++ b/tools/testing/selftests/arm64/signal/testcases/mangle_pc_invalid.c
> @@ -0,0 +1,24 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* Copyright (C) 2019 ARM Limited */
> +
> +#include "test_signals_utils.h"
> +#include "testcases.h"
> +
> +static int mangle_invalid_pc_run(struct tdescr *td, siginfo_t *si,
> +				 ucontext_t *uc)
> +{
> +	ASSERT_GOOD_CONTEXT(uc);
> +
> +	uc->uc_mcontext.pc = 0xffffffffcccccccc;

Similarly to the previous test, I don't think this is testing the
sigreturn behaviour: the kernel just restores the bogus PC value and
returns to userspace.  We then rely on the architecture to generate a
prefetch abort when trying to fetch from the bogus PC.

Am I missing anything?

Could we have a test that points SP to kernel memory and the calls
sigreturn: there is a real behaviour to test there: we must not be able
to trick the kernel into interpreting kernel memory as a signal frame.

[...]

Cheers
--Dave
