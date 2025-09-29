Return-Path: <linux-kselftest+bounces-42577-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B341BA9751
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Sep 2025 15:59:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11B1C3B2E9B
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Sep 2025 13:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BF363090F5;
	Mon, 29 Sep 2025 13:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SzMTMIUI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF123090E8
	for <linux-kselftest@vger.kernel.org>; Mon, 29 Sep 2025 13:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759154381; cv=none; b=KHiLHdm3bYduKSHqYKrLFbH84oVqmsEUzBF7LrIo1pA0FWCfeEF6ZYmp15f+7Cze8K7vQoQSoMisBVfRyc7RSiEkfAZ4ViRHA3KIeRbjKh8okYVUItaFxpMQo1vi1YFgIwDUXRBrzA2qnPDE1ID6rnhCxN7Y1dnw/t5ekXZaUJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759154381; c=relaxed/simple;
	bh=7uitIzQ1GatOj3aC/wPhGEU9p9oB81Xc0jNEY+fNKWc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RbKUMCUya+9VUXBqcbcOK6Lnb7nDHN8/Ss92IaL3YobensGi4AD1ajzFCgt33of4VPj9lIeFiuIvVrcrPnbSJYevOON06RhxSieeIyXuZCm8ejKPYwouN7hij80IS2uy8jMsww8QwIuIomTKsqvwfXeLOjQQagLUR5ITO7nZr+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SzMTMIUI; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3ee155e0c08so2500576f8f.2
        for <linux-kselftest@vger.kernel.org>; Mon, 29 Sep 2025 06:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759154378; x=1759759178; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ipfI8eVx3bzgfWjoq31uPWRXd4Smibc+RtoSzpX+z2A=;
        b=SzMTMIUILcV4p5Dzp5abWBb3KdTMobSaXTIJ1eOtbZd+YHcJVCt17QBDJrlPd0uYf5
         Aa/zOoFTlW0L1Zzssc4U5hZovWfp+yZ/dzEfIJBvgDWpOXd/exNpUzf6pABMnUQ+s0Bb
         B0WDgyZiFTKWNaLnJiRayvlAG4c4ARcDBs9725UwIvLh3khyeuhqdBaVUsv1a7FFwJe1
         I5Spb7dz8kvoX2H+1rHG4n8QiW3J57hok55RRiCSQ8zOb7ki/tncIGW8BXokwemvPzZv
         eekbBP841OvEeN62U4oqkKQTu1IQBd/zYsHisLp7fCLLs4skUghYBe1W1chXPw7iJSVf
         RNMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759154378; x=1759759178;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ipfI8eVx3bzgfWjoq31uPWRXd4Smibc+RtoSzpX+z2A=;
        b=UlRAYjFoHMXkedqRYNnT0SqCei4V9ALX3A9+F0fKvroe9OD5oM/fR6QrtmKEJrjoJ0
         gAV7QmZpOifzLEBp6911CXg2X3jgPdoS61FFaZ3cLNBG45YYMEHGArJE3wln3N5vp6MJ
         AxXzR3hq8AAlfFqe/g1vurGE3LzZwfx4gIhAe6m3ErB5Qw/8bJvelutW8MBLRl7NcyG9
         H2M4ivGjOkn+OhRaXnpnW7rZQNJ0Ng28AtR6FMdhn1A9KFf+KhtTKzzqPMePHirFDpP5
         HmZThAyLwLq96RjqXsQFXOMEmPyz9bs/IdjXPGSs6/Ynfh8XdWU+HgxbH5Gu5PLyKwyP
         mJwA==
X-Forwarded-Encrypted: i=1; AJvYcCUDsr6M0nI1Asc4fGvGenprBxDC6Ttg/88xwE7iWo9WedgdmwL1F3vSYJm2hMk/GYb0RZ+9s6nQ4jRK4+fV4oc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1lVrUPKMJOQVsVCPGyJO+rY97u/xpnO6/0oY4qOniWY7KCKwk
	sGwlfa5tc27sDbmrq/nsOsca7r764cc4IONgixOqPP8z+/MZhcYubBv3
X-Gm-Gg: ASbGncv6QX3qmBl8ILiAliC+TnOChG2Ubdvwe+PffssuuwEAlzGjio+TvtOfSR+NQEU
	fjG2wKCbIDm5eUO72zt5HH8YEi9JMjEiXc8b8CeQ6diRWyfOUgOk5YujIEM1eWFjlkv7XIoFhGg
	BfJqeJ74WtvRAztuDno6+vs7u6CxVpljwwEASe053/hf9Jt6G8gh0odqCDZWMS8mmhh2NnqIwHH
	y+IcGW1GrJf04FPAMgluzE8gtA6uO4zvTPIlYzCa2eN2+USUKrdhyeOoj5GRwJwkagsi2LsMHF0
	tVqTJwGEDqYP8qc69RaaI+2WbnxuOEot6LpIXb2XaVulbBlRUHbwTWHG/UXUWsCjgtHY1TQFfRB
	AG5FYXwROij70XI25jR/2g4dFinhRTYKlPU4kTcY=
X-Google-Smtp-Source: AGHT+IGmk8eIupNHH6e8ZECR90n/BecDA3d0fPOnthyKhQCMVja8jB69/O5wl6BImeD5SJG0fNGoiA==
X-Received: by 2002:a05:6000:2203:b0:3ea:63d:44ca with SMTP id ffacd0b85a97d-40e4adceb15mr13337551f8f.32.1759154377256;
        Mon, 29 Sep 2025 06:59:37 -0700 (PDT)
Received: from [10.24.66.14] ([15.248.2.234])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fc88b0779sm18227650f8f.58.2025.09.29.06.59.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Sep 2025 06:59:37 -0700 (PDT)
Message-ID: <7d109638-3d26-443a-b24d-eb7a0059b80f@gmail.com>
Date: Mon, 29 Sep 2025 14:59:35 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] KVM: arm64: Add pre_fault_memory implementation
Content-Language: en-GB
To: Oliver Upton <oliver.upton@linux.dev>
Cc: maz@kernel.org, pbonzini@redhat.com, joey.gouly@arm.com,
 suzuki.poulose@arm.com, yuzenghui@huawei.com, catalin.marinas@arm.com,
 will@kernel.org, shuah@kernel.org, linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, isaku.yamahata@intel.com,
 roypat@amazon.co.uk, kalyazin@amazon.co.uk, jackabt@amazon.com
References: <20250911134648.58945-1-jackabt.amazon@gmail.com>
 <20250911134648.58945-4-jackabt.amazon@gmail.com>
 <aMMYKqWsAZ4y0WI7@linux.dev>
From: "Thomson, Jack" <jackabt.amazon@gmail.com>
In-Reply-To: <aMMYKqWsAZ4y0WI7@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Oliver,

Thanks for reviewing!

On 11/09/2025 7:42 pm, Oliver Upton wrote:
> On Thu, Sep 11, 2025 at 02:46:45PM +0100, Jack Thomson wrote:
>> @@ -1607,7 +1611,7 @@ static int __user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
>>   			    struct kvm_s2_trans *nested,
>>   			    struct kvm_memory_slot *memslot,
>>   			    long *page_size, unsigned long hva,
>> -			    bool fault_is_perm)
>> +			    bool fault_is_perm, bool pre_fault)
>>   {
>>   	int ret = 0;
>>   	bool topup_memcache;
>> @@ -1631,10 +1635,13 @@ static int __user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
>>   	vm_flags_t vm_flags;
>>   	enum kvm_pgtable_walk_flags flags = KVM_PGTABLE_WALK_MEMABORT_FLAGS;
>>   
>> +	if (pre_fault)
>> +		flags |= KVM_PGTABLE_WALK_PRE_FAULT;
>> +
>>   	if (fault_is_perm)
>>   		fault_granule = kvm_vcpu_trap_get_perm_fault_granule(vcpu);
>> -	write_fault = kvm_is_write_fault(vcpu);
>> -	exec_fault = kvm_vcpu_trap_is_exec_fault(vcpu);
>> +	write_fault = !pre_fault && kvm_is_write_fault(vcpu);
>> +	exec_fault = !pre_fault && kvm_vcpu_trap_is_exec_fault(vcpu);
> 
> I'm not a fan of this. While user_mem_abort() is already a sloppy mess,
> one thing we could reliably assume is the presence of a valid fault
> context. Now we need to remember to special-case our interpretation of a
> fault on whether or not we're getting invoked for a pre-fault.
> 
> I'd rather see the pre-fault infrastructure compose a synthetic fault
> context (HPFAR_EL2, ESR_EL2, etc.). It places the complexity where it
> belongs and the rest of the abort handling code should 'just work'.
> 

Agreed, it looks much better with the synthetic abort. Is this the
approach you had in mind?

+long kvm_arch_vcpu_pre_fault_memory(struct kvm_vcpu *vcpu,
+				    struct kvm_pre_fault_memory *range)
+{
+	int ret, idx;
+	hva_t hva;
+	phys_addr_t end;
+	u64 esr, hpfar;
+	struct kvm_memory_slot *memslot;
+	struct kvm_vcpu_fault_info *fault_info;
+
+	long page_size = PAGE_SIZE;
+	phys_addr_t ipa = range->gpa;
+	gfn_t gfn = gpa_to_gfn(range->gpa);
+
+	idx = srcu_read_lock(&vcpu->kvm->srcu);
+
+	if (ipa >= kvm_phys_size(vcpu->arch.hw_mmu)) {
+		ret = -ENOENT;
+		goto out_unlock;
+	}
+
+	memslot = gfn_to_memslot(vcpu->kvm, gfn);
+	if (!memslot) {
+		ret = -ENOENT;
+		goto out_unlock;
+	}
+
+	fault_info = &vcpu->arch.fault;
+
+	esr = fault_info->esr_el2;
+	hpfar = fault_info->hpfar_el2;
+
+	fault_info->esr_el2 = ESR_ELx_FSC_ACCESS_L(KVM_PGTABLE_LAST_LEVEL);
+	fault_info->hpfar_el2 = HPFAR_EL2_NS |
+		((ipa >> (12 - HPFAR_EL2_FIPA_SHIFT)) & HPFAR_EL2_FIPA_MASK);
+
+	if (kvm_slot_has_gmem(memslot)) {
+		ret = gmem_abort(vcpu, ipa, NULL, memslot, false);
+	} else {
+		hva = gfn_to_hva_memslot_prot(memslot, gfn, NULL);
+		if (kvm_is_error_hva(hva)) {
+			ret = -EFAULT;
+			goto out;
+		}
+		ret = user_mem_abort(vcpu, ipa, NULL, memslot, &page_size, hva,
+				     false);
+	}
+
+	if (ret < 0)
+		goto out;
+
+	end = (range->gpa & ~(page_size - 1)) + page_size;
+	ret = min(range->size, end - range->gpa);
+
+out:
+	fault_info->esr_el2 = esr;
+	fault_info->hpfar_el2 = hpfar;
+out_unlock:
+	srcu_read_unlock(&vcpu->kvm->srcu, idx);
+	return ret;
+}

>> +long kvm_arch_vcpu_pre_fault_memory(struct kvm_vcpu *vcpu,
>> +				    struct kvm_pre_fault_memory *range)
>> +{
>> +	int r;
>> +	hva_t hva;
>> +	phys_addr_t end;
>> +	long page_size;
>> +	struct kvm_memory_slot *memslot;
>> +	phys_addr_t ipa = range->gpa;
>> +	gfn_t gfn = gpa_to_gfn(range->gpa);
>> +
>> +	while (true) {
>> +		page_size = PAGE_SIZE;
>> +		memslot = gfn_to_memslot(vcpu->kvm, gfn);
>> +		if (!memslot)
>> +			return -ENOENT;
>> +
>> +		if (kvm_slot_has_gmem(memslot)) {
>> +			r = __gmem_abort(vcpu, ipa, NULL, memslot, false, true);
>> +		} else {
>> +			hva = gfn_to_hva_memslot_prot(memslot, gfn, NULL);
>> +			if (kvm_is_error_hva(hva))
>> +				return -EFAULT;
>> +			r = __user_mem_abort(vcpu, ipa, NULL, memslot, &page_size, hva, false,
>> +					     true);
>> +		}
>> +
>> +		if (r != -EAGAIN)
>> +			break;
>> +
>> +		if (signal_pending(current))
>> +			return -EINTR;
>> +
>> +		if (kvm_check_request(KVM_REQ_VM_DEAD, vcpu))
>> +			return -EIO;
>> +
>> +		cond_resched();
>> +	};
> 
> Why do we need another retry loop? Looks like we've already got one in
> the arch-generic code.
>

Good point thanks, I've removed that now.

> 
> Thanks,
> Oliver

Thanks,
Jack

