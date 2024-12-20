Return-Path: <linux-kselftest+bounces-23637-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 02E8C9F8927
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Dec 2024 02:01:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA12818970B2
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Dec 2024 01:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09D18259486;
	Fri, 20 Dec 2024 01:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OdWRy+MH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE32800
	for <linux-kselftest@vger.kernel.org>; Fri, 20 Dec 2024 01:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734656506; cv=none; b=lhmUB5PzWxvu9z8jurdsIqSXixfvc0thWkl1LrQl8G2csE/vsX1qBv5AZQ37EqQKX5GMnnls6jZdzsLKuU56umln204M7VIPr2E2TMdbGhJEhhe0V4xwgYOKYxyqOmMMEnFq4YdL5YIEmOCf/qHBvEePQFp64D888YxxT9j8Fi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734656506; c=relaxed/simple;
	bh=AmvKiwHYZclLrWzYtO3E/88S0KH98FEZ36WFjG+D5vg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VsztW7BdNgM6/PaGkpqFPNVR+iJxNA8gIQGTpFiqzh7rVfG6BfPmFn4Nq+JJFNxW4f8LZroXNrWjZuUS2FQLmNfntQ1/Eha3JFdpDm4CzOZWr67g2+LYeH67GwiyEBrn0Qc3mRQ9uSo3SnXL5FTvix9mf8hEvmZsYbZgYMerbo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OdWRy+MH; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2178115051dso12290905ad.1
        for <linux-kselftest@vger.kernel.org>; Thu, 19 Dec 2024 17:01:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734656505; x=1735261305; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kU9WyG19GvmAHnJMbh+DDznl+d32y7f3La+cRtAb2IY=;
        b=OdWRy+MHSaoCjvt1wh4i6ZK3Sx3AXvBWcHEN5cv01AJ/5FYdMiaiZFuO84tgn30y6x
         qKqLDXzHSZvLveRq0PEPLaF4ObgIqzMAlOzGm2ASJGz6zOaTmSnlifcTEvcuI01c1jZy
         Go1UZRIZ0Yt2rcjrWUutOKFO/t8ab0KkkWvp/xA2aLyz1fEFdgZYVi3D21wnzZnrk1nn
         dt57pHAyApLABReyNOHopQmzEP+V4kdq48hs1HMiU+Zh7jTbaxzoph4855BXCtVHD+Cn
         yV/WntMsu4iILBgSBGMKYGg5vUdzVcOU66CzhLfCMDi5KjtSYZWTlJe59QXtRyHI+eZ5
         cq0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734656505; x=1735261305;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kU9WyG19GvmAHnJMbh+DDznl+d32y7f3La+cRtAb2IY=;
        b=PQjcdwlPOFxSCsDT75Paw6QFAWUgH4gGd+p+5ZJvgjDExCJoMjjnyXOzS0PU81i88+
         8cDMYYtGYQ4AGLCJqdYA+wFovsU5C34jldZIXci0IQfnixHZWuk97XrdDYECwL7nYHpL
         JXW6tD/XUfh8uLAadOVbEE2U5STVvFmEZoCsMCboaWVEzSAq8pl4wyk/GjQAiVIvCXPE
         aDn+C/III9I/1NdhEyil/B4fmoSX1ODTtsLh0ehASVlt9gov3//2fijMkOjVK03fAP8s
         c1U6Snzxd3aKlo8DefzWBxvZHKuUE2CE9injsx/cY7YCQL9X0Fgex+rDV6AutyFkmklw
         opZA==
X-Forwarded-Encrypted: i=1; AJvYcCUSye4UXIf2FmbCOGtuQRD77Bpinnygc13zhkYbMHrX5A7Cfh/16gNwYBBq9vWGdTuHrDY3vwTBEPenQmQm2Is=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAbeiud6Wa6XCjAasFCeft1834uV1+1EqDMWgVW9WHvAUjrCkz
	5W4L4vAOflflDFs7FavV9oHZDNWI7ixA5Ej4pZnhVDUokEp9/1Nkl9UgjIlvR9sYW5Ham33IZIu
	CiQ==
X-Google-Smtp-Source: AGHT+IHVg58sfOSXGQuK9wowTQQZv8Ln1PgdxkbXGMHa3GA4fedav2PQtck4bQSEknJOToOx3ahJRQQoD8Y=
X-Received: from plbkc6.prod.google.com ([2002:a17:903:33c6:b0:216:25a2:2ed5])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2449:b0:216:50fb:5dfc
 with SMTP id d9443c01a7336-219e6e8c3admr12657845ad.9.1734656504858; Thu, 19
 Dec 2024 17:01:44 -0800 (PST)
Date: Thu, 19 Dec 2024 17:01:43 -0800
In-Reply-To: <20241022054810.23369-4-manali.shukla@amd.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241022054810.23369-1-manali.shukla@amd.com> <20241022054810.23369-4-manali.shukla@amd.com>
Message-ID: <Z2TB94Ux5mOlds3b@google.com>
Subject: Re: [PATCH v4 3/4] KVM: nSVM: implement the nested idle halt intercept
From: Sean Christopherson <seanjc@google.com>
To: Manali Shukla <manali.shukla@amd.com>
Cc: kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, pbonzini@redhat.com, 
	shuah@kernel.org, nikunj@amd.com, thomas.lendacky@amd.com, 
	vkuznets@redhat.com, bp@alien8.de, babu.moger@amd.com
Content-Type: text/plain; charset="us-ascii"

On Tue, Oct 22, 2024, Manali Shukla wrote:
> diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
> index d5314cb7dff4..feb241110f1a 100644
> --- a/arch/x86/kvm/svm/nested.c
> +++ b/arch/x86/kvm/svm/nested.c
> @@ -178,6 +178,14 @@ void recalc_intercepts(struct vcpu_svm *svm)
>  	} else {
>  		WARN_ON(!(c->virt_ext & VIRTUAL_VMLOAD_VMSAVE_ENABLE_MASK));
>  	}
> +
> +	/*
> +	 * Clear the HLT intercept for L2 guest when the Idle HLT intercept feature
> +	 * is enabled on the platform and the guest can use the Idle HLT intercept
> +	 * feature.
> +	 */
> +	if (guest_can_use(&svm->vcpu, X86_FEATURE_IDLE_HLT))
> +		vmcb_clr_intercept(c, INTERCEPT_HLT);

This is wrong.  KVM needs to honor the intercept of vmcb12.  If L1 wants to
intercept HLT, then KVM needs to configure vmcb02 to intercept HLT, regradless
of whether or not L1 is utilizing INTERCEPT_IDLE_HLT.

Given how KVM currently handles intercepts for nested SVM, I'm pretty sure you
can simply do nothing.  recalc_intercepts() starts with KVM's intercepts (from
vmcb01), and adds in L1's intercepts.  So unless there is a special case, the
default behavior should Just Work.

	for (i = 0; i < MAX_INTERCEPT; i++)
		c->intercepts[i] = h->intercepts[i];

	...

	for (i = 0; i < MAX_INTERCEPT; i++)
		c->intercepts[i] |= g->intercepts[i];

KVM's approach creates all kinds of virtualization holes, e.g. L1 can utilize
IDLE_HLT even if the feature isn't advertised to L1.  But that's true for quite
literally all feature-based intercepts, so for better or worse, I don't think
it makes sense to try and change that approach for this feature.

> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index e86b79e975d3..38d546788fc6 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -4425,6 +4425,7 @@ static void svm_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
>  	kvm_governed_feature_check_and_set(vcpu, X86_FEATURE_PFTHRESHOLD);
>  	kvm_governed_feature_check_and_set(vcpu, X86_FEATURE_VGIF);
>  	kvm_governed_feature_check_and_set(vcpu, X86_FEATURE_VNMI);
> +	kvm_governed_feature_check_and_set(vcpu, X86_FEATURE_IDLE_HLT);
>  
>  	svm_recalc_instruction_intercepts(vcpu, svm);
>  
> @@ -5228,6 +5229,9 @@ static __init void svm_set_cpu_caps(void)
>  		if (vnmi)
>  			kvm_cpu_cap_set(X86_FEATURE_VNMI);
>  
> +		if (cpu_feature_enabled(X86_FEATURE_IDLE_HLT))
> +			kvm_cpu_cap_set(X86_FEATURE_IDLE_HLT);

kvm_cpu_cap_check_and_set() does this for you.

> +
>  		/* Nested VM can receive #VMEXIT instead of triggering #GP */
>  		kvm_cpu_cap_set(X86_FEATURE_SVME_ADDR_CHK);
>  	}
> -- 
> 2.34.1
> 

