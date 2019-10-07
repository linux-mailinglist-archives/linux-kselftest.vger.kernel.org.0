Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB0FACEBB1
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Oct 2019 20:24:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728212AbfJGSYA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Oct 2019 14:24:00 -0400
Received: from foss.arm.com ([217.140.110.172]:43808 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728079AbfJGSYA (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Oct 2019 14:24:00 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 83F821570;
        Mon,  7 Oct 2019 11:23:59 -0700 (PDT)
Received: from [10.1.197.50] (e120937-lin.cambridge.arm.com [10.1.197.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B73693F68E;
        Mon,  7 Oct 2019 11:23:58 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
Subject: Re: [PATCH v6 06/11] kselftest: arm64: fake_sigreturn_bad_magic
To:     Dave Martin <Dave.Martin@arm.com>
Cc:     linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, shuah@kernel.org,
        amit.kachhap@arm.com, andreyknvl@google.com
References: <20190910123111.33478-1-cristian.marussi@arm.com>
 <20190910123111.33478-7-cristian.marussi@arm.com>
 <20190917160603.GN27757@arm.com>
Message-ID: <abcff746-ad38-5817-b256-7195337ee130@arm.com>
Date:   Mon, 7 Oct 2019 19:23:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190917160603.GN27757@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 17/09/2019 17:06, Dave Martin wrote:
> On Tue, Sep 10, 2019 at 01:31:06pm +0100, Cristian Marussi wrote:
>> Add a simple fake_sigreturn testcase which builds a ucontext_t with a bad
>> magic header and place it onto the stack. Expects a SIGSEGV on test PASS.
>>
>> Introduce a common utility assembly trampoline function to invoke a
>> sigreturn while placing the provided sigframe at wanted alignment and
>> also an helper to make space when needed inside the sigframe reserved
>> area.
>>
>> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
>> ---
>> v5 --> v6
>> - fake_sigreturn: cleaned up, avoiding excessive SP misalignments
>> - fake_sigreturn: better formatting and prologue
>> - get_starting_header: cleand up and commented
>> - avoid timeout on failure
> 
> [...]
> 
>> diff --git a/tools/testing/selftests/arm64/signal/signals.S b/tools/testing/selftests/arm64/signal/signals.S
>> new file mode 100644
>> index 000000000000..e670f8f2c8de
>> --- /dev/null
>> +++ b/tools/testing/selftests/arm64/signal/signals.S
>> @@ -0,0 +1,64 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/* Copyright (C) 2019 ARM Limited */
>> +
>> +#include <asm/unistd.h>
>> +
>> +.section        .rodata, "a"
>> +call_fmt:
>> +	.asciz "Calling sigreturn with fake sigframe sized:%zd at SP @%08lX\n"
>> +
>> +.text
>> +
>> +.globl fake_sigreturn
>> +
>> +/*	fake_sigreturn	x0:&sigframe,  x1:sigframe_size,  x2:misalign_bytes */
>> +fake_sigreturn:
>> +	stp	x29, x30, [sp, #-16]!
>> +	mov	x29, sp
>> +
>> +	mov	x20, x0
>> +	mov	x21, x1
>> +	mov	x22, x2
>> +
>> +	/* create space on the stack for fake sigframe 16 bytes-aligned */
>> +	add	x0, x21, x22
>> +	add	x0, x0, #16
>> +	bic	x0, x0, #15 /* round_up(sigframe_size + misalign_bytes, 16) */
> 
> If I've figured this out right, x0 as computed here actually looks
> like round_up(sigframe_size + misalign_bytes + 1, 16) - 1.
> 
> (n + (m - 1)) & ~(m - 1) is the classic way to round up when m is a
> power of 2.
> 
> That's why I originally suggested to add 15.  Your code works, but I
> think it always allocates at least one byte more than needed (?)
> 
> This is not a huge deal, and better than allocating one byte to few,
> but it would be good to understand whether this behaviour was
> intentional or not.
> 

Well the reason if that I was equally (but wrongly on my side) convinced
to have to sum +16 before clearing the lower 0b1111.

My bad. I'm fixing in v7.


>> +	sub	sp, sp, x0
>> +	add	x23, sp, x22 /* new sigframe base with misaligment if any */
>> +
>> +	ldr	x0, =call_fmt
>> +	mov	x1, x21
>> +	mov	x2, x23
>> +	bl	printf
>> +
>> +	/* memcpy the provided content, while still keeping SP aligned */
>> +	mov	x0, x23
>> +	mov	x1, x20
>> +	mov	x2, x21
>> +	bl	memcpy
>> +
>> +	/*
>> +	 * Here saving a last minute SP to current->token acts as a marker:
>> +	 * if we got here, we are successfully faking a sigreturn; in other
>> +	 * words we are sure no bad fatal signal has been raised till now
>> +	 * for unrelated reasons, so we should consider the possibly observed
>> +	 * fatal signal like SEGV coming from Kernel restore_sigframe() and
>> +	 * triggered as expected from our test-case.
>> +	 * For simplicity this assumes that current field 'token' is laid out
>> +	 * as first in struct tdescr
>> +	 */
>> +	ldr	x0, current
>> +	str	x23, [x0]
>> +	/* finally move SP to misaligned address...if any requested */
>> +	mov	sp, x23
>> +
>> +	mov	x8, #__NR_rt_sigreturn
>> +	svc	#0
>> +
>> +	/*
>> +	 * Above sigreturn should not return...looping here leads to a timeout
>> +	 * and ensure proper and clean test failure, instead of jumping around
>> +	 * on a potentially corrupted stack.
>> +	 */
>> +	b	.
> 
> [...]
> 
>> diff --git a/tools/testing/selftests/arm64/signal/testcases/testcases.c b/tools/testing/selftests/arm64/signal/testcases/testcases.c
>> index 1914a01222a1..e3521949b800 100644
>> --- a/tools/testing/selftests/arm64/signal/testcases/testcases.c
>> +++ b/tools/testing/selftests/arm64/signal/testcases/testcases.c
>> @@ -148,3 +148,49 @@ bool validate_reserved(ucontext_t *uc, size_t resv_sz, char **err)
>>  
>>  	return true;
>>  }
>> +
>> +/*
>> + * This function walks through the records inside the provided reserved area
>> + * trying to find enough space to fit @need_sz bytes: if not enough space is
>> + * available and an extra_context record is present, it throws away the
>> + * extra_context record.
>> + *
>> + * It returns a pointer to a new header where it is possible to start storing
>> + * our need_sz bytes.
>> + *
>> + * @shead: points to the start of reserved area
>> + * @need_sz: needed bytes
>> + * @resv_sz: reserved area size in bytes
>> + * @offset: if not null, this will be filled with the offset of the return
>> + *	    head pointer from @shead
>> + *
>> + * @return: pointer to a new head where to start storing need_sz bytes, or
>> + *	    NULL if space could not be made available.
>> + */
> 
> That's much clearer now, thanks for that.
> 
>> +struct _aarch64_ctx *get_starting_head(struct _aarch64_ctx *shead,
>> +				       size_t need_sz, size_t resv_sz,
>> +				       size_t *offset)
>> +{
> 
> [...]
> 
> Cheers
> ---Dave
> 

Cheers

Cristian
