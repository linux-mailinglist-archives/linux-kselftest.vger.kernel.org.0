Return-Path: <linux-kselftest+bounces-33971-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DEFAEAC7489
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 May 2025 01:39:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88B0E1C066F1
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 May 2025 23:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9A1F2165ED;
	Wed, 28 May 2025 23:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="I2OgV/fQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6491C8638
	for <linux-kselftest@vger.kernel.org>; Wed, 28 May 2025 23:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748475586; cv=none; b=L35+0WWk9Z3d/7wfvtpeO6TlqRv4qcngls/HUDsIucEpFuED8WB2wZQFW3pn/2dChOQnH16hyqqxeHDhd/6gxfrrPJ6uxwOoWEktILeR8oemkUDDrfOC37jN1uYq9vRdUGAn/aVYE85vYHoRLFxY62+j8Oi782vvEW0u8xsPrn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748475586; c=relaxed/simple;
	bh=k1kQlVJgH6q7dRU5ldvGLOVOwub346WXXiCsMt6agkw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PgfOUgqiFkWEKlPvv4dqRFo+WnTUiEcaHr38BzwCPAd/9yZMJVwNkKQ+kbhY8L8tJYjBSKDWRh14BORyvdQoO795f+OXDY/ygexfE9u0hqAVhEg4oG9vR6dyJ+FeiFs1a2oPt1KOWfADrUv7z3ieoftB/hI9xaM+o3KrSmH3FZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=I2OgV/fQ; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 29 May 2025 08:39:20 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1748475570;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=R63PwFVA/9d9S96TV3kYiTBL2lE7Bke5AfXlMMFR5tY=;
	b=I2OgV/fQdg913ekiXwixAf04eNpxY8BlshIyqFM1w2ABnm+F/Izd3iFHlm2e+SWYLrMDjF
	3uUwaGtpH+Hj4HkrwnlBGeZLShKA9dZ32lkM9zHO3NzMrAYWXj2s6l9zZA++9QYp5w2EkA
	1aH0q3KS3kX06nxIckn0hSai3npoqm0=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Itaru Kitayama <itaru.kitayama@linux.dev>
To: Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	maz@kernel.org, oliver.upton@linux.dev, joey.gouly@arm.com,
	suzuki.poulose@arm.com, yuzenghui@huawei.com, seanjc@google.com,
	darren@os.amperecomputing.com
Subject: Re: [PATCH RFC v2 1/9] KVM: arm64: nv: selftests: Add support to run
 guest code in vEL2.
Message-ID: <aDeeqMQ3JvAayTJF@vm4>
References: <20250512105251.577874-1-gankulkarni@os.amperecomputing.com>
 <20250512105251.577874-2-gankulkarni@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250512105251.577874-2-gankulkarni@os.amperecomputing.com>
X-Migadu-Flow: FLOW_OUT

Hi Ganapatrao
On Mon, May 12, 2025 at 03:52:43AM -0700, Ganapatrao Kulkarni wrote:
> This patch adds required changes to vcpu init to run a guest code
> in vEL2 context and also adds NV specific helper functions.
> 
> Signed-off-by: Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>

I'm interested in testing this, but is this series against kvmarm? which
branch I can cleanly do git am?

Thanks,
Itaru.

> ---
>  tools/testing/selftests/kvm/Makefile.kvm      |  2 +
>  .../kvm/include/arm64/kvm_util_arch.h         |  3 +
>  .../selftests/kvm/include/arm64/nv_util.h     | 45 ++++++++++++++
>  .../selftests/kvm/include/arm64/vgic.h        |  1 +
>  .../testing/selftests/kvm/include/kvm_util.h  |  3 +
>  tools/testing/selftests/kvm/lib/arm64/nv.c    | 46 ++++++++++++++
>  .../selftests/kvm/lib/arm64/processor.c       | 61 ++++++++++++++-----
>  tools/testing/selftests/kvm/lib/arm64/vgic.c  |  8 +++
>  8 files changed, 155 insertions(+), 14 deletions(-)
>  create mode 100644 tools/testing/selftests/kvm/include/arm64/nv_util.h
>  create mode 100644 tools/testing/selftests/kvm/lib/arm64/nv.c
> 
> diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
> index f773f8f99249..3348f729d3b2 100644
> --- a/tools/testing/selftests/kvm/Makefile.kvm
> +++ b/tools/testing/selftests/kvm/Makefile.kvm
> @@ -37,6 +37,7 @@ LIBKVM_arm64 += lib/arm64/processor.c
>  LIBKVM_arm64 += lib/arm64/spinlock.c
>  LIBKVM_arm64 += lib/arm64/ucall.c
>  LIBKVM_arm64 += lib/arm64/vgic.c
> +LIBKVM_arm64 += lib/arm64/nv.c
>  
>  LIBKVM_s390 += lib/s390/diag318_test_handler.c
>  LIBKVM_s390 += lib/s390/processor.c
> @@ -155,6 +156,7 @@ TEST_GEN_PROGS_arm64 += arm64/vgic_irq
>  TEST_GEN_PROGS_arm64 += arm64/vgic_lpi_stress
>  TEST_GEN_PROGS_arm64 += arm64/vpmu_counter_access
>  TEST_GEN_PROGS_arm64 += arm64/no-vgic-v3
> +TEST_GEN_PROGS_arm64 += arm64/nv_guest_hypervisor
>  TEST_GEN_PROGS_arm64 += access_tracking_perf_test
>  TEST_GEN_PROGS_arm64 += arch_timer
>  TEST_GEN_PROGS_arm64 += coalesced_io_test
> diff --git a/tools/testing/selftests/kvm/include/arm64/kvm_util_arch.h b/tools/testing/selftests/kvm/include/arm64/kvm_util_arch.h
> index e43a57d99b56..ab5279c24413 100644
> --- a/tools/testing/selftests/kvm/include/arm64/kvm_util_arch.h
> +++ b/tools/testing/selftests/kvm/include/arm64/kvm_util_arch.h
> @@ -2,6 +2,9 @@
>  #ifndef SELFTEST_KVM_UTIL_ARCH_H
>  #define SELFTEST_KVM_UTIL_ARCH_H
>  
> +#define CurrentEL_EL1		(1 << 2)
> +#define CurrentEL_EL2		(2 << 2)
> +
>  struct kvm_vm_arch {};
>  
>  #endif  // SELFTEST_KVM_UTIL_ARCH_H
> diff --git a/tools/testing/selftests/kvm/include/arm64/nv_util.h b/tools/testing/selftests/kvm/include/arm64/nv_util.h
> new file mode 100644
> index 000000000000..622a17c9d142
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/include/arm64/nv_util.h
> @@ -0,0 +1,45 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (c) 2025 Ampere Computing
> + */
> +#ifndef SELFTEST_NV_UTIL_H
> +#define SELFTEST_NV_UTIL_H
> +
> +#include <linux/bitmap.h>
> +#include <vgic.h>
> +
> +#define HCR_NV2		(UL(1) << 45)
> +#define HCR_AT		(UL(1) << 44)
> +#define HCR_NV		(UL(1) << 42)
> +#define HCR_E2H		(UL(1) << 34)
> +#define HCR_TTLB        (UL(1) << 25)
> +
> +/* Enable NV2 and guest in VHE mode */
> +#define HCR_EL2_NV_EANBLE (HCR_E2H | HCR_NV | HCR_NV2 | HCR_AT | HCR_TTLB)
> +
> +struct kvm_vm *nv_vm_create_with_vcpus_gic(uint32_t nr_vcpus,
> +		struct kvm_vcpu **vcpus, int *gic_fd, void *guest_code);
> +
> +struct kvm_vm *__nv_vm_create_with_vcpus_gic(struct vm_shape shape,
> +		uint32_t nr_vcpus, struct kvm_vcpu **vcpus,
> +		uint64_t extra_mem_pages, int *gic_fd, void *guest_code);
> +
> +/* NV helpers */
> +static inline void init_vcpu_nested(struct kvm_vcpu_init *init)
> +{
> +	init->features[0] |= (1 << KVM_ARM_VCPU_HAS_EL2);
> +}
> +
> +static inline bool kvm_arm_vcpu_has_el2(struct kvm_vcpu_init *init)
> +{
> +	unsigned long features = init->features[0];
> +
> +	return test_bit(KVM_ARM_VCPU_HAS_EL2, &features);
> +}
> +
> +static inline bool is_vcpu_nested(struct kvm_vcpu *vcpu)
> +{
> +	return vcpu->nested;
> +}
> +
> +#endif /* SELFTEST_NV_UTIL_H */
> diff --git a/tools/testing/selftests/kvm/include/arm64/vgic.h b/tools/testing/selftests/kvm/include/arm64/vgic.h
> index c481d0c00a5d..46142fa36199 100644
> --- a/tools/testing/selftests/kvm/include/arm64/vgic.h
> +++ b/tools/testing/selftests/kvm/include/arm64/vgic.h
> @@ -17,6 +17,7 @@
>  	index)
>  
>  int vgic_v3_setup(struct kvm_vm *vm, unsigned int nr_vcpus, uint32_t nr_irqs);
> +void vgic_v3_close(int gic_fd);
>  
>  #define VGIC_MAX_RESERVED	1023
>  
> diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
> index 373912464fb4..9b26b9124dc3 100644
> --- a/tools/testing/selftests/kvm/include/kvm_util.h
> +++ b/tools/testing/selftests/kvm/include/kvm_util.h
> @@ -65,6 +65,9 @@ struct kvm_vcpu {
>  	struct kvm_dirty_gfn *dirty_gfns;
>  	uint32_t fetch_index;
>  	uint32_t dirty_gfns_count;
> +#ifdef __aarch64__
> +	bool nested;
> +#endif
>  };
>  
>  struct userspace_mem_regions {
> diff --git a/tools/testing/selftests/kvm/lib/arm64/nv.c b/tools/testing/selftests/kvm/lib/arm64/nv.c
> new file mode 100644
> index 000000000000..e930808a7ed4
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/lib/arm64/nv.c
> @@ -0,0 +1,46 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2025 Ampere Computing LLC
> + */
> +
> +#include <linux/compiler.h>
> +#include <assert.h>
> +
> +#include "guest_modes.h"
> +#include "kvm_util.h"
> +#include "nv_util.h"
> +#include "processor.h"
> +
> +struct kvm_vm *__nv_vm_create_with_vcpus_gic(struct vm_shape shape, uint32_t nr_vcpus,
> +		struct kvm_vcpu **vcpus, uint64_t extra_mem_pages, int *gic_fd, void *guest_code)
> +{
> +	struct kvm_vcpu_init init;
> +	struct kvm_vm *vm;
> +	int i;
> +
> +	TEST_REQUIRE(kvm_has_cap(KVM_CAP_ARM_EL2));
> +
> +	vm = __vm_create(shape, nr_vcpus, extra_mem_pages);
> +	vm_ioctl(vm, KVM_ARM_PREFERRED_TARGET, &init);
> +	init_vcpu_nested(&init);
> +
> +	for (i = 0; i < nr_vcpus; ++i) {
> +		vcpus[i] = aarch64_vcpu_add(vm, i, &init, guest_code);
> +		__TEST_REQUIRE(is_vcpu_nested(vcpus[i]), "Failed to Enable NV");
> +	}
> +
> +	/* vgic is not created, If gic_fd argument is NULL */
> +	if (gic_fd) {
> +		*gic_fd = vgic_v3_setup(vm, nr_vcpus, 64);
> +		__TEST_REQUIRE(*gic_fd >= 0, "Failed to create vgic-v3");
> +	}
> +
> +	return vm;
> +}
> +
> +struct kvm_vm *nv_vm_create_with_vcpus_gic(uint32_t nr_vcpus,
> +		struct kvm_vcpu **vcpus, int *gic_fd, void *guest_code)
> +{
> +	return __nv_vm_create_with_vcpus_gic(VM_SHAPE_DEFAULT,
> +				nr_vcpus, vcpus, 0, gic_fd, guest_code);
> +}
> diff --git a/tools/testing/selftests/kvm/lib/arm64/processor.c b/tools/testing/selftests/kvm/lib/arm64/processor.c
> index 7ba3aa3755f3..6e759981bf9e 100644
> --- a/tools/testing/selftests/kvm/lib/arm64/processor.c
> +++ b/tools/testing/selftests/kvm/lib/arm64/processor.c
> @@ -10,6 +10,7 @@
>  
>  #include "guest_modes.h"
>  #include "kvm_util.h"
> +#include "nv_util.h"
>  #include "processor.h"
>  #include "ucall_common.h"
>  
> @@ -258,14 +259,49 @@ void virt_arch_dump(FILE *stream, struct kvm_vm *vm, uint8_t indent)
>  	}
>  }
>  
> +static void aarch64_vcpu_set_reg(struct kvm_vcpu *vcpu, uint64_t sctlr_el1,
> +			uint64_t tcr_el1, uint64_t ttbr0_el1)
> +{
> +	uint64_t fpen;
> +
> +	/*
> +	 * Enable FP/ASIMD to avoid trapping when accessing Q0-Q15
> +	 * registers, which the variable argument list macros do.
> +	 */
> +	fpen = 3 << 20;
> +
> +	if (is_vcpu_nested(vcpu)) {
> +		vcpu_set_reg(vcpu, KVM_ARM64_SYS_REG(SYS_CPTR_EL2), fpen);
> +		vcpu_set_reg(vcpu, KVM_ARM64_SYS_REG(SYS_SCTLR_EL2), sctlr_el1);
> +		vcpu_set_reg(vcpu, KVM_ARM64_SYS_REG(SYS_TCR_EL2), tcr_el1);
> +		vcpu_set_reg(vcpu, KVM_ARM64_SYS_REG(SYS_MAIR_EL2), DEFAULT_MAIR_EL1);
> +		vcpu_set_reg(vcpu, KVM_ARM64_SYS_REG(SYS_TTBR0_EL2), ttbr0_el1);
> +		vcpu_set_reg(vcpu, KVM_ARM64_SYS_REG(SYS_HCR_EL2), HCR_EL2_NV_EANBLE);
> +	} else {
> +		vcpu_set_reg(vcpu, KVM_ARM64_SYS_REG(SYS_CPACR_EL1), fpen);
> +		vcpu_set_reg(vcpu, KVM_ARM64_SYS_REG(SYS_SCTLR_EL1), sctlr_el1);
> +		vcpu_set_reg(vcpu, KVM_ARM64_SYS_REG(SYS_TCR_EL1), tcr_el1);
> +		vcpu_set_reg(vcpu, KVM_ARM64_SYS_REG(SYS_MAIR_EL1), DEFAULT_MAIR_EL1);
> +		vcpu_set_reg(vcpu, KVM_ARM64_SYS_REG(SYS_TTBR0_EL1), ttbr0_el1);
> +
> +	}
> +
> +	vcpu_set_reg(vcpu, KVM_ARM64_SYS_REG(SYS_TPIDR_EL1), vcpu->id);
> +}
> +
>  void aarch64_vcpu_setup(struct kvm_vcpu *vcpu, struct kvm_vcpu_init *init)
>  {
>  	struct kvm_vcpu_init default_init = { .target = -1, };
>  	struct kvm_vm *vm = vcpu->vm;
>  	uint64_t sctlr_el1, tcr_el1, ttbr0_el1;
>  
> -	if (!init)
> +	if (!init) {
>  		init = &default_init;
> +	} else {
> +		/* Is this vcpu a Guest-Hypersior */
> +		if (kvm_arm_vcpu_has_el2(init))
> +			vcpu->nested = true;
> +	}
>  
>  	if (init->target == -1) {
>  		struct kvm_vcpu_init preferred;
> @@ -275,12 +311,6 @@ void aarch64_vcpu_setup(struct kvm_vcpu *vcpu, struct kvm_vcpu_init *init)
>  
>  	vcpu_ioctl(vcpu, KVM_ARM_VCPU_INIT, init);
>  
> -	/*
> -	 * Enable FP/ASIMD to avoid trapping when accessing Q0-Q15
> -	 * registers, which the variable argument list macros do.
> -	 */
> -	vcpu_set_reg(vcpu, KVM_ARM64_SYS_REG(SYS_CPACR_EL1), 3 << 20);
> -
>  	sctlr_el1 = vcpu_get_reg(vcpu, KVM_ARM64_SYS_REG(SYS_SCTLR_EL1));
>  	tcr_el1 = vcpu_get_reg(vcpu, KVM_ARM64_SYS_REG(SYS_TCR_EL1));
>  
> @@ -349,11 +379,7 @@ void aarch64_vcpu_setup(struct kvm_vcpu *vcpu, struct kvm_vcpu_init *init)
>  	if (use_lpa2_pte_format(vm))
>  		tcr_el1 |= (1ul << 59) /* DS */;
>  
> -	vcpu_set_reg(vcpu, KVM_ARM64_SYS_REG(SYS_SCTLR_EL1), sctlr_el1);
> -	vcpu_set_reg(vcpu, KVM_ARM64_SYS_REG(SYS_TCR_EL1), tcr_el1);
> -	vcpu_set_reg(vcpu, KVM_ARM64_SYS_REG(SYS_MAIR_EL1), DEFAULT_MAIR_EL1);
> -	vcpu_set_reg(vcpu, KVM_ARM64_SYS_REG(SYS_TTBR0_EL1), ttbr0_el1);
> -	vcpu_set_reg(vcpu, KVM_ARM64_SYS_REG(SYS_TPIDR_EL1), vcpu->id);
> +	aarch64_vcpu_set_reg(vcpu, sctlr_el1, tcr_el1, ttbr0_el1);
>  }
>  
>  void vcpu_arch_dump(FILE *stream, struct kvm_vcpu *vcpu, uint8_t indent)
> @@ -387,7 +413,11 @@ static struct kvm_vcpu *__aarch64_vcpu_add(struct kvm_vm *vm, uint32_t vcpu_id,
>  
>  	aarch64_vcpu_setup(vcpu, init);
>  
> -	vcpu_set_reg(vcpu, ARM64_CORE_REG(sp_el1), stack_vaddr + stack_size);
> +	if (is_vcpu_nested(vcpu))
> +		vcpu_set_reg(vcpu, KVM_ARM64_SYS_REG(SYS_SP_EL2), stack_vaddr + stack_size);
> +	else
> +		vcpu_set_reg(vcpu, ARM64_CORE_REG(sp_el1), stack_vaddr + stack_size);
> +
>  	return vcpu;
>  }
>  
> @@ -457,7 +487,10 @@ void vcpu_init_descriptor_tables(struct kvm_vcpu *vcpu)
>  {
>  	extern char vectors;
>  
> -	vcpu_set_reg(vcpu, KVM_ARM64_SYS_REG(SYS_VBAR_EL1), (uint64_t)&vectors);
> +	if (is_vcpu_nested(vcpu))
> +		vcpu_set_reg(vcpu, KVM_ARM64_SYS_REG(SYS_VBAR_EL2), (uint64_t)&vectors);
> +	else
> +		vcpu_set_reg(vcpu, KVM_ARM64_SYS_REG(SYS_VBAR_EL1), (uint64_t)&vectors);
>  }
>  
>  void route_exception(struct ex_regs *regs, int vector)
> diff --git a/tools/testing/selftests/kvm/lib/arm64/vgic.c b/tools/testing/selftests/kvm/lib/arm64/vgic.c
> index 4427f43f73ea..67822b803d0f 100644
> --- a/tools/testing/selftests/kvm/lib/arm64/vgic.c
> +++ b/tools/testing/selftests/kvm/lib/arm64/vgic.c
> @@ -79,6 +79,14 @@ int vgic_v3_setup(struct kvm_vm *vm, unsigned int nr_vcpus, uint32_t nr_irqs)
>  	return gic_fd;
>  }
>  
> +void  vgic_v3_close(int gic_fd)
> +{
> +	if (gic_fd < 0)
> +		return;
> +
> +	close(gic_fd);
> +}
> +
>  /* should only work for level sensitive interrupts */
>  int _kvm_irq_set_level_info(int gic_fd, uint32_t intid, int level)
>  {
> 
> -- 
> 2.48.1
> 

