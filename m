Return-Path: <linux-kselftest+bounces-12874-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FD5B91AE58
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Jun 2024 19:42:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35B1328DB05
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Jun 2024 17:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C286F199238;
	Thu, 27 Jun 2024 17:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bRAQV1Dp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E6881C6A7
	for <linux-kselftest@vger.kernel.org>; Thu, 27 Jun 2024 17:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719510142; cv=none; b=n1TarK/ISkEEMk/wGFMvHpRxIwISBUpGopJcyHHdGMRsJJpUBvoh27LB8wmbJKSzKSVN2RgqP7dxl5Kx71IdYL7+AKPyQX2bGn2DbaJCO9oDDolynSFEZIVeKvBkOziwEM5ZS8DRmKFWNkvuL7POJuzpCVZSkNWXfpPtNb40Shg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719510142; c=relaxed/simple;
	bh=QWiCFle1OjlmoDLkJTUXa/Nbue5uZFbpxYfIHw4qoco=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=G9l28OYHB0WxJX4FEgmGhz5NCzaS8YVHuZK3lp758vjv5smk6XeqUXsE3fmcIvQoC2EmVQFekMJATbqTaxIAm/aNpzoyD9fQZCWYqn0qXB+WxcNIstd0hljeHv3C9WgtGo92XxV7g0PMFitvgyscrflL/YeD+OwSbvwFoWVUADw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bRAQV1Dp; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-64507372362so116073277b3.1
        for <linux-kselftest@vger.kernel.org>; Thu, 27 Jun 2024 10:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719510140; x=1720114940; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1sQpJMlhaOImbaZsmQPczRmnXse/xZ0ADeEMYCxzlHY=;
        b=bRAQV1Dp5u5Adi3cLjCobR05EDS+7XtfTblwgoAQ6i0LcBITtl2aeHrQrK6R7gsqrU
         nGoKGSCKkH7iE1905nRzgCDq7fxDRqVM5XfgQffNnxluFhMafO1kBlDPb65eGwCmQGuA
         GCN0nkdv2HB+2kyW0I1B4SF71atzgayuRyAUVkPeUu1nrPZriuvch9r/gk1wb/Rj/qta
         xg0apBKlYyGT8iwS4HhkB4ImrXR3+8KDhlg19rxa1HrXSqFnWV/AMXSJDVzwV9PpDKYp
         YozyGDw5xHRPwaJXJwwaGU1WGxtaKvszww9E+pxr2sNP8QmHZC3S8tWjbBm9SFiPQno/
         GjTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719510140; x=1720114940;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1sQpJMlhaOImbaZsmQPczRmnXse/xZ0ADeEMYCxzlHY=;
        b=lvZtol2tkD6nqf54zSKFG9zKbszt97EzYY9RNSwtOZ4Jp8IrjbuOxoNGLuZbS+jJN8
         BRGxwR95UcNpcfu55QFTL+XK1HcvM0spow7XGD6jgAR1nA82Zg2d2EMKJIvjyrDpCTUB
         oSiwcIFSuXcQsSsnaoIl4syYdChckkiRq1p7ngn/MVEu/7Dg3sa5R6CCallemaUb4R7f
         FrCxsbMFNDnrSTvHewLeK4CWQhEs58HRdCCoRuvfWxzSDn5TgnWFhoIXTJ6gPhbNJcAV
         cKGvp9rJV4MEDXdD9RMGVG/ShuJviShyRUdggFQKzQl8wjFeD+U32aHNsiDL0HyiBRP/
         jdww==
X-Forwarded-Encrypted: i=1; AJvYcCUO3rzM9dszprI9FGpIMzskWesmuDg6SnFvzD7xC3BkyaOY23bRFMQCghtSn4PZ/CQ1RcFMDZFD97mBZCUPp8EipD/UpOj5eQVykjLgS8RE
X-Gm-Message-State: AOJu0Ywgo9iM2g/Jg7enRN/9PUi55YKUREZegd3edX18j2myQBMtu7ao
	xB9aJWTHQpMoR4nseb7FuRu0bYS604hdpFCX4qYI89XXWIgXTIlICb58Jrjt6qCYtPbS5JG06zj
	8yQ==
X-Google-Smtp-Source: AGHT+IE8qFFP1ajg6w4kSm8Qn4ro9HS/brjSiPL5I1EbZHI/6XKc4cVAGbMPmz4OZwpyYhZSw4GJu61Pw7M=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:690c:c16:b0:631:9b3b:525d with SMTP id
 00721157ae682-642997c4d57mr470617b3.4.1719510140198; Thu, 27 Jun 2024
 10:42:20 -0700 (PDT)
Date: Thu, 27 Jun 2024 10:42:18 -0700
In-Reply-To: <20240621204305.1730677-2-mlevitsk@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240621204305.1730677-1-mlevitsk@redhat.com> <20240621204305.1730677-2-mlevitsk@redhat.com>
Message-ID: <Zn2ker_KZ7Fk-7W1@google.com>
Subject: Re: [PATCH 1/1] KVM: selftests: pmu_counters_test: increase
 robustness of LLC cache misses
From: Sean Christopherson <seanjc@google.com>
To: Maxim Levitsky <mlevitsk@redhat.com>
Cc: kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Fri, Jun 21, 2024, Maxim Levitsky wrote:
> Currently this test does a single CLFLUSH on its memory location
> but due to speculative execution this might not cause LLC misses.
> 
> Instead, do a cache flush on each loop iteration to confuse the prediction
> and make sure that cache misses always occur.
> 
> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> ---
>  .../selftests/kvm/x86_64/pmu_counters_test.c  | 20 +++++++++----------
>  1 file changed, 9 insertions(+), 11 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/x86_64/pmu_counters_test.c b/tools/testing/selftests/kvm/x86_64/pmu_counters_test.c
> index 96446134c00b7..ddc0b7e4a888e 100644
> --- a/tools/testing/selftests/kvm/x86_64/pmu_counters_test.c
> +++ b/tools/testing/selftests/kvm/x86_64/pmu_counters_test.c
> @@ -14,8 +14,8 @@
>   * instructions that are needed to set up the loop and then disabled the
>   * counter.  1 CLFLUSH/CLFLUSHOPT/NOP, 1 MFENCE, 2 MOV, 2 XOR, 1 WRMSR.
>   */
> -#define NUM_EXTRA_INSNS		7
> -#define NUM_INSNS_RETIRED	(NUM_BRANCHES + NUM_EXTRA_INSNS)
> +#define NUM_EXTRA_INSNS		5
> +#define NUM_INSNS_RETIRED	(NUM_BRANCHES * 2 + NUM_EXTRA_INSNS)

The comment above is stale.  I also think it's worth adding a macro to capture
that the '2' comes from having two instructions in the loop body (three, if we
keep the MFENCE).

>  static uint8_t kvm_pmu_version;
>  static bool kvm_has_perf_caps;
> @@ -133,9 +133,8 @@ static void guest_assert_event_count(uint8_t idx,
>   * doesn't need to be clobbered as the input value, @pmc_msr, is restored
>   * before the end of the sequence.
>   *
> - * If CLFUSH{,OPT} is supported, flush the cacheline containing (at least) the
> - * start of the loop to force LLC references and misses, i.e. to allow testing
> - * that those events actually count.
> + * If CLFUSH{,OPT} is supported, flush the cacheline containing the CLFUSH{,OPT}
> + * instruction on each loop iteration to ensure that LLC cache misses happen.
>   *
>   * If forced emulation is enabled (and specified), force emulation on a subset
>   * of the measured code to verify that KVM correctly emulates instructions and
> @@ -145,10 +144,9 @@ static void guest_assert_event_count(uint8_t idx,
>  #define GUEST_MEASURE_EVENT(_msr, _value, clflush, FEP)				\
>  do {										\
>  	__asm__ __volatile__("wrmsr\n\t"					\
> -			     clflush "\n\t"					\
> -			     "mfence\n\t"					\

Based on your testing, it's probably ok to drop the mfence, but I don't see any
reason to do so.  It's not like that mfence meaningfully affects the runtime, and
anything easy/free we can do to avoid flaky tests is worth doing.

I'll post and apply a v2, with a prep patch to add a NUM_INSNS_PER_LOOP macro and
keep the MFENCE (I'll be offline all of next week, and don't want to push anything
to -next tomorrow, even though the risk of breaking anything is minimal).

> -			     "1: mov $" __stringify(NUM_BRANCHES) ", %%ecx\n\t"	\
> -			     FEP "loop .\n\t"					\
> +			     " mov $" __stringify(NUM_BRANCHES) ", %%ecx\n\t"	\
> +			     "1: " clflush "\n\t"				\
> +			     FEP "loop 1b\n\t"					\
>  			     FEP "mov %%edi, %%ecx\n\t"				\
>  			     FEP "xor %%eax, %%eax\n\t"				\
>  			     FEP "xor %%edx, %%edx\n\t"				\
> @@ -163,9 +161,9 @@ do {										\
>  	wrmsr(pmc_msr, 0);							\
>  										\
>  	if (this_cpu_has(X86_FEATURE_CLFLUSHOPT))				\
> -		GUEST_MEASURE_EVENT(_ctrl_msr, _value, "clflushopt 1f", FEP);	\
> +		GUEST_MEASURE_EVENT(_ctrl_msr, _value, "clflushopt .", FEP);	\
>  	else if (this_cpu_has(X86_FEATURE_CLFLUSH))				\
> -		GUEST_MEASURE_EVENT(_ctrl_msr, _value, "clflush 1f", FEP);	\
> +		GUEST_MEASURE_EVENT(_ctrl_msr, _value, "clflush .", FEP);	\
>  	else									\
>  		GUEST_MEASURE_EVENT(_ctrl_msr, _value, "nop", FEP);		\
>  										\
> -- 
> 2.26.3
> 

