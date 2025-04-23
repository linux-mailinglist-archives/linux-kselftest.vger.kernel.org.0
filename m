Return-Path: <linux-kselftest+bounces-31428-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B76BA993CA
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Apr 2025 18:03:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4F989A2F9D
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Apr 2025 15:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 938EE28E600;
	Wed, 23 Apr 2025 15:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mOQ4yyOr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E549228368C
	for <linux-kselftest@vger.kernel.org>; Wed, 23 Apr 2025 15:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745423056; cv=none; b=h7Nji/ZBTnTe+XMgCFkWLsxjYW/5Ide30vroE8IiVWUvL5/vFgPkYh2fzlj8MbDexqaoEyTrHGlRE4asuxZT7cEzP0s9H6PQLfedUpHX+D//SuduAJCvbaPVRoqPEk7RoXFhDTj0Q56/yqyw/KFi0bJInfVjT1Yclh1pJYa433A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745423056; c=relaxed/simple;
	bh=PTgTXbiqBZbLrDvwU4F+5aFy0KIW3wzX+95atzxzKbA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BqQIyMz4+7oBHCAv9sTwfaovY7BCm22i5YNt27dGlkCO16iIcuIAqjA9pb6ts9MQLUA46ZMdH2COgw1SXSlBXiCQM4lGIapatg8UC77j+EZ+Djsb4c/lyjm9pKS2LuAWT7Dnx+hWIM50p7kgOciC+lwfECsYqwdjmJdYbs59Oj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mOQ4yyOr; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-3032f4eca83so5886757a91.3
        for <linux-kselftest@vger.kernel.org>; Wed, 23 Apr 2025 08:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745423054; x=1746027854; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xPhgwd63apwbZo6TL59hfQlqDly5iGnPFF4jLyqPwhs=;
        b=mOQ4yyOrnUzvbqmyr6oY/g9TCACDLTHTNMncaFJuZ35sps44FmIEQ3KJtl6hHpnRrU
         5TAJQvfxG/ccara+f5N6I/cvkOt8fNx7hqFBq5PYTNd3a7Xm41x0bB7Myko2W4sG3nSm
         /17CYN3GuhCrhTMTIt1QmDfahqVN+EIwWl5EMQXn3FKPi4hwq/lUNR/4Du4jduePbf7+
         w3SsyZFkuC2Ogk7YA6QAJAXgmJ9qDgLiZnwEyH2GZ4kLLocM1IlDo6klw237/1f8XPPY
         8dUmerUbBk0L6SpucHGtGQdqIQK+yinNaZtEnZvpSj0c0Wmf0ptX8zbdoa0/EM87qCba
         NFFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745423054; x=1746027854;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xPhgwd63apwbZo6TL59hfQlqDly5iGnPFF4jLyqPwhs=;
        b=TU+FBCu6z7pLhFdRm+qKnsrbrxcvE7hiJY6LI6Gzoliz5CmrESRAPo6adYxdXI9GnN
         skbLQeLFrniPLMXPlkqA04Sv6hpYhg66iJHh+ZMPiM6s+qPTbN4fmG8oV0/GEhUD2SCf
         Aan0lAOS46l1juVG/JOvS3qsdaIZ1+s2oMURGoJxq8NjWO3rLM7TDMmoEAAhE4iAkpHw
         Obue/g5ecm9Otl6FzECxT0fWKLlpPi1CS4Jcsdtfsy8kfGYaEJg3+Hun5cyfK+muenQu
         bW/2encOoPIkN6fGFs9AoYRfQuy6+kz1/FpG0d9dS0WFHB0AEe19Rgl6xEd1lXhb+LBL
         /d6A==
X-Forwarded-Encrypted: i=1; AJvYcCXmIS+dgnxBfUQpN1Xc5ayppTqemx7Yoxh84lfE9KbC/p/lIhTSYbse0cL5C2qJS//rx8VKo1jsQrr0AMUkPjM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzP9OVQD0gBI1WYWWlkCpCR+hR8HMvl1KG1JRBu/KT/MlBeYXa3
	3ZQThuVZtaoQ7OgMvMpF9k/ej7luNr7jfxATueCNkeVMpfHyxet1XSSUxBSzKYHEl5kBzPepdXg
	m1A==
X-Google-Smtp-Source: AGHT+IHSkI6Mn0oDpHpElbO32DnQkfEefLjjNmyGwYzoz4thjAq+r46reZVQvyh0CS2WtBzQW2wRRZTNpuA=
X-Received: from pjbkl15.prod.google.com ([2002:a17:90b:498f:b0:2f9:c349:2f84])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:dfc5:b0:2fa:1a23:c01d
 with SMTP id 98e67ed59e1d1-3087bb6bcaamr27998226a91.21.1745423054216; Wed, 23
 Apr 2025 08:44:14 -0700 (PDT)
Date: Wed, 23 Apr 2025 08:44:12 -0700
In-Reply-To: <20250324130248.126036-5-manali.shukla@amd.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250324130248.126036-1-manali.shukla@amd.com> <20250324130248.126036-5-manali.shukla@amd.com>
Message-ID: <aAkKzEpNXDgC9_Vh@google.com>
Subject: Re: [PATCH v4 4/5] KVM: SVM: Add support for KVM_CAP_X86_BUS_LOCK_EXIT
 on SVM CPUs
From: Sean Christopherson <seanjc@google.com>
To: Manali Shukla <manali.shukla@amd.com>
Cc: kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, pbonzini@redhat.com, 
	nikunj@amd.com, thomas.lendacky@amd.com, bp@alien8.de
Content-Type: text/plain; charset="us-ascii"

On Mon, Mar 24, 2025, Manali Shukla wrote:
> +	if (vmcb02->save.rip && (svm->nested.ctl.bus_lock_rip == vmcb02->save.rip)) {
> +		vmcb02->control.bus_lock_counter = 1;
> +		svm->bus_lock_rip = svm->nested.ctl.bus_lock_rip;
> +	} else {
> +		vmcb02->control.bus_lock_counter = 0;
> +	}
> +	svm->nested.ctl.bus_lock_rip = INVALID_GPA;
> +
>  	/* Done at vmrun: asid.  */
>  
>  	/* Also overwritten later if necessary.  */
> @@ -1039,6 +1069,18 @@ int nested_svm_vmexit(struct vcpu_svm *svm)
>  
>  	}
>  
> +	/*
> +	 * If bus_lock_counter is nonzero and the guest has not moved past the
> +	 * guilty instruction, save bus_lock_rip in svm_nested_state. This will
> +	 * help determine at nested VMRUN whether to stash vmcb02's counter or
> +	 * reset it to '0'.
> +	 */
> +	if (vmcb02->control.bus_lock_counter &&
> +	    svm->bus_lock_rip == vmcb02->save.rip)
> +		svm->nested.ctl.bus_lock_rip = svm->bus_lock_rip;
> +	else
> +		svm->nested.ctl.bus_lock_rip = INVALID_GPA;
> +
>  	nested_svm_copy_common_state(svm->nested.vmcb02.ptr, svm->vmcb01.ptr);
>  
>  	svm_switch_vmcb(svm, &svm->vmcb01);

...

> +static int bus_lock_exit(struct kvm_vcpu *vcpu)
> +{
> +	struct vcpu_svm *svm = to_svm(vcpu);
> +
> +	vcpu->run->exit_reason = KVM_EXIT_X86_BUS_LOCK;
> +	vcpu->run->flags |= KVM_RUN_X86_BUS_LOCK;
> +
> +	vcpu->arch.cui_linear_rip = kvm_get_linear_rip(vcpu);
> +	svm->bus_lock_rip = vcpu->arch.cui_linear_rip;
> +	vcpu->arch.complete_userspace_io = complete_userspace_buslock;
> +
> +	return 0;
> +}

> @@ -327,6 +328,7 @@ struct vcpu_svm {
>  
>  	/* Guest GIF value, used when vGIF is not enabled */
>  	bool guest_gif;
> +	u64 bus_lock_rip;

I don't think this field is necessary.  Rather than unconditionally invalidate
on nested VMRUN and then conditionally restore on nested #VMEXIT, just leave
svm->nested.ctl.bus_lock_rip set on VMRUN and conditionally invalidate on #VMEXIT.
And then in bus_lock_exit(), update the field if the exit occurred while L2 is
active.

Completely untested:

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index a42ef7dd9143..98e065a93516 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -700,13 +700,10 @@ static void nested_vmcb02_prepare_control(struct vcpu_svm *svm,
         * L1 re-enters L2, the same instruction will trigger a VM-Exit and the
         * entire cycle start over.
         */
-       if (vmcb02->save.rip && (svm->nested.ctl.bus_lock_rip == vmcb02->save.rip)) {
+       if (vmcb02->save.rip && (svm->nested.ctl.bus_lock_rip == vmcb02->save.rip))
                vmcb02->control.bus_lock_counter = 1;
-               svm->bus_lock_rip = svm->nested.ctl.bus_lock_rip;
-       } else {
+       else
                vmcb02->control.bus_lock_counter = 0;
-       }
-       svm->nested.ctl.bus_lock_rip = INVALID_GPA;
 
        /* Done at vmrun: asid.  */
 
@@ -1070,15 +1067,10 @@ int nested_svm_vmexit(struct vcpu_svm *svm)
        }
 
        /*
-        * If bus_lock_counter is nonzero and the guest has not moved past the
-        * guilty instruction, save bus_lock_rip in svm_nested_state. This will
-        * help determine at nested VMRUN whether to stash vmcb02's counter or
-        * reset it to '0'.
+        * Invalidate bus_lock_rip unless kVM is still waiting for the guest
+        * to make forward progress before re-enabling bus lock detection.
         */
-       if (vmcb02->control.bus_lock_counter &&
-           svm->bus_lock_rip == vmcb02->save.rip)
-               svm->nested.ctl.bus_lock_rip = svm->bus_lock_rip;
-       else
+       if (!vmcb02->control.bus_lock_counter)
                svm->nested.ctl.bus_lock_rip = INVALID_GPA;
 
        nested_svm_copy_common_state(svm->nested.vmcb02.ptr, svm->vmcb01.ptr);
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index ea12e93ae983..11ce031323fd 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -3333,9 +3333,10 @@ static int bus_lock_exit(struct kvm_vcpu *vcpu)
        vcpu->run->flags |= KVM_RUN_X86_BUS_LOCK;
 
        vcpu->arch.cui_linear_rip = kvm_get_linear_rip(vcpu);
-       svm->bus_lock_rip = vcpu->arch.cui_linear_rip;
        vcpu->arch.complete_userspace_io = complete_userspace_buslock;
 
+       if (is_guest_mode(vcpu))
+               svm->nested.ctl.bus_lock_rip = vcpu->arch.cui_linear_rip;
        return 0;
 }
 
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index 7a4c5848c952..8667faccaedc 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -328,7 +328,6 @@ struct vcpu_svm {
 
        /* Guest GIF value, used when vGIF is not enabled */
        bool guest_gif;
-       u64 bus_lock_rip;
 };
 
 struct svm_cpu_data {


