Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 446364E626
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jun 2019 12:35:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbfFUKfX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 21 Jun 2019 06:35:23 -0400
Received: from foss.arm.com ([217.140.110.172]:58002 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726289AbfFUKfW (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 21 Jun 2019 06:35:22 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D427028;
        Fri, 21 Jun 2019 03:35:21 -0700 (PDT)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 12F2E3F718;
        Fri, 21 Jun 2019 03:35:20 -0700 (PDT)
Date:   Fri, 21 Jun 2019 11:35:19 +0100
From:   Dave Martin <Dave.Martin@arm.com>
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, shuah@kernel.org,
        andreyknvl@google.com
Subject: Re: [PATCH 03/13] kselftest: arm64: mangle_sp_misaligned
Message-ID: <20190621103518.GK2790@e103592.cambridge.arm.com>
References: <20190613111335.7645-1-cristian.marussi@arm.com>
 <20190613111335.7645-4-cristian.marussi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190613111335.7645-4-cristian.marussi@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Jun 13, 2019 at 12:13:25PM +0100, Cristian Marussi wrote:
> Added a simple mangle testcase which messes with the ucontext_t
> from within the sig_handler, trying to badly modify and misalign the SP.
> Expects SIGBUS on test PASS.
> 
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> ---
>  .../arm64/signal/testcases/.gitignore         |  1 +
>  .../signal/testcases/mangle_sp_misaligned.c   | 24 +++++++++++++++++++
>  2 files changed, 25 insertions(+)
>  create mode 100644 tools/testing/selftests/arm64/signal/testcases/.gitignore
>  create mode 100644 tools/testing/selftests/arm64/signal/testcases/mangle_sp_misaligned.c
> 
> diff --git a/tools/testing/selftests/arm64/signal/testcases/.gitignore b/tools/testing/selftests/arm64/signal/testcases/.gitignore
> new file mode 100644
> index 000000000000..7f7414d241f2
> --- /dev/null
> +++ b/tools/testing/selftests/arm64/signal/testcases/.gitignore
> @@ -0,0 +1 @@
> +mangle_sp_misaligned
> diff --git a/tools/testing/selftests/arm64/signal/testcases/mangle_sp_misaligned.c b/tools/testing/selftests/arm64/signal/testcases/mangle_sp_misaligned.c
> new file mode 100644
> index 000000000000..41bd27312e54
> --- /dev/null
> +++ b/tools/testing/selftests/arm64/signal/testcases/mangle_sp_misaligned.c
> @@ -0,0 +1,24 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* Copyright (C) 2019 ARM Limited */
> +
> +#include "test_signals_utils.h"
> +#include "testcases.h"
> +
> +static int mangle_misaligned_sp_run(struct tdescr *td, siginfo_t *si,
> +				    ucontext_t *uc)
> +{
> +	ASSERT_GOOD_CONTEXT(uc);
> +
> +	uc->uc_mcontext.sp += 3;

What are we testing here?

It is archietcturally permitted (if unusual) to have a misaligned sp in
userspace.

So are we just getting a SIGBUS after the sigreturn, when the thread
tries to dereference sp?  If so, we aren't really testing anything about
sigreturn here -- I don't see any check in the kernel when restoring sp
in sigreturn.

Even if there were no SIGBUS, the thread stack is now corrupt (due to
wrong sp), so the interrupted code is unlikely to continue running
successfully.

Am I missing something?

[...]

Cheers
---Dave
