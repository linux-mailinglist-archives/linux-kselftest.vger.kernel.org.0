Return-Path: <linux-kselftest+bounces-34445-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE625AD1763
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Jun 2025 05:14:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A80183A8E4F
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Jun 2025 03:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 746B7270540;
	Mon,  9 Jun 2025 03:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wjAcwwkK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5621E2701D1
	for <linux-kselftest@vger.kernel.org>; Mon,  9 Jun 2025 03:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749438889; cv=none; b=KF1WOqW0UvV4oZr9tN9OJaW2cyW64p7rZsZtq1aax7UXNRLNlDcGvslsOAl6x5irweVBSGzvln9y67AzQlFWL7Ts3CNgGppUzSO2DkAagXDBsHxJ2hCcqF/JjGwF2U5nsEV3xAcmcILkL7TrU3nGAYH7vKAKhBtHVWeQoDoyJTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749438889; c=relaxed/simple;
	bh=xRlqgqO+PBZjgD2LQSpsqgv4NWJcwV3apOdFBq34//4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EY9/uVWts48KPypnMcEhpTjKquzUB7PwrNmAaVdtjXJKRSbgDJ5k/7Aa7XGxBbI1tsh435yR27pEGdMv3x+esHuHZHRXjsJ49yOPrGk2ckfsCQygmpfVf0chTQ4MvHoByW1OllYlnHCKG4A7JfrQxAwt367vMa2ruHF4ermCXww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wjAcwwkK; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 9 Jun 2025 12:14:36 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1749438885;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lmdoW92ozb614B0US2yeVMuGdKGqmA8u64UZkV8QgO0=;
	b=wjAcwwkKVcWrOHIi2Zd49lxWYxwFo3SnglOJzz6JfAtOcYly83irJO2lauQQFNmENpiz/9
	LFfPgOmdGgBBM48jiWDlEOvZBd4ScN8oeriDbny02luqN7D27nTJOV8yRC1M3YcXNhKVGu
	V6EG1lawUnRAc88TO/+QQiLXVieN+vQ=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Itaru Kitayama <itaru.kitayama@linux.dev>
To: Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	maz@kernel.org, oliver.upton@linux.dev, joey.gouly@arm.com,
	suzuki.poulose@arm.com, yuzenghui@huawei.com, seanjc@google.com,
	darren@os.amperecomputing.com
Subject: Re: [RFC PATCH v2 2/9] KVM: arm64: nv: selftests: Add simple test to
 run guest code in vEL2
Message-ID: <aEZRnBK7pD4rkgdi@vm4>
References: <20250512105251.577874-1-gankulkarni@os.amperecomputing.com>
 <20250512105251.577874-3-gankulkarni@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250512105251.577874-3-gankulkarni@os.amperecomputing.com>
X-Migadu-Flow: FLOW_OUT

On Mon, May 12, 2025 at 03:52:44AM -0700, Ganapatrao Kulkarni wrote:
> Add simple test to run guest code with NV enabled. With NV enabled,
> guest code runs in vEL2 context.
> 
> Signed-off-by: Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
> ---
>  .../selftests/kvm/arm64/nv_guest_hypervisor.c | 68 +++++++++++++++++++
>  1 file changed, 68 insertions(+)
>  create mode 100644 tools/testing/selftests/kvm/arm64/nv_guest_hypervisor.c
> 
> diff --git a/tools/testing/selftests/kvm/arm64/nv_guest_hypervisor.c b/tools/testing/selftests/kvm/arm64/nv_guest_hypervisor.c
> new file mode 100644
> index 000000000000..7d7b3944e229
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/arm64/nv_guest_hypervisor.c
> @@ -0,0 +1,68 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2025 Ampere Computing LLC
> + */
> +#include <kvm_util.h>
> +#include <nv_util.h>
> +#include <processor.h>
> +
> +static void guest_code(void)
> +{
> +	if (read_sysreg(CurrentEL) == CurrentEL_EL2)
> +		GUEST_PRINTF("Test PASS\n");
> +	else
> +		GUEST_FAIL("Fail to run in vEL2\n");
> +
> +	GUEST_DONE();
> +}
> +
> +static void guest_undef_handler(struct ex_regs *regs)
> +{
> +	GUEST_FAIL("Unexpected exception far_el1 = 0x%lx", read_sysreg(far_el1));
> +}
> +
> +static void test_run_vcpu(struct kvm_vcpu *vcpu)
> +{
> +	struct ucall uc;
> +
> +	do {
> +		vcpu_run(vcpu);
> +
> +		switch (get_ucall(vcpu, &uc)) {
> +		case UCALL_ABORT:
> +			REPORT_GUEST_ASSERT(uc);
> +			break;
> +		case UCALL_PRINTF:
> +			printf("%s", uc.buffer);
> +			break;
> +		case UCALL_DONE:
> +			break;
> +		default:
> +			TEST_FAIL("Unknown ucall %lu", uc.cmd);
> +		}
> +	} while (uc.cmd != UCALL_DONE);
> +}
> +
> +static void test_nv_guest_hypervisor(void)
> +{
> +	struct kvm_vcpu *vcpu;
> +	struct kvm_vm *vm;
> +	int gic_fd = -1;
> +
> +	vm = nv_vm_create_with_vcpus_gic(1, &vcpu, &gic_fd, guest_code);
> +	vm_init_descriptor_tables(vm);
> +	vcpu_init_descriptor_tables(vcpu);
> +	vm_install_sync_handler(vm, VECTOR_SYNC_CURRENT,
> +				ESR_ELx_EC_UNKNOWN, guest_undef_handler);
> +
> +	test_run_vcpu(vcpu);
> +
> +	vgic_v3_close(gic_fd);
> +	kvm_vm_free(vm);
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +	test_nv_guest_hypervisor();
> +	return 0;
> +}

The kernel this v2 series applied is based off of the latest kvmarm-next 
and tested this on QEMU TCG mode with the kvm-arm.mode=nested option added at boot.

Tested-by: Itaru Kitayama <itaru.kitayama@fujitsu.com>

> -- 
> 2.48.1
> 

