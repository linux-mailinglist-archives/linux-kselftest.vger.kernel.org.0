Return-Path: <linux-kselftest+bounces-3995-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D53B08469A9
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Feb 2024 08:36:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FC1728D55E
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Feb 2024 07:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AED71799D;
	Fri,  2 Feb 2024 07:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Ky1+34J6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7223917BAD
	for <linux-kselftest@vger.kernel.org>; Fri,  2 Feb 2024 07:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706859380; cv=none; b=cN1cUwRpY9lS6EWaBn8RoEylEWhVo1gCxFz2PX23d8xqHgVqlWQbCkkwoFfKUOE9eWG39hAql4LJF/dwUYimE4bU3Q+0YXP8m8khbRNJFZ7eZXnkSO550J3vqxdctfJppnwxQaL/314Tlz8Jv7y86l1PhQZZyq5q2YLF1eFRZWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706859380; c=relaxed/simple;
	bh=F8Vf9MHjreYyw+SWVq3L3jo/ghauMjcPIlV1loK3X1M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p4I7VGNuWgpZgM161ooD2pPQIiCRq1VQR3eSHoBb6vV0Dyko77+XIxhAHNxueSbbgkv2hwtpjKL64BZ2snhqRLzdYkZcVfPsHiFt5O9PWvrM8CKGfa3iXBSBlpp4GXQDvtG6oZQB7EJIr4Oc+AFMsDCIxSpJxmVxQNfLOk9ooH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Ky1+34J6; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 2 Feb 2024 07:36:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1706859375;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5EWZhYkrDt/8XKpyBqmfzBglkyRPBzsB9XpFbePCy6s=;
	b=Ky1+34J6vLyruougguTgN/oJcFJWeF+YLyxaTsnQ9gIwRuQsHNtyO1eFPA58P6H3pOO0tx
	7EuHIa7HF/yJjY14d7KjLmsw4C0A5wKd3POh4hbUg68SxT5aSTr6mugk2tEcm/R5sY8hD8
	/dqY+kyYgEts8oY6uBbwKYoFe+aM5no=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Oliver Upton <oliver.upton@linux.dev>
To: Shaoqin Huang <shahuang@redhat.com>
Cc: Marc Zyngier <maz@kernel.org>, kvmarm@lists.linux.dev,
	Eric Auger <eauger@redhat.com>, Eric Auger <eric.auger@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
	James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 1/5] KVM: selftests: aarch64: Make the
 [create|destroy]_vpmu_vm() public
Message-ID: <ZbybaH2t7Yp9NJOK@linux.dev>
References: <20240202025659.5065-1-shahuang@redhat.com>
 <20240202025659.5065-2-shahuang@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240202025659.5065-2-shahuang@redhat.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Feb 01, 2024 at 09:56:50PM -0500, Shaoqin Huang wrote:

[...]

> diff --git a/tools/testing/selftests/kvm/include/aarch64/vpmu.h b/tools/testing/selftests/kvm/include/aarch64/vpmu.h
> new file mode 100644
> index 000000000000..0a56183644ee
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/include/aarch64/vpmu.h
> @@ -0,0 +1,16 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#include <kvm_util.h>
> +
> +#define GICD_BASE_GPA	0x8000000ULL
> +#define GICR_BASE_GPA	0x80A0000ULL

Shouldn't a standardized layout of the GIC frames go with the rest of
the GIC stuff?

> +/* Create a VM that has one vCPU with PMUv3 configured. */
> +struct vpmu_vm *create_vpmu_vm(void *guest_code)
> +{
> +	struct kvm_vcpu_init init;
> +	uint8_t pmuver;
> +	uint64_t dfr0, irq = 23;
> +	struct kvm_device_attr irq_attr = {
> +		.group = KVM_ARM_VCPU_PMU_V3_CTRL,
> +		.attr = KVM_ARM_VCPU_PMU_V3_IRQ,
> +		.addr = (uint64_t)&irq,
> +	};
> +	struct kvm_device_attr init_attr = {
> +		.group = KVM_ARM_VCPU_PMU_V3_CTRL,
> +		.attr = KVM_ARM_VCPU_PMU_V3_INIT,
> +	};
> +	struct vpmu_vm *vpmu_vm;
> +
> +	vpmu_vm = calloc(1, sizeof(*vpmu_vm));
> +	TEST_ASSERT(vpmu_vm != NULL, "Insufficient Memory");

!vpmu_vm would be the normal way to test if a pointer is NULL.

> +	memset(vpmu_vm, 0, sizeof(vpmu_vm));

What? man calloc would tell you that the returned object is already
zero-initalized.

> +	vpmu_vm->vm = vm_create(1);
> +	vm_init_descriptor_tables(vpmu_vm->vm);
> +
> +	/* Create vCPU with PMUv3 */
> +	vm_ioctl(vpmu_vm->vm, KVM_ARM_PREFERRED_TARGET, &init);
> +	init.features[0] |= (1 << KVM_ARM_VCPU_PMU_V3);
> +	vpmu_vm->vcpu = aarch64_vcpu_add(vpmu_vm->vm, 0, &init, guest_code);
> +	vcpu_init_descriptor_tables(vpmu_vm->vcpu);

I extremely dislike that the VM is semi-configured by this helper.
You're still expecting the caller to actually install the exception
handler.

> +	vpmu_vm->gic_fd = vgic_v3_setup(vpmu_vm->vm, 1, 64,
> +					GICD_BASE_GPA, GICR_BASE_GPA);
> +	__TEST_REQUIRE(vpmu_vm->gic_fd >= 0,
> +		       "Failed to create vgic-v3, skipping");
> +
> +	/* Make sure that PMUv3 support is indicated in the ID register */
> +	vcpu_get_reg(vpmu_vm->vcpu,
> +		     KVM_ARM64_SYS_REG(SYS_ID_AA64DFR0_EL1), &dfr0);
> +	pmuver = FIELD_GET(ARM64_FEATURE_MASK(ID_AA64DFR0_EL1_PMUVer), dfr0);
> +	TEST_ASSERT(pmuver != ID_AA64DFR0_EL1_PMUVer_IMP_DEF &&
> +		    pmuver >= ID_AA64DFR0_EL1_PMUVer_IMP,
> +		    "Unexpected PMUVER (0x%x) on the vCPU with PMUv3", pmuver);

Not your code, but this assertion is meaningless. KVM does not advertise
an IMP_DEF PMU to guests.

> +	/* Initialize vPMU */
> +	vcpu_ioctl(vpmu_vm->vcpu, KVM_SET_DEVICE_ATTR, &irq_attr);
> +	vcpu_ioctl(vpmu_vm->vcpu, KVM_SET_DEVICE_ATTR, &init_attr);

Not your code, but these should be converted to kvm_device_attr_set()
calls.

Overall I'm somewhat tepid on the idea of the library being so
coarse-grained. It is usually more helpful to expose finer-grained
controls, like a helper that initializes the vPMU state for a
preexisting VM. That way the PMU code can more easily be composed with
other helpers in different tests.

-- 
Thanks,
Oliver

