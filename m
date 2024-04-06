Return-Path: <linux-kselftest+bounces-7349-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABBEF89AD09
	for <lists+linux-kselftest@lfdr.de>; Sat,  6 Apr 2024 23:27:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6B611C20A9C
	for <lists+linux-kselftest@lfdr.de>; Sat,  6 Apr 2024 21:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 180C04E1C1;
	Sat,  6 Apr 2024 21:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Dw+2gJ5t"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A8CBE6C;
	Sat,  6 Apr 2024 21:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712438864; cv=none; b=NBvupRF7py5w3tGBqWQm4JYlwHmkj9hrYwE6Ti+fmQWyANcHkKc+dT9rQJEz66/mjL9iUmfGl5sa8zrKjktq5uDOM4HHEN9yHCvmEOfD4cazjmCNWQ7rizWc5NBmfbkkQ/8ddMVGSz/fxbffxPlnFX0lhFSFeWdLVwZn9nRh01Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712438864; c=relaxed/simple;
	bh=MBFCsX6Mb7MeMYdtCbn0YRk3xZc2KfwwFXanEwGtUzk=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=jb+mJVJv5Jqlgq+Pe+cx34u2rDLN1Gk/MzMJhefDzeLILDyHRPDKCyJnmqxjyXkOJf6uF99J4QbNELw4KF7GAKalqkLfJRhskkO7ntOf8EPb3rzm1uEuuArMJc++MmYpaECepvxO9Y/6Fk9kLREXdwn4IkUgPQBylvv+UuWQtJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Dw+2gJ5t; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1712438859;
	bh=MBFCsX6Mb7MeMYdtCbn0YRk3xZc2KfwwFXanEwGtUzk=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=Dw+2gJ5tOSmDXzrzyqf2Ei3zC+7qwcpqEAj/XS9GOAHBnG++azLZUzb5NDI85gVx8
	 7MqgieBAaMU+ZkcY/FbGUBG9aDp0lTen2sU0OtNWKORonzVOH3FOTzeaXgElZ1/5Y+
	 BrjzF4HvUYL5W1qdEOLAM0njsk0INuf4wv1S27ceqkgRIrA7/SJifw5HGPEkDFzo3U
	 9dm61Bb+T6RT/8bFhGllPNHhmRepLiR3Scc9O6KD9uo0y/imRy+Y49FwEWIRTLpUND
	 rwEymze28ulKW1sEYCCYNIBdDSnM/94FDyAx9RuNBUEe/9DKvP7MyMqxBblRGqBaja
	 KwF4h+X7dfDBg==
Received: from [100.113.15.66] (ec2-34-240-57-77.eu-west-1.compute.amazonaws.com [34.240.57.77])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 285F537809CE;
	Sat,  6 Apr 2024 21:27:33 +0000 (UTC)
Message-ID: <1ce0e9c7-0bd3-47c1-893c-3ea5aa95fef5@collabora.com>
Date: Sun, 7 Apr 2024 02:28:06 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Anshuman.Khandual@arm.com, suzuki.poulose@arm.com, ryan.roberts@arm.com,
 rob.herring@arm.com, Catalin.Marinas@arm.com, broonie@kernel.org,
 will@kernel.org, mark.rutland@arm.com
Subject: Re: [PATCH 2/4] selftests/arm: Add signal tests
To: Dev Jain <dev.jain@arm.com>, shuah@kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20240405084410.256788-1-dev.jain@arm.com>
 <20240405084410.256788-3-dev.jain@arm.com>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20240405084410.256788-3-dev.jain@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/5/24 1:44 PM, Dev Jain wrote:
> This patch introduces two signal tests, and generic test wrappers similar to
> selftests/arm64/signal directory, along with the mangling testcases found
> therein. arm_cpsr, dumped by the kernel to user space in the ucontext structure
> to the signal handler, is mangled with. The kernel must spot this illegal
> attempt and the testcases are expected to terminate via SEGV.
> 
> Signed-off-by: Dev Jain <dev.jain@arm.com>
> ---
>  .../selftests/arm/signal/test_signals.c       |  27 ++
>  .../selftests/arm/signal/test_signals.h       |  74 +++++
>  .../selftests/arm/signal/test_signals_utils.c | 257 ++++++++++++++++++
>  .../selftests/arm/signal/test_signals_utils.h | 128 +++++++++
>  .../signal/testcases/mangle_cpsr_aif_bits.c   |  33 +++
>  .../mangle_cpsr_invalid_compat_toggle.c       |  29 ++
Too many files/tests in one patch. Break this patch logically into multiple
tests for easy to review and follow.

>  6 files changed, 548 insertions(+)
>  create mode 100644 tools/testing/selftests/arm/signal/test_signals.c
>  create mode 100644 tools/testing/selftests/arm/signal/test_signals.h
>  create mode 100644 tools/testing/selftests/arm/signal/test_signals_utils.c
>  create mode 100644 tools/testing/selftests/arm/signal/test_signals_utils.h
>  create mode 100644 tools/testing/selftests/arm/signal/testcases/mangle_cpsr_aif_bits.c
>  create mode 100644 tools/testing/selftests/arm/signal/testcases/mangle_cpsr_invalid_compat_toggle.c
> 
> diff --git a/tools/testing/selftests/arm/signal/test_signals.c b/tools/testing/selftests/arm/signal/test_signals.c
> new file mode 100644
> index 000000000000..1ecf1e9f041c
> --- /dev/null
> +++ b/tools/testing/selftests/arm/signal/test_signals.c
> @@ -0,0 +1,27 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2024 ARM Limited
> + *
> + * Generic test wrapper for arm signal tests.
> + *
> + * Each test provides its own tde struct tdescr descriptor to link with
> + * this wrapper. Framework provides common helpers.
> + */
> +#include <kselftest.h>
> +
> +#include "test_signals.h"
> +#include "test_signals_utils.h"
> +
> +struct tdescr *current = &tde;
> +
> +int main(int argc, char *argv[])
> +{
> +	ksft_print_msg("%s :: %s\n", current->name, current->descr);
> +	if (test_setup(current) && test_init(current)) {
> +		test_run(current);
> +		test_cleanup(current);
> +	}
> +	test_result(current);
> +
> +	return current->result;
> +}
This test isn't TAP compliant. Please make this and all tests TAP
compilant. The 1/4 patch has example of TAP usage.

> diff --git a/tools/testing/selftests/arm/signal/test_signals.h b/tools/testing/selftests/arm/signal/test_signals.h
> new file mode 100644
> index 000000000000..bbd147127d66
> --- /dev/null
> +++ b/tools/testing/selftests/arm/signal/test_signals.h
> @@ -0,0 +1,74 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* Copyright (C) 2024 ARM Limited */
> +
> +#ifndef __TEST_SIGNALS_H__
> +#define __TEST_SIGNALS_H__
> +
> +#include <signal.h>
> +#include <stdbool.h>
> +#include <ucontext.h>
> +
> +/*
> + * Using ARCH specific and sanitized Kernel headers from the tree.
> + */
> +#include <asm/ptrace.h>
> +#include <asm/hwcap.h>
> +
> +/*
> + * A descriptor used to describe and configure a test case.
> + * Fields with a non-trivial meaning are described inline in the following.
> + */
> +struct tdescr {
> +	/* KEEP THIS FIELD FIRST for easier lookup from assembly */
> +	void			*token;
> +	/* when disabled token based sanity checking is skipped in handler */
> +	bool			sanity_disabled;
> +	/* just a name for the test-case; manadatory field */
> +	char			*name;
> +	char			*descr;
> +
> +	bool			initialized;
> +	unsigned int		minsigstksz;
> +	/* signum used as a test trigger. Zero if no trigger-signal is used */
> +	int			sig_trig;
> +	/*
> +	 * signum considered as a successful test completion.
> +	 * Zero when no signal is expected on success
> +	 */
> +	int			sig_ok;
> +	/* signum expected on unsupported CPU features. */
> +	int			sig_unsupp;
> +	/* a timeout in second for test completion */
> +	unsigned int		timeout;
> +	bool			triggered;
> +	bool			pass;
> +	unsigned int		result;
> +	/* optional sa_flags for the installed handler */
> +	int			sa_flags;
> +	ucontext_t		saved_uc;
> +	/* used by get_current_ctx() */
> +	size_t			live_sz;
> +	ucontext_t		*live_uc;
> +	volatile sig_atomic_t	live_uc_valid;
> +	/* optional test private data */
> +	void			*priv;
> +
> +	/* a custom setup: called alternatively to default_setup */
> +	int (*setup)(struct tdescr *td);
> +	/* a custom init: called by default test init after test_setup */
> +	bool (*init)(struct tdescr *td);
> +	/* a custom cleanup function called before test exits */
> +	void (*cleanup)(struct tdescr *td);
> +	/* an optional function to be used as a trigger for starting test */
> +	int (*trigger)(struct tdescr *td);
> +	/*
> +	 * the actual test-core: invoked differently depending on the
> +	 * presence of the trigger function above; this is mandatory
> +	 */
> +	int (*run)(struct tdescr *td, siginfo_t *si, ucontext_t *uc);
> +	/* an optional function for custom results' processing */
> +	void (*check_result)(struct tdescr *td);
> +};
> +
> +extern struct tdescr tde;
> +#endif
> diff --git a/tools/testing/selftests/arm/signal/test_signals_utils.c b/tools/testing/selftests/arm/signal/test_signals_utils.c
> new file mode 100644
> index 000000000000..96aeb11de151
> --- /dev/null
> +++ b/tools/testing/selftests/arm/signal/test_signals_utils.c
> @@ -0,0 +1,257 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (C) 2024 ARM Limited */
> +
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <signal.h>
> +#include <string.h>
> +#include <unistd.h>
> +#include <assert.h>
> +#include <sys/auxv.h>
> +#include <linux/auxvec.h>
> +#include <ucontext.h>
> +
> +#include <asm/unistd.h>
> +
> +#include <kselftest.h>
> +
> +#include "test_signals.h"
> +#include "test_signals_utils.h"
> +
> +
> +extern struct tdescr *current;
> +
> +static int sig_copyctx = SIGTRAP;
> +
> +static void unblock_signal(int signum)
> +{
> +	sigset_t sset;
> +
> +	sigemptyset(&sset);
> +	sigaddset(&sset, signum);
> +	sigprocmask(SIG_UNBLOCK, &sset, NULL);
> +}
> +
> +static void default_result(struct tdescr *td, bool force_exit)
> +{
> +	if (td->result == KSFT_SKIP) {
> +		fprintf(stderr, "==>> completed. SKIP.\n");
> +	} else if (td->pass) {
> +		fprintf(stderr, "==>> completed. PASS(1)\n");
> +		td->result = KSFT_PASS;
> +	} else {
> +		fprintf(stdout, "==>> completed. FAIL(0)\n");
> +		td->result = KSFT_FAIL;
> +	}
> +
> +	if (force_exit)
> +		exit(td->result);
> +}
> +
> +/*
> + * The following handle_signal_* helpers are used by main default_handler
> + * and are meant to return true when signal is handled successfully:
> + * when false is returned instead, it means that the signal was somehow
> + * unexpected in that context and it was NOT handled; default_handler will
> + * take care of such unexpected situations.
> + */
> +
> +static bool handle_signal_unsupported(struct tdescr *td,
> +				      siginfo_t *si, void *uc)
> +{
> +
> +	/* Mangling PC to avoid loops on original SIGILL */
> +	((ucontext_t *)uc)->uc_mcontext.arm_pc += 4;
> +
> +	if (!td->initialized) {
> +		fprintf(stderr,
> +			"Got SIG_UNSUPP @test_init. Ignore.\n");
> +	} else {
> +		fprintf(stderr,
> +			"-- RX SIG_UNSUPP on unsupported feat...OK\n");
> +		td->pass = 1;
> +		default_result(current, 1);
> +	}
> +
> +	return true;
> +}
> +
> +static bool handle_signal_trigger(struct tdescr *td,
> +				  siginfo_t *si, void *uc)
> +{
> +	td->triggered = 1;
> +
> +	/* ->run was asserted NON-NULL in test_setup() already */
> +	td->run(td, si, uc);
> +
> +	return true;
> +}
> +
> +static bool handle_signal_ok(struct tdescr *td,
> +			     siginfo_t *si, void *uc)
> +{
> +
> +	/*
> +	 * it's a bug in the test code when this assert fail:
> +	 * if sig_trig was defined, it must have been used before getting here.
> +	 */
> +	assert(!td->sig_trig || td->triggered);
> +	fprintf(stderr,
> +		"SIG_OK -- SP:0x%lX  si_addr@:%p  si_code:%d  token@:%p  offset:%d\n",
> +		((ucontext_t *)uc)->uc_mcontext.arm_sp,
> +		si->si_addr, si->si_code, td->token, td->token - si->si_addr);
> +
> +	/*
> +	 * Trying to narrow down the SEGV to the ones generated by Kernel itself
> +	 * via arm64_notify_segfault(). This is a best-effort check anyway, and
> +	 * the si_code check may need to change if this aspect of the kernel
> +	 * ABI changes.
> +	 */
> +	if (td->sig_ok == SIGSEGV && si->si_code != SEGV_ACCERR) {
> +		fprintf(stdout,
> +			"si_code != SEGV_ACCERR...test is probably broken!\n");
> +		abort();
> +	}
> +	td->pass = 1;
> +	/*
> +	 * Some tests can lead to SEGV loops: in such a case we want to
> +	 * terminate immediately exiting straight away; some others are not
> +	 * supposed to outlive the signal handler code, due to the content of
> +	 * the fake sigframe which caused the signal itself.
> +	 */
> +	default_result(current, 1);
> +
> +	return true;
> +}
> +
> +static void default_handler(int signum, siginfo_t *si, void *uc)
> +{
> +	if (current->sig_unsupp && signum == current->sig_unsupp &&
> +	    handle_signal_unsupported(current, si, uc)) {
> +		fprintf(stderr, "Handled SIG_UNSUPP\n");
> +	} else if (current->sig_trig && signum == current->sig_trig &&
> +		   handle_signal_trigger(current, si, uc)) {
> +		fprintf(stderr, "Handled SIG_TRIG\n");
> +	} else if (current->sig_ok && signum == current->sig_ok &&
> +		   handle_signal_ok(current, si, uc)) {
> +		fprintf(stderr, "Handled SIG_OK\n");
> +	} else if (signum == sig_copyctx && current->live_uc) {
> +		fprintf(stderr, "Handled SIG_COPYCTX\n");
> +	} else {
> +		if (signum == SIGALRM && current->timeout) {
> +			fprintf(stderr, "-- Timeout !\n");
> +		} else {
> +			fprintf(stderr,
> +				"-- RX UNEXPECTED SIGNAL: %d code %d address %p\n",
> +				signum, si->si_code, si->si_addr);
> +		}
> +		default_result(current, 1);
> +	}
> +}
> +
> +static int default_setup(struct tdescr *td)
> +{
> +	struct sigaction sa;
> +
> +	sa.sa_sigaction = default_handler;
> +	sa.sa_flags = SA_SIGINFO | SA_RESTART;
> +	sa.sa_flags |= td->sa_flags;
> +	sigemptyset(&sa.sa_mask);
> +	/* uncatchable signals naturally skipped ... */
> +	for (int sig = 1; sig < 32; sig++)
> +		sigaction(sig, &sa, NULL);
> +	/*
> +	 * RT Signals default disposition is Term but they cannot be
> +	 * generated by the Kernel in response to our tests; so just catch
> +	 * them all and report them as UNEXPECTED signals.
> +	 */
> +	for (int sig = SIGRTMIN; sig <= SIGRTMAX; sig++)
> +		sigaction(sig, &sa, NULL);
> +
> +	/* just in case...unblock explicitly all we need */
> +	if (td->sig_trig)
> +		unblock_signal(td->sig_trig);
> +	if (td->sig_ok)
> +		unblock_signal(td->sig_ok);
> +	if (td->sig_unsupp)
> +		unblock_signal(td->sig_unsupp);
> +
> +	if (td->timeout) {
> +		unblock_signal(SIGALRM);
> +		alarm(td->timeout);
> +	}
> +	fprintf(stderr, "Registered handlers for all signals.\n");
> +
> +	return 1;
> +}
> +
> +static inline int default_trigger(struct tdescr *td)
> +{
> +	return !raise(td->sig_trig);
> +}
> +
> +int test_init(struct tdescr *td)
> +{
> +	if (td->sig_trig == sig_copyctx) {
> +		fprintf(stdout,
> +			"Signal %d is RESERVED, cannot be used as a trigger. Aborting\n",
> +			sig_copyctx);
> +		return 0;
> +	}
> +	/* just in case */
> +	unblock_signal(sig_copyctx);
> +
> +	td->minsigstksz = getauxval(AT_MINSIGSTKSZ);
> +	if (!td->minsigstksz)
> +		td->minsigstksz = MINSIGSTKSZ;
> +	fprintf(stderr, "Detected MINSTKSIGSZ:%d\n", td->minsigstksz);
> +
> +	/* Perform test specific additional initialization */
> +	if (td->init && !td->init(td)) {
> +		fprintf(stderr, "FAILED Testcase initialization.\n");
> +		return 0;
> +	}
> +	td->initialized = 1;
> +	fprintf(stderr, "Testcase initialized.\n");
> +
> +	return 1;
> +}
> +
> +int test_setup(struct tdescr *td)
> +{
> +	/* assert core invariants symptom of a rotten testcase */
> +	assert(current);
> +	assert(td);
> +	assert(td->name);
> +	assert(td->run);
> +
> +	/* Default result is FAIL if test setup fails */
> +	td->result = KSFT_FAIL;
> +	if (td->setup)
> +		return td->setup(td);
> +	else
> +		return default_setup(td);
> +}
> +
> +int test_run(struct tdescr *td)
> +{
> +	if (td->trigger)
> +		return td->trigger(td);
> +	else if (td->sig_trig)
> +		return default_trigger(td);
> +	else
> +		return td->run(td, NULL, NULL);
> +}
> +
> +void test_result(struct tdescr *td)
> +{
> +	if (td->initialized && td->result != KSFT_SKIP && td->check_result)
> +		td->check_result(td);
> +	default_result(td, 0);
> +}
> +
> +void test_cleanup(struct tdescr *td)
> +{
> +	if (td->cleanup)
> +		td->cleanup(td);
> +}
> diff --git a/tools/testing/selftests/arm/signal/test_signals_utils.h b/tools/testing/selftests/arm/signal/test_signals_utils.h
> new file mode 100644
> index 000000000000..386dcc6c268d
> --- /dev/null
> +++ b/tools/testing/selftests/arm/signal/test_signals_utils.h
> @@ -0,0 +1,128 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* Copyright (C) 2024 ARM Limited */
> +
> +#ifndef __TEST_SIGNALS_UTILS_H__
> +#define __TEST_SIGNALS_UTILS_H__
> +
> +#include <assert.h>
> +#include <stdio.h>
> +#include <string.h>
> +
> +#include <linux/compiler.h>
> +#include "test_signals.h"
> +
> +int test_init(struct tdescr *td);
> +int test_setup(struct tdescr *td);
> +void test_cleanup(struct tdescr *td);
> +int test_run(struct tdescr *td);
> +void test_result(struct tdescr *td);
> +
> +/*
> + * Obtaining a valid and full-blown ucontext_t from userspace is tricky:
> + * libc getcontext does() not save all the regs and messes with some of
> + * them (pstate value in particular is not reliable).
> + *
> + * Here we use a service signal to grab the ucontext_t from inside a
> + * dedicated signal handler, since there, it is populated by Kernel
> + * itself in setup_sigframe(). The grabbed context is then stored and
> + * made available in td->live_uc.
> + *
> + * As service-signal is used a SIGTRAP induced by a 'brk' instruction,
> + * because here we have to avoid syscalls to trigger the signal since
> + * they would cause any SVE sigframe content (if any) to be removed.
> + *
> + * Anyway this function really serves a dual purpose:
> + *
> + * 1. grab a valid sigcontext into td->live_uc for result analysis: in
> + * such case it returns 1.
> + *
> + * 2. detect if, somehow, a previously grabbed live_uc context has been
> + * used actively with a sigreturn: in such a case the execution would have
> + * magically resumed in the middle of this function itself (seen_already==1):
> + * in such a case return 0, since in fact we have not just simply grabbed
> + * the context.
> + *
> + * This latter case is useful to detect when a fake_sigreturn test-case has
> + * unexpectedly survived without hitting a SEGV.
> + *
> + * Note that the case of runtime dynamically sized sigframes (like in SVE
> + * context) is still NOT addressed: sigframe size is supposed to be fixed
> + * at sizeof(ucontext_t).
> + */
> +static __always_inline bool get_current_context(struct tdescr *td,
> +						ucontext_t *dest_uc,
> +						size_t dest_sz)
> +{
> +	static volatile bool seen_already;
> +	int i;
> +	char *uc = (char *)dest_uc;
> +
> +	assert(td && dest_uc);
> +	/* it's a genuine invocation..reinit */
> +	seen_already = 0;
> +	td->live_uc_valid = 0;
> +	td->live_sz = dest_sz;
> +
> +	/*
> +	 * This is a memset() but we don't want the compiler to
> +	 * optimise it into either instructions or a library call
> +	 * which might be incompatible with streaming mode.
> +	 */
> +	for (i = 0; i < td->live_sz; i++) {
> +		uc[i] = 0;
> +		OPTIMIZER_HIDE_VAR(uc[0]);
> +	}
> +
> +	td->live_uc = dest_uc;
> +	/*
> +	 * Grab ucontext_t triggering a SIGTRAP.
> +	 *
> +	 * Note that:
> +	 * - live_uc_valid is declared volatile sig_atomic_t in
> +	 *   struct tdescr since it will be changed inside the
> +	 *   sig_copyctx handler
> +	 * - the additional 'memory' clobber is there to avoid possible
> +	 *   compiler's assumption on live_uc_valid and the content
> +	 *   pointed by dest_uc, which are all changed inside the signal
> +	 *   handler
> +	 * - BRK causes a debug exception which is handled by the Kernel
> +	 *   and finally causes the SIGTRAP signal to be delivered to this
> +	 *   test thread. Since such delivery happens on the ret_to_user()
> +	 *   /do_notify_resume() debug exception return-path, we are sure
> +	 *   that the registered SIGTRAP handler has been run to completion
> +	 *   before the execution path is restored here: as a consequence
> +	 *   we can be sure that the volatile sig_atomic_t live_uc_valid
> +	 *   carries a meaningful result. Being in a single thread context
> +	 *   we'll also be sure that any access to memory modified by the
> +	 *   handler (namely ucontext_t) will be visible once returned.
> +	 * - note that since we are using a breakpoint instruction here
> +	 *   to cause a SIGTRAP, the ucontext_t grabbed from the signal
> +	 *   handler would naturally contain a PC pointing exactly to this
> +	 *   BRK line, which means that, on return from the signal handler,
> +	 *   or if we place the ucontext_t on the stack to fake a sigreturn,
> +	 *   we'll end up in an infinite loop of BRK-SIGTRAP-handler.
> +	 *   For this reason we take care to artificially move forward the
> +	 *   PC to the next instruction while inside the signal handler.
> +	 */
> +	asm volatile ("brk #666"
> +		      : "+m" (*dest_uc)
> +		      :
> +		      : "memory");
> +
> +	/*
> +	 * If we get here with seen_already==1 it implies the td->live_uc
> +	 * context has been used to get back here....this probably means
> +	 * a test has failed to cause a SEGV...anyway live_uc does not
> +	 * point to a just acquired copy of ucontext_t...so return 0
> +	 */
> +	if (seen_already) {
> +		fprintf(stdout,
> +			"Unexpected successful sigreturn detected: live_uc is stale !\n");
> +		return 0;
> +	}
> +	seen_already = 1;
> +
> +	return td->live_uc_valid;
> +}
> +
> +#endif
> diff --git a/tools/testing/selftests/arm/signal/testcases/mangle_cpsr_aif_bits.c b/tools/testing/selftests/arm/signal/testcases/mangle_cpsr_aif_bits.c
> new file mode 100644
> index 000000000000..f422cd11ccf2
> --- /dev/null
> +++ b/tools/testing/selftests/arm/signal/testcases/mangle_cpsr_aif_bits.c
> @@ -0,0 +1,33 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2024 ARM Limited
> + *
> + * Try to mangle the ucontext from inside a signal handler, mangling the
> + * AIF bits in an illegal manner: this attempt must be spotted by Kernel
> + * and the test case is expected to be terminated via SEGV.
> + *
> + */
> +
> +#include "test_signals_utils.h"
> +
> +static int mangle_invalid_cpsr_run(struct tdescr *td, siginfo_t *si,
> +				   ucontext_t *uc)
> +{
> +
> +	/*
> +	 * This config should trigger a SIGSEGV by Kernel when it checks
> +	 * the sigframe consistency in valid_user_regs() routine.
> +	 */
> +	uc->uc_mcontext.arm_cpsr |= PSR_A_BIT | PSR_I_BIT | PSR_F_BIT;
> +
> +	return 1;
> +}
> +
> +struct tdescr tde = {
> +		.sanity_disabled = true,
> +		.name = "MANGLE_CPSR_INVALID_AIF_BITS",
> +		.descr = "Mangling uc_mcontext with INVALID AIF_BITS",
> +		.sig_trig = SIGUSR1,
> +		.sig_ok = SIGSEGV,
> +		.run = mangle_invalid_cpsr_run,
> +};
> diff --git a/tools/testing/selftests/arm/signal/testcases/mangle_cpsr_invalid_compat_toggle.c b/tools/testing/selftests/arm/signal/testcases/mangle_cpsr_invalid_compat_toggle.c
> new file mode 100644
> index 000000000000..cb7eb8aec7f2
> --- /dev/null
> +++ b/tools/testing/selftests/arm/signal/testcases/mangle_cpsr_invalid_compat_toggle.c
> @@ -0,0 +1,29 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2024 ARM Limited
> + *
> + * Try to mangle the ucontext from inside a signal handler, toggling
> + * the execution state bit: this attempt must be spotted by Kernel and
> + * the test case is expected to be terminated via SEGV.
> + */
> +
> +#include "test_signals_utils.h"
> +
> +static int mangle_invalid_cpsr_run(struct tdescr *td, siginfo_t *si,
> +				   ucontext_t *uc)
> +{
> +
> +	/* This config should trigger a SIGSEGV by Kernel */
> +	uc->uc_mcontext.arm_cpsr ^= MODE32_BIT;
> +
> +	return 1;
> +}
> +
> +struct tdescr tde = {
> +		.sanity_disabled = true,
> +		.name = "MANGLE_CPSR_INVALID_STATE_TOGGLE",
> +		.descr = "Mangling uc_mcontext with INVALID STATE_TOGGLE",
> +		.sig_trig = SIGUSR1,
> +		.sig_ok = SIGSEGV,
> +		.run = mangle_invalid_cpsr_run,
> +};

-- 
BR,
Muhammad Usama Anjum

