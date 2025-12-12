Return-Path: <linux-kselftest+bounces-47537-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 43373CB9EB6
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Dec 2025 23:25:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D63BF3003102
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Dec 2025 22:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAB9F30BBA5;
	Fri, 12 Dec 2025 22:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4AJ7w4St"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oo1-f73.google.com (mail-oo1-f73.google.com [209.85.161.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9CA2288C30
	for <linux-kselftest@vger.kernel.org>; Fri, 12 Dec 2025 22:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765578348; cv=none; b=mljmBx/xSRP8j2VYTtLl3joP/T6REGpzn6JuAAQ28dzCMEiHxyomsy8En+JOhDUM4uMjrj01FwSc72pR835ReX5NzQweRg+Ll8ZQMf1hRDYqUKujO3hj6Dm7E7ARy9SriQKS4Nl3PrhgjZzyEV8xUwX7QQFyLiU4pzRzBTI6+Ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765578348; c=relaxed/simple;
	bh=kbOpl9/EBS6WJQv34DS3/RORKeG4Tpro9hVI1b+Wo+Q=;
	h=Date:In-Reply-To:Mime-Version:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=sCyuTMUKVnZ/4xlOtn+L6TL8NBpEmJ8mf7ouvyd+XCKgnRfOvB6y4hpIV8WthXhtmvgaNuMFdhwYJeSBLyflif1oPqSZF4mprq4Wz69NZlH1CaaT95yupQ08yB/ttS0KIFAukO3q3LpaL089T9LixGn14fzN6+HeOs8Ptw/P2Dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4AJ7w4St; arc=none smtp.client-ip=209.85.161.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Received: by mail-oo1-f73.google.com with SMTP id 006d021491bc7-65b325457e5so1435969eaf.1
        for <linux-kselftest@vger.kernel.org>; Fri, 12 Dec 2025 14:25:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1765578345; x=1766183145; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kTtJNntNErDibGFF1qkwnsYLDpE8m9agPY4m5XiEmeI=;
        b=4AJ7w4Stxn4zo4pMPqrbCVRQNLPO1IoxYFNjdYOIEhv/GaUdKFB5aPLyWzUZmClVBA
         Movgeh+WEAiAcvYylPxGti1NOiF9oJ9TAY85B4Vj42dcTmafBIvwVxebcc7a2jCRaY+G
         Uurdw5KNm7dVA4Yfh0m2pGPgdIoD+dcd/L2DlAghJ57t4WvmjZwTYuNo1akbwnFVQtiM
         DeJcWsNiJh3Ju+JpAw7MRN5/xUtXF30gohcgNOEOhHwLYOow1m23qVddchK9+unhrlna
         JxJ/nGLSLEIo+XilhFyO+u+9V9Q+sV5ueIjSuK7crWiz9X+SBPostV7bCk91W8SaHCvS
         ImzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765578345; x=1766183145;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kTtJNntNErDibGFF1qkwnsYLDpE8m9agPY4m5XiEmeI=;
        b=UAdTWjRjdDJZUd/xD6N9JJ+LUvWSCmRct+cUh/AOa2yoXhvysCh3MsbJhFIPxfCIqc
         hUQeX6bWJ0fywso2OoFl1ejIu2PZLrcF46blSji118L9jxmP91wzRWftl0seV+7ngcvp
         u6zko0oRow24eblEzi8hmHTr/XJakruF71cpcDlzSew5AdAIqZ6XkXts3tYel3wSxkUV
         4VtGgAXXzzfcKnEZxrkNwXDyy6PpwTzbpFk48KsOlmACMlC+5Aj3sPPn48VNYr4NutOU
         EOY0pXczyxrrPsiDnta+/tCRN+ED7A1PJgX4KZF4hdA5lljH424uiWDqJYeg1t7UGlKr
         Grew==
X-Forwarded-Encrypted: i=1; AJvYcCUInjzlk+pPglxWYcAHlp5NSXFOyJclPGd7mqn2fPa7Zkx+bJpHWc87kzl5Zw8JDW3ZmlMXasH6i6HDAE2sV38=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6sZXgQQ8tW5h9w9/sFt3kUEveSAqL60DDELqmYGmMleQiLdtd
	W5/xOqrwdiWyERZGtvFcDd1xPubB1HCbRR2dEgRLVb7Ops34mTreSIspRn7RiKs9OarXpz0tGFW
	xo8xSEfYJC9h/tS12SgirFvOOhA==
X-Google-Smtp-Source: AGHT+IGhwhSlHWOdHiYNzV9FksIu24P3urR9RfAnI9PHJHO/oofMWeWBwj21tpDMdRbsZ5qCySgnl+QY1Z9IQMTNWA==
X-Received: from ioyp8.prod.google.com ([2002:a05:6602:3048:b0:948:6160:f5b])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6820:a05:b0:659:9a49:8e64 with SMTP id 006d021491bc7-65b45253071mr1578654eaf.52.1765578344930;
 Fri, 12 Dec 2025 14:25:44 -0800 (PST)
Date: Fri, 12 Dec 2025 22:25:44 +0000
In-Reply-To: <aTidfRwYLYwTfmK_@kernel.org> (message from Oliver Upton on Tue,
 9 Dec 2025 14:06:53 -0800)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-ID: <gsntecoz2v87.fsf@coltonlewis-kvm.c.googlers.com>
Subject: Re: [PATCH v5 19/24] KVM: arm64: Implement lazy PMU context swaps
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

> On Tue, Dec 09, 2025 at 08:51:16PM +0000, Colton Lewis wrote:
>> +enum vcpu_pmu_register_access {
>> +	VCPU_PMU_ACCESS_UNSET,
>> +	VCPU_PMU_ACCESS_VIRTUAL,
>> +	VCPU_PMU_ACCESS_PHYSICAL,
>> +};

> This is confusing. Even when the guest is accessing registers directly
> on the CPU I'd still call that "hardware assisted virtualization" and
> not "physical".

It was what I thought described the access pattern. Do you have another
naming suggestion?

>> +#endif /* _ASM_ARM64_KVM_TYPES_H */
>> diff --git a/arch/arm64/kvm/debug.c b/arch/arm64/kvm/debug.c
>> index 0ab89c91e19cb..c2cf6b308ec60 100644
>> --- a/arch/arm64/kvm/debug.c
>> +++ b/arch/arm64/kvm/debug.c
>> @@ -34,7 +34,7 @@ static int cpu_has_spe(u64 dfr0)
>>    *  - Self-hosted Trace Filter controls (MDCR_EL2_TTRF)
>>    *  - Self-hosted Trace (MDCR_EL2_TTRF/MDCR_EL2_E2TB)
>>    */
>> -static void kvm_arm_setup_mdcr_el2(struct kvm_vcpu *vcpu)
>> +void kvm_arm_setup_mdcr_el2(struct kvm_vcpu *vcpu)
>>   {
>>   	int hpmn = kvm_pmu_hpmn(vcpu);

>> diff --git a/arch/arm64/kvm/hyp/include/hyp/switch.h  
>> b/arch/arm64/kvm/hyp/include/hyp/switch.h
>> index bde79ec1a1836..ea288a712bb5d 100644
>> --- a/arch/arm64/kvm/hyp/include/hyp/switch.h
>> +++ b/arch/arm64/kvm/hyp/include/hyp/switch.h
>> @@ -963,6 +963,8 @@ static bool kvm_hyp_handle_pmu_regs(struct kvm_vcpu  
>> *vcpu)
>>   	if (ret)
>>   		__kvm_skip_instr(vcpu);

>> +	kvm_pmu_set_physical_access(vcpu);
>> +
>>   	return ret;
>>   }

>> diff --git a/arch/arm64/kvm/pmu-direct.c b/arch/arm64/kvm/pmu-direct.c
>> index 8d0d6d1a0d851..c5767e2ebc651 100644
>> --- a/arch/arm64/kvm/pmu-direct.c
>> +++ b/arch/arm64/kvm/pmu-direct.c
>> @@ -73,6 +73,7 @@ bool kvm_vcpu_pmu_use_fgt(struct kvm_vcpu *vcpu)
>>   	u8 hpmn = vcpu->kvm->arch.nr_pmu_counters;

>>   	return kvm_vcpu_pmu_is_partitioned(vcpu) &&
>> +		vcpu->arch.pmu.access == VCPU_PMU_ACCESS_PHYSICAL &&
>>   		cpus_have_final_cap(ARM64_HAS_FGT) &&
>>   		(hpmn != 0 || cpus_have_final_cap(ARM64_HAS_HPMN0));
>>   }
>> @@ -92,6 +93,26 @@ u64 kvm_pmu_fgt2_bits(void)
>>   		| HDFGRTR2_EL2_nPMICNTR_EL0;
>>   }

>> +/**
>> + * kvm_pmu_set_physical_access()
>> + * @vcpu: Pointer to vcpu struct
>> + *
>> + * Reconfigure the guest for physical access of PMU hardware if
>> + * allowed. This means reconfiguring mdcr_el2 and loading the vCPU
>> + * state onto hardware.
>> + *
>> + */
>> +
>> +void kvm_pmu_set_physical_access(struct kvm_vcpu *vcpu)
>> +{
>> +	if (kvm_vcpu_pmu_is_partitioned(vcpu)
>> +	    && vcpu->arch.pmu.access == VCPU_PMU_ACCESS_VIRTUAL) {
>> +		vcpu->arch.pmu.access = VCPU_PMU_ACCESS_PHYSICAL;
>> +		kvm_arm_setup_mdcr_el2(vcpu);
>> +		kvm_pmu_load(vcpu);
>> +	}

> It isn't immediately obvious how this guards against preemption.

> Also, the general approach for these context-loading situations is to do
> a full load/put on the vCPU rather than a directed load.

Understood. Will fix.

>> +static void kvm_pmu_register_init(struct kvm_vcpu *vcpu)
>> +{
>> +	if (vcpu->arch.pmu.access == VCPU_PMU_ACCESS_UNSET)
>> +		vcpu->arch.pmu.access = VCPU_PMU_ACCESS_VIRTUAL;

> This is confusing. The zero value of the enum should be consistent with
> the "unloaded" state.

That's the way I initially wrote it but it had a problem on a different
kernel. I forget the exact issue, but I never saw the problem on
upstream so I'm happy to go back to it.

>> diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
>> index f2ae761625a66..d73218706b834 100644
>> --- a/arch/arm64/kvm/sys_regs.c
>> +++ b/arch/arm64/kvm/sys_regs.c
>> @@ -1197,6 +1197,8 @@ static bool access_pmu_evtyper(struct kvm_vcpu  
>> *vcpu, struct sys_reg_params *p,
>>   		p->regval = __vcpu_sys_reg(vcpu, reg);
>>   	}

>> +	kvm_pmu_set_physical_access(vcpu);
>> +
>>   	return true;
>>   }

>> @@ -1302,6 +1304,8 @@ static bool access_pmovs(struct kvm_vcpu *vcpu,  
>> struct sys_reg_params *p,
>>   		p->regval = __vcpu_sys_reg(vcpu, PMOVSSET_EL0);
>>   	}

>> +	kvm_pmu_set_physical_access(vcpu);
>> +
>>   	return true;
>>   }

> Aren't there a ton of other registers the guest may access before
> these two? Having generic PMU register accessors would allow you to
> manage residence of PMU registers from a single spot.

Yes but these are the only two that use the old trap handlers. I also
call set_physical_access from my fast path handler that handles all the
other registers when partitioned.

Agree on having some generic accessors which you mention in an earlier
patch.

