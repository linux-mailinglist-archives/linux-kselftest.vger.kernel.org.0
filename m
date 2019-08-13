Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F7AF8BE85
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Aug 2019 18:28:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727351AbfHMQ2A (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 13 Aug 2019 12:28:00 -0400
Received: from foss.arm.com ([217.140.110.172]:40204 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727053AbfHMQ2A (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 13 Aug 2019 12:28:00 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3CCD0337;
        Tue, 13 Aug 2019 09:27:59 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 70D053F706;
        Tue, 13 Aug 2019 09:27:58 -0700 (PDT)
Date:   Tue, 13 Aug 2019 17:27:56 +0100
From:   Dave Martin <Dave.Martin@arm.com>
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, shuah@kernel.org,
        andreyknvl@google.com
Subject: Re: [PATCH v3 11/11] kselftest: arm64: fake_sigreturn_misaligned_sp
Message-ID: <20190813162756.GI10425@arm.com>
References: <20190802170300.20662-1-cristian.marussi@arm.com>
 <20190802170300.20662-12-cristian.marussi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190802170300.20662-12-cristian.marussi@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Aug 02, 2019 at 06:03:00PM +0100, Cristian Marussi wrote:
> Added a simple fake_sigreturn testcase which places a valid

Add

> sigframe on a non-16 bytes aligned SP.
> fake_sigretrun() helper function has been patched accordingly
> to support placing a sigframe on a non-16 bytes aligned address.
> Expects a SIGSEGV on test PASS.
> 
> Adds also a test TODO lists holding some further test ideas.

Adds -> Also add
lists -> list

> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> ---
> Re-added this text after fixing the forced misaglinment procedure in
> fake_sigreturn() itself: require a ZERO alignment and you'll get
> your sigframe placed on a misaligned SP (2-bytes off the 16-align)
> ---
>  .../testing/selftests/arm64/signal/signals.S  | 21 +++++++++----
>  .../arm64/signal/testcases/TODO.readme        |  8 +++++
>  .../testcases/fake_sigreturn_misaligned_sp.c  | 30 +++++++++++++++++++
>  3 files changed, 53 insertions(+), 6 deletions(-)
>  create mode 100644 tools/testing/selftests/arm64/signal/testcases/TODO.readme
>  create mode 100644 tools/testing/selftests/arm64/signal/testcases/fake_sigreturn_misaligned_sp.c
> 
> diff --git a/tools/testing/selftests/arm64/signal/signals.S b/tools/testing/selftests/arm64/signal/signals.S
> index 6262b877400b..2099871176ed 100644
> --- a/tools/testing/selftests/arm64/signal/signals.S
> +++ b/tools/testing/selftests/arm64/signal/signals.S
> @@ -13,19 +13,28 @@ call_fmt:
>  
>  .globl fake_sigreturn
>  
> -/*	fake_sigreturn	x0:&sigframe,  x1:sigframe_size,  x2:alignment_SP */
> +/*	fake_sigreturn	x0:&sigframe, x1:sigframe_sz, x2:align */
>  fake_sigreturn:
> -	mov x20, x0
> -	mov x21, x1
> -	mov x22, x2
> -	mov x23, sp
>  
> -	/* create space on the stack for fake sigframe..."x22"-aligned */
> +	/* Save args and decide which aligment to enforce */
> +	mov 	x23, sp
> +	mov	x20, x0
> +	mov 	x21, x1
> +	/* x22 and x24 used for forcing alignment or misalignment */
> +	mov	x22, x2
> +	mov	x24, #0
> +	cbnz	x22, 1f
> +	mov	x22, #16
> +	mov	x24, #2
> +
> +1:	/* create space on the stack for fake sigframe..."x22"-aligned */
>  	mov x0, #0
>  	add x0, x21, x22
>  	sub x22, x22, #1
>  	bic x0, x0, x22
>  	sub x23, x23, x0
> +	/* force misaligned by x24 bytes if required alignment was zero */
> +	add x23, x23, x24
>  
>  	ldr x0, =call_fmt
>  	mov x1, x21

Would it be simpler for the third argument to specify a number of bytes
to subtract from SP after allocating 16-byte aligned storage to
accommodate sigframe_sz?

Then 0 gives an aligned frame, 1 gives a frame misaligned by 1 byte,
etc.


Also if all this is a fix to the original fake_sigreturn, can we merge
it into the original patch instead?

> diff --git a/tools/testing/selftests/arm64/signal/testcases/TODO.readme b/tools/testing/selftests/arm64/signal/testcases/TODO.readme
> new file mode 100644
> index 000000000000..5c949492e7ab
> --- /dev/null
> +++ b/tools/testing/selftests/arm64/signal/testcases/TODO.readme
> @@ -0,0 +1,8 @@
> +Some more possible ideas for signals tests:
> +
> +- fake_sigreturn_unmapped_sp
> +- fake_sigreturn_kernelspace_sp
> +- fake_sigreturn_sve_bad_extra_context
> +- mangle_sve_invalid_extra_context
> +- mangle_pstate_invalid_el for H modes (+ macroization ?)
> +- fake_sigreturn_overflow_reserved

This seems a reasonable list, but it occurs to me that it will tend to
go out of sync as tests get added.  So maybe just put this list in the
cover letter instead of including it in the patch.

We should probably have a one-line description of each proposed test,
since the names are a bit cryptic.

> diff --git a/tools/testing/selftests/arm64/signal/testcases/fake_sigreturn_misaligned_sp.c b/tools/testing/selftests/arm64/signal/testcases/fake_sigreturn_misaligned_sp.c
> new file mode 100644
> index 000000000000..3ee8c500c7d1
> --- /dev/null
> +++ b/tools/testing/selftests/arm64/signal/testcases/fake_sigreturn_misaligned_sp.c
> @@ -0,0 +1,30 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* Copyright (C) 2019 ARM Limited */
> +

signal.h?

> +#include <ucontext.h>
> +
> +#include "test_signals_utils.h"
> +#include "testcases.h"
> +
> +struct fake_sigframe sf;
> +
> +static int fake_sigreturn_misaligned_run(struct tdescr *td,
> +				         siginfo_t *si, ucontext_t *uc)
> +{
> +	/* just to fill the ucontext_t with something real */
> +	if (!get_current_context(td, &sf.uc))
> +		return 1;
> +
> +	/* Forcing sigframe on misaligned (=!16) SP */
> +	fake_sigreturn(&sf, sizeof(sf), 0);
> +
> +	return 1;
> +}

[...]

Cheers
---Dave
