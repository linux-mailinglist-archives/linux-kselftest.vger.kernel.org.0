Return-Path: <linux-kselftest+bounces-37142-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 054F4B024C0
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Jul 2025 21:45:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B86217BD11
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Jul 2025 19:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61D791E5B99;
	Fri, 11 Jul 2025 19:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kH80zFXK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3710A1DFDB9
	for <linux-kselftest@vger.kernel.org>; Fri, 11 Jul 2025 19:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752263109; cv=none; b=oamkDKki2KncRc7TaRNrzVbgz56OUJ4viaHBoMHo3hXIo1VGUv+fS+7fAAuFf1JxA6qLUZbcwVKa6EAffNIjOcoSD/UD8/1jXexYzXQ9GRxkdIEn1wyahuff3Bkwykv83cz2xpol00AC8lY23YxSWcMOzp9CTRMuFU+oxtjIuVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752263109; c=relaxed/simple;
	bh=7F1llPY1e1frQp3CuaI3RwsFx3bdVbXEi7i0uaBnSrI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ojN9uJctB6QvfsSGMOHVGSZea7/3RNLfSG4dnG6j2Eg+QsqC4e8lB2VJmzsbsxwNX6bg0qxlL3UEPPfLoVvs5U3Ock7rnyqC00PcmhNt8KoHS1ZK8bmQuRA6QvIFA/TiCcN9/vBYVSml9akUjxU0kl+nQ6Jjne2kU4Rb1b/vcQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kH80zFXK; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 11 Jul 2025 12:44:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752263105;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qmaKxm/VmiEPcbL87CsCSjMPkOq/8ZNs8tYEfygZixg=;
	b=kH80zFXK3lACL0sgsmmLCLehTpzI+Pr6JxI1qYdKcOWqbbM5SYC5fwpCSgFYmaYCCOr6PO
	4jVXPBefLC5jxfzRabsaGEVXLdBcQxQaXkPOqE6FUtSAxlLmqA/W2MOnFqNLWTiZoSy6pu
	SIbSGrDfGAaj/dtkyXxQ6kd6y2n716I=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Oliver Upton <oliver.upton@linux.dev>
To: Jiaqi Yan <jiaqiyan@google.com>
Cc: maz@kernel.org, joey.gouly@arm.com, suzuki.poulose@arm.com,
	yuzenghui@huawei.com, catalin.marinas@arm.com, will@kernel.org,
	pbonzini@redhat.com, corbet@lwn.net, shuah@kernel.org,
	kvm@vger.kernel.org, kvmarm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
	duenwen@google.com, rananta@google.com, jthoughton@google.com
Subject: Re: [PATCH v2 5/6] KVM: selftests: Test for KVM_CAP_INJECT_EXT_IABT
Message-ID: <aHFpt0qJF-Rvb2bS@linux.dev>
References: <20250604050902.3944054-1-jiaqiyan@google.com>
 <20250604050902.3944054-6-jiaqiyan@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250604050902.3944054-6-jiaqiyan@google.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Jun 04, 2025 at 05:09:00AM +0000, Jiaqi Yan wrote:
> Test userspace can use KVM_SET_VCPU_EVENTS to inject an external
> instruction abort into guest. The test injects instruction abort at an
> arbitrary time without real SEA happening in the guest VCPU, so only
> certain ESR_EL1 bits are expected and asserted.
> 
> Signed-off-by: Jiaqi Yan <jiaqiyan@google.com>

I reworked mmio_abort to be a general external abort test, can you add
your test cases there in the next spin (arm64/external_aborts.c)?

Thanks,
Oliver

> ---
>  tools/arch/arm64/include/uapi/asm/kvm.h       |  3 +-
>  tools/testing/selftests/kvm/Makefile.kvm      |  1 +
>  .../testing/selftests/kvm/arm64/inject_iabt.c | 98 +++++++++++++++++++
>  3 files changed, 101 insertions(+), 1 deletion(-)
>  create mode 100644 tools/testing/selftests/kvm/arm64/inject_iabt.c
> 
> diff --git a/tools/arch/arm64/include/uapi/asm/kvm.h b/tools/arch/arm64/include/uapi/asm/kvm.h
> index af9d9acaf9975..d3a4530846311 100644
> --- a/tools/arch/arm64/include/uapi/asm/kvm.h
> +++ b/tools/arch/arm64/include/uapi/asm/kvm.h
> @@ -184,8 +184,9 @@ struct kvm_vcpu_events {
>  		__u8 serror_pending;
>  		__u8 serror_has_esr;
>  		__u8 ext_dabt_pending;
> +		__u8 ext_iabt_pending;
>  		/* Align it to 8 bytes */
> -		__u8 pad[5];
> +		__u8 pad[4];
>  		__u64 serror_esr;
>  	} exception;
>  	__u32 reserved[12];
> diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
> index 9eecce6b8274f..e6b504ded9c1c 100644
> --- a/tools/testing/selftests/kvm/Makefile.kvm
> +++ b/tools/testing/selftests/kvm/Makefile.kvm
> @@ -149,6 +149,7 @@ TEST_GEN_PROGS_arm64 += arm64/arch_timer_edge_cases
>  TEST_GEN_PROGS_arm64 += arm64/debug-exceptions
>  TEST_GEN_PROGS_arm64 += arm64/host_sve
>  TEST_GEN_PROGS_arm64 += arm64/hypercalls
> +TEST_GEN_PROGS_arm64 += arm64/inject_iabt
>  TEST_GEN_PROGS_arm64 += arm64/mmio_abort
>  TEST_GEN_PROGS_arm64 += arm64/page_fault_test
>  TEST_GEN_PROGS_arm64 += arm64/psci_test
> diff --git a/tools/testing/selftests/kvm/arm64/inject_iabt.c b/tools/testing/selftests/kvm/arm64/inject_iabt.c
> new file mode 100644
> index 0000000000000..0c7999e5ba5b3
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/arm64/inject_iabt.c
> @@ -0,0 +1,98 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * inject_iabt.c - Tests for injecting instruction aborts into guest.
> + */
> +
> +#include "processor.h"
> +#include "test_util.h"
> +
> +static void expect_iabt_handler(struct ex_regs *regs)
> +{
> +	u64 esr = read_sysreg(esr_el1);
> +
> +	GUEST_PRINTF("Handling Guest SEA\n");
> +	GUEST_PRINTF("  ESR_EL1=%#lx\n", esr);
> +
> +	GUEST_ASSERT_EQ(ESR_ELx_EC(esr), ESR_ELx_EC_IABT_CUR);
> +	GUEST_ASSERT_EQ(esr & ESR_ELx_FSC_TYPE, ESR_ELx_FSC_EXTABT);
> +
> +	GUEST_DONE();
> +}
> +
> +static void guest_code(void)
> +{
> +	GUEST_FAIL("Guest should only run SEA handler");
> +}
> +
> +static void vcpu_run_expect_done(struct kvm_vcpu *vcpu)
> +{
> +	struct ucall uc;
> +	bool guest_done = false;
> +
> +	do {
> +		vcpu_run(vcpu);
> +		switch (get_ucall(vcpu, &uc)) {
> +		case UCALL_ABORT:
> +			REPORT_GUEST_ASSERT(uc);
> +			break;
> +		case UCALL_PRINTF:
> +			ksft_print_msg("From guest: %s", uc.buffer);
> +			break;
> +		case UCALL_DONE:
> +			ksft_print_msg("Guest done gracefully!\n");
> +			guest_done = true;
> +			break;
> +		default:
> +			TEST_FAIL("Unexpected ucall: %lu", uc.cmd);
> +		}
> +	} while (!guest_done);
> +}
> +
> +static void vcpu_inject_ext_iabt(struct kvm_vcpu *vcpu)
> +{
> +	struct kvm_vcpu_events events = {};
> +
> +	events.exception.ext_iabt_pending = true;
> +	vcpu_events_set(vcpu, &events);
> +}
> +
> +static void vcpu_inject_invalid_abt(struct kvm_vcpu *vcpu)
> +{
> +	struct kvm_vcpu_events events = {};
> +	int r;
> +
> +	events.exception.ext_iabt_pending = true;
> +	events.exception.ext_dabt_pending = true;
> +
> +	ksft_print_msg("Injecting invalid external abort events\n");
> +	r = __vcpu_ioctl(vcpu, KVM_SET_VCPU_EVENTS, &events);
> +	TEST_ASSERT(r && errno == EINVAL,
> +		    KVM_IOCTL_ERROR(KVM_SET_VCPU_EVENTS, r));
> +}
> +
> +static void test_inject_iabt(void)
> +{
> +	struct kvm_vcpu *vcpu;
> +	struct kvm_vm *vm;
> +
> +	vm = vm_create_with_one_vcpu(&vcpu, guest_code);
> +
> +	vm_init_descriptor_tables(vm);
> +	vcpu_init_descriptor_tables(vcpu);
> +
> +	vm_install_sync_handler(vm, VECTOR_SYNC_CURRENT,
> +				ESR_ELx_EC_IABT_CUR, expect_iabt_handler);
> +
> +	vcpu_inject_invalid_abt(vcpu);
> +
> +	vcpu_inject_ext_iabt(vcpu);
> +	vcpu_run_expect_done(vcpu);
> +
> +	kvm_vm_free(vm);
> +}
> +
> +int main(void)
> +{
> +	test_inject_iabt();
> +	return 0;
> +}
> -- 
> 2.49.0.1266.g31b7d2e469-goog
> 

