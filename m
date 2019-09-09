Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4CF97ADC7C
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Sep 2019 17:52:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389048AbfIIPv6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 9 Sep 2019 11:51:58 -0400
Received: from foss.arm.com ([217.140.110.172]:52992 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727003AbfIIPv5 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 9 Sep 2019 11:51:57 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3DD51169E;
        Mon,  9 Sep 2019 08:51:57 -0700 (PDT)
Received: from [10.1.197.50] (e120937-lin.cambridge.arm.com [10.1.197.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 516963F59C;
        Mon,  9 Sep 2019 08:51:56 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
Subject: Re: [PATCH v5 05/11] kselftest: arm64: mangle_pstate_ssbs_regs
To:     Dave Martin <Dave.Martin@arm.com>
Cc:     linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, shuah@kernel.org,
        amit.kachhap@arm.com, andreyknvl@google.com
References: <20190902112932.36129-1-cristian.marussi@arm.com>
 <20190902112932.36129-6-cristian.marussi@arm.com>
 <20190904114836.GV27757@arm.com>
Message-ID: <1794920f-84b3-a4e6-b20a-b769d95df0c8@arm.com>
Date:   Mon, 9 Sep 2019 16:51:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190904114836.GV27757@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi

On 04/09/2019 12:48, Dave Martin wrote:
> On Mon, Sep 02, 2019 at 12:29:26pm +0100, Cristian Marussi wrote:
>> Add a simple mangle testcase which messes with the ucontext_t from within
>> the signal handler, trying to set the PSTATE SSBS bit.
>> Expect SIGILL if SSBS feature is unsupported or that, on test PASS, the
>> value set in PSTATE.SSBS in the signal frame is preserved by sigreturn.
>>
>> Additionally, in order to support this test specific needs:
>> - extend signal testing framework to allow the definition of a custom per
>>   test initialization function to be run at the end of test setup.
>> - introduced a set_regval() helper to set system register values in a
>>   toolchain independent way.
>> - introduce also a new common utility function: get_current_context()
>>   which can be used to grab a ucontext without the help of libc, and
>>   detect if such ucontext has been actively used to jump back into it.
>>
>> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
>> ---
>> v3 --> v4
>> - fix commit message
>> - missing include signal.h
>> - added .init per-test init-func
>> - added set_regval() helper
>> - added SSBS clear to 0 custom .init function
>> - removed volatile qualifier associated with sig_atomic_t data
>> - added dsb inside handler to ensure the writes related to the
>>   grabbed ucontext have completed
>> - added test description
>> ---
>>  .../selftests/arm64/signal/test_signals.h     | 20 +++-
>>  .../arm64/signal/test_signals_utils.c         | 98 +++++++++++++++++++
>>  .../arm64/signal/test_signals_utils.h         |  2 +
>>  .../testcases/mangle_pstate_ssbs_regs.c       | 69 +++++++++++++
>>  4 files changed, 184 insertions(+), 5 deletions(-)
>>  create mode 100644 tools/testing/selftests/arm64/signal/testcases/mangle_pstate_ssbs_regs.c
>>
>> diff --git a/tools/testing/selftests/arm64/signal/test_signals.h b/tools/testing/selftests/arm64/signal/test_signals.h
>> index a1cf69997604..0767e27fbe78 100644
>> --- a/tools/testing/selftests/arm64/signal/test_signals.h
>> +++ b/tools/testing/selftests/arm64/signal/test_signals.h
>> @@ -27,6 +27,14 @@
>>  	: "memory");					\
>>  }
>>  
>> +#define set_regval(regname, in)				\
>> +{							\
>> +	asm volatile("msr " __stringify(regname) ", %0" \
>> +	:						\
>> +	: "r" (in)					\
>> +	: "memory");					\
>> +}
>> +
>>  /* Regs encoding and masks naming copied in from sysreg.h */
>>  #define SYS_ID_AA64MMFR1_EL1	S3_0_C0_C7_1	/* MRS Emulated */
>>  #define SYS_ID_AA64MMFR2_EL1	S3_0_C0_C7_2	/* MRS Emulated */
>> @@ -89,12 +97,16 @@ struct tdescr {
>>  	/* optional sa_flags for the installed handler */
>>  	int		sa_flags;
>>  	ucontext_t	saved_uc;
>> -
>> -	/* a custom setup function to be called before test starts */
>> +	/* used by get_current_ctx() */
>> +	size_t		live_sz;
>> +	ucontext_t	*live_uc;
>> +	sig_atomic_t	live_uc_valid;
>> +	/* a custom setup: called alternatively to default_setup */
>>  	int (*setup)(struct tdescr *td);
>> +	/* a custom init: called by default test initialization */
>> +	void (*init)(struct tdescr *td);
>>  	/* a custom cleanup function called before test exits */
>>  	void (*cleanup)(struct tdescr *td);
>> -
>>  	/* an optional function to be used as a trigger for test starting */
>>  	int (*trigger)(struct tdescr *td);
>>  	/*
>> @@ -102,10 +114,8 @@ struct tdescr {
>>  	 * presence of the trigger function above; this is mandatory
>>  	 */
>>  	int (*run)(struct tdescr *td, siginfo_t *si, ucontext_t *uc);
>> -
>>  	/* an optional function for custom results' processing */
>>  	void (*check_result)(struct tdescr *td);
>> -
>>  	void *priv;
>>  };
>>  
>> diff --git a/tools/testing/selftests/arm64/signal/test_signals_utils.c b/tools/testing/selftests/arm64/signal/test_signals_utils.c
>> index e2a5f37e6ad3..c6fdcb23f246 100644
>> --- a/tools/testing/selftests/arm64/signal/test_signals_utils.c
>> +++ b/tools/testing/selftests/arm64/signal/test_signals_utils.c
>> @@ -11,12 +11,16 @@
>>  #include <linux/auxvec.h>
>>  #include <ucontext.h>
>>  
>> +#include <asm/unistd.h>
>> +
>>  #include "test_signals.h"
>>  #include "test_signals_utils.h"
>>  #include "testcases/testcases.h"
>>  
>>  extern struct tdescr *current;
>>  
>> +static int sig_copyctx = SIGUSR2;
>> +
>>  static char *feats_store[FMAX_END] = {
>>  	" SSBS ",
>>  	" PAN ",
>> @@ -43,6 +47,81 @@ static inline char *feats_to_string(unsigned long feats)
>>  	return feats_string;
>>  }
>>  
>> +/*
>> + * Obtaining a valid and full-blown ucontext_t from userspace is tricky:
>> + * libc getcontext does() not save all the regs and messes with some of
>> + * them (pstate value in particular is not reliable).
>> + * Here we use a service signal to grab the ucontext_t from inside a
>> + * dedicated signal handler, since there, it is populated by Kernel
>> + * itself in setup_sigframe(). The grabbed context is then stored and
>> + * made available in td->live_uc.
>> + *
>> + * Anyway this function really serves a dual purpose:
>> + *
>> + * 1. grab a valid sigcontext into td->live_uc for result analysis: in
>> + * such case it returns 1.
>> + *
>> + * 2. detect if somehow a previously grabbed live_uc context has been
>> + * used actively with a sigreturn: in such a case the execution would have
>> + * magically resumed in the middle of the function itself (seen_already==1):
>> + * in such a case return 0, since in fact we have not just simply grabbed
>> + * the context.
>> + *
>> + * This latter case is useful to detect when a fake_sigreturn test-case has
>> + * unexpectedly survived without hittig a SEGV.
>> + */
>> +bool get_current_context(struct tdescr *td, ucontext_t *dest_uc)
>> +{
>> +	static sig_atomic_t seen_already;
>> +
>> +	assert(td && dest_uc);
>> +	/* it's a genuine invocation..reinit */
>> +	seen_already = 0;
>> +	td->live_uc_valid = 0;
>> +	td->live_sz = sizeof(*dest_uc);
>> +	memset(dest_uc, 0x00, td->live_sz);
>> +	td->live_uc = dest_uc;
>> +	/*
>> +	 * Grab ucontext_t triggering a signal...
>> +	 * ASM equivalent of raise(sig_copyctx);
>> +	 *
>> +	 * Note that:
>> +	 * - live_uc_valid is declared sig_atomic_t in struct tdescr
>> +	 *   since it will be changed inside the sig_copyctx handler
>> +	 * - the kill() syscall invocation returns only after any possible
>> +	 *   registered signal handler for the invoked signal has returned,
>> +	 *   so that live_uc_valid flag is surely up to date when this
>> +	 *   function return it.
>> +	 * - the additional 'memory' clobber is there to avoid possible
>> +	 *   compiler's assumption on live_uc_valid, seen-already and
>> +	 *   the content pointed by dest_uc, which are all changed inside
>> +	 *   the signal handler, without resorting to the volatile qualifier
>> +	 *   (and keeping quiet checkpatch.pl)
>> +	 */
>> +	asm volatile ("mov x8, %0\n\t"
>> +		      "svc #0\n\t"
>> +		      "mov x1, %1\n\t"
>> +		      "mov x8, %2\n\t"
>> +		      "svc #0"
>> +		      :
>> +		      : "i" (__NR_getpid), "r" (sig_copyctx), "i" (__NR_kill)
>> +		      : "x1", "x8", "x0", "memory");
>> +	/*
>> +	 * If we get here with seen_already==1 it implies the td->live_uc
>> +	 * context has been used to get back here....this probably means
>> +	 * a test has failed to cause a SEGV...anyway the live_uc has not
>> +	 * just been acquired...so return 0
>> +	 */
>> +	if (seen_already) {
>> +		fprintf(stdout,
>> +			"Successful sigreturn detected: live_uc is stale !\n");
>> +		return 0;
>> +	}
>> +	seen_already = 1;
>> +
>> +	return td->live_uc_valid;
>> +}
>> +
>>  static void unblock_signal(int signum)
>>  {
>>  	sigset_t sset;
>> @@ -124,6 +203,17 @@ static void default_handler(int signum, siginfo_t *si, void *uc)
>>  		 * to terminate immediately exiting straight away
>>  		 */
>>  		default_result(current, 1);
>> +	} else if (signum == sig_copyctx && current->live_uc) {
>> +		memcpy(current->live_uc, uc, current->live_sz);
>> +		ASSERT_GOOD_CONTEXT(current->live_uc);
>> +		current->live_uc_valid = 1;
>> +		/*
>> +		 * Ensure above writes have completed before signal
>> +		 * handler terminates
>> +		 */
>> +		asm volatile ("dsb sy" ::: "memory");
> 
> The dsb doesn't help here: this has no effect on how the compiler caches
> variables in registers etc.
> 
> Overall, I think some details need a bit of a rethink here.
> 

Beside the dsb which I understand is useless, I thought the memory clobber
could have helped at least with the compiler optimization/re-ordering issues
while avoiding the volatile. (but not fully)

> We need some way to ensure coherency of accesses to variables around
> and inside the signal handler here, but since we're running in a single
> thread that may be interrupted by a signal handler (running in the same
> thread), it's compiler<->compiler coherency that's the issue here, not
> cpu<->cpu or cpu<->device coherency.
> 
> There may also be atomicity concerns, since the compiler might move
> stuff across and/or duplicate or tear reads/writes around the asm where
> the signal is delivered.
> 
> The classic solution to these problems is to use volatile, but this
> is a blunt tool and you often end up having to mark more objects
> volatile than you really want to in order to ensure correctness.  The
> ordering behaviour of accesses to volatiles is also ill-specified for
> accesses made in different threads.
> 
> That said, efficiency is of no concern here and we're single-threaded,
> so a blunt, simple tool may still be adequate.
> 
I'll revert back to use volatile despite checkpatch complaints, and sig_atomic_t
where needed, and add an output param in the inline asm for *dest_uc to avoid
compiler making assumptions about it

> 
> Another issue is that nothing stops the stack frame the captured SP
> points to from disappearing between get_current_context() and the
> fake_sigreturn() that tries to jump back to it.
> 
> To avoid this issue, we'd probably need to inline more of
> get_current_context(), i.e., turn it into a macro.
> 

I made it a static __always_inline.

Moreover I moved away from kill(mypid, USR1) approach since the syscall path
will zero the SVE regs before grabbing the sigframe
(and is bad for future signal/SVE tests).

I'm instead now using brk and catch the SIGTRAP (picked form the arm64/signal
SVE tests patch still to be published)

>> +		fprintf(stderr,
>> +			"GOOD CONTEXT grabbed from sig_copyctx handler\n");
>>  	} else {
>>  		if (signum == current->sig_unsupp && !are_feats_ok(current)) {
>>  			fprintf(stderr,
>> @@ -222,7 +312,15 @@ static int test_init(struct tdescr *td)
>>  			!feats_ok ? "NOT " : "");
>>  	}
>>  
>> +	if (td->sig_trig == sig_copyctx)
>> +		sig_copyctx = SIGUSR1;
>> +	unblock_signal(sig_copyctx);
>> +
>> +	/* Perform test specific additional initialization */
>> +	if (td->init)
>> +		td->init(td);
>>  	td->initialized = 1;
>> +
>>  	return 1;
>>  }
>>  
>> diff --git a/tools/testing/selftests/arm64/signal/test_signals_utils.h b/tools/testing/selftests/arm64/signal/test_signals_utils.h
>> index 8658d1a7d4b9..ce35be8ebc8e 100644
>> --- a/tools/testing/selftests/arm64/signal/test_signals_utils.h
>> +++ b/tools/testing/selftests/arm64/signal/test_signals_utils.h
>> @@ -10,4 +10,6 @@ int test_setup(struct tdescr *td);
>>  void test_cleanup(struct tdescr *td);
>>  int test_run(struct tdescr *td);
>>  void test_result(struct tdescr *td);
>> +
>> +bool get_current_context(struct tdescr *td, ucontext_t *dest_uc);
>>  #endif
>> diff --git a/tools/testing/selftests/arm64/signal/testcases/mangle_pstate_ssbs_regs.c b/tools/testing/selftests/arm64/signal/testcases/mangle_pstate_ssbs_regs.c
>> new file mode 100644
>> index 000000000000..15e6f62512d5
>> --- /dev/null
>> +++ b/tools/testing/selftests/arm64/signal/testcases/mangle_pstate_ssbs_regs.c
>> @@ -0,0 +1,69 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (C) 2019 ARM Limited
>> + *
>> + * Try to mangle the ucontext from inside a signal handler, setting the
>> + * SSBS bit to 1 and veryfing that such modification is preserved.
>> + */
>> +
>> +#include <stdio.h>
>> +#include <signal.h>
>> +#include <ucontext.h>
>> +
>> +#include "test_signals_utils.h"
>> +#include "testcases.h"
>> +
>> +static void mangle_invalid_pstate_ssbs_init(struct tdescr *td)
>> +{
>> +	fprintf(stderr, "Clearing SSBS to 0\n");
>> +	set_regval(SSBS_SYSREG, 0);
>> +}
>> +
>> +static int mangle_invalid_pstate_ssbs_run(struct tdescr *td,
>> +					  siginfo_t *si, ucontext_t *uc)
>> +{
>> +	ASSERT_GOOD_CONTEXT(uc);
>> +
>> +	/* set bit value */
>> +	uc->uc_mcontext.pstate |= PSR_SSBS_BIT;
> 
> Can we check that uc->uc_mcontext.pstate & PSR_SSBS_BIT is initially 0?
> 
> If not, it suggests either a test bug, or modification of the SSBS
> flag by other C code before the test signal was delivered.
> 
Here the situation is a bit tricky: architecture defines three levels of
SSBS support:
 1.  SSBS bit + MRS SSBS instruction or
 2.  SSBS bit ONLY
 3.  no support

HW_SSBS capability is reported as supported by kernel only for full support (1.)
Otherwise it is reported as unsupported, even if in 2. the PSTATE.SSBS bit is working
and I can look it up using util get_current_context().

Moreover the test is supposed to check that the sigreturn Kernel path does NOT clear
improperly the SSBS bit while returning: so as long as we can set the SSBS bit in uc PSTATE
we can check if it is cleared.

So in order to gather as much info as possible from the test without incurring in unneeded
SIGILL (attempting to use MRS), my new approach is:

- test anyway no matter if SSBS is supported: check that bit is NOT cleared on sigreturn
- use MRS clear to 0 on test_init only if SSBS declared as supported
- abort when PSTATE.SSBS bit is not cleared on test start (trigger) ONLY if SSBS was declared supported  (and so cleared in test_init)
- check test result using:
  - MRS SSBS if HW_SSBS supported
  - PSTATE.SSBS get_current_context if HW_SSBS NOT supported
  - print out always PSTATE retrieved values

This way I was able to avoid SIGILL and properly test at any level of support (1,2,3)
both the PASS and the FAIL path (using a Kernel which does NOT  properly preserve the
SSBS bit)


>> +	fprintf(stderr, "SSBS set to 1 -- PSTATE: 0x%016llX\n",
>> +		uc->uc_mcontext.pstate);
>> +	/* Save after mangling...it should be preserved */
>> +	td->saved_uc = *uc;
>> +
>> +	return 1;
>> +}
>> +
>> +static void pstate_ssbs_bit_checks(struct tdescr *td)
>> +{
>> +	uint64_t val = 0;
>> +	ucontext_t uc;
>> +
>> +	/* This check reports some result even if MRS SSBS unsupported */
>> +	if (get_current_context(td, &uc))
>> +		fprintf(stderr,
>> +			"INFO: live_uc - got PSTATE: 0x%016llX -> SSBS %s\n",
>> +			uc.uc_mcontext.pstate,
>> +			(td->saved_uc.uc_mcontext.pstate & PSR_SSBS_BIT) ==
>> +			(uc.uc_mcontext.pstate & PSR_SSBS_BIT) ?
>> +			"PRESERVED" : "CLEARED");
>> +
>> +	fprintf(stderr, "Checking with MRS SSBS...\n");
>> +	get_regval(SSBS_SYSREG, val);
>> +	fprintf(stderr, "INFO: MRS SSBS - got: 0x%016lX\n", val);
>> +	/* pass when preserved */
>> +	td->pass = (val & PSR_SSBS_BIT) ==
>> +		   (td->saved_uc.uc_mcontext.pstate & PSR_SSBS_BIT);
>> +}
>> +
>> +struct tdescr tde = {
>> +		.sanity_disabled = true,
>> +		.name = "MANGLE_PSTATE_SSBS_REGS",
>> +		.descr = "Mangling uc_mcontext changing SSBS.(PRESERVE)",
> 
> Can we come up with a clearer description here?  I'm not sure how to
> read this.
> 

Ok..I was trying to please checkpatch.
> [...]
> 
> Cheers
> ---Dave
> 

Cheers

Cristian
