Return-Path: <linux-kselftest+bounces-47678-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E669CC9C3B
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Dec 2025 00:05:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 485BF3014B54
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Dec 2025 23:05:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEDED32ED51;
	Wed, 17 Dec 2025 23:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EBb1p8bz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ot1-f73.google.com (mail-ot1-f73.google.com [209.85.210.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E882C3276
	for <linux-kselftest@vger.kernel.org>; Wed, 17 Dec 2025 23:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766012729; cv=none; b=PyOEMfq6IXkIdYpb++Ohd50WHWsTrCgVfBW6W4lBRZIeZrX49x6b1uzGuDFJP+vrvbFLA/nVDAzKuIr2UPnJDKkpYc8ckXbQAsrk1DdM5GU4lnvhJu1NIogqbqhDikL/SwLHttcB3pEbTSJ9L3E4Gfrueh0ORQxdHROmg0tzgUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766012729; c=relaxed/simple;
	bh=0l/omZO1v8asiZJMEMWG7M0JnZi5IJrGYo3/p+gESCE=;
	h=Date:In-Reply-To:Mime-Version:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=F+u/269Fqrd0CmUda0i8q39HyoKULEOCyYBc9tIQ4SxRgMPP0AwnQQX2qAoEkGjpetAXVItYidQT/DXHWUZGI3rYoKHlPVcwo6kq4u44sNSlaZE4zfr/2VKiaAi73Svh4P1sMkn4n6vNw/Uw5KQvTcnDa9CZtiJdhGpywucQlxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EBb1p8bz; arc=none smtp.client-ip=209.85.210.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Received: by mail-ot1-f73.google.com with SMTP id 46e09a7af769-7cacaa675feso12963957a34.3
        for <linux-kselftest@vger.kernel.org>; Wed, 17 Dec 2025 15:05:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1766012727; x=1766617527; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GLCAorwrKlMW8FunTjt8zj7Va5wWm7XneVrIZBSPv24=;
        b=EBb1p8bzEwiF3Lu+DMjXUQwtVzw5gBRP72IVghNFvFFa0z7qC/VrsSVB3FLCt5H0AM
         cJeT1Q5eAutT1RyaPO9goRXe/O8erhAbEj6W0BnVASJ/W26oRRZbDu2X4zjLK7+xsb84
         k9P/nLv/zwBjdHGGZSg8SI+rXle+u3d1N1O/FRLsv74rddRMufLT6Cy+ZI9f8yEOBprA
         xsOqku1qz1AlMzgd2YfyJbbDh2Tvv6atVMY3CAunxEp3gFbSlUTtyURuGpgDyP1hJ6zx
         QFGmI19GEDL2MRqpYN2E/nowvTVLtrxWz6r/bW54R+BPIpv3RheWK/ovhOCzDviKF6HI
         WwfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766012727; x=1766617527;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GLCAorwrKlMW8FunTjt8zj7Va5wWm7XneVrIZBSPv24=;
        b=ICvfTySW4iCRUXZXxyaqa5bd0tRm6FIIAE/jU6QwGOdyWZPxyGt6SK3Kk0Hx2zuYgV
         mDFubTeiggLIxamv3dXSrZMdiyjA3lC0V4lq00qIZgYZrWk0ilgWrzvi4cC8zOP/aAMc
         99q7ymHhkhoXQavIABY5oWVsL3GoFsZZqhVMKc7wL4oa80OEx61V4pudOXOOW/iqDByD
         bCI9wIbTYNgtf3Hu62MoKhbrb2Qk2cC9lY/Q+hVljuWCix6vneZYXjmRZY8Y9oC6SV1j
         iE5A+rS6Ca7E6gVKKSbnZj32kKOTpTUFCd3MsjhkZ0zqyssXFjvzoYtUN7Mvxex9sFo3
         i3Ag==
X-Forwarded-Encrypted: i=1; AJvYcCUOdDv5KvaT0sG5kOha2AgsTkdVWKZK6jMof+nngogbbcJM/keWo5T7WWDmrB1OX9QVflGmMxFw6DMZtKHRxIs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGq6Rycc/HJ5YfirefPKMPEeq+W0ce0Z9+EfJcyqVYB6gtumi6
	3g/FqNC7w8V2UTYfmPfn92KVrygscumAISQmu2yFLP7f5jTpVqchjk/f7NudKoj81ir93mJ7GRq
	LwSZKo2PPE3qQ0+JCN62ueam/KQ==
X-Google-Smtp-Source: AGHT+IFeAgC0uw9c+8LafGLGz/f6/NPZAPXmK9qXp7aoSKF9A72AfmoYnPNSSr0uyMWXg523FecZ0oA8sQssQiXDkg==
X-Received: from ilbbo32.prod.google.com ([2002:a05:6e02:3420:b0:430:ccc7:4f1e])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6820:4815:b0:65c:fe5b:9f4d with SMTP id 006d021491bc7-65cfe5ba58emr301994eaf.47.1766012727236;
 Wed, 17 Dec 2025 15:05:27 -0800 (PST)
Date: Wed, 17 Dec 2025 23:05:26 +0000
In-Reply-To: <aUH_7yYZsmFlRvEc@kernel.org> (message from Oliver Upton on Tue,
 16 Dec 2025 16:57:19 -0800)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-ID: <gsntzf7g1zgp.fsf@coltonlewis-kvm.c.googlers.com>
Subject: Re: [PATCH v5 18/24] KVM: arm64: Enforce PMU event filter at vcpu_load()
From: Colton Lewis <coltonlewis@google.com>
To: Oliver Upton <oupton@kernel.org>
Cc: kvm@vger.kernel.org, pbonzini@redhat.com, corbet@lwn.net, 
	linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org, 
	maz@kernel.org, oliver.upton@linux.dev, mizhang@google.com, 
	joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com, 
	mark.rutland@arm.com, shuah@kernel.org, gankulkarni@os.amperecomputing.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-perf-users@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes

Oliver Upton <oupton@kernel.org> writes:

> Re-reading this patch...

> On Tue, Dec 09, 2025 at 08:51:15PM +0000, Colton Lewis wrote:
>> The KVM API for event filtering says that counters do not count when
>> blocked by the event filter. To enforce that, the event filter must be
>> rechecked on every load since it might have changed since the last
>> time the guest wrote a value.

> Just directly state that this is guarding against userspace programming
> an unsupported event ID.

Sure

>> +static void kvm_pmu_apply_event_filter(struct kvm_vcpu *vcpu)
>> +{
>> +	struct arm_pmu *pmu = vcpu->kvm->arch.arm_pmu;
>> +	u64 evtyper_set = ARMV8_PMU_EXCLUDE_EL0 |
>> +		ARMV8_PMU_EXCLUDE_EL1;
>> +	u64 evtyper_clr = ARMV8_PMU_INCLUDE_EL2;
>> +	u8 i;
>> +	u64 val;
>> +	u64 evsel;
>> +
>> +	if (!pmu)
>> +		return;
>> +
>> +	for (i = 0; i < pmu->hpmn_max; i++) {

> Iterate the bitmask of counters and you'll handle the cycle counter 'for
> free'.

Will do.

> <snip>

>> +		val = __vcpu_sys_reg(vcpu, PMEVTYPER0_EL0 + i);
>> +		evsel = val & kvm_pmu_event_mask(vcpu->kvm);
>> +
>> +		if (vcpu->kvm->arch.pmu_filter &&
>> +		    !test_bit(evsel, vcpu->kvm->arch.pmu_filter))
>> +			val |= evtyper_set;
>> +
>> +		val &= ~evtyper_clr;
>> +		write_pmevtypern(i, val);

> </snip>

> This all needs to be shared with writethrough_pmevtyper() instead of
> open-coding the same thing.

Will do.

> Thanks,
> Oliver

