Return-Path: <linux-kselftest+bounces-5468-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 020F386878F
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Feb 2024 04:11:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C6BC1F257B8
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Feb 2024 03:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B2CA1B949;
	Tue, 27 Feb 2024 03:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RrRtBhYF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AACA81B28D
	for <linux-kselftest@vger.kernel.org>; Tue, 27 Feb 2024 03:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709003447; cv=none; b=hJyXdoPx7ZDGUZ0rP5HUqn4qYdokHSta8FTioxg8RS+V1vUQovi6ZbdI+g20m0ktsOG7krSjlHfcyjSq+3upwb7LlyWq9aPrcZ9wIKrBz55wahFHpAqir+nwotNiKx6fvwyBeW6NBzsknf6TRKxPek/yIFSmVd/1fpDwmyK4Psw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709003447; c=relaxed/simple;
	bh=Ls5kTMNuqgxfAY9k/ke80o4n3YBDZ/BHrqUK9admG7Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oVHdRl98M8W4BVNQ5MUnl0ffKh4/Yx7zy8mwl1O9iZd3mSqfBM5CSoCfztY2+j3nNVfL1nIOHJXHcWLp4RdPiXqknlROowY5dPORwZ3nbjZGzPBkCSlgiHsFom8KLfY9kINFu9uRAphsxPLDzMYYlP7n0y9DkAr6c3Bq+0uxqOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RrRtBhYF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709003444;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yW5t2Z6Gbwkk+Nxw6G8FRSH8GBkS6FO1ImQ0kDaAxuA=;
	b=RrRtBhYFWX1hamX3ki5QlARiX0VfX0quC1Iw5zix+JCzWR63w0bo14jCi48zD1DZ44qb6M
	oqoVFvBlsszpxaYTdoFo2yBGgLMh7kRvHNpj00fF+vj/y2tbynLa8Zt7QqmZ49Lo/bjvgY
	iqFywzR0grUzgkST9yawip4A5v6o4is=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-320-0Kpul1uNOsq5nZzEbQvdCA-1; Mon, 26 Feb 2024 22:10:43 -0500
X-MC-Unique: 0Kpul1uNOsq5nZzEbQvdCA-1
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-5cf8663f2d6so962631a12.1
        for <linux-kselftest@vger.kernel.org>; Mon, 26 Feb 2024 19:10:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709003442; x=1709608242;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yW5t2Z6Gbwkk+Nxw6G8FRSH8GBkS6FO1ImQ0kDaAxuA=;
        b=kFnrzdAFZAhPVdiYkmBfNWse6o1yTy2O8HJ69PltIfx7N8tQbO3vHzWP7PUvZkmPqz
         YJo6/eFw25v3pnH0cEvi1tlVuTaW6TkQ2eBrIZQlxDFiy14EIAL5hOo5UpbEnjTJCRXJ
         0uzc/38U7vHBOF560fgztAF80sofmPKkmho+DvZXpQ4jCkVT6K63k3d0W/FV/V7Vfzrj
         HMjD1kuQfyvYCk8SWesQijxu+55aGfYhYYg8+HGiZJ0CB/wygLodshVYvr3ZAS1i8rTb
         vFJWda5qqXFLTCKyUJVJJRMUFt4XcJc08+3FW8FuZn4LxjUuIMQhDKIoaUY9GE8QvGQS
         7YSw==
X-Forwarded-Encrypted: i=1; AJvYcCUlzEwzGioqu+QdhTite8atE7Rnrvdiq6MZLQqAHCaV0eUXnnxpEX3pKF6DmgIMUkCgQK6/oEG8APCXTg139PdTB3lLqIgDgElQzirLe2qK
X-Gm-Message-State: AOJu0YzpTrB+aL9eZC8GdWrknN7fyo5GcbE7WoKCyfKw1HSvd6JWNaIC
	Mjkd2wZz75YsQauduPci05/MJ40ERwSJfyqOI7X0+qRVo4xobOZa24pcEbecBAV7N818WPw+evV
	rov5TK7cj9KeEofvDbJ9CO1VNRizLRhl0MQPo8rLN6XQQ5lix5SxRdRa3XqAgZwEAiw==
X-Received: by 2002:a17:902:b20c:b0:1dc:abeb:288 with SMTP id t12-20020a170902b20c00b001dcabeb0288mr3031034plr.1.1709003442390;
        Mon, 26 Feb 2024 19:10:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFLHOVU2ZKAg4ShAMdKS4MeMEbCuuvXzBFtYNaJApygaoDeG4i65q+7JXA66JfuRhFGj5TAgw==
X-Received: by 2002:a17:902:b20c:b0:1dc:abeb:288 with SMTP id t12-20020a170902b20c00b001dcabeb0288mr3031015plr.1.1709003442053;
        Mon, 26 Feb 2024 19:10:42 -0800 (PST)
Received: from [10.72.116.113] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id lb7-20020a170902fa4700b001dbbcff0b5bsm392494plb.232.2024.02.26.19.10.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Feb 2024 19:10:41 -0800 (PST)
Message-ID: <f557f89c-7699-4c58-ab91-486d57d723e7@redhat.com>
Date: Tue, 27 Feb 2024 11:10:34 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/5] KVM: selftests: aarch64: Make the
 [create|destroy]_vpmu_vm() public
To: Oliver Upton <oliver.upton@linux.dev>
Cc: Marc Zyngier <maz@kernel.org>, kvmarm@lists.linux.dev,
 Eric Auger <eauger@redhat.com>, Eric Auger <eric.auger@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
 James Morse <james.morse@arm.com>, Suzuki K Poulose
 <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20240202025659.5065-1-shahuang@redhat.com>
 <20240202025659.5065-2-shahuang@redhat.com> <ZbybaH2t7Yp9NJOK@linux.dev>
Content-Language: en-US
From: Shaoqin Huang <shahuang@redhat.com>
In-Reply-To: <ZbybaH2t7Yp9NJOK@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Oliver,

On 2/2/24 15:36, Oliver Upton wrote:
> On Thu, Feb 01, 2024 at 09:56:50PM -0500, Shaoqin Huang wrote:
> 
> [...]
> 
>> diff --git a/tools/testing/selftests/kvm/include/aarch64/vpmu.h b/tools/testing/selftests/kvm/include/aarch64/vpmu.h
>> new file mode 100644
>> index 000000000000..0a56183644ee
>> --- /dev/null
>> +++ b/tools/testing/selftests/kvm/include/aarch64/vpmu.h
>> @@ -0,0 +1,16 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +
>> +#include <kvm_util.h>
>> +
>> +#define GICD_BASE_GPA	0x8000000ULL
>> +#define GICR_BASE_GPA	0x80A0000ULL
> 
> Shouldn't a standardized layout of the GIC frames go with the rest of
> the GIC stuff?
> 
>> +/* Create a VM that has one vCPU with PMUv3 configured. */
>> +struct vpmu_vm *create_vpmu_vm(void *guest_code)
>> +{
>> +	struct kvm_vcpu_init init;
>> +	uint8_t pmuver;
>> +	uint64_t dfr0, irq = 23;
>> +	struct kvm_device_attr irq_attr = {
>> +		.group = KVM_ARM_VCPU_PMU_V3_CTRL,
>> +		.attr = KVM_ARM_VCPU_PMU_V3_IRQ,
>> +		.addr = (uint64_t)&irq,
>> +	};
>> +	struct kvm_device_attr init_attr = {
>> +		.group = KVM_ARM_VCPU_PMU_V3_CTRL,
>> +		.attr = KVM_ARM_VCPU_PMU_V3_INIT,
>> +	};
>> +	struct vpmu_vm *vpmu_vm;
>> +
>> +	vpmu_vm = calloc(1, sizeof(*vpmu_vm));
>> +	TEST_ASSERT(vpmu_vm != NULL, "Insufficient Memory");
> 
> !vpmu_vm would be the normal way to test if a pointer is NULL.
> 
>> +	memset(vpmu_vm, 0, sizeof(vpmu_vm));
> 
> What? man calloc would tell you that the returned object is already
> zero-initalized.
> 
>> +	vpmu_vm->vm = vm_create(1);
>> +	vm_init_descriptor_tables(vpmu_vm->vm);
>> +
>> +	/* Create vCPU with PMUv3 */
>> +	vm_ioctl(vpmu_vm->vm, KVM_ARM_PREFERRED_TARGET, &init);
>> +	init.features[0] |= (1 << KVM_ARM_VCPU_PMU_V3);
>> +	vpmu_vm->vcpu = aarch64_vcpu_add(vpmu_vm->vm, 0, &init, guest_code);
>> +	vcpu_init_descriptor_tables(vpmu_vm->vcpu);
> 
> I extremely dislike that the VM is semi-configured by this helper.
> You're still expecting the caller to actually install the exception
> handler.
> 
>> +	vpmu_vm->gic_fd = vgic_v3_setup(vpmu_vm->vm, 1, 64,
>> +					GICD_BASE_GPA, GICR_BASE_GPA);
>> +	__TEST_REQUIRE(vpmu_vm->gic_fd >= 0,
>> +		       "Failed to create vgic-v3, skipping");
>> +
>> +	/* Make sure that PMUv3 support is indicated in the ID register */
>> +	vcpu_get_reg(vpmu_vm->vcpu,
>> +		     KVM_ARM64_SYS_REG(SYS_ID_AA64DFR0_EL1), &dfr0);
>> +	pmuver = FIELD_GET(ARM64_FEATURE_MASK(ID_AA64DFR0_EL1_PMUVer), dfr0);
>> +	TEST_ASSERT(pmuver != ID_AA64DFR0_EL1_PMUVer_IMP_DEF &&
>> +		    pmuver >= ID_AA64DFR0_EL1_PMUVer_IMP,
>> +		    "Unexpected PMUVER (0x%x) on the vCPU with PMUv3", pmuver);
> 
> Not your code, but this assertion is meaningless. KVM does not advertise
> an IMP_DEF PMU to guests.
> 
>> +	/* Initialize vPMU */
>> +	vcpu_ioctl(vpmu_vm->vcpu, KVM_SET_DEVICE_ATTR, &irq_attr);
>> +	vcpu_ioctl(vpmu_vm->vcpu, KVM_SET_DEVICE_ATTR, &init_attr);
> 
> Not your code, but these should be converted to kvm_device_attr_set()
> calls.
> 
> Overall I'm somewhat tepid on the idea of the library being so
> coarse-grained. It is usually more helpful to expose finer-grained
> controls, like a helper that initializes the vPMU state for a
> preexisting VM. That way the PMU code can more easily be composed with
> other helpers in different tests.

Thanks for your effort reviewing my code. You're right, the helper is 
too coarse-grained. I'm trying to refactor it and define some 
finer-grained helper which can be reused for futher vpmu tests.

Thanks,
Shaoqin

> 

-- 
Shaoqin


