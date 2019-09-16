Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 274E3B3992
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Sep 2019 13:40:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731393AbfIPLka (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 16 Sep 2019 07:40:30 -0400
Received: from foss.arm.com ([217.140.110.172]:43820 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731110AbfIPLka (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 16 Sep 2019 07:40:30 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D9F091000;
        Mon, 16 Sep 2019 04:40:28 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F147D3F59C;
        Mon, 16 Sep 2019 04:40:27 -0700 (PDT)
Date:   Mon, 16 Sep 2019 12:40:25 +0100
From:   Dave Martin <Dave.Martin@arm.com>
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     amit.kachhap@arm.com, andreyknvl@google.com, shuah@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v5 02/11] kselftest: arm64: add common utils and one
 testcase
Message-ID: <20190916114025.GH27757@arm.com>
References: <20190902112932.36129-1-cristian.marussi@arm.com>
 <20190902112932.36129-3-cristian.marussi@arm.com>
 <20190904114752.GS27757@arm.com>
 <4d13461b-acf6-505f-aefc-05afdec278c7@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4d13461b-acf6-505f-aefc-05afdec278c7@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Sep 06, 2019 at 11:26:29AM +0100, Cristian Marussi wrote:
> Hi
> 
> On 04/09/2019 12:47, Dave Martin wrote:
> > ^Nit: "add one testcase" doesn't really describe what is being added here.
> > 
> 
> Yep I know...I was trying to stay under first commit line length limitations
> 
> > Maybe the following would work as the subject line:
> > 
> > --8<--
> > kselftest: arm64: mangle_pstate_invalid_compat_toggle and common utils
> > -->8--
> > 
> I'll grab it
> 
> 
> > The remainder of the commit message looks fine.
> > 
> > On Mon, Sep 02, 2019 at 12:29:23pm +0100, Cristian Marussi wrote:
> >> Add some arm64/signal specific boilerplate and utility code to help
> >> further testcases' development.
> >>
> >> Introduce also one simple testcase mangle_pstate_invalid_compat_toggle
> >> and some related helpers: it is a simple mangle testcase which messes
> >> with the ucontext_t from within the signal handler, trying to toggle
> >> PSTATE state bits to switch the system between 32bit/64bit execution
> >> state. Expects SIGSEGV on test PASS.
> >>
> >> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> >> ---
> >> v4 --> v5
> >> - moved kernel headers include search to top level KSFT arm64 Makefile
> >> - removed warning about kernel headers not found
> >> - moved testcases/.gitignore up one level
> >> v3 --> v4
> >> - removed standalone mode
> >> - fixed arm64/signal/README
> >> - add file level comments: test layout / test description
> >> - reduced verbosity
> >> - removed spurious headers includes
> >> - reviewed ID_AA64MMFR[1,2]_EL1 macros
> >> - removed unused feats_ok
> >> - simplified CPU features gathering
> >> - reviewed included headers
> >> - fixed/refactored get_header() and validation routines
> >> - added test description
> >> ---
> > 
> > [...]
> > 
> >> diff --git a/tools/testing/selftests/arm64/signal/test_signals.c b/tools/testing/selftests/arm64/signal/test_signals.c
> >> new file mode 100644
> >> index 000000000000..f05c6dbf8659
> >> --- /dev/null
> >> +++ b/tools/testing/selftests/arm64/signal/test_signals.c
> >> @@ -0,0 +1,29 @@
> >> +// SPDX-License-Identifier: GPL-2.0
> >> +/*
> >> + * Copyright (C) 2019 ARM Limited
> >> + *
> >> + * Generic test wrapper for arm64 signal tests.
> >> + *
> >> + * Each test provides its own tde struct tddescr descriptor to link with
> > 
> > Typo?  tdescr
> > 
> Yes
> 
> > [...]
> > 
> >> diff --git a/tools/testing/selftests/arm64/signal/test_signals_utils.c b/tools/testing/selftests/arm64/signal/test_signals_utils.c
> >> new file mode 100644
> >> index 000000000000..e2a5f37e6ad3
> >> --- /dev/null
> >> +++ b/tools/testing/selftests/arm64/signal/test_signals_utils.c
> >> @@ -0,0 +1,269 @@
> >> +// SPDX-License-Identifier: GPL-2.0
> >> +/* Copyright (C) 2019 ARM Limited */
> >> +
> >> +#include <stdio.h>
> >> +#include <stdlib.h>
> >> +#include <signal.h>
> >> +#include <string.h>
> >> +#include <unistd.h>
> >> +#include <assert.h>
> >> +#include <sys/auxv.h>
> >> +#include <linux/auxvec.h>
> >> +#include <ucontext.h>
> >> +
> >> +#include "test_signals.h"
> >> +#include "test_signals_utils.h"
> >> +#include "testcases/testcases.h"
> >> +
> >> +extern struct tdescr *current;
> >> +
> >> +static char *feats_store[FMAX_END] = {
> > 
> > Nit: can we call this feat_names[]?ok
> > 
> > "store" makes me think of loads and stores...
> > 
> > Also, nit: can this be static const char *const []?
> > 
> > String literals are immutable anyway, and I guess we don't intend too
> > modify the pointers to the strings either...
> > 
> Yes of course.
> 
> >> +	" SSBS ",
> >> +	" PAN ",
> >> +	" UAO ",
> >> +};
> >> +
> >> +#define MAX_FEATS_SZ	128
> >> +static char feats_string[MAX_FEATS_SZ];
> >> +
> >> +static inline char *feats_to_string(unsigned long feats)
> >> +{
> >> +	size_t flen = MAX_FEATS_SZ - 1;
> >> +
> >> +	for (int i = 0; i < FMAX_END; i++) {
> >> +		if (feats & 1UL << i) {
> > 
> > Nit: maybe have () around (1UL << i), though I think it makes no
> > difference.
> 
> Yes it's better, I feared that, being not required, was frown upon.
> 
> > 
> >> +			size_t tlen = strlen(feats_store[i]);
> >> +
> >> +			assert(flen > tlen);
> >> +			flen -= tlen;
> >> +			strncat(feats_string, feats_store[i], flen);
> >> +		}
> >> +	}
> >> +
> >> +	return feats_string;
> >> +}
> >> +
> >> +static void unblock_signal(int signum)
> >> +{
> >> +	sigset_t sset;
> >> +
> >> +	sigemptyset(&sset);
> >> +	sigaddset(&sset, signum);
> >> +	sigprocmask(SIG_UNBLOCK, &sset, NULL);
> >> +}
> >> +
> >> +static void default_result(struct tdescr *td, bool force_exit)
> >> +{
> >> +	if (td->pass)
> >> +		fprintf(stderr, "==>> completed. PASS(1)\n");
> >> +	else
> >> +		fprintf(stdout, "==>> completed. FAIL(0)\n");
> >> +	if (force_exit)
> >> +		exit(td->pass ? EXIT_SUCCESS : EXIT_FAILURE);
> >> +}
> >> +
> >> +static inline bool are_feats_ok(struct tdescr *td)
> >> +{
> >> +	return (td->feats_required & td->feats_supported) == td->feats_required;
> >> +}
> >> +
> >> +static void default_handler(int signum, siginfo_t *si, void *uc)
> >> +{
> >> +	if (current->sig_trig && signum == current->sig_trig) {
> > 
> > (Thinking about it, signum is never 0 because there is no signal 0.
> > So we could write if (signum == current->sig_trig).  But I think your
> > code makes the intention clearer -- so no need to change it.)
> > 
> 
> Yes, in fact that's the reason I left it even if unneeded.

Ok, sounds fine.

> >> +		fprintf(stderr, "Handling SIG_TRIG\n");
> >> +		current->triggered = 1;
> >> +		/* ->run was asserted NON-NULL in test_setup() already */
> >> +		current->run(current, si, uc);
> >> +	} else if (signum == SIGILL && !current->initialized) {

[...]

> >> +static int test_init(struct tdescr *td)
> >> +{
> >> +	td->minsigstksz = getauxval(AT_MINSIGSTKSZ);
> >> +	if (!td->minsigstksz)
> >> +		td->minsigstksz = MINSIGSTKSZ;
> >> +	fprintf(stderr, "Detected MINSTKSIGSZ:%d\n", td->minsigstksz);
> >> +
> >> +	if (td->feats_required) {
> >> +		bool feats_ok = false;
> >> +
> >> +		td->feats_supported = 0;
> >> +		/*
> >> +		 * Checking for CPU required features using both the
> >> +		 * auxval and the arm64 MRS Emulation to read sysregs.
> >> +		 */
> >> +		if (getauxval(AT_HWCAP) & HWCAP_CPUID) {
> >> +			uint64_t val = 0;
> >> +
> >> +			/* Uses HWCAP to check capability */
> >> +			if (getauxval(AT_HWCAP) & HWCAP_SSBS)
> >> +				td->feats_supported |= FEAT_SSBS;
> > 
> > Should this be outside the HWCAP_CPUID check?
> 
> Right.
> 
> > 
> > It's only the get_regval(SYS_ID_foo) based checks that depend on
> > HWCAP_CPUID.
> > 
> >> +			/* Uses MRS emulation to check capability */
> >> +			get_regval(SYS_ID_AA64MMFR1_EL1, val);
> >> +			if (ID_AA64MMFR1_EL1_PAN_SUPPORTED(val))
> >> +				td->feats_supported |= FEAT_PAN;
> >> +			/* Uses MRS emulation to check capability */
> >> +			get_regval(SYS_ID_AA64MMFR2_EL1, val);
> >> +			if (ID_AA64MMFR2_EL1_UAO_SUPPORTED(val))
> >> +				td->feats_supported |= FEAT_UAO;
> >> +		} else {
> >> +			fprintf(stderr,
> >> +				"HWCAP_CPUID NOT available. Mark ALL feats UNSUPPORTED.\n");
> >> +		}
> >> +		feats_ok = are_feats_ok(td);
> >> +		fprintf(stderr,
> >> +			"Required Features: [%s] %ssupported\n",
> >> +			feats_ok ? feats_to_string(td->feats_supported) :
> >> +			feats_to_string(td->feats_required ^
> >> +					td->feats_supported),
> > 
> > Should this be something like:
> > td->feats_required & ~td->feats_supported ?
> > 
> > Otherwise we'll include features that are supported but not required,
> > when printing the features that are NOT supported.
> > 
> > Alternatively, we could just print out the required and supported sets
> > separately and leave it up to the user to obverse how they are
> > different.
> > 
> > (Watch out for calling feats_to_string() twice in the same printf() call
> > though.)
> > 
> Ok. Reported information was poor in fact.

[..]

> >> diff --git a/tools/testing/selftests/arm64/signal/testcases/testcases.c b/tools/testing/selftests/arm64/signal/testcases/testcases.c
> >> new file mode 100644
> >> index 000000000000..72e3f482b177
> >> --- /dev/null
> >> +++ b/tools/testing/selftests/arm64/signal/testcases/testcases.c
> >> @@ -0,0 +1,151 @@
> >> +// SPDX-License-Identifier: GPL-2.0
> >> +/* Copyright (C) 2019 ARM Limited */
> >> +#include "testcases.h"
> >> +
> >> +struct _aarch64_ctx *get_header(struct _aarch64_ctx *head, uint32_t magic,
> >> +				size_t resv_sz, size_t *offset)
> >> +{
> >> +	size_t offs = 0;
> >> +	struct _aarch64_ctx *found = NULL;
> >> +
> >> +	if (!head)
> >> +		return found;
> >> +
> > 
> > I suggest you also check for resv_sz < HDR_SZ, since the while()
> > condition assumes that resv_sz - HDR_SZ doesn't underflow.
> > 
> > For now, I think resv_sz is already sizeof(__reserved) so this is never
> > true, but I suspect we will want to reuse this code eventually to looko
> > at the contents of extra_context.  Then, resv_sz would be the
> > extra_context size rather than a fixed constant.
> > 
> 
> Ok....in fact I think I removed recently such check...not sure why o_O
> I'll fix it.
> 
> 
> >> +	while (offs <= resv_sz - HDR_SZ &&
> >> +	       head->magic != magic && head->magic) {
> >> +		offs += head->size;
> >> +		head = GET_RESV_NEXT_HEAD(head);
> >> +	}
> >> +	if (head->magic == magic) {
> >> +		found = head;
> >> +		if (offset)
> >> +			*offset = offs;
> >> +	}
> > 
> > Although there appears to be some code duplication here, I guess you
> > need things this way to do the right thing if called with magic==0.
> > 
> > So I guess this is fine.
> >
> Yes that was exactly the point, and it seemed to me that removing further
> duplication would have made the code more complex and unreadable.
> 
> > Ultimately it would be good to have GET_RESV_NEXT_HEAD() work more
> > like an iterator, doing integrity bounds/alignment checks and updating
> > offs as it goes, but for now I think the code is sufficient.  We can
> > always beef it up later to catch more kinds of error from the kernel.
> > 
> Yes I remember you told me that on a previous iteration, but for now I left the
> GET_RESV_NEXT_HEAD() as it was without embedding the bounds checking logic
> because it is indirectly used also by the validation function that I use in
> the ASSERT_GOOD/BAD_CONTEXT() macros, so it should be able to handle
> artficially badly formed and corrupted frames without bailing out: it just walks
> and any kind of logic is handled outside...but maybe I'm overthinking
> (certainly I have not explained this reasons anywhere...I'll add a comment)

Sure, I think that's sufficient.

We could always improve this later, if needed.

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
> >> +		case 0:
> >> +			if (head->size)
> >> +				*err = "Bad size for terminator";
> >> +			else
> >> +				terminated = true;
> >> +			break;
> >> +		case FPSIMD_MAGIC:
> >> +			if (flags & FPSIMD_CTX)
> >> +				*err = "Multiple FPSIMD_MAGIC";
> >> +			else if (head->size !=
> >> +				 sizeof(struct fpsimd_context))
> >> +				*err = "Bad size for fpsimd_context";
> >> +			flags |= FPSIMD_CTX;
> >> +			break;
> >> +		case ESR_MAGIC:
> >> +			if (head->size != sizeof(struct esr_context))
> >> +				fprintf(stderr,
> >> +					"Bad size for esr_context is not an error...just ignore.\n");
> >> +			break;
> > 
> > Although it's not essential, I'd prefer that we enforce the correct
> > size here.  All records, including esr_context are intended to be
> > fixed-size.
> > 
> > In the kernel we check a bit more loosely -- this allows userspace to
> > delete a record using head->size += next_head->size.  This way no
> > memmove() is needed to shuffle subsequent records down.  I don't know
> > whether any userspace code makes use of this -- prior to SVE there were
> > no optional records except for esr_context, and sigreturn ignores that
> > in any case so deleting it is pointless.
> > 
> 
> > The kernel should never insert extra padding between records though,
> > so I think it makes sense to have strict size checks in this test.
> > 
> 
> Ok, I'll do. I kept it loose as it is in Kernel, because in some past tests
> (now removed) I used to play also with esr_context size to build easily an inflated
> fake sigframe (but good) and adding some badness on top of it.

OK, I guess that would be a problem if we want to use the same validity
checker for kernel-generated and user-generated signal frames.

I'm happy either way ... I'll take a look at v6 and comment.

Cheers
---Dave
