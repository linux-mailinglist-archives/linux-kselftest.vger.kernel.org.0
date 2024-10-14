Return-Path: <linux-kselftest+bounces-19669-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E8C099D5D4
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Oct 2024 19:51:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 724351C22EC8
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Oct 2024 17:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BCBE1C728E;
	Mon, 14 Oct 2024 17:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=nik.wipper@gmx.de header.b="B4DX2fGQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 702B41B85C0;
	Mon, 14 Oct 2024 17:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728928266; cv=none; b=NGK4IaSfOceTMO9fnVOsTD4PaKgUHzPeMQuNRMWET9WUb+6Rxu5JZO6/lLVSCBv5Mz01T5MItoadQg80cXXYkjpbr+ts0C4EIAWkzyA4t6ZVSdFlW8GVYz5td8xXxDoN3j71DRYzTLVCLrr/VvhjAwrEw/oUczlUM2gIzPPc3gU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728928266; c=relaxed/simple;
	bh=I0X5zGKGyx41/TP8U0WUHo+BK84LLbMN01eqB8kLUkI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YgIbfTDJ6REGbr8mBakgfdHzMiAq9gdQEFUH2FvCkY45eEdBpluCRyUP9nyZNowfPXhYRRKq1B+kaWFaiBqF9gShthrPeytX8kT2KXH5wpIHFQ1PXA1U4j0tr+zbyt2lpSxsbmOgefidNV+tNDKGneSvN02cgeHD0wSiSTEn/Xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=nik.wipper@gmx.de header.b=B4DX2fGQ; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1728928220; x=1729533020; i=nik.wipper@gmx.de;
	bh=a+RE15GmokJYWbGRjD6Dzb3yHSQxcePvP91ijU9kPxM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=B4DX2fGQmMAmESqj/a76U78yAL+pLs3kl12YucIEka4+6e1yoHQXjqP8tVaWXlsX
	 0j5ZdsVx+rmirDeh6YFgHOwDsaqqxAQZzfo9G9b6G3w8cCHX2BLUHwN56RQ9UShPS
	 /lU1qbF6DEOMFOxROM9BT0CtOkp8hL8v3R4KRVF9dxu8NFWlJAUDZXkfI9RZxL1ub
	 PA4iMdECzQXOPJY/B8lSBwAnzfL+/uFoXV3p6ctUxNqhHVTFBl0BtmDlj8AT7b9Bt
	 N8D+qwxHtrGGrkYJGa1qXyiuqFJLPthF5xXO/kBGyvfinWwIoYCtEqC9b5CMCMgND
	 42xMuGlEKabHhGIPrg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.178.21] ([31.17.149.238]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MOA3F-1tJpjO3geP-00KbpD; Mon, 14
 Oct 2024 19:50:19 +0200
Message-ID: <9ef935db-459a-4738-ab9a-4bd08828cb60@gmx.de>
Date: Mon, 14 Oct 2024 19:50:17 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] KVM: x86: Implement Hyper-V's vCPU suspended state
To: Vitaly Kuznetsov <vkuznets@redhat.com>, Nikolas Wipper <nikwip@amazon.de>
Cc: Nicolas Saenz Julienne <nsaenz@amazon.com>,
 Alexander Graf <graf@amazon.de>, James Gowans <jgowans@amazon.com>,
 nh-open-source@amazon.com, Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org, x86@kernel.org, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20241004140810.34231-1-nikwip@amazon.de>
 <20241004140810.34231-3-nikwip@amazon.de> <875xq0gws8.fsf@redhat.com>
Content-Language: en-US
From: Nikolas Wipper <nik.wipper@gmx.de>
In-Reply-To: <875xq0gws8.fsf@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/vySEODhYTiiFir1ArY1mTcWrbhUiDrb1NaTr0ui5GF4cSuU9Z8
 oQOCEpj1ugeh3L/EdX6ebrLdLaWgtNOxWQAqPwOAla70ur+CLzh1221eTDmxpLXy89QKMxW
 kL+Obpe47DAIqV3bI9r96cvhQZ/Oj7ULPOGcVySmGeGA2HCUBSX/4NBoOotZrLt79LmaU+k
 FsyzEk+mxGkERcQi4Y2qQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:cRrrVgdmKt4=;2xNp32HNEcGdz3sDtwm+XdtN7jn
 PVj0Jea1rouhXFUlWEATGqYYbCl9LQVZiGIiFDgXeTnBOtNLGxiJGbwu8GocRCAatspwstS5j
 /JbTQyJrTO5q8EQ5iRnMcdzwZPatGViA0VxY7ARVOZjc2l22Uwo8zQ8+pMSlkONICEwJ37/bT
 I4E4DKFQgdJX2NYLXsCWVziSutD7F3tWQMQPPz9khDVNjX/zCqyGI2uBxAglFfq87l0iTsCq+
 ToHS3/RjgE3CyLp3vZoCg/5p7NDEzkj/myPgzXh+klBdhQVgo0dRZqpadqx5+Gnty/JP9fanH
 vzPsfaN5ajY/giT0agYVqLqPfehzmZZb9uciQ/MfAlpcvjNlXbe4Z8AssbBUT4WfUjf/Aruvw
 MdjMBv3i58JqpKYZbfuieccf+82f8n8vOVD19ypCvkDaD9DVxUHypFr5EvQlAH7smXfMHGsF0
 MjZXijMid5KbaKMJ9gC89jXqyiaw1hOyMwHdS/19QvzSXvBpTnlKgGbyJBhWViwVdlXBCyhCE
 HH2ginj1vWeR/iCrKhYxcDEMvoTOU924sFRuFktFMZy4OBH+GOMe830WFTlaheES4AE1IPEPI
 WYcsYY6wU5+JakhSGrOvKmXmWm7eD1ReV6wCxF+Y9Od+BaMyp+3Gbc453CWIbH7t36Q3I/cG0
 tyyJ2ZyL/wDVbPpBodb45L9rH/K8vhrSqDif918pErm4waPBkWpqjHTsTdnJ8WBfIPsu0q3hr
 LSBy4rWR3aDmV1ddxfCBmW/FbKi3Q5YI9T+Lh9xBf88YbVLMcz36xk/O4zkqTnRxU3w8gK9VI
 2IB6A+/g+N5Eal6B8fSG3cMsTG5kSg4jSoExX4B8t4A6I=

On 10.10.24 10:57, Vitaly Kuznetsov wrote:
> Nikolas Wipper <nikwip@amazon.de> writes:
>> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm=
_host.h
>> index 46e0a466d7fb..7571ac578884 100644
>> --- a/arch/x86/include/asm/kvm_host.h
>> +++ b/arch/x86/include/asm/kvm_host.h
>> @@ -695,6 +695,9 @@ struct kvm_vcpu_hv {
>>  		u64 vm_id;
>>  		u32 vp_id;
>>  	} nested;
>> +
>> +	bool suspended;
>> +	int waiting_on;
>
> I don't quite understand why we need 'suspended' at all. Isn't it always
> suspended when 'waiting_on !=3D -1'? I can see we always update these tw=
o
> in pair.
>

This is mainly for future proofing the implementation. You are right, this
is currently not required, but it's nice to have a single flags, so that
when the suspended state is used in a different context, the whole logic
surrounding it still works.

> Also, I would suggest we use a more descriptive
> name. 'waiting_on_vcpu_id', for example.
>

Sounds good.

>>  };
>>
>>  struct kvm_hypervisor_cpuid {
>> diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
>> index 4f0a94346d00..6e7941ed25ae 100644
>> --- a/arch/x86/kvm/hyperv.c
>> +++ b/arch/x86/kvm/hyperv.c
>> @@ -971,6 +971,7 @@ int kvm_hv_vcpu_init(struct kvm_vcpu *vcpu)
>>
>>  	vcpu->arch.hyperv =3D hv_vcpu;
>>  	hv_vcpu->vcpu =3D vcpu;
>> +	hv_vcpu->waiting_on =3D -1;
>>
>>  	synic_init(&hv_vcpu->synic);
>>
>> @@ -2915,3 +2916,32 @@ int kvm_get_hv_cpuid(struct kvm_vcpu *vcpu, stru=
ct kvm_cpuid2 *cpuid,
>>
>>  	return 0;
>>  }
>> +
>> +void kvm_hv_vcpu_suspend_tlb_flush(struct kvm_vcpu *vcpu, int vcpu_id)
>
> Can we make parameter's name 'waiting_on_vcpu_id' as well? Because as-is
> I'm getting confused which CPU of these two is actually getting
> suspended)
>

Yup, that would certainly help readability.

> Also, why do we need '_tlb_flush' in the name? The mechanism seems to be
> fairly generic, it's just that we use it for TLB flushes.
>

The 'waiting_on' part is TLB flushing specific.

>> +{
>> +	/* waiting_on's store should happen before suspended's */
>> +	WRITE_ONCE(vcpu->arch.hyperv->waiting_on, vcpu_id);
>> +	WRITE_ONCE(vcpu->arch.hyperv->suspended, true);
>> +}
>> +
>> +void kvm_hv_vcpu_unsuspend_tlb_flush(struct kvm_vcpu *vcpu)
>
> And here someone may expect this means 'unsuspend vcpu' but in reality
> this means 'unsuspend all vCPUs which are waiting on 'vcpu'). I guess we
> need a rename. How about
>
> void kvm_hv_unsuspend_vcpus(struct kvm_vcpu *waiting_on_vcpu)
>
> ?
>

Also sounds good.

>> +{
>> +	DECLARE_BITMAP(vcpu_mask, KVM_MAX_VCPUS);
>> +	struct kvm_vcpu_hv *vcpu_hv;
>> +	struct kvm_vcpu *v;
>> +	unsigned long i;
>> +
>> +	kvm_for_each_vcpu(i, v, vcpu->kvm) {
>> +		vcpu_hv =3D to_hv_vcpu(v);
>> +
>> +		if (kvm_hv_vcpu_suspended(v) &&
>> +		    READ_ONCE(vcpu_hv->waiting_on) =3D=3D vcpu->vcpu_id) {
>> +			/* waiting_on's store should happen before suspended's */
>> +			WRITE_ONCE(v->arch.hyperv->waiting_on, -1);
>> +			WRITE_ONCE(v->arch.hyperv->suspended, false);
>> +			__set_bit(i, vcpu_mask);
>> +		}
>> +	}
>> +
>> +	kvm_make_vcpus_request_mask(vcpu->kvm, KVM_REQ_EVENT, vcpu_mask);
>> +}
>> diff --git a/arch/x86/kvm/hyperv.h b/arch/x86/kvm/hyperv.h
>> index 913bfc96959c..a55832cea221 100644
>> --- a/arch/x86/kvm/hyperv.h
>> +++ b/arch/x86/kvm/hyperv.h
>> @@ -265,6 +265,15 @@ static inline void kvm_hv_nested_transtion_tlb_flu=
sh(struct kvm_vcpu *vcpu,
>>  }
>>
>>  int kvm_hv_vcpu_flush_tlb(struct kvm_vcpu *vcpu);
>> +
>> +static inline bool kvm_hv_vcpu_suspended(struct kvm_vcpu *vcpu)
>> +{
>> +	return vcpu->arch.hyperv_enabled &&
>> +	       READ_ONCE(vcpu->arch.hyperv->suspended);
>
> I don't think READ_ONCE() means anything here, does it?
>

It does prevent compiler optimisations and is actually required[1]. Also
it makes clear that this variable is shared, and may be accessed from
remote CPUs.

[1] https://www.open-std.org/jtc1/sc22/wg21/docs/papers/2018/p0124r6.html#=
Variable%20Access

Nikolas

