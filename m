Return-Path: <linux-kselftest+bounces-38689-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7DE1B213E3
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Aug 2025 20:13:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D005216E17C
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Aug 2025 18:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55D2B2D6E78;
	Mon, 11 Aug 2025 18:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wWvOMoAd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCFCA2D6E59
	for <linux-kselftest@vger.kernel.org>; Mon, 11 Aug 2025 18:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754935891; cv=none; b=jlakN+LwvrMCG+8MIj8YZkuOi2MGh5UjiRgbKLkFMQdsJQXO+PkP5xJeuL72fv2Dc35bNRPgdF6VGHtztuPEJUZP2cILaaCkzkF9LUp/9TKfLYmVEOskyQ8P2ArYT0HLXGlmBnq43rMl8VDmVT7jaPCGbAz/JvdrLsLmGedU6fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754935891; c=relaxed/simple;
	bh=iZPEOI5THAwnIFM2nry3kBt3qHLW6Zn5YN5C5XSNsjg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=u5x+vki9+wADF2c9KX4zxxBoOedPNJJHTTLwhVQGCHwyO5B5u+Si6IANWqKL+9W+r2ZOaQZ/0q2x+1d9PUCQOhIB8Ram7SS1m87/iiIv/fB/w/dhNyaZuF8L23TbN4rpVFlHOkq7jRVo4Yh0EBHPQRoWo6uXdMxKLkvb725EEkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wWvOMoAd; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-23ff6e5c131so37407825ad.2
        for <linux-kselftest@vger.kernel.org>; Mon, 11 Aug 2025 11:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754935889; x=1755540689; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=K59WBaNblq5XWDJj9sqpuJW6Kxuh2ig/qlqaTgjtH+U=;
        b=wWvOMoAdD+gtfP3fX1mArWPtm86PVq8KAyceJ7oiGB9s3i0hYBD0C8HzIgxywrdIf4
         OgnFiqlgxEgaslzGbg0eaSXN+EM78Pdf4f5pzb926uDXT4xPU3dsgkVbpIiBuiJLTV7T
         +qDGyiT9KwpLm1WBZ17phTevtmz/UM56amg/hdOBM1EtVRHkfAeR1y17PpLszE6EiY9F
         VEWIfi8F0funpF6aOuLPdSCFo7TzGw7khaceM7qjaWjxrJn1HQoCPIdo1R5VWuaUY0sK
         od5bJ3f2PdEWMPxd9HpJ2CrRH28cWpahSS8OPWOBmJKOH0qe1ffyaY+zZ4h6whQ30j+B
         +auA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754935889; x=1755540689;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K59WBaNblq5XWDJj9sqpuJW6Kxuh2ig/qlqaTgjtH+U=;
        b=tztk0dFCznggfAqJd73ybQhdeSAnL2JEj/UW1cGjZ7YwK9ZypyOztMhmVxeJtGUwC/
         IDn8GtHHKlfsfEuL5iEq4ajudtXGcNGtz4S8DRqPYnwBcLXkFweOY3j+qqfsHZUUYqJ3
         U8/9iqQw4jN8cVaAAA2+ZqM95gmQhgJklS3DKQkDCbLz/HDLZ05368nsdU5JfY5f+Iw5
         wHvUysmSSWoDmGkYWLcAH/9QZN5eC2QDYrWMERq6ghamYaTlwHrtQXqlLYEekNLwuBxa
         paqj3rKD3jiGu2uvq5rRF6HNTCZGOGm30wZ6nNYymSuV+8phL9hX+8fVi/8gE/eMHdg1
         i5wA==
X-Gm-Message-State: AOJu0Ywf0EZJl9ILENqvMHn05oZviaPX7UQpYSWOuy4rATAyfArsvy2u
	GgwLrPouVD2D74XF7OEW0unKUgUrLDU2flJCFqpWtHvx3f9Yj+RJmlNfj09jNpBOHg4xRqG/Um9
	YUKuFhA==
X-Google-Smtp-Source: AGHT+IFIl3WpRSek+zdAYh5772U8b9NbQKB2y0NYVeudiSt8nzCjUmUxun5TY9FKyuyRSAvLEOxe0f0LTkg=
X-Received: from pjje1.prod.google.com ([2002:a17:90a:6301:b0:312:1dae:6bf0])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2352:b0:234:8ef1:aa7b
 with SMTP id d9443c01a7336-242fc23de5bmr6002635ad.20.1754935888983; Mon, 11
 Aug 2025 11:11:28 -0700 (PDT)
Date: Mon, 11 Aug 2025 11:11:27 -0700
In-Reply-To: <20250807201628.1185915-3-sagis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250807201628.1185915-1-sagis@google.com> <20250807201628.1185915-3-sagis@google.com>
Message-ID: <aJoyT-w9U9lJhR-z@google.com>
Subject: Re: [PATCH v8 02/30] KVM: selftests: Expose function that sets up
 sregs based on VM's mode
From: Sean Christopherson <seanjc@google.com>
To: Sagi Shahar <sagis@google.com>
Cc: linux-kselftest@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, Ackerley Tng <ackerleytng@google.com>, 
	Ryan Afranji <afranji@google.com>, Andrew Jones <ajones@ventanamicro.com>, 
	Isaku Yamahata <isaku.yamahata@intel.com>, Erdem Aktas <erdemaktas@google.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Roger Wang <runanwang@google.com>, 
	Binbin Wu <binbin.wu@linux.intel.com>, Oliver Upton <oliver.upton@linux.dev>, 
	"Pratik R. Sampat" <pratikrajesh.sampat@amd.com>, Reinette Chatre <reinette.chatre@intel.com>, 
	Ira Weiny <ira.weiny@intel.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, Aug 07, 2025, Sagi Shahar wrote:
> From: Ackerley Tng <ackerleytng@google.com>
> 

Make changelogs standalone, i.e. don't rely on the subject/shortlog for context.

> This allows initializing sregs without setting vCPU registers in
> KVM.
> 
> No functional change intended.
> 
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> Signed-off-by: Sagi Shahar <sagis@google.com>
> ---
>  .../selftests/kvm/include/x86/processor.h     |  1 +
>  .../testing/selftests/kvm/lib/x86/processor.c | 45 ++++++++++---------
>  2 files changed, 25 insertions(+), 21 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/include/x86/processor.h b/tools/testing/selftests/kvm/include/x86/processor.h
> index b11b5a53ebd5..f2eb764cbd7c 100644
> --- a/tools/testing/selftests/kvm/include/x86/processor.h
> +++ b/tools/testing/selftests/kvm/include/x86/processor.h
> @@ -1025,6 +1025,7 @@ static inline struct kvm_cpuid2 *allocate_kvm_cpuid2(int nr_entries)
>  }
>  
>  void vcpu_init_cpuid(struct kvm_vcpu *vcpu, const struct kvm_cpuid2 *cpuid);
> +void vcpu_setup_mode_sregs(struct kvm_vm *vm, struct kvm_sregs *sregs);
>  
>  static inline void vcpu_get_cpuid(struct kvm_vcpu *vcpu)
>  {
> diff --git a/tools/testing/selftests/kvm/lib/x86/processor.c b/tools/testing/selftests/kvm/lib/x86/processor.c
> index a92dc1dad085..002303e2a572 100644
> --- a/tools/testing/selftests/kvm/lib/x86/processor.c
> +++ b/tools/testing/selftests/kvm/lib/x86/processor.c
> @@ -488,34 +488,37 @@ static void kvm_seg_set_tss_64bit(vm_vaddr_t base, struct kvm_segment *segp)
>  	segp->present = 1;
>  }
>  
> -static void vcpu_init_sregs(struct kvm_vm *vm, struct kvm_vcpu *vcpu)
> +void vcpu_setup_mode_sregs(struct kvm_vm *vm, struct kvm_sregs *sregs)
>  {
> -	struct kvm_sregs sregs;
> -
>  	TEST_ASSERT_EQ(vm->mode, VM_MODE_PXXV48_4K);
>  
> -	/* Set mode specific system register values. */
> -	vcpu_sregs_get(vcpu, &sregs);
> -
> -	sregs.idt.base = vm->arch.idt;
> -	sregs.idt.limit = NUM_INTERRUPTS * sizeof(struct idt_entry) - 1;
> -	sregs.gdt.base = vm->arch.gdt;
> -	sregs.gdt.limit = getpagesize() - 1;
> +	sregs->idt.base = vm->arch.idt;
> +	sregs->idt.limit = NUM_INTERRUPTS * sizeof(struct idt_entry) - 1;
> +	sregs->gdt.base = vm->arch.gdt;
> +	sregs->gdt.limit = getpagesize() - 1;
>  
> -	sregs.cr0 = X86_CR0_PE | X86_CR0_NE | X86_CR0_PG;
> -	sregs.cr4 |= X86_CR4_PAE | X86_CR4_OSFXSR;
> +	sregs->cr0 = X86_CR0_PE | X86_CR0_NE | X86_CR0_PG;
> +	sregs->cr4 |= X86_CR4_PAE | X86_CR4_OSFXSR;
>  	if (kvm_cpu_has(X86_FEATURE_XSAVE))
> -		sregs.cr4 |= X86_CR4_OSXSAVE;
> -	sregs.efer |= (EFER_LME | EFER_LMA | EFER_NX);
> +		sregs->cr4 |= X86_CR4_OSXSAVE;
> +	sregs->efer |= (EFER_LME | EFER_LMA | EFER_NX);
> +
> +	kvm_seg_set_unusable(&sregs->ldt);
> +	kvm_seg_set_kernel_code_64bit(&sregs->cs);
> +	kvm_seg_set_kernel_data_64bit(&sregs->ds);
> +	kvm_seg_set_kernel_data_64bit(&sregs->es);
> +	kvm_seg_set_kernel_data_64bit(&sregs->gs);
> +	kvm_seg_set_tss_64bit(vm->arch.tss, &sregs->tr);
>  
> -	kvm_seg_set_unusable(&sregs.ldt);
> -	kvm_seg_set_kernel_code_64bit(&sregs.cs);
> -	kvm_seg_set_kernel_data_64bit(&sregs.ds);
> -	kvm_seg_set_kernel_data_64bit(&sregs.es);
> -	kvm_seg_set_kernel_data_64bit(&sregs.gs);
> -	kvm_seg_set_tss_64bit(vm->arch.tss, &sregs.tr);
> +	sregs->cr3 = vm->pgd;

Add helpers/macros for the few things that are open coded here so that the TDX
code can get the "default" values.  Bouncing data through kvm_sregs is unnecessary
(unless you're trying to win the Obfuscated C contest) and makes it much harder to
understand what TDX actually needs, and why.

IDT.base, GDT.base, and CR3 (vm->pgd) are already available, so something like:

diff --git a/tools/testing/selftests/kvm/lib/x86/processor.c b/tools/testing/selftests/kvm/lib/x86/processor.c
index d4c19ac885a9..83efcf48faad 100644
--- a/tools/testing/selftests/kvm/lib/x86/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86/processor.c
@@ -498,15 +498,13 @@ static void vcpu_init_sregs(struct kvm_vm *vm, struct kvm_vcpu *vcpu)
        vcpu_sregs_get(vcpu, &sregs);
 
        sregs.idt.base = vm->arch.idt;
-       sregs.idt.limit = NUM_INTERRUPTS * sizeof(struct idt_entry) - 1;
+       sregs.idt.limit = kvm_get_default_idt_limit();
        sregs.gdt.base = vm->arch.gdt;
-       sregs.gdt.limit = getpagesize() - 1;
+       sregs.gdt.limit = kvm_get_default_gdt_limit();
 
-       sregs.cr0 = X86_CR0_PE | X86_CR0_NE | X86_CR0_PG;
-       sregs.cr4 |= X86_CR4_PAE | X86_CR4_OSFXSR;
-       if (kvm_cpu_has(X86_FEATURE_XSAVE))
-               sregs.cr4 |= X86_CR4_OSXSAVE;
-       sregs.efer |= (EFER_LME | EFER_LMA | EFER_NX);
+       sregs.cr0 = kvm_get_default_cr0();
+       sregs.cr4 |= kvm_get_default_cr4();
+       sregs.efer |= kvm_get_default_efer();
 
        kvm_seg_set_unusable(&sregs.ldt);
        kvm_seg_set_kernel_code_64bit(&sregs.cs);


> +}
> +
> +static void vcpu_init_sregs(struct kvm_vm *vm, struct kvm_vcpu *vcpu)
> +{
> +	struct kvm_sregs sregs;
>  
> -	sregs.cr3 = vm->pgd;
> +	vcpu_sregs_get(vcpu, &sregs);
> +	vcpu_setup_mode_sregs(vm, &sregs);
>  	vcpu_sregs_set(vcpu, &sregs);
>  }
>  
> -- 
> 2.51.0.rc0.155.g4a0f42376b-goog
> 

