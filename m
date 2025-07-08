Return-Path: <linux-kselftest+bounces-36778-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B89FAFDB26
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Jul 2025 00:34:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 071921AA7E58
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Jul 2025 22:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F3BC25B1DC;
	Tue,  8 Jul 2025 22:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q61I2oqU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f202.google.com (mail-il1-f202.google.com [209.85.166.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D264125A2C2
	for <linux-kselftest@vger.kernel.org>; Tue,  8 Jul 2025 22:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752014080; cv=none; b=Mxz0MuleGA3ZsgVTyZ4ldguoqZQwaF8wQrT9Yf9o4d8RG21Y8FDtYyJr3h2FskYjB6VYLrtE3cDaEap0+KtAuoiv31ZZp1cf6r0wUBlnF6EXeoi8zkibsO6LVDzTXOVtaMFA6xX1Z7AflPHhf2ldUyN2iq2OT2TtZwQ4lYSTNFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752014080; c=relaxed/simple;
	bh=02xDzJQPlhBq0RU8lcHj/2RG+qyIWz4nKYd1naozQns=;
	h=Date:In-Reply-To:Mime-Version:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=JS/iXSOVbV8Wo3Gf/CEY10ekIe/OUEojRMeMKv0qXOmYqEjk+wjj+6TgtzUrtk1roN9dnnC2Fdd2sjjWYYEU1e8ENEvjaqixO+hjZSxQrYxev2xeHdUIA6iFSZAqWtx31HbGC/oH/wRdvBkAeSC1WcvDHJ713EqHoZHgJtGc8qI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=q61I2oqU; arc=none smtp.client-ip=209.85.166.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Received: by mail-il1-f202.google.com with SMTP id e9e14a558f8ab-3ddbec809acso54958825ab.2
        for <linux-kselftest@vger.kernel.org>; Tue, 08 Jul 2025 15:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752014077; x=1752618877; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=j/9FFTs3Hz/7yNjDy98C2EAojjbwb0TEz5q962JZJd0=;
        b=q61I2oqU6t7TlFUuejfBAlRXMpmAZ7Y88nYyFUVvwWgUfS3spZQ2M3X/95is9uC3+z
         LMVKgQMD+NWwSknrYWq3Rb4UkPk/AVRK7pobaKLfJTAd6nsi0fsG/u5BNhNmAbKPv8+V
         z4zz+OjLynPwAnrqvFrbctC2wLfX0R1HhIr8reyxMY6Xouf15IZbHSrGQAIVZGHnyBwh
         VyOnDUis/7wVtVVBA03qPFwrv9jK8ie/ji/brym+HWEu1LcZqz/ZJ1J4CtdPqujSRKO1
         s/CzBthoM+bGlLDFUxJMKHqNfGH11HITo55nDTazdXlhPkJxBAn+iWWriAd/rvl/dSsz
         ZQ8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752014077; x=1752618877;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j/9FFTs3Hz/7yNjDy98C2EAojjbwb0TEz5q962JZJd0=;
        b=fkwONtc2IgU9CbKUA8IE9aWHnaDHhi+/+xVNPk5IrNJZjsOq331pX/9uEtEMR02aRm
         D+WSuSB3zf3+BsPYFEEPE7DLMaQYtCr2J1N8xDUM9uUTc41Hyx6sNYSf/x+QAHl7RB0W
         SqHBMNgYRcUsS3JI2G0GD/30kPzfSjruRuTb/hPyy/IkITyz8mLlx43ukeP7aT+ziv0n
         2jTFI2CofXBoGRvvKu1lBrE8nAI3WRV5teda9U2amOywpsYnNVJrxEFfTdLNKIJRtGzk
         Oj/f9rmU9jLlQDBbD96yyUhJSNwNavk1x6Oq0tWTOeWpvMh4KIHLNT7CebhOh4EVWwaw
         8UxA==
X-Forwarded-Encrypted: i=1; AJvYcCWmDFN9YB9rEy59346R1qLk7ozP1vPtoZ/Z9l/AohRqHxfVWUAenhQcigX39s1j32EMyENmAfrIMD3yYBEcwnU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTsfjQAiSHry4QwmWSYFPqtRcXL/R0smjU22IfD/wuO8UaFjeh
	qcsIs4i6RZinU9CwlbiRn13eMf0vEyb+P5n3VaeNDLG/8KpQNRNv+px28Uh22mQS1fTTtitDN08
	2KGaXDagiaKiA+xDZPAGAOq3k9Q==
X-Google-Smtp-Source: AGHT+IHW+RfduRT7VliGk050iQEqjU318xPGArkYZW5dZzAyyRBuwQAaT6oV8zuk0wkHYQ4WnuckwA/hmtfDS9hyaw==
X-Received: from ilfg10.prod.google.com ([2002:a05:6e02:198a:b0:3df:30df:d2c4])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6e02:339f:b0:3e0:4564:4ef9 with SMTP id e9e14a558f8ab-3e166ffbeb5mr5390855ab.4.1752014077049;
 Tue, 08 Jul 2025 15:34:37 -0700 (PDT)
Date: Tue, 08 Jul 2025 22:34:35 +0000
In-Reply-To: <aGvwLIAN8rhxtA_V@J2N7QTR9R3> (message from Mark Rutland on Mon,
 7 Jul 2025 17:05:00 +0100)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-ID: <gsnt34b61fd0.fsf@coltonlewis-kvm.c.googlers.com>
Subject: Re: [PATCH v3 01/22] arm64: cpufeature: Add cpucap for HPMN0
From: Colton Lewis <coltonlewis@google.com>
To: Mark Rutland <mark.rutland@arm.com>
Cc: kvm@vger.kernel.org, pbonzini@redhat.com, corbet@lwn.net, 
	linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org, 
	maz@kernel.org, oliver.upton@linux.dev, mizhang@google.com, 
	joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com, 
	shuah@kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-perf-users@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes

Mark Rutland <mark.rutland@arm.com> writes:

> On Thu, Jun 26, 2025 at 08:04:37PM +0000, Colton Lewis wrote:
>> Add a capability for FEAT_HPMN0, whether MDCR_EL2.HPMN can specify 0
>> counters reserved for the guest.

>> This required changing HPMN0 to an UnsignedEnum in tools/sysreg
>> because otherwise not all the appropriate macros are generated to add
>> it to arm64_cpu_capabilities_arm64_features.

> I agree it's appropriate to mark ID_AA64DFR0_EL1.HPMN0 as an
> UnsignedEnum. It follows the usual ID scheme per ARM DDI 0487 L.a
> section D24.1.3, and zero means not present, so it must be unsigned.

> Likewise, the value renames (UNPREDICTABLE => NI and DEF => IMP) look
> fine to me.

>> Signed-off-by: Colton Lewis <coltonlewis@google.com>

> I have one minor nit below, but either way:

> Acked-by: Mark Rutland <mark.rutland@arm.com>

Thank you Mark

>> ---
>>   arch/arm64/kernel/cpufeature.c | 8 ++++++++
>>   arch/arm64/tools/cpucaps       | 1 +
>>   arch/arm64/tools/sysreg        | 6 +++---
>>   3 files changed, 12 insertions(+), 3 deletions(-)

>> diff --git a/arch/arm64/kernel/cpufeature.c  
>> b/arch/arm64/kernel/cpufeature.c
>> index b34044e20128..73a7dac4b6f6 100644
>> --- a/arch/arm64/kernel/cpufeature.c
>> +++ b/arch/arm64/kernel/cpufeature.c
>> @@ -548,6 +548,7 @@ static const struct arm64_ftr_bits ftr_id_mmfr0[] = {
>>   };

>>   static const struct arm64_ftr_bits ftr_id_aa64dfr0[] = {
>> +	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE,  
>> ID_AA64DFR0_EL1_HPMN0_SHIFT, 4, 0),
>>   	S_ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE,  
>> ID_AA64DFR0_EL1_DoubleLock_SHIFT, 4, 0),
>>   	ARM64_FTR_BITS(FTR_HIDDEN, FTR_NONSTRICT, FTR_LOWER_SAFE,  
>> ID_AA64DFR0_EL1_PMSVer_SHIFT, 4, 0),
>>   	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE,  
>> ID_AA64DFR0_EL1_CTX_CMPs_SHIFT, 4, 0),
>> @@ -2896,6 +2897,13 @@ static const struct arm64_cpu_capabilities  
>> arm64_features[] = {
>>   		.matches = has_cpuid_feature,
>>   		ARM64_CPUID_FIELDS(ID_AA64MMFR0_EL1, FGT, FGT2)
>>   	},
>> +	{
>> +		.desc = "FEAT_HPMN0",

> Minor nit, but we can drop the "FEAT_" prefix here, for consistency with
> other features (e.g. E0PD, FPMR).

> Mark.

Will do.

>> +		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
>> +		.capability = ARM64_HAS_HPMN0,
>> +		.matches = has_cpuid_feature,
>> +		ARM64_CPUID_FIELDS(ID_AA64DFR0_EL1, HPMN0, IMP)
>> +	},
>>   #ifdef CONFIG_ARM64_SME
>>   	{
>>   		.desc = "Scalable Matrix Extension",
>> diff --git a/arch/arm64/tools/cpucaps b/arch/arm64/tools/cpucaps
>> index 10effd4cff6b..5b196ba21629 100644
>> --- a/arch/arm64/tools/cpucaps
>> +++ b/arch/arm64/tools/cpucaps
>> @@ -39,6 +39,7 @@ HAS_GIC_CPUIF_SYSREGS
>>   HAS_GIC_PRIO_MASKING
>>   HAS_GIC_PRIO_RELAXED_SYNC
>>   HAS_HCR_NV1
>> +HAS_HPMN0
>>   HAS_HCX
>>   HAS_LDAPR
>>   HAS_LPA2
>> diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
>> index 8a8cf6874298..d29742481754 100644
>> --- a/arch/arm64/tools/sysreg
>> +++ b/arch/arm64/tools/sysreg
>> @@ -1531,9 +1531,9 @@ EndEnum
>>   EndSysreg

>>   Sysreg	ID_AA64DFR0_EL1	3	0	0	5	0
>> -Enum	63:60	HPMN0
>> -	0b0000	UNPREDICTABLE
>> -	0b0001	DEF
>> +UnsignedEnum	63:60	HPMN0
>> +	0b0000	NI
>> +	0b0001	IMP
>>   EndEnum
>>   UnsignedEnum	59:56	ExtTrcBuff
>>   	0b0000	NI
>> --
>> 2.50.0.727.gbf7dc18ff4-goog


