Return-Path: <linux-kselftest+bounces-19893-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E35D9A15EB
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 00:54:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F00228500E
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Oct 2024 22:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B14D61D363F;
	Wed, 16 Oct 2024 22:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YIjPYUpy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF39F9C1;
	Wed, 16 Oct 2024 22:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729119237; cv=none; b=FeZC3VHTb7TDENPLluiZHXe1So2i+PgkxW2PtLCdiyKdzusCA5pGcUGjFkefJBYS7uUutZT//pC0Ash3Nc4K0Wlivo9iWiSau77PzQkLbMDz1RFp4naGdnAgfXfKkJphJfIy8WB2/oht/+aJi1LFGsa6+rND+RdM4G4B8E5xbik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729119237; c=relaxed/simple;
	bh=ZzgH6edon6973UkILs4hl4gx6y7cVOccuZjGRNkDDEk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JCG23tmXNkzS4p5BNe2to0KU9fAh+uahAOrj9rIvwyYnTfWSgVIQ9om38qHxM9BdDvPzcejsY2ai1xdHt/BhISLY3/oR/AipsIHbYmLB2Gqdie+6piT2dRlXY0pREi+6Ce/l1sk4Zg/8ynOkkJgr/4cvjaB/tVZd1GNeCH1KQ8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YIjPYUpy; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2fb3da341c9so3585551fa.2;
        Wed, 16 Oct 2024 15:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729119234; x=1729724034; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ga/CVT5W3GWQeZc8PFfRNTONvuq8BK53J6zZCa4F0Xs=;
        b=YIjPYUpyCjwqg4gakIEIeyWtUKJ1fFO39ixSLsg3t0gzYKwUMtS4JGES7yM2hjjG1m
         D28x9UTD2bLtrX1DZfc3fnpeEdWU07IOQAF8NmUOvkjsNIItoZVu8fZFlS31hEcp7tEi
         cT6C6k6xeFjFFLni1WUufpm7SnqV+LViOwchnmfFl46zeTQCCL99qEl/9AAnizk0kUv9
         W0Lk7Qfge5WNGj1Px3/qVlY2xS3m+jAY2f4DxlqKRlgJr1fa85KAHAPXBDQehO+msffJ
         lZSRYWshDxqxjr/Yg9R9WxmOwN0swCQPUQLzv4AVG/FNhUkPFEzJvWgdMOCWmce7a46N
         PHpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729119234; x=1729724034;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ga/CVT5W3GWQeZc8PFfRNTONvuq8BK53J6zZCa4F0Xs=;
        b=WmlnJ+vAsEmPTfUXen14nr7yrlD0wnip9kMnNptOsBHAV+GdfmVd1bQni72m442eQh
         6qkxxmubPUSEp1MgM+UCVmgORuRj6zTIT6ZXthQrL/eBAM6ojaDjBG7Py27DdiMHdm1G
         0N4lH1SlYWVwffF+Mg2i9JgzsumG4HMlELI5iBJ8c8AFe0Mdn/tb9MHW71FVUQkt55VT
         W1MJAQ7UkZpLTCQrwC9GfWXP4zg/4v61qzfZYQdo6+P94TZs/FevTgAOuBY2kQY6w84s
         PPd5TBW31GiCGDHmaY8Sc6j9J39xvZe6t/qeFez2MeAuMuuehr8pZKaKaSqDrvddIr7t
         KiHQ==
X-Forwarded-Encrypted: i=1; AJvYcCVaqSOdrPoc4nrJgEEhrXm8asHrSIe7Zlq1wFJZ1xVh7qKMu4C4nryTcElJmDhvNPZFYTPw8auxPcLjXv+M@vger.kernel.org, AJvYcCVdPSpxfRhT+geqjNMTFdmpjGnceeb36V7ffdgFjA5cZk+6C14+L36L4ZFTu3CqNPQ6g8I=@vger.kernel.org, AJvYcCXiNTu2USeSuUfEUhtCZOh6Vd+SU7HtKCU3q0DAmzts2X2jmEb3RDVP1Osq93LN0bO7/TGIzc8xXUTP6Gws4oCv@vger.kernel.org
X-Gm-Message-State: AOJu0YxD3SoX0qAkxRGbsFgjb8ZAiYYVmAP7ptW257HIJtWQZZHVyrJl
	f5hINK67t0InPkx7Xqbf7n0Gd2S1rHbqJgfZbbLtiJMJGvxrhq7/
X-Google-Smtp-Source: AGHT+IFwU20AfuL0IjVDwUZCfNCYMwzvYSydiUwCAC8r43c3D1HNNKNbO2HiS99yRrFvIESYEmG8dg==
X-Received: by 2002:a05:6512:694:b0:538:9e40:94b with SMTP id 2adb3069b0e04-539e54e82abmr7941535e87.19.1729119233501;
        Wed, 16 Oct 2024 15:53:53 -0700 (PDT)
Received: from ?IPV6:2a02:8012:e013:0:f52b:f2f2:1fbe:f0ae? ([2a02:8012:e013:0:f52b:f2f2:1fbe:f0ae])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43158c36b59sm6998575e9.7.2024.10.16.15.53.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Oct 2024 15:53:53 -0700 (PDT)
Message-ID: <2b954265-9ec0-4ee6-99c8-6ac080687d02@gmail.com>
Date: Wed, 16 Oct 2024 23:53:50 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] KVM: vmx, svm, mmu: Process MMIO during event
 delivery
To: Sean Christopherson <seanjc@google.com>, Ivan Orlov <iorlov@amazon.com>
Cc: bp@alien8.de, dave.hansen@linux.intel.com, mingo@redhat.com,
 pbonzini@redhat.com, shuah@kernel.org, tglx@linutronix.de, hpa@zytor.com,
 kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, x86@kernel.org, jalliste@amazon.com,
 nh-open-source@amazon.com, pdurrant@amazon.co.uk
References: <20240927161657.68110-1-iorlov@amazon.com>
 <20240927161657.68110-3-iorlov@amazon.com> <Zwm9TmRpNY6EeGKu@google.com>
Content-Language: en-US
From: Ivan Orlov <ivan.orlov0322@gmail.com>
In-Reply-To: <Zwm9TmRpNY6EeGKu@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/12/24 01:05, Sean Christopherson wrote:
> 
>> +			 * without VMM intervention, so return a corresponding internal error
>> +			 * instead (otherwise, vCPU will fall into infinite loop trying to
>> +			 * deliver the event again and again).
>> +			 */
>> +			if (error_code & PFERR_EVT_DELIVERY) {
> 
> Hmm, I'm 99% certain handling error in this location is wrong, and I'm also pretty
> sure it's unnecessary.  Or rather, the synthetic error code is unnecessary.
> 
> It's wrong because this path specifically handles "cached" MMIO, i.e. emulated
> MMIO that is triggered by a special MMIO SPTE.  KVM should punt to userspace on
> _any_ MMIO emulation.  KVM has gotten away with the flaw because SVM is completely
> broken, and VMX can always generate reserved EPTEs.  But with SVM, on CPUs with
> MAXPHYADDR=52, KVM can't generate a reserved #PF, i.e. can't do cached MMIO, and
> so I'm pretty sure your test would fail on those CPUs since they'll never come
> down this path.
> 

Ah, alright, I see... Probably, I need to test the next version with 
enable_mmio_caching=false as well.

> Heh, though I bet the introduction of RET_PF_WRITE_PROTECTED has regressed shadow
> paging on CPUs with PA52.
> 

Is it because it doesn't process write-protected gfn correctly if it is 
in MMIO range when mmio caching is disabled?

> Anyways, the synthetic PFERR flag is unnecessary because the information is readily
> available to {vmx,svm}_check_emulate_instruction().  Ha!  And EMULTYPE_WRITE_PF_TO_SP
> means vendor code can even precisely identify MMIO.
> 

Hmm, do you mean EMULTYPE_PF? It looks like EMULTYPE_WRITE_PF_TO_SP has 
nothing to do with MMIO...

I thought about processing the error in check_emulate_instruction as it 
seems logical, however I hadn't found a way to detect MMIO without page 
walking on SVM. I'll validate that EMULTYPE_PF gets set in all of the 
MMIO cases and move the handling into this function in V2 if it works.

> I think another X86EMUL_* return type is needed, but that's better than a synthetic
> #PF error code flag.
> 

If I understand correctly, you suggest returning this new 
X86EMUL_<something> code from {svm,vmx}_check_emulate_instruction and 
process it in the common code, right? I agree that it's much better than 
handling the error in MMU code. We are gonna return this return type 
from vendor code and handle it in the common code this way, which is neat!

>>   
>> -	/*
>> -	 * Note:
>> -	 * Do not try to fix EXIT_REASON_EPT_MISCONFIG if it caused by
>> -	 * delivery event since it indicates guest is accessing MMIO.
>> -	 * The vm-exit can be triggered again after return to guest that
>> -	 * will cause infinite loop.
>> -	 */
>>   	if ((vectoring_info & VECTORING_INFO_VALID_MASK) &&
>>   	    (exit_reason.basic != EXIT_REASON_EXCEPTION_NMI &&
>>   	     exit_reason.basic != EXIT_REASON_EPT_VIOLATION &&
>>   	     exit_reason.basic != EXIT_REASON_PML_FULL &&
>>   	     exit_reason.basic != EXIT_REASON_APIC_ACCESS &&
>>   	     exit_reason.basic != EXIT_REASON_TASK_SWITCH &&
>> -	     exit_reason.basic != EXIT_REASON_NOTIFY)) {
>> +	     exit_reason.basic != EXIT_REASON_NOTIFY &&
>> +	     exit_reason.basic != EXIT_REASON_EPT_MISCONFIG)) {
> 
> Changing the behavior of EPT_MISCONFIG belongs in a separate commit.
> 

I will extract the vmx-specific changes into separate commit in V2, thanks!

> Huh, and that's technically a bug fix.  If userspace _creates_ a memslot, KVM
> doesn't eagerly zap MMIO SPTEs and instead relies on vcpu_match_mmio_gen() to
> force kvm_mmu_page_fault() down the actual page fault path.  If the guest somehow
> manages to generate an access to the new page while vectoring an event, KVM will
> spuriously exit to userspace instead of trying to fault-in the new page.
> 
> It's _ridiculously_ contrived, but technically a bug.
> 

That's amazing, I finally introduced an unintentional bugfix (usually 
it's other way around) :D

> Ugh, and the manual call to vmx_check_emulate_instruction() in handle_ept_misconfig()
> is similarly flawed, though encountering that is even more contrived as that only
> affects accesses from SGX enclaves.
> 
> Hmm, and looking at all of this, SVM doesn't take advantage of KVM_FAST_MMIO_BUS.
> Unless I'm forgetting some fundamental incompatibility, SVM can do fast MMIO so
> long as next_rip is valid.
> 
> Anyways, no need to deal with vmx_check_emulate_instruction() or fast MMIO, I'll
> tackle that in a separate series.  But for this series, please do the EPT misconfig
> in a separate patch from fixing SVM.  E.g. extract the helper, convert VMX to the
> new flow, and then teach SVM to do the same.
> 

Hmm, implementing KVM_FAST_MMIO_BUS for SVM sounds like an interesting 
thing to do, please let me know if I could help. By the way, why can't 
we move the call to kvm_io_bus_write into the common code (e.g. MMU)? It 
would remove the need of implementing KVM_FAST_MMIO_BUS specifically for 
each vendor.

>>   		gpa_t gpa = vmcs_read64(GUEST_PHYSICAL_ADDRESS);
>> -		bool is_mmio = exit_reason.basic == EXIT_REASON_EPT_MISCONFIG;
>> -
> 
> Blank newline after variable declarations.
> 
>> -		kvm_prepare_ev_delivery_failure_exit(vcpu, gpa, is_mmio);
>> +		kvm_prepare_ev_delivery_failure_exit(vcpu, gpa, false);
>>   		return 0;
>>   	}
> 
> All in all, I think this is the basic gist?  Definitely feel free to propose a
> better name than X86EMUL_UNHANDLEABLE_VECTORING.
> 

It sounds OK, but maybe something more precise would work, like 
X86EMUL_VECTORING_IO_NEEDED (by analogy with X86EMUL_IO_NEEDED)?

Thanks a lot for the review.

-- 
Kind regards,
Ivan Orlov

