Return-Path: <linux-kselftest+bounces-11798-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 706E5905D91
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Jun 2024 23:20:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 993911C21275
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Jun 2024 21:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37E1585923;
	Wed, 12 Jun 2024 21:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2UMGOmvp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD29F83A12
	for <linux-kselftest@vger.kernel.org>; Wed, 12 Jun 2024 21:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718227254; cv=none; b=n1tTFbt3NjCRKroY3616OjjEMwUO+/tm+Mlz8OmNPF7U3kmF/p6s0WXn0y48FMKXwojRSQ7tIM3/pscYzX0HjMU9gC5PYPWTqKH3mZMvMpA+2ZSqhqcYZmQ0LFpAWf0jIoJue1eE0sShY3LdHGi61S3xY1rO8McWif8CzQRI6fE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718227254; c=relaxed/simple;
	bh=1GcSncPwqKEQjxsMosB7/O2aygmUJPI07VDJmC37b5E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=F4SHeKISSc1ed0UOhrghHbP5CkI+QTdE47kkYUn6knzTlS+0gXAGdxtHbuRIwUYrqTUYhyzDUPN+4wdyhWSAxrTFqpQdX6A0vJdaxzkeyhKjPbqcJlwHAR9vKkTqm2lx/jCZ2LPnfJNTD3khVECz1FtxNwaSqA63hZ1HNIYgKSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2UMGOmvp; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-1f72c0c4529so2331985ad.3
        for <linux-kselftest@vger.kernel.org>; Wed, 12 Jun 2024 14:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718227252; x=1718832052; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=a4s5wFvfeNJXCJWEmUtUY237craFIfNnXh+7wQwiZM8=;
        b=2UMGOmvpfuxZFXk9IV9IutXeotId8EYUzKxQe4/pzSKzalDUMuUMEqCZ5S5+bCP5+m
         SSHuT//O0SB2zqV4FxFGPHmmZGLwPSP56Y1+PxVV6hhGDtQ6R2IcJwamT9EcJ7LMdEjO
         HltO6YBhQ5oSis1c/KH9H/H/EXXqwu6pKt6rSzWzEOx+N6ioUBcRUr6UIX4Ak2hqLOS4
         YR1Ka/kf6HBxDtfcKPPQ5TOYZ8bkDAGDxplSzY1EWkF6+3ahoxzvrmZ/5xGlAvT4BWhd
         VQ41E3iDlGaeha/vh3q5coQbWOCCC8yQRr7AcyCV2yD1Hm9oYxHtmdEVxYp0BcielSdp
         jVJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718227252; x=1718832052;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a4s5wFvfeNJXCJWEmUtUY237craFIfNnXh+7wQwiZM8=;
        b=XsXZNy8FInbWRkwtVZhFyhUXdUogjU3xo0KvNHQJB9HCSnjmpDGD3PvsOsAtyv42LT
         lCyRlaEdwtJsYjUl5He3QqOuOQDJv6lQML66Vi098DGVzchYgCVmlCcFxzfkECTNiZ+w
         VXlkd4wnCo4vEN7gkmvGATLFMLCuawh7fG8++mma8TnkAdCYYFB+2+6nY0sDcJi6+2wQ
         9lwpOk4DatbserXh+oFqCAVHpRrZkBd5qihb4bV68zeOFnfBhg6lJSakVFtSEZCKUPmk
         lPRO6mbNMnCUkEPvI+6SjJUjD5Zf6JdF9PWvCiciVgyePBW3HeGnaYhebCjJc7N8P5of
         npcw==
X-Forwarded-Encrypted: i=1; AJvYcCX0vAe2IGFtOTlymWKMDm09eMn25Z9VV5kycObReGGkg/4IQPmKk7FTIMAgDuO1X5XpxVMl+5zcKP1NFbmJdH/oQ0LUcTW0BUYciZai/Pud
X-Gm-Message-State: AOJu0YwQP4hJFAgL6idLeWvZhBAx/7OTBbzbVigzz7jEJIEjIHo5hIlk
	94GasQlwtzzIqS2TR6wN4tpgR2QOBYnTqIEEXIQ5LKDa4wV/kowWy6vlxoB6pUpY0tVRInZ+OMN
	LLw==
X-Google-Smtp-Source: AGHT+IF236fVTqan1xeFH5dPPmgc0NM7zLynRwigfEMIC3iJa54rvvA/hW7i8p+BK04gMU89grxKlGMEn9I=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:903:234f:b0:1f3:f8c:55d5 with SMTP id
 d9443c01a7336-1f83b55b4b7mr84625ad.2.1718227252048; Wed, 12 Jun 2024 14:20:52
 -0700 (PDT)
Date: Wed, 12 Jun 2024 14:20:50 -0700
In-Reply-To: <20240207172646.3981-8-xin3.li@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240207172646.3981-1-xin3.li@intel.com> <20240207172646.3981-8-xin3.li@intel.com>
Message-ID: <ZmoRMp_-CXC9QqPK@google.com>
Subject: Re: [PATCH v2 07/25] KVM: VMX: Set intercept for FRED MSRs
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
> @@ -7774,10 +7777,12 @@ static void update_intel_pt_cfg(struct kvm_vcpu *vcpu)
>  static void vmx_vcpu_config_fred_after_set_cpuid(struct kvm_vcpu *vcpu)
>  {
>  	struct vcpu_vmx *vmx = to_vmx(vcpu);
> +	bool fred_enumerated;
>  
>  	kvm_governed_feature_check_and_set(vcpu, X86_FEATURE_FRED);
> +	fred_enumerated = guest_can_use(vcpu, X86_FEATURE_FRED);

"enumerated" isn't correct.  Userspace can enumerate FRED to the guest even if
FRED is unsupported in KVM.

Planning for a future where this becomes guest_cpu_cap_has(), maybe "has_fred"?

> -	if (guest_can_use(vcpu, X86_FEATURE_FRED)) {
> +	if (fred_enumerated) {
>  		vm_entry_controls_setbit(vmx, VM_ENTRY_LOAD_IA32_FRED);
>  		secondary_vm_exit_controls_setbit(vmx,
>  						  SECONDARY_VM_EXIT_SAVE_IA32_FRED |
> @@ -7788,6 +7793,16 @@ static void vmx_vcpu_config_fred_after_set_cpuid(struct kvm_vcpu *vcpu)
>  						    SECONDARY_VM_EXIT_SAVE_IA32_FRED |
>  						    SECONDARY_VM_EXIT_LOAD_IA32_FRED);
>  	}
> +
> +	vmx_set_intercept_for_msr(vcpu, MSR_IA32_FRED_RSP0, MSR_TYPE_RW, !fred_enumerated);
> +	vmx_set_intercept_for_msr(vcpu, MSR_IA32_FRED_RSP1, MSR_TYPE_RW, !fred_enumerated);
> +	vmx_set_intercept_for_msr(vcpu, MSR_IA32_FRED_RSP2, MSR_TYPE_RW, !fred_enumerated);
> +	vmx_set_intercept_for_msr(vcpu, MSR_IA32_FRED_RSP3, MSR_TYPE_RW, !fred_enumerated);
> +	vmx_set_intercept_for_msr(vcpu, MSR_IA32_FRED_STKLVLS, MSR_TYPE_RW, !fred_enumerated);
> +	vmx_set_intercept_for_msr(vcpu, MSR_IA32_FRED_SSP1, MSR_TYPE_RW, !fred_enumerated);
> +	vmx_set_intercept_for_msr(vcpu, MSR_IA32_FRED_SSP2, MSR_TYPE_RW, !fred_enumerated);
> +	vmx_set_intercept_for_msr(vcpu, MSR_IA32_FRED_SSP3, MSR_TYPE_RW, !fred_enumerated);
> +	vmx_set_intercept_for_msr(vcpu, MSR_IA32_FRED_CONFIG, MSR_TYPE_RW, !fred_enumerated);
>  }
>  
>  static void vmx_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
> -- 
> 2.43.0
> 

