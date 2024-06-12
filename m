Return-Path: <linux-kselftest+bounces-11801-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BC02905E01
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Jun 2024 23:53:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D61A0284B00
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Jun 2024 21:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F1F3129E86;
	Wed, 12 Jun 2024 21:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fB8clxDM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6239284D02
	for <linux-kselftest@vger.kernel.org>; Wed, 12 Jun 2024 21:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718229186; cv=none; b=b7z27VAg0zdvRr3uuXUnTNv1gDMeQCw3KNIuAvhM/j9STjrCORjO/EA9X2/ba6crkE4u6OKQoSyxHpqy0Xm+cDEe/FDEN0i0zeDk0TYMBtuLyjLLK/tViRxSsHQa5hicA/ScU4X9ovmG0lWZw5Ys0qEaP57bTHDcXgUjvZ3B5e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718229186; c=relaxed/simple;
	bh=wusK4kc1FS+vHMjVpzL07yrjIW2g3Y3LcvsX2vuPaps=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QPZ21ooIIgLdAep0pITYnp7g0W36j2ZgAydJTQxjtcerQGcbHMw1broRRtDNh3N74G6QDAkXdfx2IN9U5mmEB/GBrgdIVK27Y8toshLU8vo2s4ZskFajEftcaEp1CzYisU9LsPuuZUvCXugTTpWMxntzXnqWOkpKENObaV85hFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fB8clxDM; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2c2fe3c4133so216321a91.3
        for <linux-kselftest@vger.kernel.org>; Wed, 12 Jun 2024 14:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718229183; x=1718833983; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xc5E1XEOoOO6m8at8GOziJ7pGWON/gur52mgUSEksH0=;
        b=fB8clxDMfQn1hS6Z2I1gxumHpNNQjaVGN3szaluSHppL6hXntf8uxhdY9Js8lzGccg
         ggTTh5Z1SsyDNOSmoGSmxBnNJ7RqDqJPK1LD7+6QT480YauemTIvdv4pgjpMoybFHuby
         jIsATDnv+s5qGaXHuD8ZLAX43k5JNhmEfJzUM1mCvIhBAOyY1rWbTaPKvm5XNxf5AU0E
         ZzCe1ivh/IQrQhiiQ0RqvMIZvDjDkoAMW3hgwyWOuFsz2E8VFIAbZJCvjEK8qBfIYc4H
         5UB94XtiRSqYWhJv6kMFgHQh6e/d2upyP2zj/BW+PzWk66CpJ5p+jF3Xu8FegBkuKfTB
         y5vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718229183; x=1718833983;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xc5E1XEOoOO6m8at8GOziJ7pGWON/gur52mgUSEksH0=;
        b=Zhqe2Lg2xSpQzKBB7pNp0XXGgwsevqYQvaPXEufUSwW9bhI38GWcEhGi3pVKYBxz6D
         q57SzcQDdFLkBP1iDuHq2HpmIZ1002qD9n7xXAO39xTIpyrRHaznFzkE412rY690I/1H
         WXX9Vj16GxoS3paM2HCuByXkUTtwvVczRghrjh4U86BUSCIImTzn618o7JCgXneLOZD7
         FkDZa7NT0RZsa8C/9WIIVsBB721HosfAwmZD5rXeWvVqWlVaeYMzUhRYEosh+AKqMCIk
         BejKAHHZPY1zXAhxuOwRYTxOdkAZSDR9BZOd2uDv7LMPQ3NJ49R3UWn/lSHSEtYYLKcF
         0cQw==
X-Forwarded-Encrypted: i=1; AJvYcCXKt1aOfoLxqnjf2h1iSXI0lE0ITQqxlo/ul9NaIRRa/IvfN4b6pHu47WXHGxrwWNXH1KoZNwzzNasmn33YnF+bpfRjvQQ0wenRhHKz6xrd
X-Gm-Message-State: AOJu0Yz51nUdDUvSuz9wYmhm55OD3LXNk3F6k1fD3Vd+mfIemGMx/yrW
	w2NEia0UZFrQU9/bb/iFkk0/DLzsAk3bHSnFp7PW999bSwjsIQ98t6ozHErftaV45caaTL0YJA/
	ceg==
X-Google-Smtp-Source: AGHT+IHbT5hnMTXfHXSrzZVzfM2ddDy1yTfVBw9Mcqt2XJ++35TEAMcRNhA5paiMB3+XTpPwciNXAbVip6c=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90a:62c9:b0:2c2:c65f:52dc with SMTP id
 98e67ed59e1d1-2c4a770e8f6mr8577a91.6.1718229182634; Wed, 12 Jun 2024 14:53:02
 -0700 (PDT)
Date: Wed, 12 Jun 2024 14:53:01 -0700
In-Reply-To: <20240207172646.3981-10-xin3.li@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240207172646.3981-1-xin3.li@intel.com> <20240207172646.3981-10-xin3.li@intel.com>
Message-ID: <ZmoYvcbFBPJ5ARma@google.com>
Subject: Re: [PATCH v2 09/25] KVM: VMX: Switch FRED RSP0 between host and guest
From: Sean Christopherson <seanjc@google.com>
To: Xin Li <xin3.li@intel.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	pbonzini@redhat.com, corbet@lwn.net, tglx@linutronix.de, mingo@redhat.com, 
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	shuah@kernel.org, vkuznets@redhat.com, peterz@infradead.org, 
	ravi.v.shankar@intel.com, xin@zytor.com
Content-Type: text/plain; charset="us-ascii"

On Wed, Feb 07, 2024, Xin Li wrote:
> Switch MSR_IA32_FRED_RSP0 between host and guest in
> vmx_prepare_switch_to_{host,guest}().
> 
> MSR_IA32_FRED_RSP0 is used during ring 3 event delivery only, thus
> KVM, running on ring 0, can run safely with guest FRED RSP0, i.e.,
> no need to switch between host/guest FRED RSP0 during VM entry and
> exit.
> 
> KVM should switch to host FRED RSP0 before returning to user level,
> and switch to guest FRED RSP0 before entering guest mode.

Heh, if only KVM had a framework that was specifically designed for context
switching MSRs on return to userspace.  Translation: please use the user_return_msr()
APIs.

> Signed-off-by: Xin Li <xin3.li@intel.com>
> Tested-by: Shan Kang <shan.kang@intel.com>
> ---
> 
> Changes since v1:
> * Don't use guest_cpuid_has() in vmx_prepare_switch_to_{host,guest}(),
>   which are called from IRQ-disabled context (Chao Gao).
> * Reset msr_guest_fred_rsp0 in __vmx_vcpu_reset() (Chao Gao).
> ---
>  arch/x86/kvm/vmx/vmx.c | 17 +++++++++++++++++
>  arch/x86/kvm/vmx/vmx.h |  2 ++
>  2 files changed, 19 insertions(+)
> 
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index b7b772183ee4..264378c3b784 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -1337,6 +1337,16 @@ void vmx_prepare_switch_to_guest(struct kvm_vcpu *vcpu)
>  	}
>  
>  	wrmsrl(MSR_KERNEL_GS_BASE, vmx->msr_guest_kernel_gs_base);
> +
> +	if (guest_can_use(vcpu, X86_FEATURE_FRED)) {
> +		/*
> +		 * MSR_IA32_FRED_RSP0 is top of task stack, which never changes.
> +		 * Thus it should be initialized only once.

Then grab the host value during vmx_hardware_setup().  And when you rebase on top
of the latest kvm-x86/next, there's a handy dandy "struct kvm_host_values kvm_host"
to track host MSR values (and similar state).

You could also use that for MSR_IA32_FRED_CONFIG and MSR_IA32_FRED_STKLVLS.

> +		 */
> +		if (unlikely(vmx->msr_host_fred_rsp0 == 0))
> +			vmx->msr_host_fred_rsp0 = read_msr(MSR_IA32_FRED_RSP0);
> +		wrmsrl(MSR_IA32_FRED_RSP0, vmx->msr_guest_fred_rsp0);
> +	}
>  #else
>  	savesegment(fs, fs_sel);
>  	savesegment(gs, gs_sel);
> @@ -1381,6 +1391,11 @@ static void vmx_prepare_switch_to_host(struct vcpu_vmx *vmx)
>  	invalidate_tss_limit();
>  #ifdef CONFIG_X86_64
>  	wrmsrl(MSR_KERNEL_GS_BASE, vmx->msr_host_kernel_gs_base);
> +
> +	if (guest_can_use(&vmx->vcpu, X86_FEATURE_FRED)) {
> +		vmx->msr_guest_fred_rsp0 = read_msr(MSR_IA32_FRED_RSP0);
> +		wrmsrl(MSR_IA32_FRED_RSP0, vmx->msr_host_fred_rsp0);
> +	}
>  #endif
>  	load_fixmap_gdt(raw_smp_processor_id());
>  	vmx->guest_state_loaded = false;
> @@ -4889,6 +4904,8 @@ static void __vmx_vcpu_reset(struct kvm_vcpu *vcpu)
>  
>  #ifdef CONFIG_X86_64
>  	if (kvm_cpu_cap_has(X86_FEATURE_FRED)) {
> +		vmx->msr_guest_fred_rsp0 = 0;

Eh, I wouldn't bother.  Arguably it's better to use __kvm_set_msr(), and "vmx"
is zero-allocated so this is unnecessary.

The GUEST_IA32_FRED_* VMCS fields need to be explicitly initialized because the
VMCS could (very theoretically) use a non-zero-based encoding scheme.

