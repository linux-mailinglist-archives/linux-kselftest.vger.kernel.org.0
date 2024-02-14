Return-Path: <linux-kselftest+bounces-4653-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAE5E854EA2
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Feb 2024 17:36:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFE061C2760A
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Feb 2024 16:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C8E160ED7;
	Wed, 14 Feb 2024 16:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jKILbWpU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D02604BC;
	Wed, 14 Feb 2024 16:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707928414; cv=none; b=geIvp4g49EHkgjbFIq7I3TCN7fQJp04SZO0sTC0ryHFdpdJRirETPBrmVlP8ovUOYRLXTBHES84zA/gUNwFUxmQiNiKHfvcY8ZXtTWSjyMtjTIIGaRGPUvcfhzOgymQiEzaCW1OqjzpoSNrvogAjELl2p+mDgiLdZu4VKUDaR3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707928414; c=relaxed/simple;
	bh=JH+cCf/L0R21P3qjQ9lpmYR84KhT0v2So1FyzNIN9DQ=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=rN6ZBSVgtb8UxmEyxOr8YGUJFKlmppR+WTQNyjoRCen1fIChIDadH0pW+6G5pg88GXMyeuCrYVIvcxRAfHGqBPPI9v2omnc5rid+YrP3BTtDzcIjRmLxD42H1bRdV/bAdWpHUzLQnQ1skkhGjKzgWcDoBABH7m1sh04y3VoQy48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jKILbWpU; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-41166710058so22852195e9.3;
        Wed, 14 Feb 2024 08:33:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707928409; x=1708533209; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xA9EABobwKTY5WTafCAbuFXVa5wkz+rHS00hIhTaT6Q=;
        b=jKILbWpUthlzgPDrdKPolZRu7y/gqg0Pk6ksxAxK6gpsslK6ZG4QAFvABsAoAKxe78
         UjLZ2g9g+cBB/5HuYLbQnquicsOes3DZEX5B/o7rke1rXHYekagOH4w0lDT1/skc8Gzy
         US+E8znT3C3WO/xU9nRA8IQTr6dlPxpLS4jqoiXYE2dkj9NSQifPbGstUR5r5xQRpfyC
         K5kINcQ974UzpykO07rfcMnGShaS3Uvc9MvOo8vCHNY+ln46ImhSRHsdT4FGvMV9m7jn
         FJKcwTgotQtYmAcQY0xdd88Ptbxotf+IthDb4Pu86NGbNbARrh4xPBL47QOQuSf3IVIO
         gk+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707928409; x=1708533209;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xA9EABobwKTY5WTafCAbuFXVa5wkz+rHS00hIhTaT6Q=;
        b=kMeHW8FH6AaPyaR0vMye3NOmTUkhxve0cblA+a+BiLpCCQjLdf2BA9pdQtHkBtYHuj
         uCIyjgGmL5Ow7+JBtId9rrZ6CS+QbBR/5JwuEcHXOEZhGYEU4Lf2c82iY5nqzvjadH1H
         gYsBnjiBsHogojalTT1mnmmJEWeucwUgYd6yNNEUEzLFYYnPFrouKBXD05SOk2bR42+8
         /tMIgPRqj8YJc7KEg7lr6oHKYb5j45f8qsFNIvkD8D6N8EhMTa5eKT+zcGNgJqgAkAN1
         YD2AYOn76Ix7gkrrg8A1NvBbFTODJH6RS+ivYt4APqVNNapVRs5RudM08+u18aBzMoWE
         aMAQ==
X-Forwarded-Encrypted: i=1; AJvYcCUzbwVnCc8UyqzsWVsYnDINbX+jUkefrJEuM+yJaIvvqSi1g3o3ohjN9K3SQq/dvfCsSar8lfA9O6GFmzWwn8YUGsIqxrwVyT+ijT8JeO7wmOvfeTqKPny1Gv8fcN0DO8Ci/mG9WEs3bcMkZ9dA0TEYGfDTsNbOYZJ4fdNfLbhIBdRY+0ui8SoYdQhVRW1KgLXEsqUuu7libQx2sL58
X-Gm-Message-State: AOJu0Yy+x6SXxZ9Ovj01xNeLpbjO1YkPBT8xmUAV4Euq7Ls/vyJ33QSk
	dIzTkweKW8PsO9cjgZV4kuiPDmYGmMlSJZuNkmKSYDncDKEHjsJu
X-Google-Smtp-Source: AGHT+IEBanadPAfFGvqIf0HfCbAakOyTgirpAO17W29qLh4NiTlrBpf8fX9UiwhlBwikByK2EKlO+A==
X-Received: by 2002:a05:600c:5185:b0:411:f94b:379e with SMTP id fa5-20020a05600c518500b00411f94b379emr975945wmb.27.1707928409006;
        Wed, 14 Feb 2024 08:33:29 -0800 (PST)
Received: from [192.168.11.205] (54-240-197-228.amazon.com. [54.240.197.228])
        by smtp.gmail.com with ESMTPSA id hi11-20020a05600c534b00b00410dd253008sm2374505wmb.42.2024.02.14.08.33.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Feb 2024 08:33:28 -0800 (PST)
From: Paul Durrant <xadimgnik@gmail.com>
X-Google-Original-From: Paul Durrant <paul@xen.org>
Message-ID: <ca70f373-27eb-4586-95e6-e56fcafa5914@xen.org>
Date: Wed, 14 Feb 2024 16:33:14 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: paul@xen.org
Subject: Re: [PATCH v12 08/20] KVM: pfncache: allow a cache to be activated
 with a fixed (userspace) HVA
Content-Language: en-US
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 David Woodhouse <dwmw2@infradead.org>, Shuah Khan <shuah@kernel.org>,
 kvm@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Janosch Frank <frankja@linux.ibm.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>
References: <20240115125707.1183-1-paul@xen.org>
 <20240115125707.1183-9-paul@xen.org> <ZcMBDP6H5PRo5C2d@google.com>
 <9c542f39-959e-4ab1-94a5-39e049a30743@xen.org> <ZczoP_pfb4E3i8OO@google.com>
Organization: Xen Project
In-Reply-To: <ZczoP_pfb4E3i8OO@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14/02/2024 16:20, Sean Christopherson wrote:
> On Wed, Feb 14, 2024, Paul Durrant wrote:
>> On 07/02/2024 04:03, Sean Christopherson wrote:
>>> +s390 folks (question on kvm_is_error_gpa() for ya)
>>> But!  kvm_is_error_gpa() already exists, and it very, very sneakily does a memslot
>>> lookup and checks for a valid HVA.
>>>
>>> s390 people, any objection to renaming kvm_is_error_gpa() to something like
>>> kvm_gpa_has_memslot() or kvm_gpa_is_in_memslot()?  s390 is the only code that
>>> uses the existing helper.
>>>
>>> That would both to free up the name to pair with kvm_is_error_hva(), and would
>>> make it obvious what the helper does; I was quite surprised that "error" means
>>> "is covered by a valid memslot".
>>>
>>
>> Seemingly no response to this; I'll define a local helper rather than
>> re-working the open-coded tests to check against INVALID_GPA. This can then
>> be trivially replaced if need be.
> 
> How about we force a decision with a patch?  This should be easy enough to slot
> in, and I would be quite surprised if s390 is overly attached to kvm_is_error_gpa().
> 

Ok. I'll slot that in.

> From: Sean Christopherson <seanjc@google.com>
> Date: Wed, 14 Feb 2024 08:05:49 -0800
> Subject: [PATCH] KVM: s390: Refactor kvm_is_error_gpa() into
>   kvm_is_gpa_in_memslot()
> 
> Rename kvm_is_error_gpa() to kvm_is_gpa_in_memslot() and invert the
> polarity accordingly in order to (a) free up kvm_is_error_gpa() to match
> with kvm_is_error_{hva,page}(), and (b) to make it more obvious that the
> helper is doing a memslot lookup, i.e. not simply checking for INVALID_GPA.
> 
> No functional change intended.
> 
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>   arch/s390/kvm/diag.c     |  2 +-
>   arch/s390/kvm/gaccess.c  | 14 +++++++-------
>   arch/s390/kvm/kvm-s390.c |  4 ++--
>   arch/s390/kvm/priv.c     |  4 ++--
>   arch/s390/kvm/sigp.c     |  2 +-
>   include/linux/kvm_host.h |  4 ++--
>   6 files changed, 15 insertions(+), 15 deletions(-)
> 
> diff --git a/arch/s390/kvm/diag.c b/arch/s390/kvm/diag.c
> index 3c65b8258ae6..2a32438e09ce 100644
> --- a/arch/s390/kvm/diag.c
> +++ b/arch/s390/kvm/diag.c
> @@ -102,7 +102,7 @@ static int __diag_page_ref_service(struct kvm_vcpu *vcpu)
>   		    parm.token_addr & 7 || parm.zarch != 0x8000000000000000ULL)
>   			return kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
>   
> -		if (kvm_is_error_gpa(vcpu->kvm, parm.token_addr))
> +		if (!kvm_is_gpa_in_memslot(vcpu->kvm, parm.token_addr))
>   			return kvm_s390_inject_program_int(vcpu, PGM_ADDRESSING);
>   
>   		vcpu->arch.pfault_token = parm.token_addr;
> diff --git a/arch/s390/kvm/gaccess.c b/arch/s390/kvm/gaccess.c
> index 5bfcc50c1a68..415c99649e43 100644
> --- a/arch/s390/kvm/gaccess.c
> +++ b/arch/s390/kvm/gaccess.c
> @@ -664,7 +664,7 @@ static unsigned long guest_translate(struct kvm_vcpu *vcpu, unsigned long gva,
>   	case ASCE_TYPE_REGION1:	{
>   		union region1_table_entry rfte;
>   
> -		if (kvm_is_error_gpa(vcpu->kvm, ptr))
> +		if (!kvm_is_gpa_in_memslot(vcpu->kvm, ptr))
>   			return PGM_ADDRESSING;
>   		if (deref_table(vcpu->kvm, ptr, &rfte.val))
>   			return -EFAULT;
> @@ -682,7 +682,7 @@ static unsigned long guest_translate(struct kvm_vcpu *vcpu, unsigned long gva,
>   	case ASCE_TYPE_REGION2: {
>   		union region2_table_entry rste;
>   
> -		if (kvm_is_error_gpa(vcpu->kvm, ptr))
> +		if (!kvm_is_gpa_in_memslot(vcpu->kvm, ptr))
>   			return PGM_ADDRESSING;
>   		if (deref_table(vcpu->kvm, ptr, &rste.val))
>   			return -EFAULT;
> @@ -700,7 +700,7 @@ static unsigned long guest_translate(struct kvm_vcpu *vcpu, unsigned long gva,
>   	case ASCE_TYPE_REGION3: {
>   		union region3_table_entry rtte;
>   
> -		if (kvm_is_error_gpa(vcpu->kvm, ptr))
> +		if (!kvm_is_gpa_in_memslot(vcpu->kvm, ptr))
>   			return PGM_ADDRESSING;
>   		if (deref_table(vcpu->kvm, ptr, &rtte.val))
>   			return -EFAULT;
> @@ -728,7 +728,7 @@ static unsigned long guest_translate(struct kvm_vcpu *vcpu, unsigned long gva,
>   	case ASCE_TYPE_SEGMENT: {
>   		union segment_table_entry ste;
>   
> -		if (kvm_is_error_gpa(vcpu->kvm, ptr))
> +		if (!kvm_is_gpa_in_memslot(vcpu->kvm, ptr))
>   			return PGM_ADDRESSING;
>   		if (deref_table(vcpu->kvm, ptr, &ste.val))
>   			return -EFAULT;
> @@ -748,7 +748,7 @@ static unsigned long guest_translate(struct kvm_vcpu *vcpu, unsigned long gva,
>   		ptr = ste.fc0.pto * (PAGE_SIZE / 2) + vaddr.px * 8;
>   	}
>   	}
> -	if (kvm_is_error_gpa(vcpu->kvm, ptr))
> +	if (!kvm_is_gpa_in_memslot(vcpu->kvm, ptr))
>   		return PGM_ADDRESSING;
>   	if (deref_table(vcpu->kvm, ptr, &pte.val))
>   		return -EFAULT;
> @@ -770,7 +770,7 @@ static unsigned long guest_translate(struct kvm_vcpu *vcpu, unsigned long gva,
>   		*prot = PROT_TYPE_IEP;
>   		return PGM_PROTECTION;
>   	}
> -	if (kvm_is_error_gpa(vcpu->kvm, raddr.addr))
> +	if (!kvm_is_gpa_in_memslot(vcpu->kvm, raddr.addr))
>   		return PGM_ADDRESSING;
>   	*gpa = raddr.addr;
>   	return 0;
> @@ -957,7 +957,7 @@ static int guest_range_to_gpas(struct kvm_vcpu *vcpu, unsigned long ga, u8 ar,
>   				return rc;
>   		} else {
>   			gpa = kvm_s390_real_to_abs(vcpu, ga);
> -			if (kvm_is_error_gpa(vcpu->kvm, gpa)) {
> +			if (!kvm_is_gpa_in_memslot(vcpu->kvm, gpa)) {
>   				rc = PGM_ADDRESSING;
>   				prot = PROT_NONE;
>   			}
> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index ea63ac769889..3e5a1d7aa81a 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -2878,7 +2878,7 @@ static int kvm_s390_vm_mem_op_abs(struct kvm *kvm, struct kvm_s390_mem_op *mop)
>   
>   	srcu_idx = srcu_read_lock(&kvm->srcu);
>   
> -	if (kvm_is_error_gpa(kvm, mop->gaddr)) {
> +	if (!kvm_is_gpa_in_memslot(kvm, mop->gaddr)) {
>   		r = PGM_ADDRESSING;
>   		goto out_unlock;
>   	}
> @@ -2940,7 +2940,7 @@ static int kvm_s390_vm_mem_op_cmpxchg(struct kvm *kvm, struct kvm_s390_mem_op *m
>   
>   	srcu_idx = srcu_read_lock(&kvm->srcu);
>   
> -	if (kvm_is_error_gpa(kvm, mop->gaddr)) {
> +	if (!kvm_is_gpa_in_memslot(kvm, mop->gaddr)) {
>   		r = PGM_ADDRESSING;
>   		goto out_unlock;
>   	}
> diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
> index f875a404a0a0..1be19cc9d73c 100644
> --- a/arch/s390/kvm/priv.c
> +++ b/arch/s390/kvm/priv.c
> @@ -149,7 +149,7 @@ static int handle_set_prefix(struct kvm_vcpu *vcpu)
>   	 * first page, since address is 8k aligned and memory pieces are always
>   	 * at least 1MB aligned and have at least a size of 1MB.
>   	 */
> -	if (kvm_is_error_gpa(vcpu->kvm, address))
> +	if (!kvm_is_gpa_in_memslot(vcpu->kvm, address))
>   		return kvm_s390_inject_program_int(vcpu, PGM_ADDRESSING);
>   
>   	kvm_s390_set_prefix(vcpu, address);
> @@ -464,7 +464,7 @@ static int handle_test_block(struct kvm_vcpu *vcpu)
>   		return kvm_s390_inject_prog_irq(vcpu, &vcpu->arch.pgm);
>   	addr = kvm_s390_real_to_abs(vcpu, addr);
>   
> -	if (kvm_is_error_gpa(vcpu->kvm, addr))
> +	if (!kvm_is_gpa_in_memslot(vcpu->kvm, addr))
>   		return kvm_s390_inject_program_int(vcpu, PGM_ADDRESSING);
>   	/*
>   	 * We don't expect errors on modern systems, and do not care
> diff --git a/arch/s390/kvm/sigp.c b/arch/s390/kvm/sigp.c
> index d9696b530064..55c34cb35428 100644
> --- a/arch/s390/kvm/sigp.c
> +++ b/arch/s390/kvm/sigp.c
> @@ -172,7 +172,7 @@ static int __sigp_set_prefix(struct kvm_vcpu *vcpu, struct kvm_vcpu *dst_vcpu,
>   	 * first page, since address is 8k aligned and memory pieces are always
>   	 * at least 1MB aligned and have at least a size of 1MB.
>   	 */
> -	if (kvm_is_error_gpa(vcpu->kvm, irq.u.prefix.address)) {
> +	if (!kvm_is_gpa_in_memslot(vcpu->kvm, irq.u.prefix.address)) {
>   		*reg &= 0xffffffff00000000UL;
>   		*reg |= SIGP_STATUS_INVALID_PARAMETER;
>   		return SIGP_CC_STATUS_STORED;
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index 7e7fd25b09b3..d175b64488ec 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -1788,11 +1788,11 @@ static inline hpa_t pfn_to_hpa(kvm_pfn_t pfn)
>   	return (hpa_t)pfn << PAGE_SHIFT;
>   }
>   
> -static inline bool kvm_is_error_gpa(struct kvm *kvm, gpa_t gpa)
> +static inline bool kvm_is_gpa_in_memslot(struct kvm *kvm, gpa_t gpa)
>   {
>   	unsigned long hva = gfn_to_hva(kvm, gpa_to_gfn(gpa));
>   
> -	return kvm_is_error_hva(hva);
> +	return !kvm_is_error_hva(hva);
>   }
>   
>   enum kvm_stat_kind {
> 
> base-commit: 687d8f4c3dea0758afd748968d91288220bbe7e3


