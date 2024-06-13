Return-Path: <linux-kselftest+bounces-11879-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C8CA90792E
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jun 2024 19:01:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8181B1C230DA
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jun 2024 17:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A239149C4A;
	Thu, 13 Jun 2024 17:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ADEac/KR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D964C6B
	for <linux-kselftest@vger.kernel.org>; Thu, 13 Jun 2024 17:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718298093; cv=none; b=Xq9870WITiuAqWJXaIgiHeGM/SpRC7TzopEf1nt0Haze9RvcmbNOsTxZvF7tqX71y0vV7ld1zp30ZCtjkwUkuddH38XEVCFN88c8GgPlAr3/mzAo3UFG1CO1g/1pYo6aNq1IncjchsAZh6khIy3TfKi/LDGnEGZNB0OpzrKK4Y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718298093; c=relaxed/simple;
	bh=0lQAT2+KMVRgoQfAgOXbFpy27kuZJljG825RDkACMEY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NTYdyG6zcxVyqBL8aymXeRg7L7xzmXLvyCcHoSWOAJLpESPow6jEhm18HxZoe4ht5Os4pEt2XHhWAGkQ+admtW1oL/sHDkoy1XkMsf1N/hrkJ1STklwXT3Vg1kjEG5gTAWvNvw5mcjE6hUUv/x/B62xCCvqMdUB5DPHX8tO19sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ADEac/KR; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2c2d0e695d7so1040278a91.1
        for <linux-kselftest@vger.kernel.org>; Thu, 13 Jun 2024 10:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718298091; x=1718902891; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=XStJnbLK4V1qhVKaIcxt2hEnuPMBNwhPJrtY0iEHhTg=;
        b=ADEac/KRHgff2C9IepoV7zzOz6xmZ8nc89FX03seKfRMKn907bPjGbTmCTH9eAsUu2
         aBGU72SZ8aBrK8fAjnZL1yQxV4DQ830AOUTlZRaDJDNe6QaUUohoWAyMiPBxpGwzcNT8
         lIVc/2gFQboPK6Fv5op1Ouq+1uw+vOAccO6L6Wp48++zRL39p0fzMnZog52djMe9vw3k
         o9SdfCOPto6z3LSTOayJdRBtHChp43dLyS2FIgMfgIkd94jBhZndNTpZsJSErAucg5sR
         h6kpBLkiKNqxtPCpQxzxcXgC3WKvMjRvqpF4AOuP7m1Un0bKZv8KBkswQKfqvQOGfgLm
         yoDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718298091; x=1718902891;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XStJnbLK4V1qhVKaIcxt2hEnuPMBNwhPJrtY0iEHhTg=;
        b=bqbFxZRiZlYgjmTBQeOd0ddsOZwUzuEKXHpbhydej+3VD0Eas7N2dm9q8JPAWQ+FAS
         VmHj8GDx5bywe/yKBXM3sCRfsY4axUplvK47svFWxsGxybdE6R0MW2EfpFpNkwuPPfYl
         0R5SvQGzgA2aqzZA4U1c5GqRNsRLtueawa0/upuBkbfH+aAAhdAsFMyh31zksyzBM9SI
         LgGuZ7kpWLHOBURY/IhOx61YiiVBkNuEkYXNHk/e+C2d6bB42N3Vk9Yo2XSKFGiS+jcy
         WO2eegscjBOZWJNvE1vA4QBD8KbZDBr824P4BrAy2CLmWtZEMb62V+GhfmgUMEKvULX4
         aFGA==
X-Forwarded-Encrypted: i=1; AJvYcCUoUaeI1F1UD01QrmMM/uy+i6ImhBPIkm5PZh2smq/tKXcRWv2OSlulSGPDrBmx61usxm0lfdWQdE2yaZcH9WxzDrb6GvdrKPwCGMZ+YXLp
X-Gm-Message-State: AOJu0Yw9WWe0TJdBC0bxD9VoNIB9xCILb1HBf2UzFwt5sEw/OWBofY4r
	+aOFmcmvE9UVvRzTQgviEym+MaBA+bfLVJaKzBNo391zJMdUcxFaWY7FGO8nX40OTMkECBH9q/S
	6dg==
X-Google-Smtp-Source: AGHT+IGY0fQD4689v6rLCIHgS6868CkRehhGNu4lanKhlcUUceleGb6rw06vnZTUAaafVZSYbUgXh/S7jdE=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90a:c7d0:b0:2c3:c8b:f634 with SMTP id
 98e67ed59e1d1-2c4da9c8aefmr1011a91.0.1718298090662; Thu, 13 Jun 2024 10:01:30
 -0700 (PDT)
Date: Thu, 13 Jun 2024 10:01:29 -0700
In-Reply-To: <20240207172646.3981-14-xin3.li@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240207172646.3981-1-xin3.li@intel.com> <20240207172646.3981-14-xin3.li@intel.com>
Message-ID: <Zmsl6WtT40-u4Pkn@google.com>
Subject: Re: [PATCH v2 13/25] KVM: VMX: Handle VMX nested exception for FRED
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
> @@ -725,8 +733,28 @@ static void kvm_multiple_exception(struct kvm_vcpu *vcpu,
>  		vcpu->arch.exception.injected = false;
>  		vcpu->arch.exception.pending = false;
>  
> +		/*
> +		 * A #DF is NOT a nested event per its definition, however per
> +		 * FRED spec 5.0 Appendix B, its delivery determines the new
> +		 * stack level as is done for events occurring when CPL = 0.
> +		 */

Similar to my comments about CR2, this is mostly noise.  Unless I'm missing a
patch, KVM is not responsible for emulating the stack level stuff, and so there
is zero reason to mention it, because it's not relevant to the KVM code.  Simply
say that #DF is defined to not be a nested exception.

		/* #DF is NOT a nested event, per its definition. */


> +		vcpu->arch.exception.nested = false;
> +
>  		kvm_queue_exception_e(vcpu, DF_VECTOR, 0);
>  	} else {
> +		/*
> +		 * FRED spec 5.0 Appendix B: delivery of a nested exception
> +		 * determines the new stack level as is done for events
> +		 * occurring when CPL = 0.
> +		 *
> +		 * IOW, FRED event delivery of an event encountered in ring 3
> +		 * normally uses stack level 0 unconditionally.  However, if
> +		 * the event is an exception nested on any earlier event,
> +		 * delivery of the nested exception will consult the FRED MSR
> +		 * IA32_FRED_STKLVLS to determine which stack level to use.
> +		 */

And drop this entirely.  The above does not help the reader understand _why_ KVM
sets nested=true for FRED.  E.g. there's no CPL check here.

IMO, this code is entirely self-explanatory; KVM is quite obviously handling a
back-to-back exceptions, and it doesn't take a big mental leap to grok that FRED
tracks that information by describing the second exception as "nested".

> +		vcpu->arch.exception.nested = kvm_is_fred_enabled(vcpu);
> +
>  		/* replace previous exception with a new one in a hope
>  		   that instruction re-execution will regenerate lost
>  		   exception */

