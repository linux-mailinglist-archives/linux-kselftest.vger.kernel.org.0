Return-Path: <linux-kselftest+bounces-11799-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79C96905DAF
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Jun 2024 23:32:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A1921C20F89
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Jun 2024 21:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8267086250;
	Wed, 12 Jun 2024 21:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BGZ0oYOj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F7E84FD6
	for <linux-kselftest@vger.kernel.org>; Wed, 12 Jun 2024 21:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718227926; cv=none; b=NJY9JfkwRhyvzp/dFkyEsS9mgIdSx6L5Qa6S1aHJHXq5+VsljJudfnixohUQoFKsOLQQO9VC4Oc0tB+nsU5kvErvODoVAsISEjjruTwlULvHREbhPDWRHbh3WEHKJkcxnLnLIcuZyRJp/6qsZOrQwn9HPcjju/YtiOna7z2g5Uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718227926; c=relaxed/simple;
	bh=W5Lf3m/ndcYRRPBJWPF6wvhs/2Q/L4nQNdthZxKjzRg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=d4bI8G7tmTFXeebJ3Bk+FQiyMIYtpou/SCvq3QRAsZQKaw2CMbwn1PxSPka9MFoWyqWdVXSQz40ZVSVFAb32N5FrtYJX3psLCTOrfAU9aDKdh6UUPOoqgfcxhcvx5U0pw1hBebDyJcUHsXhUbFFgrXzeJUuRIJw0dludTbo+j8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BGZ0oYOj; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-62f9fc2cbf6so6059007b3.2
        for <linux-kselftest@vger.kernel.org>; Wed, 12 Jun 2024 14:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718227924; x=1718832724; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1QhL6pyEL28D/XNE8O9WA5q6Sm9P5RrVE+DUX18+yxg=;
        b=BGZ0oYOjCuu+2FztOekL9bGT4kIT+0Mkyxtlqqs4iixMR2yB5xY0xLmd2xZSAFmoxL
         NhwKcdf2MJWhO87UrxL22vqKTdQMLLfk+QSM6pqmfiu5YXG7HXylm/W0MNqSwAEc9tMd
         muevp/bCQxRs5QSt/Y3L8aCehNOu6VKmCmpkViMXfCxi6SwrFY3YK3YnYmOGKM62TfoU
         bNctT8HnlUkayiMEC1SYecE80166dbZh+hwfXXWnyHYDs8G486V+oYM9ihIv27eCGwfp
         SIRYDMUIko+f1VvH65QrcaQ+j7djCOafZqYfhBx48v2xhBtBaUYpnWGbgp//+tV688Dd
         OYEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718227924; x=1718832724;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1QhL6pyEL28D/XNE8O9WA5q6Sm9P5RrVE+DUX18+yxg=;
        b=dNJc5dFn0ZgMHmEDJCEsl0U5qvWW0dDFUFHo1m8Z5NQ/SLAIEnesVTKSgHMxXwNW3Q
         6r+FRV4ftMEkOPFgTkbUBm7Yj3PakqHIOpd7F/ew3Gzi/Ltp/rBZjC/3ZOwX8p0C6VM/
         WWhekfustJD0eyNh36X8tReMLkLjC9VSQpmffi10kMqSC9tXVVHo9FLUWorIKJSQsnsw
         HmjiWOWAHVJHg1lXeDJUCad8kS5HTfKRzrxSCqET/uQ4edoB+LnTfBSEHunTtmRN94XP
         qRKdXH8NPJ2hfdwwcan7O6nI3bfHhZ6TTPQ7wcjzozaGaMfz5mlYZ7fVZ0GxU990BeQG
         3f4w==
X-Forwarded-Encrypted: i=1; AJvYcCWHVBdoRFVLSmv/OK0/h23UgPJwC65DoDcCwtOfRVEUrG4rGhaf6XwlQEnt10vQmfPCRFHAcyxSoo7TMEhzHJyCE4LxPmvFsgWhO+obrzOZ
X-Gm-Message-State: AOJu0YzH7JU++5MCN2rg/Dfq9a+4KIdbi+aL9oyJ/edweNbDXmGv6+1C
	qLBBvaSz6q/Z4pcPKmNjBwxqW0uOevYM+AsCoxqgpFMabJuti+dr0fgm0x7ifgqfvne071L+ne/
	WVQ==
X-Google-Smtp-Source: AGHT+IElKu5tuXfOpkwDgTwij1K2xNLep+MJ1d93sRu5Kogldzr3WaT9Nh8Ti2R0sk/kH/nRqM8JoaY4WmY=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:690c:d88:b0:62c:f976:a763 with SMTP id
 00721157ae682-62fb72f2569mr9479477b3.1.1718227923971; Wed, 12 Jun 2024
 14:32:03 -0700 (PDT)
Date: Wed, 12 Jun 2024 14:32:02 -0700
In-Reply-To: <ZiJzFsoHR41Sd8lE@chao-email>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240207172646.3981-1-xin3.li@intel.com> <20240207172646.3981-8-xin3.li@intel.com>
 <ZiJzFsoHR41Sd8lE@chao-email>
Message-ID: <ZmoT0jaX_3Ww3Uzu@google.com>
Subject: Re: [PATCH v2 07/25] KVM: VMX: Set intercept for FRED MSRs
From: Sean Christopherson <seanjc@google.com>
To: Chao Gao <chao.gao@intel.com>
Cc: Xin Li <xin3.li@intel.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	pbonzini@redhat.com, corbet@lwn.net, tglx@linutronix.de, mingo@redhat.com, 
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	shuah@kernel.org, vkuznets@redhat.com, peterz@infradead.org, 
	ravi.v.shankar@intel.com, xin@zytor.com
Content-Type: text/plain; charset="us-ascii"

On Fri, Apr 19, 2024, Chao Gao wrote:
> On Wed, Feb 07, 2024 at 09:26:27AM -0800, Xin Li wrote:
> >Add FRED MSRs to the valid passthrough MSR list and set FRED MSRs intercept
> >based on FRED enumeration.

This needs a *much* more verbose explanation.  It's pretty darn obvious _what_
KVM is doing, but it's not at all clear _why_ KVM is passing through FRED MSRs.
E.g. why is FRED_SSP0 not included in the set of passthrough MSRs?

> > static void vmx_vcpu_config_fred_after_set_cpuid(struct kvm_vcpu *vcpu)
> > {
> > 	struct vcpu_vmx *vmx = to_vmx(vcpu);
> >+	bool fred_enumerated;
> > 
> > 	kvm_governed_feature_check_and_set(vcpu, X86_FEATURE_FRED);
> >+	fred_enumerated = guest_can_use(vcpu, X86_FEATURE_FRED);
> > 
> >-	if (guest_can_use(vcpu, X86_FEATURE_FRED)) {
> >+	if (fred_enumerated) {
> > 		vm_entry_controls_setbit(vmx, VM_ENTRY_LOAD_IA32_FRED);
> > 		secondary_vm_exit_controls_setbit(vmx,
> > 						  SECONDARY_VM_EXIT_SAVE_IA32_FRED |
> >@@ -7788,6 +7793,16 @@ static void vmx_vcpu_config_fred_after_set_cpuid(struct kvm_vcpu *vcpu)
> > 						    SECONDARY_VM_EXIT_SAVE_IA32_FRED |
> > 						    SECONDARY_VM_EXIT_LOAD_IA32_FRED);
> > 	}
> >+
> >+	vmx_set_intercept_for_msr(vcpu, MSR_IA32_FRED_RSP0, MSR_TYPE_RW, !fred_enumerated);
> >+	vmx_set_intercept_for_msr(vcpu, MSR_IA32_FRED_RSP1, MSR_TYPE_RW, !fred_enumerated);
> >+	vmx_set_intercept_for_msr(vcpu, MSR_IA32_FRED_RSP2, MSR_TYPE_RW, !fred_enumerated);
> >+	vmx_set_intercept_for_msr(vcpu, MSR_IA32_FRED_RSP3, MSR_TYPE_RW, !fred_enumerated);
> >+	vmx_set_intercept_for_msr(vcpu, MSR_IA32_FRED_STKLVLS, MSR_TYPE_RW, !fred_enumerated);
> >+	vmx_set_intercept_for_msr(vcpu, MSR_IA32_FRED_SSP1, MSR_TYPE_RW, !fred_enumerated);
> >+	vmx_set_intercept_for_msr(vcpu, MSR_IA32_FRED_SSP2, MSR_TYPE_RW, !fred_enumerated);
> >+	vmx_set_intercept_for_msr(vcpu, MSR_IA32_FRED_SSP3, MSR_TYPE_RW, !fred_enumerated);
> >+	vmx_set_intercept_for_msr(vcpu, MSR_IA32_FRED_CONFIG, MSR_TYPE_RW, !fred_enumerated);
> 
> Use a for-loop here? e.g., 
> 	for (i = MSR_IA32_FRED_RSP0; i <= MSR_IA32_FRED_CONFIG; i++)

Hmm, I'd prefer to keep the open coded version.  It's not pretty, but I don't
expect this to have much, if any, maintenance cost.  And using a loop makes it
harder to both understand _exactly_ what's happening, and to search for relevant
code.  E.g. it's quite difficult to see that FRED_SSP0 is still intercepted (see
my comment regarding the changelog).

