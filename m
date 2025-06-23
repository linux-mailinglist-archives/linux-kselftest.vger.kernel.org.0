Return-Path: <linux-kselftest+bounces-35639-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 76BC3AE4CCB
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Jun 2025 20:26:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 209F11899FA5
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Jun 2025 18:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3FA42D3A8C;
	Mon, 23 Jun 2025 18:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wzw+7gb6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oi1-f201.google.com (mail-oi1-f201.google.com [209.85.167.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CCF718B0F
	for <linux-kselftest@vger.kernel.org>; Mon, 23 Jun 2025 18:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750703206; cv=none; b=clNGd4B1z106CbcY/pywiDVZ8bWW2un4eNU/nBiAE8WsdxA38f2FXeuYtaWMF6Uf0yGEznumBArVcTuc3qUPppk2DjccHfcOjgvwEgUnFCXfuTbJcwjcklJaRIYaOpDMgz5G4GN3xYsaLCPCvOrLjgc7VlFYyn2+dqkL6FPdo0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750703206; c=relaxed/simple;
	bh=TJbyCjpQUTgcNzSy2LbHi3jtU+JgR5DmqnRNp0zwnzU=;
	h=Date:In-Reply-To:Mime-Version:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=YWT9PTXApun3p7lyPsaNCo/ITa7C0oQqpf8DTNxqFlxE2txXQx2QlkjWGiK3GXZqmuevQRIRh6yWYlRnYdJO8DIe7TD2hW/xV1FgSKKO1vbDdBIs794uMpF/sVawxnUuQqehJjUzRECXjz2Yo55VW40ruDJYe20QE5ZnvOtulfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wzw+7gb6; arc=none smtp.client-ip=209.85.167.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Received: by mail-oi1-f201.google.com with SMTP id 5614622812f47-4067aeea8c0so862228b6e.0
        for <linux-kselftest@vger.kernel.org>; Mon, 23 Jun 2025 11:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750703204; x=1751308004; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iJHuSuwyngESt8WBCKXgeOnblRRUSgRFggwy+8QiK3Q=;
        b=wzw+7gb6asEPHet7VN863TRV0sK1pJDFU6FMH8s3nzjK+3w16TXMdj1+lJpVbxPDuZ
         WPt0G0i8dDUdrASOnLlGCYM3LStCZ0jniejkWt+xMiByXzmKPROGiz4zJY9QWGlwYNoS
         6Hsqe6hCOIys6tatyGfzJtqjzUKfJy/BXlVX5eUotyi6nx257iCPCJoBsiPPYaSM6Upl
         6Ho/q2fGk748z6/clkTTPicXaIJHJu/GfepXiFlU9stjC9NRiO1+ksg+Mca37+bMJ7F5
         h32xy4mwRiAc2C2qW8Tnrzpo+Rofjh+kBuLG9TNJUtdeovK0eebfvS4sjfHBugeqKhco
         lZ3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750703204; x=1751308004;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iJHuSuwyngESt8WBCKXgeOnblRRUSgRFggwy+8QiK3Q=;
        b=mGQ+tOpgbzbzHQz6x2forh8olq2j2dl0TyZt5sXhNjp9iJh6CLXtvN4ruyu285nMqH
         +x/KONS3ZHa1d8RvBJxU7gUnqzw16FB7CkwS0oWpQF8+O/g0NgqJY+3Mbe0TT1ZZVmsX
         ZWDOHGUFDMK69UnXA2d7JZoU+9R+mjqWfxqwRLCiNzYIav6ud7UOBM/MDeJNaxLYdJRL
         E0J7LrgFim8vX4NOQzS0lz8oM80QmvJvuBODUAvhuEAkxQDlGh2g46sQtmePuTa0xpOi
         utJPlgDghSm/sA10VTFm1Nbr56BGMqueytbF9q81ocnJ7tFArBOSyEp37QjcZPjkhvgm
         KYOg==
X-Forwarded-Encrypted: i=1; AJvYcCXLdvYruNFxb7fReFGv/9eD3QYNW+uDaex9WUw6yGqsiLtAlRpfdVLVD9HwAm4r0PozC7oswJoxb7fEHAucloc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBaLjYc8R48RgayHgEFBXX3y7qxBCBHLfxyi81bGxMoEK1m2Gj
	JNWLOyYenPmxFHMp4ZE8jT/8uw7DGlV+KCoGdm4ExUyALDp4wlV61NIZipFo0Fbnzaq3TaRXuOc
	oi0VkzOnmvg8FP6x56+OaLsYkog==
X-Google-Smtp-Source: AGHT+IGC715JfAZ6bB+MUmt3e2UkqjENUKLIOq46BUMkNYiBZaTpU+l16Sml2Ik55e/lBKhpSWes9ItyhVpKmkS24Q==
X-Received: from oirr11.prod.google.com ([2002:a05:6808:840b:b0:40a:c991:8f3c])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:1645:b0:401:918a:5b89 with SMTP id 5614622812f47-40ac6ef30e6mr10779472b6e.26.1750703203710;
 Mon, 23 Jun 2025 11:26:43 -0700 (PDT)
Date: Mon, 23 Jun 2025 18:26:42 +0000
In-Reply-To: <aFYFqrYRsmCi6oii@linux.dev> (message from Oliver Upton on Fri,
 20 Jun 2025 18:06:50 -0700)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-ID: <gsntpleu9uvx.fsf@coltonlewis-kvm.c.googlers.com>
Subject: Re: [PATCH v2 07/23] perf: arm_pmuv3: Introduce method to partition
 the PMU
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

> On Fri, Jun 20, 2025 at 10:13:07PM +0000, Colton Lewis wrote:
>> For PMUv3, the register field MDCR_EL2.HPMN partitiones the PMU
>> counters into two ranges where counters 0..HPMN-1 are accessible by
>> EL1 and, if allowed, EL0 while counters HPMN..N are only accessible by
>> EL2.

>> Create module parameters partition_pmu and reserved_guest_counters to
>> reserve a number of counters for the guest. These numbers are set at
>> boot because the perf subsystem assumes the number of counters will
>> not change after the PMU is probed.

>> Introduce the function armv8pmu_partition() to modify the PMU driver's
>> cntr_mask of available counters to exclude the counters being reserved
>> for the guest and record reserved_guest_counters as the maximum
>> allowable value for HPMN.

>> Due to the difficulty this feature would create for the driver running
>> at EL1 on the host, partitioning is only allowed in VHE mode. Working
>> on nVHE mode would require a hypercall for every counter access in the
>> driver because the counters reserved for the host by HPMN are only
>> accessible to EL2.

>> Signed-off-by: Colton Lewis <coltonlewis@google.com>
>> ---
>>   arch/arm/include/asm/arm_pmuv3.h   | 10 ++++
>>   arch/arm64/include/asm/arm_pmuv3.h |  5 ++
>>   drivers/perf/arm_pmuv3.c           | 95 +++++++++++++++++++++++++++++-
>>   include/linux/perf/arm_pmu.h       |  1 +
>>   4 files changed, 109 insertions(+), 2 deletions(-)

>> diff --git a/arch/arm/include/asm/arm_pmuv3.h  
>> b/arch/arm/include/asm/arm_pmuv3.h
>> index 2ec0e5e83fc9..9dc43242538c 100644
>> --- a/arch/arm/include/asm/arm_pmuv3.h
>> +++ b/arch/arm/include/asm/arm_pmuv3.h
>> @@ -228,6 +228,11 @@ static inline bool kvm_set_pmuserenr(u64 val)

>>   static inline void kvm_vcpu_pmu_resync_el0(void) {}

>> +static inline bool has_vhe(void)
>> +{
>> +	return false;
>> +}
>> +

> This has nothing to do with PMUv3, I'm a bit surprised to see you're
> touching 32-bit ARM. Can you just gate the whole partitioning thing on
> arm64?

The PMUv3 driver also has to compile on 32-bit ARM.

My first series had the partitioning code in arch/arm64 but you asked me
to move it to the PMUv3 driver.

How are you suggesting I square those two requirements?

>> +static bool partition_pmu __read_mostly;
>> +static u8 reserved_guest_counters __read_mostly;
>> +
>> +module_param(partition_pmu, bool, 0);
>> +MODULE_PARM_DESC(partition_pmu,
>> +		 "Partition the PMU into host and guest VM counters [y/n]");
>> +
>> +module_param(reserved_guest_counters, byte, 0);
>> +MODULE_PARM_DESC(reserved_guest_counters,
>> +		 "How many counters to reserve for guest VMs [0-$NR_COUNTERS]");
>> +

> This is confusing and not what we discussed offline.

> Please use a single parameter that describes the number of counters used
> by the *host*. This affects the *host* PMU driver, KVM can discover (and
> use) the leftovers.

> If the single module parameter goes unspecified the user did not ask for
> PMU partitioning.

I understand what we discussed offline, but I had a dilemma.

If we do a single module parameter for number of counters used by the
host, then it defaults to 0 if unset and there is no way to distinguish
between no partitioning and a request for partitioning reserving 0
counters to the host which I also thought you requested. Would you be
happy leaving no way to specify that?

In any case, I think the usage is more self explainatory if
partitition=[y/n] is a separate bit. The other parameter for guest
reservation is then based on a consideration of what an unset parameter
should mean and I decided it's a more sane default if partition=y
[other-param]=0/unset gives 0 counters to the guest.

It does affect the host, but by default the host owns everything. The
only people who will be tweaking these parameters are going to be
concerned with how many counters the guest gets and I think the
parameters should reflect that intent.

>> +/**
>> + * armv8pmu_reservation_is_valid() - Determine if reservation is allowed
>> + * @guest_counters: Number of host counters to reserve
>> + *
>> + * Determine if the number of host counters in the argument is
>> + * allowed. It is allowed if it will produce a valid value for
>> + * register field MDCR_EL2.HPMN.
>> + *
>> + * Return: True if reservation allowed, false otherwise
>> + */
>> +static bool armv8pmu_reservation_is_valid(u8 guest_counters)
>> +{
>> +	return guest_counters <= armv8pmu_pmcr_n_read();
>> +}
>> +
>> +/**
>> + * armv8pmu_partition_supported() - Determine if partitioning is  
>> possible
>> + *
>> + * Partitioning is only supported in VHE mode (with PMUv3, assumed
>> + * since we are in the PMUv3 driver)
>> + *
>> + * Return: True if partitioning is possible, false otherwise
>> + */
>> +static bool armv8pmu_partition_supported(void)
>> +{
>> +	return has_vhe();
>> +}
>> +
>> +/**
>> + * armv8pmu_partition() - Partition the PMU
>> + * @pmu: Pointer to pmu being partitioned
>> + * @guest_counters: Number of host counters to reserve
>> + *
>> + * Partition the given PMU by taking a number of host counters to
>> + * reserve and, if it is a valid reservation, recording the
>> + * corresponding HPMN value in the hpmn field of the PMU and clearing
>> + * the guest-reserved counters from the counter mask.
>> + *
>> + * Passing 0 for @guest_counters has the effect of disabling  
>> partitioning.
>> + *
>> + * Return: 0 on success, -ERROR otherwise
>> + */
>> +static int armv8pmu_partition(struct arm_pmu *pmu, u8 guest_counters)
>> +{
>> +	u8 nr_counters;
>> +	u8 hpmn;
>> +
>> +	if (!armv8pmu_reservation_is_valid(guest_counters))
>> +		return -EINVAL;
>> +
>> +	nr_counters = armv8pmu_pmcr_n_read();
>> +	hpmn = guest_counters;
>> +
>> +	pmu->hpmn_max = hpmn;

> I'm not sure the host driver needs this for anything, KVM just needs to
> know what's potentially in use by the host.

>> +	/* Inform host driver of available counters */

> ... said the driver to itself :)

I can delete that comment now :)

