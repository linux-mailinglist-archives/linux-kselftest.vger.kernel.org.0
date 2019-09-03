Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 345C0A6CEE
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Sep 2019 17:35:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728576AbfICPfE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 3 Sep 2019 11:35:04 -0400
Received: from foss.arm.com ([217.140.110.172]:39208 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725782AbfICPfE (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 3 Sep 2019 11:35:04 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D7E8A344;
        Tue,  3 Sep 2019 08:35:02 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 143303F246;
        Tue,  3 Sep 2019 08:35:01 -0700 (PDT)
Date:   Tue, 3 Sep 2019 16:34:59 +0100
From:   Dave Martin <Dave.Martin@arm.com>
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     andreyknvl@google.com, shuah@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 02/11] kselftest: arm64: adds first test and common
 utils
Message-ID: <20190903153456.GM27757@arm.com>
References: <20190802170300.20662-1-cristian.marussi@arm.com>
 <20190802170300.20662-3-cristian.marussi@arm.com>
 <20190813162411.GZ10425@arm.com>
 <a76adb28-00f9-3c32-60e5-bc746db6f2fd@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a76adb28-00f9-3c32-60e5-bc746db6f2fd@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi, responding to some non-trivial comments here where re-work isn't
needed -- so we have the right context for the mail thread.

For any remaining nits, I'll comment on the v5 patch.

On Wed, Aug 28, 2019 at 06:34:09PM +0100, Cristian Marussi wrote:
> Hi
> 
> On 13/08/2019 17:24, Dave Martin wrote:

[...]

> >> diff --git a/tools/testing/selftests/arm64/signal/Makefile b/tools/testing/selftests/arm64/signal/Makefile

[...]

> >> +# Guessing as best as we can where the Kernel headers
> >> +# could have been installed depending on ENV config and
> >> +# type of invocation.
> >> +ifeq ($(KBUILD_OUTPUT),)
> >> +khdr_dir = $(top_srcdir)/usr/include
> >> +else
> >> +ifeq (0,$(MAKELEVEL))
> >> +khdr_dir = $(KBUILD_OUTPUT)/usr/include
> >> +else
> >> +# the KSFT preferred location when KBUILD_OUTPUT is set
> >> +khdr_dir = $(KBUILD_OUTPUT)/kselftest/usr/include
> >> +endif
> >> +endif
> > 
> > When is KBUILD_OUTPUT set / not set?
> > 
> 
> Depending how the user/CI is configured KSFT installs the kernel
> headers in different places....here I'm trying to guess where they
> have been installed by KSFT.
> 
> >> +
> >> +CFLAGS += -I$(khdr_dir)
> > 
> > Do we rely on any non-UAPI headers?  If not, the default should probably
> > be to rely on the system headers (or toolchain default headers) -- i.e.,
> > add no -I option at all.
> 
> I only need updated UAPI headers, but I cannot build without this specific -I..
> that points to the installed kernel headers directory.
> 
> As an example it fails with: undefined  HWCAP_SSBS if I remove the -I
> 
> > 
> > I'm wondering why none of the other kselftests need this header search
> > logic.
> > 
> 
> Well... a lot of KSFT tests has something related to headers search in their Makefiles:
> 
> ../kcmp/Makefile:CFLAGS += -I../../../../usr/include/
> ../networking/timestamping/Makefile:CFLAGS += -I../../../../../usr/include
> ../ipc/Makefile:CFLAGS += -I../../../../usr/include/
> ../memfd/Makefile:CFLAGS += -I../../../../include/uapi/
> ../memfd/Makefile:CFLAGS += -I../../../../include/
> ../memfd/Makefile:CFLAGS += -I../../../../usr/include/
> 
> which seems aimed at doing the same thing, but it is a broken approach
> as far as I can see since if KBUILD_OUTPUT is set, KSFT will install the
> headers accordingly, so that the above static includes won't work anymore.
> 
> Not sure if I'm missing something here, but my understanding was that
> 
> - some KSFT requires arch specific bits, usually included within the dedicated kernel
> headers provided with the source itself and installed with make headers_install.
> 
> and that
> 
> - such headers can be found naturally, being included from top level libc headers
> only if:
> 
> 1. a fully updated toolchain containing updated headers too is available at CROSS_COMPILE=
> 
> or
> 
> 2. proper -I options are specified to the compiler to specify where KSFT installed the 
>   kernel headers related to this kernel and its related KSFT testcases
> 
> or
> 
> 3. updated kernel headers were installed on top of the available CROSS_COMPILE toolchain
> 
> or
> 
> 4. we are building and running natively, so you can install the kernel headers on
>    system default path and those will be searched
> 
> 
> My 'feeling' would have been that in the KSFT scenario we should try to stick with option  2.,
> in order to be able to run KSFT and run the related testcases, relying just on the shipped
> Kernel/KSFT and possibly underlying hw features, but not having any dependencies
> on the toolchain/libc.
> 
> My question is: what happens on a CI-somewhere if suddenly there's the need to update
> the toolchain somehow (fully or partially only the headers) to be able to simply
> build/run the new KSFT included with this Kernel ?; even if we accept this need to update
> the toochain, where this CI should get/scrap-from these minimum toolchain requirements ?
> (in an automated manner)
> 
> If instead we can agree to stick with 2.,  I wonder if this locate-headers mechanism which I introduced
> here should be in charge of the KSFT framework or if there is something broken in my tests: but 
> in these regards similar issues seems to affect KSFT arm64 tags tests queued on arm64/for-next
> 
> https://lkml.org/lkml/2019/8/23/721

Ack, I think we should stick with option 2 for now, but I agree to keep
it local to your tests for now to avoid breaking stuff elsewhere.

In general I think that kselftest should always search the installed
UAPI headers from the containing kernel tree first, since that's the
best way to ensure the headers are 100% up to date.

This may need wider discussion in order to be deployed more widely
across kselftest though.

[...]

> >> diff --git a/tools/testing/selftests/arm64/signal/test_signals.h b/tools/testing/selftests/arm64/signal/test_signals.h

[...]

> >> + *  "The infrastructure emulates only the following system register space:
> >> + *   	Op0=3, Op1=0, CRn=0, CRm=0,4,5,6,7
> >> + */
> >> +#define get_regval(regname, out) \
> >> +	asm volatile("mrs %0, " __stringify(regname) : "=r" (out) :: "memory")
> >> +
> >> +/* Regs encoding and masks naming copied in from sysreg.h */
> >> +#define SYS_ID_AA64MMFR1_EL1	S3_0_C0_C7_1	/* MRS Emulated */
> >> +#define SYS_ID_AA64MMFR2_EL1	S3_0_C0_C7_2	/* MRS Emulated */
> > 
> > These ID regs are part of armv8.0-a, so we don't need to use the magic
> > syntax.
> > mmm... why I found them in non UAPI headers defined as follows ?
> 
> arch/arm64/include/asm/sysreg.h:#define SYS_ID_AA64MMFR1_EL1            sys_reg(3, 0, 0, 7, 1)
> 
> anyway I tried to use nonS3 regular sysreg naming (with a reasonably new compiler:
> 
> /opt/toolchains/gcc-arm-8.3-2019.03-x86_64-aarch64-linux-gnu/bin/aarch64-linux-gnu-
> 
> and it fails (only on id_aa64mmfr2_el1) as follows:
> /tmp/ccqAyE8P.s: Assembler messages:                      
> /tmp/ccoGrnGc.s:1085: Error: selected processor does not support system register name 'id_aa64mmfr2_el1'
> 
> In fact this seems to remind me (not totally sure) that this was the reason to use such S3 syntax on this
> sysregs too.

Ah, it looks like ID_AA64MMFR2_EL1 was added from ARMv8.2-A only.  My
bad.

To keep things consistent, I'm fine with keeping the S3_ syntax for
everything here.

> >> +#define ID_AA64MMFR1_PAN_SHIFT	20
> >> +#define ID_AA64MMFR2_UAO_SHIFT	4

[...]

> >> diff --git a/tools/testing/selftests/arm64/signal/test_signals_utils.c b/tools/testing/selftests/arm64/signal/test_signals_utils.c

[...]

> >> +static inline bool are_feats_ok(struct tdescr *td)
> >> +{
> >> +	return td ? td->feats_required == td->feats_supported : 0;
> > 
> > Should this be something like
> > (td->feats_required & td->feats_supported) == td->feats_required ?
> > 
> > Otherwise additional supported features that our test doesn't care about
> > will cause this check to fail.
> > 
> Yes better.
> 
> > 
> > Do we really need to check td?
> > 
> 
> Overly defensive
> 
> > assert(foo); followed by dereferincing foo is usually a bit pointless
> > because you'd get a SIGSEGV anyway.
> >
> > However, since the tests generate deliberate SIGSEGVs too this could
> > be confusing -- in which case, having an explicit assert() here does
> > no harm.
> > 
> not sure about which assert you refer here

I was persuading myself that my own comment was unnecessary, so don't
worry about it.  The code is fine as-is.

> >> +}
> >> +
> >> +static void default_handler(int signum, siginfo_t *si, void *uc)
> >> +{
> >> +	if (current->sig_trig && signum == current->sig_trig) {
> >> +		fprintf(stderr, "Handling SIG_TRIG\n");
> >> +		current->triggered = 1;
> >> +		/* ->run was asserted NON-NULL in test_setup() already */
> >> +		current->run(current, si, uc);
> >> +	} else if (signum == SIGILL && !current->initialized) {
> >> +		/*
> >> +		 * A SIGILL here while still not initialized means we failed
> >> +		 * even to asses the existence of features during init
> >> +		 */
> >> +		fprintf(stdout,
> >> +			"Got SIGILL test_init. Marking ALL features UNSUPPORTED.\n");
> >> +		current->feats_supported = 0;
> >> +	} else if (current->sig_ok && signum == current->sig_ok) {
> >> +		/* it's a bug in the test code when this assert fail */
> > 
> > Why?  Is this because sig_ok is considered acceptable only as an effect
> > of the test -- i.e., we shouldn't see it if the test hasn't been
> > triggered yet?
> 
> This assert would like to ensure that when you receive a sig_ok signal,
> if a sig_trig was defined != 0, the trigger have been in fact used and processed before
> receiving this sig_ok here: so you didn't define a signal trigger at all, or, if defined
> it has been fired to arrive here. I'll add some commenting about this.

OK

> >> +		assert(!current->sig_trig || current->triggered);
> >> +		fprintf(stderr,
> >> +			"SIG_OK -- SP:%p  si_addr@:0x%p  si_code:%d  token@:0x%p  offset:%ld\n",
> >> +			((ucontext_t *)uc)->uc_mcontext.sp,
> >> +			si->si_addr, si->si_code, current->token,
> >> +			current->token - si->si_addr);
> >> +		/*
> >> +		 * fake_sigreturn tests, which have sanity_enabled=1, set, at
> >> +		 * the very last time, the token field to the SP address used
> >> +		 * to place the fake sigframe: so token==0 means we never made
> >> +		 * it to the end, segfaulting well-before, and the test is
> >> +		 * possibly broken.
> >> +		 */
> >> +		if (!current->sanity_disabled && !current->token) {
> >> +			fprintf(stdout,
> >> +				"current->token ZEROED...test is probably broken!\n");
> >> +			assert(0);
> > 
> > In case someone builds with -DNDEBUG, should we add abort()?
> > 
> Well, in such a case all the test suite is mostly compromised anyway.
> But you are right, I'll add an abort() at least here when broken tests
> are detected.

I guess you're right.  The abort() does no harm, anyway.

[...]

> >> diff --git a/tools/testing/selftests/arm64/signal/testcases/testcases.c b/tools/testing/selftests/arm64/signal/testcases/testcases.c

[...]

> >> +bool validate_reserved(ucontext_t *uc, size_t resv_sz, char **err)
> >> +{
> >> +	bool terminated = false;
> >> +	size_t offs = 0;
> >> +	int flags = 0;
> >> +	struct extra_context *extra = NULL;
> >> +	struct _aarch64_ctx *head =
> >> +		(struct _aarch64_ctx *)uc->uc_mcontext.__reserved;
> >> +
> >> +	if (!err)
> >> +		return false;
> >> +	/* Walk till the end terminator verifying __reserved contents */
> >> +	while (head && !terminated && offs < resv_sz) {
> >> +		if ((uint64_t)head & 0x0fUL) {
> >> +			*err = "Misaligned HEAD";
> >> +			return false;
> >> +		}
> >> +
> >> +		switch (head->magic) {
> >> +			case 0:
> >> +				if (head->size)
> >> +					*err = "Bad size for MAGIC0";
> > 
> > Or "terminator".  We don't have an actual symbolic name for magic number
> > 0.  (Arguably it would have been nice to have a name, but we managed
> > without.)
> 
> ok
> > 
> >> +				else
> >> +					terminated = true;
> >> +				break;
> >> +			case FPSIMD_MAGIC:
> >> +				if (flags & FPSIMD_CTX)
> >> +					*err = "Multiple FPSIMD_MAGIC";
> >> +				else if (head->size !=
> >> +					 sizeof(struct fpsimd_context))
> >> +					*err = "Bad size for fpsimd_context";
> >> +				flags |= FPSIMD_CTX;
> >> +				break;
> >> +			case ESR_MAGIC:
> >> +				if (head->size != sizeof(struct esr_context))
> >> +					fprintf(stderr,
> >> +						"Bad size for esr_context is not an error...just ignore.\n");
> > 
> > Why isn't this an error?  Should the kernel ever write an esr_context
> > with a different size?
> 
> There is no check on Kernel side:
> 
>     case ESR_MAGIC:
>     	/* ignore */
>         break;
> 
> so I sticked with that, since this function can be used to validate a
> Kernel originated sigframe or a crafted one which will be passed down
> to the Kernel.

I see where you're coming from: I'll comment on the v5 patch instead of
here, to make it easier to track any rework.

[...]

> >> +		if (flags & EXTRA_CTX)
> >> +			if (!validate_extra_context(extra, err))
> >> +				return false;
> > 
> > Can we validate the contents of the extra context too?
> > 
> > Ideally we can use the same code to check __reserved[] and the extra
> > context.
> > 
> Do you mean the content pointed by extra->datap ?
> This extra_context validation routine is generally under review and fixes in a further
> arm64/signal SVE extensions patch still to be published (and cleaned up):
> [kselftest: arm64: adds SVE-related signal test], given that EXTRA_CONTEXT can effectively
> appear only when SVE related instruction are used properly.
> 
> Should I introduce this and other extra-context related fixes here instead ?
> (it is hard to test and debug without any triggering SVE instruction though...)

No, it's fine to exclude it for now.

If there's a plan to add it later, that's good enough for me.

[...]

Cheers
---Dave
