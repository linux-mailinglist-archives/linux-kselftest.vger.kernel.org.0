Return-Path: <linux-kselftest+bounces-18100-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0335097B976
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Sep 2024 10:37:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27E6D1C20DC8
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Sep 2024 08:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 988F8179652;
	Wed, 18 Sep 2024 08:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="iifoiFoa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5353317798F;
	Wed, 18 Sep 2024 08:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726648603; cv=none; b=OTg1Z6PZCGdw4Rm+rYupLakLA4UzGQxpkmGNpyT29IoTvhWHmRCIHakqMrOxBicRTOAdcfJ1rCShH02Qt3pjucsKR1GYWEzsVBHqC8QsU72j+wqGJF50xsVUkmFbw1htNVGOVns65x8edSvEfQ52pqIYssg4OVCPPuovvm3ge8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726648603; c=relaxed/simple;
	bh=SPlYo2wbVPtywFZJvGZL5i8i+ocFuBwmMn6s5v97xHY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gbpA+aeVes0xDbMdMQC35PPLtA2zo9scLPQX1HktqNOfHblRwXr8ASRqVfKJt+9PtzdNM0OycdmQJAEVCaF7oZLHLnU6/ZEUoXo72eNe5Ux+IEI8PFGELD9CWvvSRmVdqZItuZQ3kdOVQUFxKGK70WlSrQaRcSyFlGnQG91he2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=iifoiFoa; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [192.168.7.205] ([71.202.166.45])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 48I8ZpZx1114904
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Wed, 18 Sep 2024 01:35:52 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 48I8ZpZx1114904
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024091601; t=1726648555;
	bh=x2GclNT1jGzmcwnuPezDBelGlqN1/8ggygWx7Pfpj6A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=iifoiFoays4n2azeZw/XhgYRM2pwAMUNJTTSYdaIl+wLZlRFZye+Ff6YDMk8jblpR
	 FCMuZZEJzGngGPObV982xZ8nFfvP+GkfHvPiLkPDOzwCrXdyKO6Zt2b1FdZaLYA6d0
	 4yIJlgFYqG7Ew/MdHaW1bDCBYU8PztXl0uwwRFTqbGIF8DKXVBwympsBtbeURKIIut
	 W9w4bnV1Q50Zs4ZV138U7SjEk4oklNRFCOHuLnBQnUwiRTt3umeYpoRPI6lCJj1czi
	 3xz6v9eutDFpTTn4Dswsg5z8gRav0GmzEheCza9k6KMYunAb33RLiOFqyz6yip0tAN
	 lE4zIHGzntXmw==
Message-ID: <d65e62d2-ca64-4b29-8656-bb8411fe837d@zytor.com>
Date: Wed, 18 Sep 2024 01:35:51 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/25] KVM: VMX: Set intercept for FRED MSRs
To: Sean Christopherson <seanjc@google.com>
Cc: Chao Gao <chao.gao@intel.com>, Xin Li <xin3.li@intel.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        pbonzini@redhat.com, corbet@lwn.net, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, shuah@kernel.org, vkuznets@redhat.com,
        peterz@infradead.org, ravi.v.shankar@intel.com
References: <20240207172646.3981-1-xin3.li@intel.com>
 <20240207172646.3981-8-xin3.li@intel.com> <ZiJzFsoHR41Sd8lE@chao-email>
 <ZmoT0jaX_3Ww3Uzu@google.com>
 <feefa9d1-f266-414f-bb7b-b770ef0d8ec6@zytor.com>
 <ZuNJlzXntREQVb3n@google.com>
Content-Language: en-US
From: Xin Li <xin@zytor.com>
Autocrypt: addr=xin@zytor.com; keydata=
 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
 l75w1xInsg==
In-Reply-To: <ZuNJlzXntREQVb3n@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

>> MSR_IA32_FRED_SSP0 is an alias of the CET MSR_IA32_PL0_SSP and likely to
>> be used in the same way as FRED RSP0, i.e., host FRED SSP0 _should_ be
>> restored in arch_exit_to_user_mode_prepare().  However as of today Linux
>> has no plan to utilize kernel shadow stack thus no one cares host FRED
>> SSP0 (no?).  But lets say anyway it is host's responsibility to manage
>> host FRED SSP0, then KVM only needs to take care of guest FRED SSP0
>> (just like how KVM should handle guest FRED RSP0) even before the
>> supervisor shadow stack feature is advertised to guest.
> 
> Heh, I'm not sure what your question is, or if there even is a question.  KVM
> needs to context switch FRED SSP0 if FRED is exposed to the guest, but presumably
> that will be done through XSAVE state?  If that's the long term plan, I would
> prefer to focus on merging CET virtualization first, and then land FRED virtualization
> on top so that KVM doesn't have to carry intermediate code to deal with the aliased
> MSR.

You mean the following patch set, right?

https://lore.kernel.org/kvm/20240531090331.13713-1-weijiang.yang@intel.com/

I think it's probably better to do so.  Otherwise a patch to explicitly
save/restore FRED SSP0 would be needed before the CET patch set lands
and then reverted immediately after:

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index f828f03d48ab..c790cb7a7d6b 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -1343,8 +1343,10 @@ void vmx_prepare_switch_to_guest(struct kvm_vcpu 
*vcpu)

         wrmsrl(MSR_KERNEL_GS_BASE, vmx->msr_guest_kernel_gs_base);

-       if (cpu_feature_enabled(X86_FEATURE_FRED) && guest_can_use(vcpu, 
X86_FEATURE_FRED))
+       if (cpu_feature_enabled(X86_FEATURE_FRED) && guest_can_use(vcpu, 
X86_FEATURE_FRED)) {
                 wrmsrns(MSR_IA32_FRED_RSP0, vmx->msr_guest_fred_rsp0);
+               wrmsrns(MSR_IA32_FRED_SSP0, vmx->msr_guest_fred_ssp0);
+       }
  #else
         savesegment(fs, fs_sel);
         savesegment(gs, gs_sel);
@@ -1393,6 +1395,8 @@ static void vmx_prepare_switch_to_host(struct 
vcpu_vmx *vmx)
         if (cpu_feature_enabled(X86_FEATURE_FRED) && 
guest_can_use(&vmx->vcpu, X86_FEATURE_FRED)) {
                 vmx->msr_guest_fred_rsp0 = read_msr(MSR_IA32_FRED_RSP0);
                 fred_sync_rsp0(vmx->msr_guest_fred_rsp0);
+
+               vmx->msr_guest_fred_ssp0 = read_msr(MSR_IA32_FRED_SSP0);
         }
  #endif
         load_fixmap_gdt(raw_smp_processor_id());
diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
index 9012428984de..d1b9352f56c7 100644
--- a/arch/x86/kvm/vmx/vmx.h
+++ b/arch/x86/kvm/vmx/vmx.h
@@ -282,6 +282,7 @@ struct vcpu_vmx {
         u64                   msr_host_kernel_gs_base;
         u64                   msr_guest_kernel_gs_base;
         u64                   msr_guest_fred_rsp0;
+       u64                   msr_guest_fred_ssp0;
  #endif

         u64                   spec_ctrl;

> 
> Ugh, but what happens if a CPU (or the host kernel) supports FRED but not CET SS?
> Or is that effectively an illegal combination?

The FRED Spec says:

IA32_FRED_SSP1, IA32_FRED_SSP2, and IA32_FRED_SSP3 (MSR indices 1D1H–
1D3H). Together with the existing MSR IA32_PL0_SSP (MSR index 6A4H), 
these are the FRED SSP MSRs.

The FRED SSP MSRs are supported by any processor that enumerates
CPUID.(EAX=7,ECX=1):EAX.FRED[bit 17] as 1. If such a processor does not 
support CET, FRED transitions will not use the MSRs (because shadow 
stacks are not enabled), but the MSRs would still be accessible using 
RDMSR and WRMSR.


So they are independent, just that FRED SSP MSRs are NOT used if
supervisor shadow stacks are not enabled (obviously Qemu can be
configured to not advertise CET but FRED).

When FRED is advertised to a guest, KVM should allow FRED SSP MSRs
accesses through disabling FRED SSP MSRs interception no matter whether
supervisor shadow stacks are enabled or not.

Thanks!
     Xin


