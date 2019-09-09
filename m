Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B31D1ADE08
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Sep 2019 19:31:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726998AbfIIRbc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 9 Sep 2019 13:31:32 -0400
Received: from foss.arm.com ([217.140.110.172]:53988 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726931AbfIIRbc (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 9 Sep 2019 13:31:32 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 195AF1000;
        Mon,  9 Sep 2019 10:31:31 -0700 (PDT)
Received: from [10.1.197.50] (e120937-lin.cambridge.arm.com [10.1.197.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 248EA3F71F;
        Mon,  9 Sep 2019 10:31:30 -0700 (PDT)
Subject: Re: [PATCH v5 06/11] kselftest: arm64: fake_sigreturn_bad_magic
To:     Dave Martin <Dave.Martin@arm.com>
Cc:     linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, shuah@kernel.org,
        amit.kachhap@arm.com, andreyknvl@google.com
References: <20190902112932.36129-1-cristian.marussi@arm.com>
 <20190902112932.36129-7-cristian.marussi@arm.com>
 <20190904114845.GW27757@arm.com>
From:   Cristian Marussi <cristian.marussi@arm.com>
Message-ID: <44186921-7dc7-451d-2d04-6424a4725ccb@arm.com>
Date:   Mon, 9 Sep 2019 18:31:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190904114845.GW27757@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi

On 04/09/2019 12:48, Dave Martin wrote:
> On Mon, Sep 02, 2019 at 12:29:27pm +0100, Cristian Marussi wrote:
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
>> v3 --> v4
>> - fix commit
>> - fix signal.S, handle misalign requests too
>> - remove unneeded comments
>> - add signal.h include
>> - added get_starting_head() helper
>> - added test description
>> ---
>>  tools/testing/selftests/arm64/signal/Makefile |  2 +-
>>  .../testing/selftests/arm64/signal/signals.S  | 62 +++++++++++++++++++
>>  .../arm64/signal/test_signals_utils.h         |  1 +
>>  .../testcases/fake_sigreturn_bad_magic.c      | 54 ++++++++++++++++
>>  .../arm64/signal/testcases/testcases.c        | 28 +++++++++
>>  .../arm64/signal/testcases/testcases.h        |  4 ++
>>  6 files changed, 150 insertions(+), 1 deletion(-)
>>  create mode 100644 tools/testing/selftests/arm64/signal/signals.S
>>  create mode 100644 tools/testing/selftests/arm64/signal/testcases/fake_sigreturn_bad_magic.c
>>
>> diff --git a/tools/testing/selftests/arm64/signal/Makefile b/tools/testing/selftests/arm64/signal/Makefile
>> index f78f5190e3d4..b497cfea4643 100644
>> --- a/tools/testing/selftests/arm64/signal/Makefile
>> +++ b/tools/testing/selftests/arm64/signal/Makefile
>> @@ -28,5 +28,5 @@ clean:
>>  # Common test-unit targets to build common-layout test-cases executables
>>  # Needs secondary expansion to properly include the testcase c-file in pre-reqs
>>  .SECONDEXPANSION:
>> -$(PROGS): test_signals.c test_signals_utils.c testcases/testcases.c $$@.c test_signals.h test_signals_utils.h testcases/testcases.h
>> +$(PROGS): test_signals.c test_signals_utils.c testcases/testcases.c signals.S $$@.c test_signals.h test_signals_utils.h testcases/testcases.h
>>  	$(CC) $(CFLAGS) $^ -o $@
>> diff --git a/tools/testing/selftests/arm64/signal/signals.S b/tools/testing/selftests/arm64/signal/signals.S
>> new file mode 100644
>> index 000000000000..b89fec0d5ba0
>> --- /dev/null
>> +++ b/tools/testing/selftests/arm64/signal/signals.S
>> @@ -0,0 +1,62 @@
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
> 
> Nit: the "bl printf" later on destroys lr.
> 
> This isn't a problem, since the function never tries to return anyway --
> if things go wrong you just "b .".
> 
> But it may be helpful for debug purposes to at least create a frame
> record, e.g.:
> 
> 	stp	x29, x30, [sp, #-16]!
> 	mov	x29, sp
> 
> before doing anything else.
> 
ok

>> +	mov x20, x0
>> +	mov x21, x1
>> +	mov x22, x2
>> +	mov x23, sp
> 
> Nit: to follow the conventional asm style for arm64 kernel code, can you
> format lines as
> 
> <TAB>	op<TAB>	operands
> 
ok

>> +
>> +	/* create space on the stack for fake sigframe 16 bytes-aligned */
>> +	add x0, x21, #16
>> +	bic x0, x0, #15
>> +	sub x23, x23, x0
>> +	/* any misalignment requested ? */
>> +	add x23, x23, x22
> 
> Aren't we actually reducing the allocation here, rather than increasing it?
> 
For the misalignment bytes if any yes...

> Doing something like this may work to allocate guaranteed sufficient
> space:
> 
> 	add	x0, x21, x22
> 	add	x0, x0, #15
> 	bic	x0, x0, #15 /* round_up(sigframe_size + misglian_bytes, 16) */
> 	sub	sp, sp, x0
> 	add	x23, sp, x22 /* new sigframe base with misaligment */
> 
> (You can drop the mov into x23 above in your function prologue if you
> code it this way.)
> 
ok...but...shouldn't be 

add x0, x0, #16

before 

bic x-, x0, #15

instead of adding #15 ?

>> +
>> +	ldr x0, =call_fmt
>> +	mov x1, x21
>> +	mov x2, x23
>> +	bl printf
>> +
>> +	mov sp, x23
> 
> AAPCS64 requires sp to be 16-byte aligned at function boundaries, so 
> we may get stack alignments faults in mempcy() here.  Possibly these
> can be confused with test failure SEGVs (I can't remember offhand how
> stack alignment faults are supported).
> 
Didn't know about function boundaries requirements.

> Coding something like what I have above to guarantee stack alignment
> should avoid this.
> 

Nice I'll do.

>> +	/* now fill it with the provided content... */
>> +	mov x0, sp
> 
> With my version this would be mov x0, x23
> 
ok

>> +	mov x1, x20
>> +	mov x2, x21
>> +	bl memcpy
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
>> +	ldr x0, current
> 
> Nit: it probably doesn't matter since this will be a small binary
> after linking, but to avoid possible fixup errors during linking you
> could also do:
> 
> 	adrp	x0, current
> 	ldr	x0, [x0, #:lo12:current]
> 
> This raises the addressing range from 0.5 MB or so to a few GB, making
> link errors much more unlikely.
> 
Ok...I'll fix this nitpick once I'll have understood it :D

>> +	str x23, [x0]
>> +	/* SP is already pointing back to the just built fake sigframe here */
>> +	mov x8, #__NR_rt_sigreturn
> 
> And finally we would mov sp, x23 here.
> 
Yes

>> +	svc #0
>> +
>> +	/*
>> +	 * Above sigreturn should not return...looping here leads to a timeout
>> +	 * and ensure proper and clean test failure, instead of jumping around
>> +	 * on a potentially corrupted stack.
>> +	 */
>> +	b .
>> diff --git a/tools/testing/selftests/arm64/signal/test_signals_utils.h b/tools/testing/selftests/arm64/signal/test_signals_utils.h
>> index ce35be8ebc8e..68930f1e46e5 100644
>> --- a/tools/testing/selftests/arm64/signal/test_signals_utils.h
>> +++ b/tools/testing/selftests/arm64/signal/test_signals_utils.h
>> @@ -12,4 +12,5 @@ int test_run(struct tdescr *td);
>>  void test_result(struct tdescr *td);
>>  
>>  bool get_current_context(struct tdescr *td, ucontext_t *dest_uc);
>> +int fake_sigreturn(void *sigframe, size_t sz, int misalign_bytes);
>>  #endif
>> diff --git a/tools/testing/selftests/arm64/signal/testcases/fake_sigreturn_bad_magic.c b/tools/testing/selftests/arm64/signal/testcases/fake_sigreturn_bad_magic.c
>> new file mode 100644
>> index 000000000000..7fb700b9801b
>> --- /dev/null
>> +++ b/tools/testing/selftests/arm64/signal/testcases/fake_sigreturn_bad_magic.c
>> @@ -0,0 +1,54 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (C) 2019 ARM Limited
>> + *
>> + * Place a fake sigframe on the stack including a BAD Unknown magic
>> + * record: on sigreturn Kernel must spot this attempt and the test
>> + * case is expected to be terminated via SEGV.
>> + */
>> +
>> +#include <signal.h>
>> +#include <ucontext.h>
>> +
>> +#include "test_signals_utils.h"
>> +#include "testcases.h"
>> +
>> +struct fake_sigframe sf;
>> +
>> +static int fake_sigreturn_bad_magic_run(struct tdescr *td,
>> +					siginfo_t *si, ucontext_t *uc)
>> +{
>> +	size_t resv_sz, need_sz;
>> +	struct _aarch64_ctx *shead = GET_SF_RESV_HEAD(sf), *head;
>> +
>> +	/* just to fill the ucontext_t with something real */
>> +	if (!get_current_context(td, &sf.uc))
>> +		return 1;
>> +
>> +	resv_sz = GET_SF_RESV_SIZE(sf);
>> +	/* need at least 2*HDR_SZ space: KSFT_BAD_MAGIC + terminator. */
>> +	need_sz = HDR_SZ * 2;
>> +	head = get_starting_head(shead, need_sz, resv_sz, NULL);
> 
> Nit: are the need_sz and resv_sz variables required?
> 
> Maybe they help to highlight what these expressions mean in the
> get_starting_head() call though.  I'm happy either way.

Not really required...I'll remove. (probably in other tests were and they
landed here too...)

> 
>> +	if (head) {
>> +		/*
>> +		 * use a well known NON existent bad magic...something
>> +		 * we should pretty sure won't be ever defined in Kernel
>> +		 */
>> +		head->magic = KSFT_BAD_MAGIC;
>> +		head->size = HDR_SZ;
>> +		write_terminator_record(GET_RESV_NEXT_HEAD(head));
>> +
>> +		ASSERT_BAD_CONTEXT(&sf.uc);
>> +		fake_sigreturn(&sf, sizeof(sf), 0);
>> +	}
>> +
>> +	return 1;
>> +}
>> +
>> +struct tdescr tde = {
>> +		.name = "FAKE_SIGRETURN_BAD_MAGIC",
>> +		.descr = "Trigger a sigreturn with a sigframe with a bad magic",
>> +		.sig_ok = SIGSEGV,
>> +		.timeout = 3,
>> +		.run = fake_sigreturn_bad_magic_run,
>> +};
>> diff --git a/tools/testing/selftests/arm64/signal/testcases/testcases.c b/tools/testing/selftests/arm64/signal/testcases/testcases.c
>> index 72e3f482b177..2effb8ded935 100644
>> --- a/tools/testing/selftests/arm64/signal/testcases/testcases.c
>> +++ b/tools/testing/selftests/arm64/signal/testcases/testcases.c
>> @@ -149,3 +149,31 @@ bool validate_reserved(ucontext_t *uc, size_t resv_sz, char **err)
>>  
>>  	return true;
>>  }
>> +
> 
> Maybe add a comment saying what this function does.
> 
> To check my understanding:
> The purpose is to find a place to append a new record, right?
> By default we append at the end (i.e., at the terminator), but
> because extra_context is optional we replace that instead if
> there isn't sufficient space after the terminator in __reserved[].
> 

Yes I'll add a comment.

>> +struct _aarch64_ctx *get_starting_head(struct _aarch64_ctx *shead,
>> +				       size_t need_sz, size_t resv_sz,
>> +				       size_t *offset)
>> +{
>> +	size_t offs = 0;
>> +	struct _aarch64_ctx *head;
>> +
>> +	head = get_terminator(shead, resv_sz, &offs);
>> +	/* not found a terminator...no need to update offset if any */
>> +	if (!head)
>> +		return head;
>> +	if (resv_sz - offs < need_sz) {
>> +		fprintf(stderr, "Low on space:%zd. Discarding extra_context.\n",
>> +			resv_sz - offs);
>> +		head = get_header(shead, EXTRA_MAGIC, resv_sz, &offs);
>> +		if (!head || resv_sz - offs < need_sz) {
>> +			fprintf(stderr,
>> +				"Failed to reclaim space on sigframe.\n");
>> +			return NULL;
>> +		}
>> +	}
>> +
>> +	fprintf(stderr, "Available space:%zd\n", resv_sz - offs);
>> +	if (offset)
>> +		*offset = offs;
>> +	return head;
>> +}
>> diff --git a/tools/testing/selftests/arm64/signal/testcases/testcases.h b/tools/testing/selftests/arm64/signal/testcases/testcases.h
>> index 00618c3202bb..7653f8a64b3d 100644
>> --- a/tools/testing/selftests/arm64/signal/testcases/testcases.h
>> +++ b/tools/testing/selftests/arm64/signal/testcases/testcases.h
>> @@ -83,4 +83,8 @@ static inline void write_terminator_record(struct _aarch64_ctx *tail)
>>  		tail->size = 0;
>>  	}
>>  }
>> +
>> +struct _aarch64_ctx *get_starting_head(struct _aarch64_ctx *shead,
>> +				       size_t need_sz, size_t resv_sz,
>> +				       size_t *offset);
>>  #endif
> 
> Apart from the comments above, this looks reasonable.
> 
> Cheers
> ---Dave
> 

Cheers

Cristian
