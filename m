Return-Path: <linux-kselftest+bounces-24072-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C928DA063DC
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Jan 2025 18:58:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA4991675EC
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Jan 2025 17:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C385D200BA1;
	Wed,  8 Jan 2025 17:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1oy7YQtG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23EAA200B95
	for <linux-kselftest@vger.kernel.org>; Wed,  8 Jan 2025 17:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736359109; cv=none; b=tCgUeKUtC1LB6tE3L2q/IW0dtZl2ed2h0UotIzxkanU5lKIqCqog2nlw++hP8YmVAsPRLgjdIUK/mYJ3QdycThUoQXrOjpNwFerR7IBQfPUENA9bMYFrn8V4BofBMvIekbc8sSGYhc3KlL3BUfknOQ0d/FVe8qh2ePDms9qWWJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736359109; c=relaxed/simple;
	bh=ujwKZVv/We1AztxkRitdfP/bw/C1YgmUWIImLGUlCAY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Om0Iv/8HbaU9tDOpvf5JkwTSSbsOjrwN5GlIjO7ol7+0wobFWifEjb+SMLQbY91yIhElcj/af63n+Ea1g5HyiQ/dmKi0j2RuD4IoEe9Z95DknCACP30fYsKMPUrAhO/iU6+IvEOyZyPJ5hevCCwDAvzCuXljPtrTCfr3YDAkAhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1oy7YQtG; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-21655569152so232580195ad.2
        for <linux-kselftest@vger.kernel.org>; Wed, 08 Jan 2025 09:58:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736359107; x=1736963907; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xp3NZYHZMMU9kdzS5JypGB4AU6S1vCs32xlQdliKkDI=;
        b=1oy7YQtGAFKbx41dpHT/OYwoRSANgJ4fw2I2LPjoE4pTD9xfVXFzcT0i/xxnnKaLeV
         XPBWPbeFfOZCElRkmOaXqt9Jw6kRT9ML+AHYLAa3BLIZJ5gIQRf1EBTabSObx4Illyyw
         32L86h1/RvBE2F9c6OXd3eLQon2EXtGcOYEc/W+OD+RuhMNfR1H4jxzlZUroOP4Gb3ck
         b1EELUV7jQgkHcowXDdPvFfFFuHlAfYgrt7JyG9N3QF/NHOagLrc1nBzelR9rXa6vf2x
         NVuceLEBmoDCdfRClHKwKJ/jkt4XUVtWX8qT29PexSp1iXq8ZwA47/qvybyRu0p/acDu
         +cWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736359107; x=1736963907;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xp3NZYHZMMU9kdzS5JypGB4AU6S1vCs32xlQdliKkDI=;
        b=bSiMXMDacUz5nSuQWnSAotLKCdUysq+rVOcrQTBvBfZpTUiZmbCZiZMVdvgEawShzy
         Djqq5CedlH5GmNQwe4PHL3zpWfjjqiiUZNz/pS+n/tpoJJWUQQytmkJCBAA78Kh76qr0
         Tvn6AfsKKQOlwFKWU5JCfziI/eaGRpfxcPAgJinAcGlTDRVtpj0LZVT8E9RXkgGFxB/N
         L31lPqU9zlT91ZzqSE592c/QCGkSKWSxknv+X+W6/13ohWo5gGYhEbg5m998791SC785
         2tGYFIiLP9YL1p5MWFwaT4gvEEUT6TzWpmtLNTBzs90vetxn7nPJvgvo+Z+b9CeWIpje
         pRGA==
X-Forwarded-Encrypted: i=1; AJvYcCUtw1jdflKhBohSDBBGcGNN6x7BJt3UAbbu9xTcICByGK01TNn7iK5y3apnV5zpZkhKVlXLo3qchJwreZadyyE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6cd9KxKhpTLIvezPafMd8MOCojhEadcPgEx/CR+9j3YSVMZlB
	YS7E7nsD4Yo95qcDDp/+sjtPT6nHOa0XcxeiyeofUoTow7i4n3r4AoY6gLJJRScAOORuxQ5LbL2
	d3g==
X-Google-Smtp-Source: AGHT+IGH++eOGif5KmzFVwEN/XcwLmcORq8FSONH0oSONcZvo5iQ5TaFGj3PNFG7sQUWjAQ6oBZAdp3nsI4=
X-Received: from pfbdc8.prod.google.com ([2002:a05:6a00:35c8:b0:725:c7de:e052])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:201c:b0:1e1:bd5b:b84b
 with SMTP id adf61e73a8af0-1e88d2f69famr5000789637.40.1736359107555; Wed, 08
 Jan 2025 09:58:27 -0800 (PST)
Date: Wed, 8 Jan 2025 09:58:26 -0800
In-Reply-To: <20240918205319.3517569-3-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240918205319.3517569-1-coltonlewis@google.com> <20240918205319.3517569-3-coltonlewis@google.com>
Message-ID: <Z368wnzQgMKMclFw@google.com>
Subject: Re: [PATCH v2 2/6] KVM: x86: selftests: Define AMD PMU CPUID leaves
From: Sean Christopherson <seanjc@google.com>
To: Colton Lewis <coltonlewis@google.com>
Cc: kvm@vger.kernel.org, Mingwei Zhang <mizhang@google.com>, 
	Jinrong Liang <ljr.kernel@gmail.com>, Jim Mattson <jmattson@google.com>, 
	Aaron Lewis <aaronlewis@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

The shortlog is misleading.  It's the *leaves* that are being defined, it's the
features and properties.

On Wed, Sep 18, 2024, Colton Lewis wrote:
> This defined the CPUID calls to determine what extensions and
> properties are available.

This is not a coherent changelog.

> AMD reference manual names listed below.
> 
> * PerfCtrExtCore (six core counters instead of four)
> * PerfCtrExtNB (four counters for northbridge events)
> * PerfCtrExtL2I (four counters for L2 cache events)
> * PerfMonV2 (support for registers to control multiple
>   counters with a single register write)
> * LbrAndPmcFreeze (support for freezing last branch recorded stack on
>   performance counter overflow)
> * NumPerfCtrCore (number of core counters)
> * NumPerfCtrNB (number of northbridge counters)
> 
> Signed-off-by: Colton Lewis <coltonlewis@google.com>
> ---
>  tools/testing/selftests/kvm/include/x86_64/processor.h | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/tools/testing/selftests/kvm/include/x86_64/processor.h b/tools/testing/selftests/kvm/include/x86_64/processor.h
> index a0c1440017bb..44ddfc4c1673 100644
> --- a/tools/testing/selftests/kvm/include/x86_64/processor.h
> +++ b/tools/testing/selftests/kvm/include/x86_64/processor.h
> @@ -183,6 +183,9 @@ struct kvm_x86_cpu_feature {
>  #define	X86_FEATURE_GBPAGES		KVM_X86_CPU_FEATURE(0x80000001, 0, EDX, 26)
>  #define	X86_FEATURE_RDTSCP		KVM_X86_CPU_FEATURE(0x80000001, 0, EDX, 27)
>  #define	X86_FEATURE_LM			KVM_X86_CPU_FEATURE(0x80000001, 0, EDX, 29)
> +#define	X86_FEATURE_PERF_CTR_EXT_CORE	KVM_X86_CPU_FEATURE(0x80000001, 0, ECX, 23)

This ordering is "broken", and confused me for quite some time.  These new features
are in ECX, but they're landed after features for EDX.  To make matters worse,
there's an existing feature, SVM, defined for ECX.

TL;DR: please be more careful about the ordering, don't just drop stuff at the
end.

> +#define	X86_FEATURE_PERF_CTR_EXT_NB	KVM_X86_CPU_FEATURE(0x80000001, 0, ECX, 24)
> +#define	X86_FEATURE_PERF_CTR_EXT_L2I	KVM_X86_CPU_FEATURE(0x80000001, 0, ECX, 28)

To make life easier for developers, I think it makes sense to use the kernel's
names (when the kernel also defines a feature), and adjust the property names to
follow suit.

If there are no objections, I'll apply this as:

--
Author:     Colton Lewis <coltonlewis@google.com>
AuthorDate: Wed Sep 18 20:53:15 2024 +0000
Commit:     Sean Christopherson <seanjc@google.com>
CommitDate: Wed Jan 8 09:55:57 2025 -0800

    KVM: selftests: Add defines for AMD PMU CPUID features and properties
    
    Add macros for AMD's PMU related CPUID features.  To make it easier to
    cross reference selftest code with KVM/kernel code, use the same macro
    names as the kernel for the features.
    
    For reference, the AMD APM defines the features/properties as:
    
      * PerfCtrExtCore (six core counters instead of four)
      * PerfCtrExtNB (four counters for northbridge events)
      * PerfCtrExtL2I (four counters for L2 cache events)
      * PerfMonV2 (support for registers to control multiple
        counters with a single register write)
      * LbrAndPmcFreeze (support for freezing last branch recorded stack on
        performance counter overflow)
      * NumPerfCtrCore (number of core counters)
      * NumPerfCtrNB (number of northbridge counters)
    
    Signed-off-by: Colton Lewis <coltonlewis@google.com>
    Link: https://lore.kernel.org/r/20240918205319.3517569-3-coltonlewis@google.com
    [sean: massage changelog, use same names as the kernel]
    Signed-off-by: Sean Christopherson <seanjc@google.com>

diff --git a/tools/testing/selftests/kvm/include/x86/processor.h b/tools/testing/selftests/kvm/include/x86/processor.h
index 9ec984cf8674..8de7cace1fbf 100644
--- a/tools/testing/selftests/kvm/include/x86/processor.h
+++ b/tools/testing/selftests/kvm/include/x86/processor.h
@@ -181,6 +181,9 @@ struct kvm_x86_cpu_feature {
  * Extended Leafs, a.k.a. AMD defined
  */
 #define        X86_FEATURE_SVM                 KVM_X86_CPU_FEATURE(0x80000001, 0, ECX, 2)
+#define        X86_FEATURE_PERFCTR_CORE        KVM_X86_CPU_FEATURE(0x80000001, 0, ECX, 23)
+#define        X86_FEATURE_PERFCTR_NB          KVM_X86_CPU_FEATURE(0x80000001, 0, ECX, 24)
+#define        X86_FEATURE_PERFCTR_LLC         KVM_X86_CPU_FEATURE(0x80000001, 0, ECX, 28)
 #define        X86_FEATURE_NX                  KVM_X86_CPU_FEATURE(0x80000001, 0, EDX, 20)
 #define        X86_FEATURE_GBPAGES             KVM_X86_CPU_FEATURE(0x80000001, 0, EDX, 26)
 #define        X86_FEATURE_RDTSCP              KVM_X86_CPU_FEATURE(0x80000001, 0, EDX, 27)
@@ -197,6 +200,8 @@ struct kvm_x86_cpu_feature {
 #define        X86_FEATURE_VGIF                KVM_X86_CPU_FEATURE(0x8000000A, 0, EDX, 16)
 #define X86_FEATURE_SEV                        KVM_X86_CPU_FEATURE(0x8000001F, 0, EAX, 1)
 #define X86_FEATURE_SEV_ES             KVM_X86_CPU_FEATURE(0x8000001F, 0, EAX, 3)
+#define        X86_FEATURE_PERFMON_V2          KVM_X86_CPU_FEATURE(0x80000022, 0, EAX, 0)
+#define        X86_FEATURE_LBR_PMC_FREEZE      KVM_X86_CPU_FEATURE(0x80000022, 0, EAX, 2)
 
 /*
  * KVM defined paravirt features.
@@ -283,6 +288,8 @@ struct kvm_x86_cpu_property {
 #define X86_PROPERTY_GUEST_MAX_PHY_ADDR                KVM_X86_CPU_PROPERTY(0x80000008, 0, EAX, 16, 23)
 #define X86_PROPERTY_SEV_C_BIT                 KVM_X86_CPU_PROPERTY(0x8000001F, 0, EBX, 0, 5)
 #define X86_PROPERTY_PHYS_ADDR_REDUCTION       KVM_X86_CPU_PROPERTY(0x8000001F, 0, EBX, 6, 11)
+#define X86_PROPERTY_NR_PERFCTR_CORE           KVM_X86_CPU_PROPERTY(0x80000022, 0, EBX, 0, 3)
+#define X86_PROPERTY_NR_PERFCTR_NB             KVM_X86_CPU_PROPERTY(0x80000022, 0, EBX, 10, 15)
 
 #define X86_PROPERTY_MAX_CENTAUR_LEAF          KVM_X86_CPU_PROPERTY(0xC0000000, 0, EAX, 0, 31)

