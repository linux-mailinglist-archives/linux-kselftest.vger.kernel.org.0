Return-Path: <linux-kselftest+bounces-34259-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E784ACCF04
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Jun 2025 23:32:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3AB457A2440
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Jun 2025 21:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C31422F164;
	Tue,  3 Jun 2025 21:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K8FA1uSf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f202.google.com (mail-il1-f202.google.com [209.85.166.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B951A8405
	for <linux-kselftest@vger.kernel.org>; Tue,  3 Jun 2025 21:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748986365; cv=none; b=RQ4E77/ci+tlj6OfSVxyGd0MgF7RN9y9p8euhnj05HAhrtP621YDiqgr16+oWlpM6oRQSWGUmHOTf8Ew5N4KFGc59QS36oj5NNLuSLNqM8/SMlIsIK4ckZEr8CpP3QTCh4Z2pxIenP2JyMxMBBqeknNHzThGsR4QGT66S65fYbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748986365; c=relaxed/simple;
	bh=mRmmFnlPCP5qmGp8cqulc+n4NmAySDPtVlsv8iPw48Q=;
	h=Date:In-Reply-To:Mime-Version:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=p8K2RUNSOOoew+sVLDJBqP2Nkj2xxdfpC06SCB+S2Qnq3/cVIlsry61O+xlwzIOeX52QCKVNXiHezlpKcJSlqdLqB6RYA9dPguSPa4rUghFvohn2boqa0pPtGdYRF2YveOepuZ1WewidMJCfPcOMVJ/FllxEmOYqxwRcD8RJ5X4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=K8FA1uSf; arc=none smtp.client-ip=209.85.166.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Received: by mail-il1-f202.google.com with SMTP id e9e14a558f8ab-3ddb9d32cfeso17431375ab.3
        for <linux-kselftest@vger.kernel.org>; Tue, 03 Jun 2025 14:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748986362; x=1749591162; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=A0l5G93fC29AgVAtcdaJmVpgHO/IQHFXQv4WdPYaaHE=;
        b=K8FA1uSfxXYjE7M/3EGc5Xqz1jBw8GcDGVwsHp27n1ZI7vHBo0QWT2qQjdijACY7BA
         lwqOv2PA2bN5COEHIj2Wn68GG+8L7U6PfTrmvhlaXGpyEgz/xHgfGsQwKWU+X06EG/UE
         2V8F6qw1w5fm+Ivo5jH9xnc9Mfk55rKMzVmVPqFSu6ppANUTxsRslGaFaCLNyadaEoxB
         MdC5tLrVwVffEBkfLJYlp6EDqSKGHLSk/wqER1yM6wUATYBMlgrWkEGdCdrUK1yC7AmZ
         mPOWsVnwgF7Gz0feqkFGxRyAB34+dtwPJMGpv1EPafIAEfKeeLEJ0Yoy/TEW/tygeHzU
         ETQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748986362; x=1749591162;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A0l5G93fC29AgVAtcdaJmVpgHO/IQHFXQv4WdPYaaHE=;
        b=E/mpx0u085lnZzH0fDuMagQyOV/0PcoBmWD4AW720Ixwr4VVJzgtwhAoI8p/ezk80Y
         8AupsSGdlWNFhLk1og7C189GleOHraVhn28Qs2NZRTeeEX4TY/DfVGy2TDm3RDILUjpW
         0VBSoLy4zN8eXqZkSEo39ne4EQF6R+UcBDt3hbZKrBURDPk9s2WkOFZoeMPG+0LxtIVg
         ZkOgVJfxF/utz+eBmQfcugllL1eMdlHHB+Sv7oEi7IIHDoAfDPiPyZYMjxsabDYlJaLM
         PFyA4J1J9jPxCFplENMBfNX6b6A7/7zagBX8voFYCSnZPYtZwHSwQwQDHG35i2eTZ4T6
         1shg==
X-Forwarded-Encrypted: i=1; AJvYcCWpe80avcHk/woZ9PfPy9CmtsOevm1QTpmqEWx7goxdAc3rSoIuCoJMReXECKSJmknZER0NRUldZ/XvXU1JvIg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxothiXON+JZtXWrluHLxvgvvLXGSBv9O3WSgjDauc93G8rh698
	2FAtRaG5nTM4lWSfIy7xA9y6OkmvnYld+eGXPHZJo2novygmKvs9HmDeyL4Hv1pqbGyBCmH13t1
	HzxtdPAgxs6gr1YeY47GltVAHqA==
X-Google-Smtp-Source: AGHT+IEpZcrefEWDzzUjOLjOnRYEdIFZat5s3G0oLfOvn/O8rphYPOQ1GWMYf3Wj71ilVVre/pSRPvqRpgjiaR79Qg==
X-Received: from ilbbm14.prod.google.com ([2002:a05:6e02:330e:b0:3d9:2b64:6884])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a92:c241:0:b0:3dc:7a9a:44d5 with SMTP id e9e14a558f8ab-3ddbedc8c8fmr6231205ab.22.1748986362621;
 Tue, 03 Jun 2025 14:32:42 -0700 (PDT)
Date: Tue, 03 Jun 2025 21:32:41 +0000
In-Reply-To: <aD4llDZwb_sC_Ptj@linux.dev> (message from Oliver Upton on Mon, 2
 Jun 2025 15:28:36 -0700)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-ID: <gsnt4iww3406.fsf@coltonlewis-kvm.c.googlers.com>
Subject: Re: [PATCH 06/17] KVM: arm64: Introduce method to partition the PMU
From: Colton Lewis <coltonlewis@google.com>
To: Oliver Upton <oliver.upton@linux.dev>
Cc: kvm@vger.kernel.org, pbonzini@redhat.com, corbet@lwn.net, 
	linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org, 
	maz@kernel.org, joey.gouly@arm.com, suzuki.poulose@arm.com, 
	yuzenghui@huawei.com, mark.rutland@arm.com, shuah@kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-perf-users@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes

Oliver Upton <oliver.upton@linux.dev> writes:

> On Mon, Jun 02, 2025 at 07:26:51PM +0000, Colton Lewis wrote:
>>   static void kvm_arm_setup_mdcr_el2(struct kvm_vcpu *vcpu)
>>   {
>> +	u8 hpmn = vcpu->kvm->arch.arm_pmu->hpmn;
>> +
>>   	preempt_disable();

>>   	/*
>>   	 * This also clears MDCR_EL2_E2PB_MASK and MDCR_EL2_E2TB_MASK
>>   	 * to disable guest access to the profiling and trace buffers
>>   	 */
>> -	vcpu->arch.mdcr_el2 = FIELD_PREP(MDCR_EL2_HPMN,
>> -					 *host_data_ptr(nr_event_counters));
>> -	vcpu->arch.mdcr_el2 |= (MDCR_EL2_TPM |
>> +	vcpu->arch.mdcr_el2 = FIELD_PREP(MDCR_EL2_HPMN, hpmn);
>> +	vcpu->arch.mdcr_el2 |= (MDCR_EL2_HPMD |
>> +				MDCR_EL2_TPM |

> This isn't safe, as there's no guarantee that kvm_arch::arm_pmu is
> pointing that the PMU for this CPU. KVM needs to derive HPMN from some
> per-CPU state, not anything tied to the VM/vCPU.

I'm confused. Isn't this function preparing to run the vCPU on this
CPU? Why would it be pointing at a different PMU?

And HPMN is something that we only want set when running a vCPU, so
there isn't any per-CPU state saying it should be anything but the
default value (number of counters) outside that context.

Unless you just mean I should check the number of counters again and
make sure HPMN is not an invalid value.

>> +/**
>> + * kvm_pmu_partition() - Partition the PMU
>> + * @pmu: Pointer to pmu being partitioned
>> + * @host_counters: Number of host counters to reserve
>> + *
>> + * Partition the given PMU by taking a number of host counters to
>> + * reserve and, if it is a valid reservation, recording the
>> + * corresponding HPMN value in the hpmn field of the PMU and clearing
>> + * the guest-reserved counters from the counter mask.
>> + *
>> + * Passing 0 for @host_counters has the effect of disabling  
>> partitioning.
>> + *
>> + * Return: 0 on success, -ERROR otherwise
>> + */
>> +int kvm_pmu_partition(struct arm_pmu *pmu, u8 host_counters)
>> +{
>> +	u8 nr_counters;
>> +	u8 hpmn;
>> +
>> +	if (!kvm_pmu_reservation_is_valid(host_counters))
>> +		return -EINVAL;
>> +
>> +	nr_counters = *host_data_ptr(nr_event_counters);
>> +	hpmn = kvm_pmu_hpmn(host_counters);
>> +
>> +	if (hpmn < nr_counters) {
>> +		pmu->hpmn = hpmn;
>> +		/* Inform host driver of available counters */
>> +		bitmap_clear(pmu->cntr_mask, 0, hpmn);
>> +		bitmap_set(pmu->cntr_mask, hpmn, nr_counters);
>> +		clear_bit(ARMV8_PMU_CYCLE_IDX, pmu->cntr_mask);
>> +		if (pmuv3_has_icntr())
>> +			clear_bit(ARMV8_PMU_INSTR_IDX, pmu->cntr_mask);
>> +
>> +		kvm_debug("Partitioned PMU with HPMN %u", hpmn);
>> +	} else {
>> +		pmu->hpmn = nr_counters;
>> +		bitmap_set(pmu->cntr_mask, 0, nr_counters);
>> +		set_bit(ARMV8_PMU_CYCLE_IDX, pmu->cntr_mask);
>> +		if (pmuv3_has_icntr())
>> +			set_bit(ARMV8_PMU_INSTR_IDX, pmu->cntr_mask);
>> +
>> +		kvm_debug("Unpartitioned PMU");
>> +	}
>> +
>> +	return 0;
>> +}

> Hmm... Just in terms of code organization I'm not sure I like having KVM
> twiddling with *host* support for PMUv3. Feels like the ARM PMU driver
> should own partitioning and KVM just takes what it can get.

Okay. I can move the code.

>> @@ -239,6 +245,13 @@ void kvm_host_pmu_init(struct arm_pmu *pmu)
>>   	if (!pmuv3_implemented(kvm_arm_pmu_get_pmuver_limit()))
>>   		return;

>> +	if (reserved_host_counters) {
>> +		if (kvm_pmu_partition_supported())
>> +			WARN_ON(kvm_pmu_partition(pmu, reserved_host_counters));
>> +		else
>> +			kvm_err("PMU Partition is not supported");
>> +	}
>> +

> Hasn't the ARM PMU been registered with perf at this point? Surely the
> driver wouldn't be very pleased with us ripping counters out from under
> its feet.

AFAICT nothing in perf registration cares about the number of counters
the PMU has. The PMUv3 driver tracks its own available counters through
cntr_mask and I modify that during partition.

Since this is still initialization of the PMU, I don't believe anything
has had a chance to use a counter yet that will be ripped away.

Aesthetically It makes since to change this if I move the partitioning
code to the PMUv3 driver, but I think it's inconsequential to the
function.

