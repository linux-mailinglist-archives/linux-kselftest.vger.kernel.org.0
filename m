Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E5F825F7F8
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Sep 2020 12:24:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728451AbgIGKYJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Sep 2020 06:24:09 -0400
Received: from foss.arm.com ([217.140.110.172]:59986 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728424AbgIGKYC (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Sep 2020 06:24:02 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 35F29106F;
        Mon,  7 Sep 2020 03:24:01 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D9BA73F66E;
        Mon,  7 Sep 2020 03:23:59 -0700 (PDT)
Date:   Mon, 7 Sep 2020 11:23:57 +0100
From:   Dave Martin <Dave.Martin@arm.com>
To:     Boyan Karatotev <boyan.karatotev@arm.com>
Cc:     Shuah Khan <shuah@kernel.org>, boian4o1@gmail.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        amit.kachhap@arm.com, vincenzo.frascino@arm.com,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/4] kselftests/arm64: add a basic Pointer Authentication
 test
Message-ID: <20200907102354.GL6642@arm.com>
References: <20200828131606.7946-1-boyan.karatotev@arm.com>
 <20200828131606.7946-2-boyan.karatotev@arm.com>
 <20200902164858.GI6642@arm.com>
 <ebcefdf0-a71b-3b67-b133-3f47419f9ec8@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ebcefdf0-a71b-3b67-b133-3f47419f9ec8@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Sep 03, 2020 at 11:12:02AM +0100, Boyan Karatotev wrote:
> On 02/09/2020 17:49, Dave Martin wrote:
> > On Fri, Aug 28, 2020 at 02:16:03PM +0100, Boyan Karatotev wrote:
> >> PAuth signs and verifies return addresses on the stack. It does so by
> >> inserting a Pointer Authentication code (PAC) into some of the unused top
> >> bits of an address. This is achieved by adding paciasp/autiasp instructions
> >> at the beginning and end of a function.
> >>
> >> This feature is partially backwards compatible with earlier versions of the
> >> ARM architecture. To coerce the compiler into emitting fully backwards
> >> compatible code the main file is compiled to target an earlier ARM version.
> >> This allows the tests to check for the feature and print meaningful error
> >> messages instead of crashing.
> >>
> >> Add a test to verify that corrupting the return address results in a
> >> SIGSEGV on return.
> >>
> >> Cc: Shuah Khan <shuah@kernel.org>
> >> Cc: Catalin Marinas <catalin.marinas@arm.com>
> >> Cc: Will Deacon <will@kernel.org>
> >> Signed-off-by: Boyan Karatotev <boyan.karatotev@arm.com>
> >> ---

[...]

> >> diff --git a/tools/testing/selftests/arm64/pauth/pac_corruptor.S b/tools/testing/selftests/arm64/pauth/pac_corruptor.S
> >> new file mode 100644
> >> index 000000000000..6a34ec23a034
> >> --- /dev/null
> >> +++ b/tools/testing/selftests/arm64/pauth/pac_corruptor.S
> >> @@ -0,0 +1,36 @@
> >> +/* SPDX-License-Identifier: GPL-2.0 */
> >> +/* Copyright (C) 2020 ARM Limited */
> >> +
> >> +.global pac_corruptor
> >> +
> >> +.text
> >> +/*
> >> + * Corrupting a single bit of the PAC ensures the authentication will fail.  It
> >> + * also guarantees no possible collision. TCR_EL1.TBI0 is set by default so no
> >> + * top byte PAC is tested
> >> + */
> >> + pac_corruptor:
> >> +	paciasp
> >> +
> >> +	/* make stack frame */
> >> +	sub sp, sp, #16
> >> +	stp x29, lr, [sp]
> > 
> > Nit: if respinning, you can optimise a few sequences of this sort, e.g.
> > 
> > 	stp	x29, lr, [sp, #-16]!
> > 
> >> +	mov x29, sp
> >> +
> >> +	/* prepare mask for bit to be corrupted (bit 54) */
> >> +	mov x1, xzr
> >> +	add x1, x1, #1
> >> +	lsl x1, x1, #54
> > 
> > Nit:
> > 
> > 	mov	x1, #1 << 54
> Thank you for this, didn't know I could do it this way.
> > 
> > but anyway, the logic operations can encode most simple bitmasks
> > directly as immediate operands, so you can skip this and just do
> > 
> >> +
> >> +	/* get saved lr, corrupt selected bit, put it back */
> >> +	ldr x0, [sp, #8]
> >> +	eor x0, x0, x1
> > 
> > 	eor	x0, x0, #1 << 54
> > 
> >> +	str x0, [sp, #8]
> >> +
> >> +	/* remove stack frame */
> >> +	ldp x29, lr, [sp]
> >> +	add sp, sp, #16
> > 
> > 	ldp	x29, lr, [sp], #16
> > 
> > [...]
> > 
> > Actually, since there are no leaf nested function calls and no trap is
> > expected until the function returns (so backtracing in the middle of
> > this function is unlikely to be needed), could we optimise this whole
> > thing down to the following?
> > 
> I suppose you're right. The intent was to emulate a c function but there
> really is no point in doing all this extra work. Will change it.

It's not critical either way, but this way it's at least less code to
maintain / read.

> > pac_corruptor:
> > 	paciasp
> > 	eor	lr, lr, #1 << 53
> > 	autiasp
> > 	ret
> > 
> > Cheers
> > ---Dave

[...]

Cheers
---Dave
