Return-Path: <linux-kselftest+bounces-35637-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10513AE4CC0
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Jun 2025 20:25:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C98A3BADA7
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Jun 2025 18:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC0602D3A74;
	Mon, 23 Jun 2025 18:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ruqqH37R"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f73.google.com (mail-io1-f73.google.com [209.85.166.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF822D028A
	for <linux-kselftest@vger.kernel.org>; Mon, 23 Jun 2025 18:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750703120; cv=none; b=TgD9XJwK8nXs/UbCVSqzeeiHJS/2/sSJ0+AfwrlPD1VlHgnkFMjT/WyMsrQVuYEJLHYtVmhJ4ROYuD3nXYUKd5i0x9BkJsIwDwVVSvQV8w5UHYdX0TydzQh5cRhIgKSN1AURcHlI5fFf+thQWDDrv1vNmuXczhpWe5d3SW+u5VQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750703120; c=relaxed/simple;
	bh=Ig5ipTdJADEoDAWoOphXIpyhS5e+nFJQDKH78u7uCTg=;
	h=Date:In-Reply-To:Mime-Version:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=ZGQzEdn3+dhBxIogqwA8JAUT/9On2hvx/13tYMYuNjcuTgHQp4Yp75PwNRhpQSLCA2W+revkcqyt18HwrGMd7XCA2n+nU5LDOPfGewLGBNRdVeXqz1gYg0qIzFUNDOMp0UgYPhCwpvCdsbsgE0qJ/H/Z2PucDzHrdgyvxIGy+7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ruqqH37R; arc=none smtp.client-ip=209.85.166.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Received: by mail-io1-f73.google.com with SMTP id ca18e2360f4ac-876074516b3so790494839f.1
        for <linux-kselftest@vger.kernel.org>; Mon, 23 Jun 2025 11:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750703118; x=1751307918; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fkKX/+jmAY5EI28pxMDSbALm6PmjD/WT98j0aaxzD8Y=;
        b=ruqqH37RFF7eaGFYweG4zc0KShUaBLkbO2jPfyZFXYkdv1y+P4JAp9eD3XzaPNtKxX
         QjqblPL9cAYN5HnjHxTgCW6LQqTusUBrX90eWdxnrQlVWMK8rIA42KM+e7tu2ZP2LRoH
         tuAWRg2xttBPbcZSzTi9rJh76jrSW70dD8ldrMcScdlGJcWQ3fWUPnBGEw2b+RR+xkRa
         NKM3/Kx+9iHyYeh8HAUIjgOARiPiVs8buCICiCYcg1TKf9dnW0MQVU5QDXXS3HK0GDDM
         kP2hlo6PHDStaBxYMFXFp8MIyWXoOKjp6MlNeVWc1C+v1mRFUwXLQV4SS85ngSMR6xoS
         Akng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750703118; x=1751307918;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fkKX/+jmAY5EI28pxMDSbALm6PmjD/WT98j0aaxzD8Y=;
        b=o04uursh/Y5OF8T4EW459HAzwlpUF7Tzye9glg18DQbx/W/AdL8xJLeNv9yKuea1qI
         HkxlCQMtI3zN9b/nE10XRwwxyoHnFo51PFa6rebDsoXlpIj//5J7MqVvWA7CdEFBwTqm
         5R3su4QNiDe7/ATyKd/0eYcSG7Q/6R0bsZXqpBYvjZ4jFgFK+mQt7Q0H6rs/wJo2OIKv
         nvlgCr20Z0tlgpethfIqzyt7Xfx/H6tQvsSU4ckuN/nZuIAUzWRxbGV6M5c2dDNdRLx/
         M1rT3dqePJhztu8PLZ4B4bGenDI7MvZzk5GMamDLa/tQp+xhSPVznPDRFB+DUPd+VYI7
         W4hg==
X-Forwarded-Encrypted: i=1; AJvYcCW3+guCuyRjL28h2VatltJj0SemBa8kq5Q4VLFo+lX1SeswQyhvEOAybcKq1Mp4ajyTESim4DCzOBCGaByKgtY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVro4US+qC1fCI20Xs9BKL7Gx+tYvlZB4qkw3d0WKi4UnwuSQ+
	G5kvr2dVBTEN1b1/QNp+LFMwskzLiaQneRkkjTOVAdpNeyVbpHRNHYO9mQUZ5L48H9+B3zGS73j
	fYYKq97VrDQVNPa2ai7txclD4CA==
X-Google-Smtp-Source: AGHT+IGzBE7m3jRf0szvIWMcwTlET+uxa4mEBdZ8JNu6pA3Bo/Yc8zZA87zzxM+0+5qc5CYD+m3kIHDI/60f4MKLBA==
X-Received: from jay12.prod.google.com ([2002:a05:6638:c2dc:b0:4f0:9e8b:e246])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6e02:1806:b0:3de:1200:219f with SMTP id e9e14a558f8ab-3de38cda633mr149171615ab.22.1750703118062;
 Mon, 23 Jun 2025 11:25:18 -0700 (PDT)
Date: Mon, 23 Jun 2025 18:25:16 +0000
In-Reply-To: <aFYAq7GcSx4pTK9Y@linux.dev> (message from Oliver Upton on Fri,
 20 Jun 2025 17:45:31 -0700)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-ID: <gsntsejq9uyb.fsf@coltonlewis-kvm.c.googlers.com>
Subject: Re: [PATCH v2 03/23] arm64: cpufeature: Add cpucap for PMICNTR
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

Hi Oliver. Thanks for review.

Oliver Upton <oliver.upton@linux.dev> writes:

> On Fri, Jun 20, 2025 at 10:13:03PM +0000, Colton Lewis wrote:
>> Add a cpucap for FEAT_PMUv3_PMICNTR, meaning there is a dedicated
>> instruction counter as well as the cycle counter.

>> Signed-off-by: Colton Lewis <coltonlewis@google.com>

> I don't see this capability being used in this series.

> Thanks,
> Oliver

You are correct it isn't now. I'll take it out.

>> ---
>>   arch/arm64/kernel/cpufeature.c | 7 +++++++
>>   arch/arm64/tools/cpucaps       | 1 +
>>   2 files changed, 8 insertions(+)

>> diff --git a/arch/arm64/kernel/cpufeature.c  
>> b/arch/arm64/kernel/cpufeature.c
>> index 278294fdc97d..85dea9714928 100644
>> --- a/arch/arm64/kernel/cpufeature.c
>> +++ b/arch/arm64/kernel/cpufeature.c
>> @@ -2904,6 +2904,13 @@ static const struct arm64_cpu_capabilities  
>> arm64_features[] = {
>>   		.matches = has_cpuid_feature,
>>   		ARM64_CPUID_FIELDS(ID_AA64DFR0_EL1, HPMN0, IMP)
>>   	},
>> +	{
>> +		.desc = "PMU Dedicated Instruction Counter",
>> +		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
>> +		.capability = ARM64_HAS_PMICNTR,
>> +		.matches = has_cpuid_feature,
>> +		ARM64_CPUID_FIELDS(ID_AA64DFR1_EL1, PMICNTR, IMP)
>> +	},
>>   #ifdef CONFIG_ARM64_SME
>>   	{
>>   		.desc = "Scalable Matrix Extension",
>> diff --git a/arch/arm64/tools/cpucaps b/arch/arm64/tools/cpucaps
>> index 5b196ba21629..6dd72fcdd612 100644
>> --- a/arch/arm64/tools/cpucaps
>> +++ b/arch/arm64/tools/cpucaps
>> @@ -47,6 +47,7 @@ HAS_LSE_ATOMICS
>>   HAS_MOPS
>>   HAS_NESTED_VIRT
>>   HAS_PAN
>> +HAS_PMICNTR
>>   HAS_PMUV3
>>   HAS_S1PIE
>>   HAS_S1POE
>> --
>> 2.50.0.714.g196bf9f422-goog


