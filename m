Return-Path: <linux-kselftest+bounces-8475-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67EC28AB439
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Apr 2024 19:13:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07D6A1F22801
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Apr 2024 17:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A41D13A267;
	Fri, 19 Apr 2024 17:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I6MhlZm8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ACA0139D14;
	Fri, 19 Apr 2024 17:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713546800; cv=none; b=d4Sq9/bIjUBGtpLkhqeNEds8SVO3TONMXkB4VbdIkVSOUZ+TXpssnu3DZxB4wv0Ddr9yspfG89ED4su3losRY+Do2bWBcRMW566fF9RSTzmdWFK5r9+w6AL8Y1TGwY4L8sRyqFCaxwgHcjlQxMR0IXRB0zHHZvHFmNceKgqWojw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713546800; c=relaxed/simple;
	bh=mFM40ysmJgPShNXuUwicehB5gO7kf2TKXguIt+XTe9s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sNnsFOsvqHOCFUsGXMASlskwfk2FIQtQvEQPlLxoSuw1LeX0e5xdQ4Se1xsG4ZyDux4H/Z7/cLQsA8/0WA3u0cbbfnGdJAElniCa/RAtBbc8ETDSoSO/kof22OqQemw164SexHafcRmHGrU4UsORz2V1pvFiTbaEbCkraOTrDw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I6MhlZm8; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713546799; x=1745082799;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=mFM40ysmJgPShNXuUwicehB5gO7kf2TKXguIt+XTe9s=;
  b=I6MhlZm8C86E+8tdFtkBNKrpe4wWiWHqTRY3YKmTKddNGAWZF173nP94
   svobCiR63paxEysc6ZKfsXehnX3btVJ17nUStYtldyinEc4ZnEBqIn4IB
   nHWHgbZKprQxet3QtIrS2qpdSk7Pxb+qI8WcnHKWkvpNZOvxgSeE1Cv1l
   141YcY5Kp4zu5ZnQicX12DUgpKI/OHF5KUMH+YM8VjE6Re+ZazkEgoLc1
   6fqEm4ynaonbBoAW42GYmz+DPAd/WfKgq0J4XF8aiklXd5HERsWbqR/no
   GxUShmZFkgMlynN192QohnZUZaFgb5dxYw8JvDJZkbfWLJvSmpaeitpgk
   w==;
X-CSE-ConnectionGUID: VMrlAMiOSiy3SiJSDWbnNQ==
X-CSE-MsgGUID: vfHA0BheTWelZvCNs0sN6Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11049"; a="34559018"
X-IronPort-AV: E=Sophos;i="6.07,214,1708416000"; 
   d="scan'208";a="34559018"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2024 10:13:18 -0700
X-CSE-ConnectionGUID: z+ry7tb3R4alYO94tUd1mA==
X-CSE-MsgGUID: TxSOaFYqRw25PIUEaDNeKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,214,1708416000"; 
   d="scan'208";a="54321210"
Received: from soc-cp83kr3.jf.intel.com (HELO [10.24.10.31]) ([10.24.10.31])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2024 10:13:17 -0700
Message-ID: <3664e8ec-1fa1-48c0-a80d-546b7f6cd671@intel.com>
Date: Fri, 19 Apr 2024 10:13:16 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] KVM: selftests: Add KVM/PV clock selftest to prove
 timer drift correction
To: Jack Allister <jalliste@amazon.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Jonathan Corbet <corbet@lwn.net>, Sean Christopherson <seanjc@google.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 Shuah Khan <shuah@kernel.org>
Cc: David Woodhouse <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>,
 kvm@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20240408220705.7637-1-jalliste@amazon.com>
 <20240408220705.7637-3-jalliste@amazon.com>
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <20240408220705.7637-3-jalliste@amazon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 4/8/2024 3:07 PM, Jack Allister wrote:
> This test proves that there is an inherent KVM/PV clock drift away from the
> guest TSC when KVM decides to update the PV time information structure due
> to a KVM_REQ_MASTERCLOCK_UPDATE. This drift is exascerbated when a guest is
> using TSC scaling and running at a different frequency to the host TSC [1].
> It also proves that KVM_[GS]ET_CLOCK_GUEST API is working to mitigate the
> drift from TSC to within ±1ns.
> 
> The test simply records the PVTI (PV time information) at time of guest
> creation, after KVM has updated it's mapped PVTI structure and once the
> correction has taken place.
> 
> A singular point in time is then recorded via the guest TSC and is used to
> calculate the a PV clock value using each of the 3 PVTI structures.
> 
> As seen below a drift of ~3500ns is observed if no correction has taken
> place after KVM has updated the PVTI via master clock update. However,
> after the correction a delta of at most 1ns can be seen.
> 
> * selftests: kvm: pvclock_test
> * scaling tsc from 2999999KHz to 1499999KHz
> * before=5038374946 uncorrected=5038371437 corrected=5038374945
> * delta_uncorrected=3509 delta_corrected=1
> 
> Clocksource check code has been borrowed from [2].
> 
> [1]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=451a707813ae
> [2]: https://lore.kernel.org/kvm/20240106083346.29180-1-dongli.zhang@oracle.com/
> 
> Signed-off-by: Jack Allister <jalliste@amazon.com>
> CC: David Woodhouse <dwmw2@infradead.org>
> CC: Paul Durrant <paul@xen.org>
> ---
>  tools/testing/selftests/kvm/Makefile          |   1 +
>  .../selftests/kvm/x86_64/pvclock_test.c       | 223 ++++++++++++++++++
>  2 files changed, 224 insertions(+)
>  create mode 100644 tools/testing/selftests/kvm/x86_64/pvclock_test.c
> 
> diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
> index 741c7dc16afc..02ee1205bbed 100644
> --- a/tools/testing/selftests/kvm/Makefile
> +++ b/tools/testing/selftests/kvm/Makefile
> @@ -87,6 +87,7 @@ TEST_GEN_PROGS_x86_64 += x86_64/pmu_counters_test
>  TEST_GEN_PROGS_x86_64 += x86_64/pmu_event_filter_test
>  TEST_GEN_PROGS_x86_64 += x86_64/private_mem_conversions_test
>  TEST_GEN_PROGS_x86_64 += x86_64/private_mem_kvm_exits_test
> +TEST_GEN_PROGS_x86_64 += x86_64/pvclock_test
>  TEST_GEN_PROGS_x86_64 += x86_64/set_boot_cpu_id
>  TEST_GEN_PROGS_x86_64 += x86_64/set_sregs_test
>  TEST_GEN_PROGS_x86_64 += x86_64/smaller_maxphyaddr_emulation_test
> diff --git a/tools/testing/selftests/kvm/x86_64/pvclock_test.c b/tools/testing/selftests/kvm/x86_64/pvclock_test.c
> new file mode 100644
> index 000000000000..172ef4d19c60
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/x86_64/pvclock_test.c
> @@ -0,0 +1,223 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright © 2024, Amazon.com, Inc. or its affiliates.
> + *
> + * Tests for pvclock API
> + * KVM_SET_CLOCK_GUEST/KVM_GET_CLOCK_GUEST
> + */
> +#include <asm/pvclock.h>
> +#include <asm/pvclock-abi.h>
> +#include <sys/stat.h>
> +#include <stdint.h>
> +#include <stdio.h>
> +
> +#include "test_util.h"
> +#include "kvm_util.h"
> +#include "processor.h"
> +
> +enum {
> +	STAGE_FIRST_BOOT,
> +	STAGE_UNCORRECTED,
> +	STAGE_CORRECTED,
> +	NUM_STAGES
> +};
> +
> +#define KVMCLOCK_GPA 0xc0000000ull
> +#define KVMCLOCK_SIZE sizeof(struct pvclock_vcpu_time_info)
> +
> +static void trigger_pvti_update(vm_paddr_t pvti_pa)
> +{
> +	/*
> +	 * We need a way to trigger KVM to update the fields
> +	 * in the PV time info. The easiest way to do this is
> +	 * to temporarily switch to the old KVM system time
> +	 * method and then switch back to the new one.
> +	 */
> +	wrmsr(MSR_KVM_SYSTEM_TIME, pvti_pa | KVM_MSR_ENABLED);
> +	wrmsr(MSR_KVM_SYSTEM_TIME_NEW, pvti_pa | KVM_MSR_ENABLED);
> +}
> +
> +static void guest_code(vm_paddr_t pvti_pa)
> +{
> +	struct pvclock_vcpu_time_info *pvti_va =
> +		(struct pvclock_vcpu_time_info *)pvti_pa;
> +
> +	struct pvclock_vcpu_time_info pvti_boot;
> +	struct pvclock_vcpu_time_info pvti_uncorrected;
> +	struct pvclock_vcpu_time_info pvti_corrected;
> +	uint64_t cycles_boot;
> +	uint64_t cycles_uncorrected;
> +	uint64_t cycles_corrected;
> +	uint64_t tsc_guest;
> +
> +	/*
> +	 * Setup the KVMCLOCK in the guest & store the original
> +	 * PV time structure that is used.
> +	 */
> +	wrmsr(MSR_KVM_SYSTEM_TIME_NEW, pvti_pa | KVM_MSR_ENABLED);
> +	pvti_boot = *pvti_va;
> +	GUEST_SYNC(STAGE_FIRST_BOOT);
> +
> +	/*
> +	 * Trigger an update of the PVTI, if we calculate
> +	 * the KVM clock using this structure we'll see
> +	 * a drift from the TSC.
> +	 */
> +	trigger_pvti_update(pvti_pa);
> +	pvti_uncorrected = *pvti_va;
> +	GUEST_SYNC(STAGE_UNCORRECTED);
> +
> +	/*
> +	 * The test should have triggered the correction by this
> +	 * point in time. We have a copy of each of the PVTI structs
> +	 * at each stage now.
> +	 *
> +	 * Let's sample the timestamp at a SINGLE point in time and
> +	 * then calculate what the KVM clock would be using the PVTI
> +	 * from each stage.
> +	 *
> +	 * Then return each of these values to the tester.
> +	 */
> +	pvti_corrected = *pvti_va;
> +	tsc_guest = rdtsc();
> +
> +	cycles_boot = __pvclock_read_cycles(&pvti_boot, tsc_guest);
> +	cycles_uncorrected = __pvclock_read_cycles(&pvti_uncorrected, tsc_guest);
> +	cycles_corrected = __pvclock_read_cycles(&pvti_corrected, tsc_guest);
> +
> +	GUEST_SYNC_ARGS(STAGE_CORRECTED, cycles_boot, cycles_uncorrected,
> +			cycles_corrected, 0);
> +}
> +
> +static void run_test(struct kvm_vm *vm, struct kvm_vcpu *vcpu)
> +{
> +	struct ucall uc;
> +	uint64_t ucall_reason;
> +	struct pvclock_vcpu_time_info pvti_before;
> +	uint64_t before, uncorrected, corrected;
> +	int64_t delta_uncorrected, delta_corrected;
> +
> +	/* Loop through each stage of the test. */
> +	while (true) {
> +
> +		/* Start/restart the running vCPU code. */
> +		vcpu_run(vcpu);
> +		TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_IO);
> +
> +		/* Retrieve and verify our stage. */
> +		ucall_reason = get_ucall(vcpu, &uc);
> +		TEST_ASSERT(ucall_reason == UCALL_SYNC,
> +			    "Unhandled ucall reason=%lu",
> +			    ucall_reason);
> +
> +		/* Run host specific code relating to stage. */
> +		switch (uc.args[1]) {
> +		case STAGE_FIRST_BOOT:
> +			/* Store the KVM clock values before an update. */
> +			vm_ioctl(vm, KVM_GET_CLOCK_GUEST, &pvti_before);
> +
> +			/* Sleep for a set amount of time to induce drift. */
> +			sleep(5);
> +			break;
> +
> +		case STAGE_UNCORRECTED:
> +			/* Restore the KVM clock values. */
> +			vm_ioctl(vm, KVM_SET_CLOCK_GUEST, &pvti_before);
> +			break;
> +
> +		case STAGE_CORRECTED:
> +			/* Query the clock information and verify delta. */
> +			before = uc.args[2];
> +			uncorrected = uc.args[3];
> +			corrected = uc.args[4];
> +
> +			delta_uncorrected = before - uncorrected;
> +			delta_corrected = before - corrected;
> +
> +			pr_info("before=%lu uncorrected=%lu corrected=%lu\n",
> +				before, uncorrected, corrected);
> +
> +			pr_info("delta_uncorrected=%ld delta_corrected=%ld\n",
> +				delta_uncorrected, delta_corrected);
> +
> +			TEST_ASSERT((delta_corrected <= 1) && (delta_corrected >= -1),
> +				    "larger than expected delta detected = %ld", delta_corrected);

I'm wondering what's the underling theory that we definitely can achieve
±1ns accuracy? I tested it on a Sapphire Rapids @2100MHz TSC frequency,
and I can see delta_corrected=2 in ~2% cases.

