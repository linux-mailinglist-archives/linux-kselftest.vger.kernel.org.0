Return-Path: <linux-kselftest+bounces-47412-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DC21ACB5F8F
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Dec 2025 14:06:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 012283020C5D
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Dec 2025 13:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AC3D3126BE;
	Thu, 11 Dec 2025 13:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="xHbr3R2W"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A362234973;
	Thu, 11 Dec 2025 13:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765458169; cv=none; b=p3bUUih9ThP/r4sDBLWB3ntA4fVK53eMk+XZHGs8k8BsgPZMA5JSg3Buv2Z0q8p58dfWdbU4nTidDzdcbGWNRZT8No8HvzXL5tNtYgkQRi0rpp5xuvbkiqtS4T8/dGyresInobGtCGUo0jf5uot4VflIG+Z9pqQS4SfSbKps1I4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765458169; c=relaxed/simple;
	bh=wMqefMX8Mc38mruoomh45hwibeRJ0H2QBBT3xydpibQ=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=uUhn0S0fghcuJpDyimhuNFl7j6gFRyCKtTjOtOZS4/XTDB1+Tk5gwvKwQYvCxuTguW3BL+CEuambGw5yZUPJ5Kj5hHGVv1mRhAbdnHVgMCBDQ4BD3BnR+wVXCj845f7Eo3JvqlDPGxsoFhNMg6JVEZm6PvgAQrPUY1/ypgMJgPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=xHbr3R2W; arc=none smtp.client-ip=113.46.200.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=yXjDj2LopgEdejBPveRLTL1bCofz4US84PT1q1wUrQg=;
	b=xHbr3R2WIFp5oR9Nco7g8uQM7yu4h8Y+nnBWfQSXyrUxZxY18Qw54d2p1AsZz3jxGzQ4smao0
	Zufh6YL+19aoxIC2d0F0j8hIcQYrDe0NKCEwe1hsGqQ+OwBnstutzZsIFz65/ezT/vDsDImfl1I
	7irz7iJCvnjq1YPX3iwjrnI=
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4dRt3k0kTVz12LCr;
	Thu, 11 Dec 2025 21:00:18 +0800 (CST)
Received: from kwepemk200017.china.huawei.com (unknown [7.202.194.83])
	by mail.maildlp.com (Postfix) with ESMTPS id 2E13418047B;
	Thu, 11 Dec 2025 21:02:35 +0800 (CST)
Received: from [10.174.178.219] (10.174.178.219) by
 kwepemk200017.china.huawei.com (7.202.194.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 11 Dec 2025 21:02:33 +0800
Subject: Re: [PATCH v4 2/3] KVM: selftests: Test for KVM_EXIT_ARM_SEA
To: Jiaqi Yan <jiaqiyan@google.com>
CC: <maz@kernel.org>, <oliver.upton@linux.dev>, <duenwen@google.com>,
	<rananta@google.com>, <jthoughton@google.com>, <vsethi@nvidia.com>,
	<jgg@nvidia.com>, <joey.gouly@arm.com>, <suzuki.poulose@arm.com>,
	<catalin.marinas@arm.com>, <will@kernel.org>, <pbonzini@redhat.com>,
	<corbet@lwn.net>, <shuah@kernel.org>, <kvm@vger.kernel.org>,
	<kvmarm@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>
References: <20251013185903.1372553-1-jiaqiyan@google.com>
 <20251013185903.1372553-3-jiaqiyan@google.com>
From: Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <3061f5f8-cef0-b7b1-c4de-f2ceea29af9a@huawei.com>
Date: Thu, 11 Dec 2025 21:02:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20251013185903.1372553-3-jiaqiyan@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemk200017.china.huawei.com (7.202.194.83)

Hi Jiaqi,

I had run into several problems when testing it on different servers. I
haven't figured them out yet but post it early for discussion.

On 2025/10/14 2:59, Jiaqi Yan wrote:
> Test how KVM handles guest SEA when APEI is unable to claim it, and
> KVM_CAP_ARM_SEA_TO_USER is enabled.
> 
> The behavior is triggered by consuming recoverable memory error (UER)
> injected via EINJ. The test asserts two major things:
> 1. KVM returns to userspace with KVM_EXIT_ARM_SEA exit reason, and
>    has provided expected fault information, e.g. esr, flags, gva, gpa.
> 2. Userspace is able to handle KVM_EXIT_ARM_SEA by injecting SEA to
>    guest and KVM injects expected SEA into the VCPU.
> 
> Tested on a data center server running Siryn AmpereOne processor
> that has RAS support.
> 
> Several things to notice before attempting to run this selftest:
> - The test relies on EINJ support in both firmware and kernel to
>   inject UER. Otherwise the test will be skipped.
> - The under-test platform's APEI should be unable to claim the SEA.
>   Otherwise the test will be skipped.
> - Some platform doesn't support notrigger in EINJ, which may cause
>   APEI and GHES to offline the memory before guest can consume
>   injected UER, and making test unable to trigger SEA.
> 
> Signed-off-by: Jiaqi Yan <jiaqiyan@google.com>

[...]

> +static void inject_uer(uint64_t paddr)
> +{
> +	if (access("/sys/firmware/acpi/tables/EINJ", R_OK) == -1)
> +		ksft_test_result_skip("EINJ table no available in firmware");

Missing '\n'.

We should return early (to actually skip the test) if the file can not
be accessed, right?

> +
> +	if (access(EINJ_ETYPE, R_OK | W_OK) == -1)
> +		ksft_test_result_skip("EINJ module probably not loaded?");
> +
> +	write_einj_entry(EINJ_ETYPE, ERROR_TYPE_MEMORY_UER);
> +	write_einj_entry(EINJ_FLAGS, MASK_MEMORY_UER);
> +	write_einj_entry(EINJ_ADDR, paddr);
> +	write_einj_entry(EINJ_MASK, ~0x0UL);
> +	write_einj_entry(EINJ_NOTRIGGER, 1);
> +	write_einj_entry(EINJ_DOIT, 1);
> +}
> +
> +/*
> + * When host APEI successfully claims the SEA caused by guest_code, kernel
> + * will send SIGBUS signal with BUS_MCEERR_AR to test thread.
> + *
> + * We set up this SIGBUS handler to skip the test for that case.
> + */
> +static void sigbus_signal_handler(int sig, siginfo_t *si, void *v)
> +{
> +	ksft_print_msg("SIGBUS (%d) received, dumping siginfo...\n", sig);
> +	ksft_print_msg("si_signo=%d, si_errno=%d, si_code=%d, si_addr=%p\n",
> +		       si->si_signo, si->si_errno, si->si_code, si->si_addr);
> +	if (si->si_code == BUS_MCEERR_AR)
> +		ksft_test_result_skip("SEA is claimed by host APEI\n");
> +	else
> +		ksft_test_result_fail("Exit with signal unhandled\n");
> +
> +	exit(0);
> +}
> +
> +static void setup_sigbus_handler(void)
> +{
> +	struct sigaction act;
> +
> +	memset(&act, 0, sizeof(act));
> +	sigemptyset(&act.sa_mask);
> +	act.sa_sigaction = sigbus_signal_handler;
> +	act.sa_flags = SA_SIGINFO;
> +	TEST_ASSERT(sigaction(SIGBUS, &act, NULL) == 0,
> +		    "Failed to setup SIGBUS handler");
> +}
> +
> +static void guest_code(void)
> +{
> +	uint64_t guest_data;
> +
> +	/* Consumes error will cause a SEA. */
> +	guest_data = *(uint64_t *)EINJ_GVA;
> +
> +	GUEST_FAIL("Poison not protected by SEA: gva=%#lx, guest_data=%#lx\n",
> +		   EINJ_GVA, guest_data);
> +}
> +
> +static void expect_sea_handler(struct ex_regs *regs)
> +{
> +	u64 esr = read_sysreg(esr_el1);
> +	u64 far = read_sysreg(far_el1);
> +	bool expect_far_invalid = far_invalid;
> +
> +	GUEST_PRINTF("Handling Guest SEA\n");
> +	GUEST_PRINTF("ESR_EL1=%#lx, FAR_EL1=%#lx\n", esr, far);
> +
> +	GUEST_ASSERT_EQ(ESR_ELx_EC(esr), ESR_ELx_EC_DABT_CUR);
> +	GUEST_ASSERT_EQ(esr & ESR_ELx_FSC_TYPE, ESR_ELx_FSC_EXTABT);
> +
> +	if (expect_far_invalid) {
> +		GUEST_ASSERT_EQ(esr & ESR_ELx_FnV, ESR_ELx_FnV);

I hit this ASSERT with:

# Mapped 0x40000 pages: gva=0x80000000 to gpa=0xff80000000
# Before EINJect: data=0xbaadcafe
# EINJ_GVA=0x81234bad, einj_gpa=0xff81234bad, einj_hva=0xffff41234bad,
einj_hpa=0x202841234bad
# echo 0x10 > /sys/kernel/debug/apei/einj/error_type - done
# echo 0x2 > /sys/kernel/debug/apei/einj/flags - done
# echo 0x202841234bad > /sys/kernel/debug/apei/einj/param1 - done
# echo 0xffffffffffffffff > /sys/kernel/debug/apei/einj/param2 - done
# echo 0x1 > /sys/kernel/debug/apei/einj/notrigger - done
# echo 0x1 > /sys/kernel/debug/apei/einj/error_inject - done
# Memory UER EINJected
# Dump kvm_run info about KVM_EXIT_ARM_SEA
# kvm_run.arm_sea: esr=0x92000610, flags=0
# kvm_run.arm_sea: gva=0, gpa=0
# From guest: Handling Guest SEA
# From guest: ESR_EL1=0x96000010, FAR_EL1=0xaaaadf254828
# Guest aborted!
==== Test Assertion Failure ====
  arm64/sea_to_user.c:172: esr & ESR_ELx_FnV == ESR_ELx_FnV
  pid=38112 tid=38112 errno=4 - Interrupted system call
     1	0x0000000000402f9b: run_vm at sea_to_user.c:246
     2	0x0000000000402467: main at sea_to_user.c:330
     3	0x0000ffff8e22b03f: ?? ??:0
     4	0x0000ffff8e22b117: ?? ??:0
     5	0x00000000004026ef: _start at ??:?
  0x0 != 0x400 (esr & ESR_ELx_FnV != ESR_ELx_FnV)

It seems that KVM doesn't emulate FnV when injecting an abort.

> +		GUEST_PRINTF("Guest observed garbage value in FAR\n");
> +	} else {
> +		GUEST_ASSERT_EQ(esr & ESR_ELx_FnV, 0);
> +		GUEST_ASSERT_EQ(far, EINJ_GVA);
> +	}
> +
> +	GUEST_DONE();
> +}
> +
> +static void vcpu_inject_sea(struct kvm_vcpu *vcpu)
> +{
> +	struct kvm_vcpu_events events = {};
> +
> +	events.exception.ext_dabt_pending = true;
> +	vcpu_events_set(vcpu, &events);
> +}
> +
> +static void run_vm(struct kvm_vm *vm, struct kvm_vcpu *vcpu)
> +{
> +	struct ucall uc;
> +	bool guest_done = false;
> +	struct kvm_run *run = vcpu->run;
> +	u64 esr;
> +
> +	/* Resume the vCPU after error injection to consume the error. */
> +	vcpu_run(vcpu);
> +
> +	ksft_print_msg("Dump kvm_run info about KVM_EXIT_%s\n",
> +		       exit_reason_str(run->exit_reason));
> +	ksft_print_msg("kvm_run.arm_sea: esr=%#llx, flags=%#llx\n",
> +		       run->arm_sea.esr, run->arm_sea.flags);
> +	ksft_print_msg("kvm_run.arm_sea: gva=%#llx, gpa=%#llx\n",
> +		       run->arm_sea.gva, run->arm_sea.gpa);
> +
> +	TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_ARM_SEA);

I can also hit this ASSERT with:

Random seed: 0x6b8b4567
# Mapped 0x40000 pages: gva=0x80000000 to gpa=0xff80000000
# Before EINJect: data=0xbaadcafe
# EINJ_GVA=0x81234bad, einj_gpa=0xff81234bad, einj_hva=0xffff41234bad,
einj_hpa=0x2841234bad
# echo 0x10 > /sys/kernel/debug/apei/einj/error_type - done
# echo 0x2 > /sys/kernel/debug/apei/einj/flags - done
# echo 0x2841234bad > /sys/kernel/debug/apei/einj/param1 - done
# echo 0xffffffffffffffff > /sys/kernel/debug/apei/einj/param2 - done
# echo 0x1 > /sys/kernel/debug/apei/einj/notrigger - done
# echo 0x1 > /sys/kernel/debug/apei/einj/error_inject - done
# Memory UER EINJected
# Dump kvm_run info about KVM_EXIT_MMIO
# kvm_run.arm_sea: esr=0xffff90ba0040, flags=0x691000
# kvm_run.arm_sea: gva=0x100000008, gpa=0
==== Test Assertion Failure ====
  arm64/sea_to_user.c:207: exit_reason == (41)
  pid=38023 tid=38023 errno=4 - Interrupted system call
     1	0x0000000000402d1b: run_vm at sea_to_user.c:207
     2	0x0000000000402467: main at sea_to_user.c:330
     3	0x0000ffff9122b03f: ?? ??:0
     4	0x0000ffff9122b117: ?? ??:0
     5	0x00000000004026ef: _start at ??:?
  Wanted KVM exit reason: 41 (ARM_SEA), got: 6 (MMIO)

Not sure what's wrong it..

> +
> +	esr = run->arm_sea.esr;
> +	TEST_ASSERT_EQ(ESR_ELx_EC(esr), ESR_ELx_EC_DABT_LOW);
> +	TEST_ASSERT_EQ(esr & ESR_ELx_FSC_TYPE, ESR_ELx_FSC_EXTABT);
> +	TEST_ASSERT_EQ(ESR_ELx_ISS2(esr), 0);
> +	TEST_ASSERT_EQ((esr & ESR_ELx_INST_SYNDROME), 0);
> +	TEST_ASSERT_EQ(esr & ESR_ELx_VNCR, 0);
> +
> +	if (!(esr & ESR_ELx_FnV)) {
> +		ksft_print_msg("Expect gva to match given FnV bit is 0\n");
> +		TEST_ASSERT_EQ(run->arm_sea.gva, EINJ_GVA);
> +	}
> +
> +	if (run->arm_sea.flags & KVM_EXIT_ARM_SEA_FLAG_GPA_VALID) {
> +		ksft_print_msg("Expect gpa to match given KVM_EXIT_ARM_SEA_FLAG_GPA_VALID is set\n");
> +		TEST_ASSERT_EQ(run->arm_sea.gpa, einj_gpa & PAGE_ADDR_MASK);
> +	}
> +
> +	far_invalid = esr & ESR_ELx_FnV;

Missing sync_global_to_guest()?

Thanks,
Zenghui

