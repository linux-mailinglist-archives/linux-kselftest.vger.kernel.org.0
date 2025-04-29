Return-Path: <linux-kselftest+bounces-31904-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 64827AA1079
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Apr 2025 17:28:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5CA9F7B4ACF
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Apr 2025 15:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EABB22171A;
	Tue, 29 Apr 2025 15:27:37 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 741E5221703;
	Tue, 29 Apr 2025 15:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745940457; cv=none; b=DD7hOps0zyvbJP6FmyXj6zfuraq+Sm+oSF5cdPivX0kktsSoqGyhVZ5EOYh/3opJ90QulqTSFfPS7K62whCOqiSelhuOoAobig7Nyq5YBTJcQABE5RAQpqE4HE1OQLmktyvUAaHPhZgszPOmWx38VVTiW+bjy5xLIKGc78e5kM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745940457; c=relaxed/simple;
	bh=tRzFMDqiQktHIzjzC5iKvHZSY49zCoD2GYhyyzs/XnE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HcrPpmyIjSLIoqFYIMyaYSIvHqepFJDJ6wZ5TXMgr4WShUuPpcnQyUR6MNO1jl4odtMpusgG30WLX1cEcwzif65YDFxtAhMcy7i8B5QybXfM37F/erUXMxMJOqTmcaGJEMazAQDYBE7rnHlMdfb8lEYVfvlEyAzkdb3ObpTJ/pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D05CC1515;
	Tue, 29 Apr 2025 08:27:27 -0700 (PDT)
Received: from J2N7QTR9R3.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1ADB83F673;
	Tue, 29 Apr 2025 08:27:32 -0700 (PDT)
Date: Tue, 29 Apr 2025 16:27:27 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Mark Brown <broonie@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
	Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev
Subject: Re: [PATCH] KVM: selftests: add test for SVE host corruption
Message-ID: <aBDv39FD7eDYoplg@J2N7QTR9R3.cambridge.arm.com>
References: <20250417-kvm-selftest-sve-signal-v1-1-6330c2f3da0c@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250417-kvm-selftest-sve-signal-v1-1-6330c2f3da0c@kernel.org>

On Thu, Apr 17, 2025 at 12:32:49AM +0100, Mark Brown wrote:
> This test program, originally written by Mark Rutland and lightly modified
> by me for upstream,

For context, I had originally pushed this as a WIP to:

  https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/commit/?h=arm64/kvm/fpsimd-tests&id=a2f7319f5b13f5f5354e6186925b3bb8f2d2966e

> verifies that we do not have the issues with host SVE
> state being discarded which were fixed in
> 
>    fbc7e61195e2 ("KVM: arm64: Unconditionally save+flush host FPSIMD/SVE/SME state")
> 
> by running a simple VM while checking the SVE register state for
> corruption.

Minor nit, but this doesn't verify the absence of the issue, as that can
be masked by preemption. I would suggest:

| Until recently, the kernel could unexpectedly discard SVE state for a
| period after a KVM_RUN ioctl, when the guest did not execute any
| FPSIMD/SVE/SME instructions. We fixed that issue in commit:
|
|   fbc7e61195e2 ("KVM: arm64: Unconditionally save+flush host FPSIMD/SVE/SME state")
|
| Add a test which tries to provoke that issue by manipulating SVE state
| before/after running a guest which does not execute any FPSIMD/SVE/SME
| instructions. The test executes a handful of iterations to miminize
| the risk that the issue is masked by preemption.

> Signed-off-by: Mark Brown <broonie@kernel.org>

Looks like my Signed-off-by got dropped by accident; it should be above
yours here.

Aside from that, and the initial feature test, this looks pretty much
identical to my original WIP.

I'm not sure if it's worth keeping all the printf() calls, which were
only there to help me check the UDF trap was being handled correctly.

Either way, with the commit message updated and SoB restored:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
>  tools/testing/selftests/kvm/Makefile.kvm     |   1 +
>  tools/testing/selftests/kvm/arm64/host_sve.c | 127 +++++++++++++++++++++++++++
>  2 files changed, 128 insertions(+)
> 
> diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
> index f62b0a5aba35..d37072054a3d 100644
> --- a/tools/testing/selftests/kvm/Makefile.kvm
> +++ b/tools/testing/selftests/kvm/Makefile.kvm
> @@ -147,6 +147,7 @@ TEST_GEN_PROGS_arm64 = $(TEST_GEN_PROGS_COMMON)
>  TEST_GEN_PROGS_arm64 += arm64/aarch32_id_regs
>  TEST_GEN_PROGS_arm64 += arm64/arch_timer_edge_cases
>  TEST_GEN_PROGS_arm64 += arm64/debug-exceptions
> +TEST_GEN_PROGS_arm64 += arm64/host_sve
>  TEST_GEN_PROGS_arm64 += arm64/hypercalls
>  TEST_GEN_PROGS_arm64 += arm64/mmio_abort
>  TEST_GEN_PROGS_arm64 += arm64/page_fault_test
> diff --git a/tools/testing/selftests/kvm/arm64/host_sve.c b/tools/testing/selftests/kvm/arm64/host_sve.c
> new file mode 100644
> index 000000000000..3826772fd470
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/arm64/host_sve.c
> @@ -0,0 +1,127 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +/*
> + * Host SVE: Check FPSIMD/SVE/SME save/restore over KVM_RUN ioctls.
> + *
> + * Copyright 2025 Arm, Ltd
> + */
> +
> +#include <errno.h>
> +#include <signal.h>
> +#include <sys/auxv.h>
> +#include <asm/kvm.h>
> +#include <kvm_util.h>
> +
> +#include "ucall_common.h"
> +
> +static void guest_code(void)
> +{
> +	for (int i = 0; i < 10; i++) {
> +		GUEST_UCALL_NONE();
> +	}
> +
> +	GUEST_DONE();
> +}
> +
> +void handle_sigill(int sig, siginfo_t *info, void *ctx)
> +{
> +	ucontext_t *uctx = ctx;
> +
> +	printf("  < host signal %d >\n", sig);
> +
> +	/*
> +	 * Skip the UDF
> +	 */
> +	uctx->uc_mcontext.pc += 4;
> +}
> +
> +void register_sigill_handler(void)
> +{
> +	struct sigaction sa = {
> +		.sa_sigaction = handle_sigill,
> +		.sa_flags = SA_SIGINFO,
> +	};
> +	sigaction(SIGILL, &sa, NULL);
> +}
> +
> +static void do_sve_roundtrip(void)
> +{
> +	unsigned long before, after;
> +
> +	/*
> +	 * Set all bits in a predicate register, force a save/restore via a
> +	 * SIGILL (which handle_sigill() will recover from), then report
> +	 * whether the value has changed.
> +	 */
> +	asm volatile(
> +	"	.arch_extension sve\n"
> +	"	ptrue	p0.B\n"
> +	"	cntp	%[before], p0, p0.B\n"
> +	"	udf #0\n"
> +	"	cntp	%[after], p0, p0.B\n"
> +	: [before] "=r" (before),
> +	  [after] "=r" (after)
> +	:
> +	: "p0"
> +	);
> +
> +	if (before != after) {
> +		TEST_FAIL("Signal roundtrip discarded predicate bits (%ld => %ld)\n",
> +			  before, after);
> +	} else {
> +		printf("Signal roundtrip preserved predicate bits (%ld => %ld)\n",
> +		       before, after);
> +	}
> +}
> +
> +static void test_run(void)
> +{
> +	struct kvm_vcpu *vcpu;
> +	struct kvm_vm *vm;
> +	struct ucall uc;
> +	bool guest_done = false;
> +
> +	register_sigill_handler();
> +
> +	vm = vm_create_with_one_vcpu(&vcpu, guest_code);
> +
> +	do_sve_roundtrip();
> +
> +	while (!guest_done) {
> +
> +		printf("Running VCPU...\n");
> +		vcpu_run(vcpu);
> +
> +		switch (get_ucall(vcpu, &uc)) {
> +		case UCALL_NONE:
> +			do_sve_roundtrip();
> +			do_sve_roundtrip();
> +			break;
> +		case UCALL_DONE:
> +			guest_done = true;
> +			break;
> +		case UCALL_ABORT:
> +			REPORT_GUEST_ASSERT(uc);
> +			break;
> +		default:
> +			TEST_FAIL("Unexpected guest exit");
> +		}
> +	}
> +
> +	kvm_vm_free(vm);
> +}
> +
> +int main(void)
> +{
> +	/*
> +	 * This is testing the host environment, we don't care about
> +	 * guest SVE support.
> +	 */
> +	if (!(getauxval(AT_HWCAP) & HWCAP_SVE)) {
> +		printf("SVE not supported\n");
> +		return KSFT_SKIP;
> +	}
> +
> +	test_run();
> +	return 0;
> +}
> 
> ---
> base-commit: 8ffd015db85fea3e15a77027fda6c02ced4d2444
> change-id: 20250226-kvm-selftest-sve-signal-1add0d9d716c
> 
> Best regards,
> -- 
> Mark Brown <broonie@kernel.org>
> 

