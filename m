Return-Path: <linux-kselftest+bounces-23185-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3610C9ED453
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Dec 2024 19:02:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56F811888D3A
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Dec 2024 18:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFCB21FF1DA;
	Wed, 11 Dec 2024 18:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X4rBHx31"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 209091BD9CA
	for <linux-kselftest@vger.kernel.org>; Wed, 11 Dec 2024 18:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733940139; cv=none; b=jMW/upBW2MyV/2iOZb2LagjBLZupjpy1Q/5B4x1O8DqmDi9H7GG7ohwVugitjbWa3jlnqA7gScLL8YhLgHzftG7gv0jBIQ8V2AI4omolnAEGCGFZb+ya595JBO7a745IjHdxgoqcLjWkPpbMTQVcebrTpPofLQPHn8ae/K7On7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733940139; c=relaxed/simple;
	bh=asqiJpjLiLhCgnZPbayuiLkQWTg+6hfrolruXld72/s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=olW+ocdQq3O6bJSnlx9rPVIsO0JsVRDiSOW4tlwBT0cBi2g/G+8tB/wQR2E7zuwtWsc+pCZHHX0aFsEhHjKsePuWqOyP9bpLjQ3zjjQFwMy7c7o+ac3Kjp9yoMboEHnoXOpcbaADQUePqOQe4oFHEa00TX72U3OAOuwLNgfyc34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=X4rBHx31; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2ef9dbeb848so3838519a91.0
        for <linux-kselftest@vger.kernel.org>; Wed, 11 Dec 2024 10:02:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733940137; x=1734544937; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=f1lf4kyl5o8ojaR7yeVD7qLHy8y/n2Kt6+OeU26iF60=;
        b=X4rBHx31fTP/34Lhya3SLBAdkYqjryz6yd4FMt+hv+69XQEYDGT3R7vSVLqAaDxlzz
         7QnA89RWW9HPeHyumm/aoqepXYzK/T7R2ILozbrwMwnNT35RvFMOX/k82Xgup95CSCOo
         Ccicgyx8rWsDj/+S17kJwLxEYmqGikW3pvMGDVVsAlDArEY9GtsPHRjBGei5L6Bc9cGQ
         WGkpNHSjYpPqhLMZsABbJZW+5Nk79tmbs9X1YhZTn+nHOhDuY7rUNSa79BcM+kEcpfzz
         RsPJUsUEEWH53ehJjL4rgrpeJrQygGK8IWmeUKy8/y/SS3nnE7aAn3XIa8BcCNiyeVOx
         gyVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733940137; x=1734544937;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f1lf4kyl5o8ojaR7yeVD7qLHy8y/n2Kt6+OeU26iF60=;
        b=XstzPCqxb6ub63wJaJVwh4EMC7zn44scv1cU14/f8myRNRrxJYtCNlwihBC8EXGuMc
         /JjcEj7DP3GKNUFxeiMSGQ242QNF3ntsAoIkRbLDTa6mizRx1hSoxeHplfW8ot+3c8wr
         L8qzOy+nwhaamdcnVPEQ/xiOjxa2eEo4AezXgptutorzSX2liHOdA41sxFlCbvlHSqdF
         oTFxXF7nrvJq7rQgpuvvHZqOZpyECKah/gAbpij3PuG3sTRn16i+SEUWMpsC9gzuzITv
         SW1DJEsnAy14mihvTcT0i4LAxR4uybyMSacJLMjQs/WhIpmvxrZKfqG2WthuV47fs9Wa
         iwTw==
X-Forwarded-Encrypted: i=1; AJvYcCVgJ/0WdAjPzlBrA+Xa2TEvRiLnJXEyFCZ3miLFEt8wm9U9BirM6bOU9oQ6V17huHkYzx+XHEKcKONG4D8N7lk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9JrJMDNkRliWz8tC2N/KLkiCdQRgdgkHcdLSaav+2nRQKl/u2
	Boq8tSl3iV19sK3SrTOV6eQoA2uzgIPg7kQwbnDk4Eht4Om1GAWAT0tJEnpBfmZFxd26me2+VAq
	oeQ==
X-Google-Smtp-Source: AGHT+IELhj748F6SgeaEJfutWFt3ozm7X+t736qOr2yK5dsPlYPqcc0/Ms9TEI5h9cMJ659WQfUT6SLlSMs=
X-Received: from pjbqa6.prod.google.com ([2002:a17:90b:4fc6:b0:2ef:79ee:65c0])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:544b:b0:2ee:b2be:f390
 with SMTP id 98e67ed59e1d1-2f13930a57bmr1094830a91.28.1733940137438; Wed, 11
 Dec 2024 10:02:17 -0800 (PST)
Date: Wed, 11 Dec 2024 10:02:15 -0800
In-Reply-To: <20241111102749.82761-2-iorlov@amazon.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241111102749.82761-1-iorlov@amazon.com> <20241111102749.82761-2-iorlov@amazon.com>
Message-ID: <Z1nTp82wgSGe4AmV@google.com>
Subject: Re: [PATCH v2 1/6] KVM: x86: Add function for vectoring error generation
From: Sean Christopherson <seanjc@google.com>
To: Ivan Orlov <iorlov@amazon.com>
Cc: bp@alien8.de, dave.hansen@linux.intel.com, mingo@redhat.com, 
	pbonzini@redhat.com, shuah@kernel.org, tglx@linutronix.de, hpa@zytor.com, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, x86@kernel.org, pdurrant@amazon.co.uk, 
	dwmw@amazon.co.uk
Content-Type: text/plain; charset="us-ascii"

On Mon, Nov 11, 2024, Ivan Orlov wrote:
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index f6900bec4874..f92740e7e107 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -6452,6 +6452,7 @@ static int __vmx_handle_exit(struct kvm_vcpu *vcpu, fastpath_t exit_fastpath)
>  	union vmx_exit_reason exit_reason = vmx->exit_reason;
>  	u32 vectoring_info = vmx->idt_vectoring_info;
>  	u16 exit_handler_index;
> +	gpa_t gpa;

I've gone back and forth on where to declare scoped varaibles, but in this case,
I think it makes sense to declare "gpa" inside the if-statement.  Making it
visible at the function scope when it's valid in a _super_ limited case is bound
to cause issues.

Of course, this code goes away by the end of the series, so that point is moot.
But on the other hand, declaring the variable in the if-statement is desirable
as the churn is precisely limited to the code that's being changed.

>  	/*
>  	 * Flush logged GPAs PML buffer, this will make dirty_bitmap more
> @@ -6550,19 +6551,10 @@ static int __vmx_handle_exit(struct kvm_vcpu *vcpu, fastpath_t exit_fastpath)
>  	     exit_reason.basic != EXIT_REASON_APIC_ACCESS &&
>  	     exit_reason.basic != EXIT_REASON_TASK_SWITCH &&
>  	     exit_reason.basic != EXIT_REASON_NOTIFY)) {
> -		int ndata = 3;
> +		gpa = exit_reason.basic == EXIT_REASON_EPT_MISCONFIG
> +		      ? vmcs_read64(GUEST_PHYSICAL_ADDRESS) : INVALID_GPA;

Again a moot point, but IMO using a ternary operator here makes it unnecessarily
difficult to see that gpa is valid if and only if the exit was an EPT misconfig.

		gpa_t gpa = INVALID_GPA;

		if (exit_reason.basic == EXIT_REASON_EPT_MISCONFIG)
			gpa = vmcs_read64(GUEST_PHYSICAL_ADDRESS);


> -		vcpu->run->exit_reason = KVM_EXIT_INTERNAL_ERROR;
> -		vcpu->run->internal.suberror = KVM_INTERNAL_ERROR_DELIVERY_EV;
> -		vcpu->run->internal.data[0] = vectoring_info;
> -		vcpu->run->internal.data[1] = exit_reason.full;
> -		vcpu->run->internal.data[2] = vmx_get_exit_qual(vcpu);
> -		if (exit_reason.basic == EXIT_REASON_EPT_MISCONFIG) {
> -			vcpu->run->internal.data[ndata++] =
> -				vmcs_read64(GUEST_PHYSICAL_ADDRESS);
> -		}
> -		vcpu->run->internal.data[ndata++] = vcpu->arch.last_vmentry_cpu;
> -		vcpu->run->internal.ndata = ndata;
> +		kvm_prepare_event_vectoring_exit(vcpu, gpa);
>  		return 0;
>  	}
>  
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 83fe0a78146f..e338d583f48f 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -8828,6 +8828,28 @@ void kvm_prepare_emulation_failure_exit(struct kvm_vcpu *vcpu)
>  }
>  EXPORT_SYMBOL_GPL(kvm_prepare_emulation_failure_exit);
>  
> +void kvm_prepare_event_vectoring_exit(struct kvm_vcpu *vcpu, gpa_t gpa)
> +{
> +	u32 reason, intr_info, error_code;
> +	struct kvm_run *run = vcpu->run;
> +	u64 info1, info2;
> +	int ndata = 0;
> +
> +	kvm_x86_call(get_exit_info)(vcpu, &reason, &info1, &info2,
> +				    &intr_info, &error_code);
> +
> +	run->internal.data[ndata++] = info2;
> +	run->internal.data[ndata++] = reason;
> +	run->internal.data[ndata++] = info1;
> +	run->internal.data[ndata++] = (u64)gpa;

No need for the cast.

> +	run->internal.data[ndata++] = vcpu->arch.last_vmentry_cpu;
> +
> +	run->exit_reason = KVM_EXIT_INTERNAL_ERROR;
> +	run->internal.suberror = KVM_INTERNAL_ERROR_DELIVERY_EV;
> +	run->internal.ndata = ndata;
> +}
> +EXPORT_SYMBOL_GPL(kvm_prepare_event_vectoring_exit);
> +
>  static int handle_emulation_failure(struct kvm_vcpu *vcpu, int emulation_type)
>  {
>  	struct kvm *kvm = vcpu->kvm;
> -- 
> 2.43.0
> 

