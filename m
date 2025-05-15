Return-Path: <linux-kselftest+bounces-32989-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12AFFAB7A4D
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 02:02:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71F584E09BF
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 00:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A7F3226D02;
	Thu, 15 May 2025 00:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4PgPaJEs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE2F19D08F
	for <linux-kselftest@vger.kernel.org>; Thu, 15 May 2025 00:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747267221; cv=none; b=t3iQMSAbuG57X9wIt91azpXohhjuaeiabcxaVhB+wD70QoKK5aCPpWoBOUUGBtn4xVbkl84NZ405jCigfOxQK8I0biIFPVI86NEu1zmF4EsxwK8inIg7b0InIaU9+O1AnsyR7OqVXb8AaQlwNSJ9IbQCCh01PyKt4KUb67Oj4T0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747267221; c=relaxed/simple;
	bh=XUwDyLw5/4WxSPmLB0tULktlt1YSPQcfNDFK4JJ3UgI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VtNrQZ7MRjmjSHN2piB22395h1tBk/rRyHCsGd4SspGnYwD1ldvv60IBIdfHpHeucstqQlZ+ZLvoZLBbQr1UBaRWGC7uXLvNslnc+wW7rClqtQ31cEfD1o63TuWvUSytCwZWEWCQnCrRoiJXzESx/ixxzZnKOFwvLQc2nvZZyd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4PgPaJEs; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-742360cec7eso291616b3a.2
        for <linux-kselftest@vger.kernel.org>; Wed, 14 May 2025 17:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747267219; x=1747872019; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=TlJJVY9lFXBl5aa6vrGZ3X+o2Y5gO/1RKuzRIMBedTA=;
        b=4PgPaJEsMv2EiQpQrpehalu77nU95qUo+MY5mjpFxwEmNW7JS/LVVWaI1mv70jpJEQ
         pic5urODW8wECi11VfN59nDobOLqwrKDSd5kUydmUfZidnM1oDu4qdvqnKACWrsxbmLu
         Tg8PdHNS2K6ywPIEKr+uU2IYmy2NBQQ20CyvmQrKBbwJRy4nJqtp8oahM5hK8t5iWFm0
         WWttAjhiDcQ3h/Vt1wVuwzTn3vRJm2KZT8wMCswD/mTwvAD7coddYc5BPmWfvdzFN+UQ
         wOGcYMGDJJU1RhWD4fmvgxfi/mgpA5//omluwLQACy9Kzu5IUaVZi8a6zlj6EUzLJOe0
         manw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747267219; x=1747872019;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TlJJVY9lFXBl5aa6vrGZ3X+o2Y5gO/1RKuzRIMBedTA=;
        b=VNR50XQORxnEjaXc3nWs3I2JPCj3uCiDiKjIt+4ysEDVa946S0+u9fieAdKom/Nfva
         phTSGraRKyvRcLDw0YKI6BdrjoWfwawoZctOwceLRvtGszoafJWaPppo6B96gHiyBBSY
         JXDRa2jcyZXLHA0kL5jdVL6yolI9VEETAg//lpjJR8ljapcsynTVlcwkxU08/iCAJz0P
         2Pa15AtVX8ro/nu4Rd6eqR8aJ3qrt63PD+euwmnjjiYQXjZe103UeRALaHvMG2zZQZ1+
         86n1c4vcWmpUsnPjMo1/oOODFpyxj+Dg4sWLL6qARO+ev8864li3/nQsmZLt/rWhHfqj
         9O2Q==
X-Forwarded-Encrypted: i=1; AJvYcCUl/S4j/oRGARJvWNzS/CbnWa4C7YBPRJvByualBng/CEDtdzsq1HYfbZbm4B7OT8YUpq9PBNOakstg5qXVwEQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzrSPs7oyFUmGS4ovyrFsScvZLR572sPpIogQyEG/4fufllsk3
	mCG21kTLiSHYGVyBIHQNgYSDuWkZevDUAWmIpHesTgMwD0XdkBKWb4E1aE/nV2dfzbK+CXsGeKM
	sXg==
X-Google-Smtp-Source: AGHT+IEHBbPUeQde2g3FySUvI+0JlrKcjlKZyfOpIZMlkRvVqTwOi/0XchtIZWlB6QuVKlDRiXI5fZZvczI=
X-Received: from pgam17.prod.google.com ([2002:a05:6a02:2b51:b0:af9:5717:cfbb])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:6d88:b0:1f5:5ca4:2744
 with SMTP id adf61e73a8af0-215ff0d4647mr6806295637.17.1747267218995; Wed, 14
 May 2025 17:00:18 -0700 (PDT)
Date: Wed, 14 May 2025 17:00:17 -0700
In-Reply-To: <20250324173121.1275209-12-mizhang@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250324173121.1275209-1-mizhang@google.com> <20250324173121.1275209-12-mizhang@google.com>
Message-ID: <aCUukXIC_9cxHQd3@google.com>
Subject: Re: [PATCH v4 11/38] perf/x86: Forbid PMI handler when guest own PMU
From: Sean Christopherson <seanjc@google.com>
To: Mingwei Zhang <mizhang@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Paolo Bonzini <pbonzini@redhat.com>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, Liang@google.com, 
	Kan <kan.liang@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Yongwei Ma <yongwei.ma@intel.com>, Xiong Zhang <xiong.y.zhang@linux.intel.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Jim Mattson <jmattson@google.com>, 
	Sandipan Das <sandipan.das@amd.com>, Zide Chen <zide.chen@intel.com>, 
	Eranian Stephane <eranian@google.com>, Shukla Manali <Manali.Shukla@amd.com>, 
	Nikunj Dadhania <nikunj.dadhania@amd.com>
Content-Type: text/plain; charset="us-ascii"

On Mon, Mar 24, 2025, Mingwei Zhang wrote:
> If a guest PMI is delivered after VM-exit, the KVM maskable interrupt will
> be held pending until EFLAGS.IF is set. In the meantime, if the logical
> processor receives an NMI for any reason at all, perf_event_nmi_handler()
> will be invoked. If there is any active perf event anywhere on the system,
> x86_pmu_handle_irq() will be invoked, and it will clear
> IA32_PERF_GLOBAL_STATUS. By the time KVM's PMI handler is invoked, it will
> be a mystery which counter(s) overflowed.
> 
> When LVTPC is using KVM PMI vecotr, PMU is owned by guest, Host NMI let
> x86_pmu_handle_irq() run, x86_pmu_handle_irq() restore PMU vector to NMI
> and clear IA32_PERF_GLOBAL_STATUS, this breaks guest vPMU passthrough
> environment.
> 
> So modify perf_event_nmi_handler() to check perf_in_guest per cpu variable,
> and if so, to simply return without calling x86_pmu_handle_irq().
> 
> Suggested-by: Jim Mattson <jmattson@google.com>
> Signed-off-by: Mingwei Zhang <mizhang@google.com>
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> ---
>  arch/x86/events/core.c | 27 +++++++++++++++++++++++++--
>  1 file changed, 25 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
> index 28161d6ff26d..96a173bbbec2 100644
> --- a/arch/x86/events/core.c
> +++ b/arch/x86/events/core.c
> @@ -54,6 +54,8 @@ DEFINE_PER_CPU(struct cpu_hw_events, cpu_hw_events) = {
>  	.pmu = &pmu,
>  };
>  
> +static DEFINE_PER_CPU(bool, pmi_vector_is_nmi) = true;

I strongly prefer guest_ctx_loaded.  pmi_vector_is_nmi very inflexible and
doesn't communicate *why* perf's NMI handler needs to ignore NMIs

>  DEFINE_STATIC_KEY_FALSE(rdpmc_never_available_key);
>  DEFINE_STATIC_KEY_FALSE(rdpmc_always_available_key);
>  DEFINE_STATIC_KEY_FALSE(perf_is_hybrid);
> @@ -1737,6 +1739,24 @@ perf_event_nmi_handler(unsigned int cmd, struct pt_regs *regs)
>  	u64 finish_clock;
>  	int ret;
>  
> +	/*
> +	 * When guest pmu context is loaded this handler should be forbidden from
> +	 * running, the reasons are:
> +	 * 1. After perf_guest_enter() is called, and before cpu enter into
> +	 *    non-root mode, host non-PMI NMI could happen, but x86_pmu_handle_irq()
> +	 *    restore PMU to use NMI vector, which destroy KVM PMI vector setting.
> +	 * 2. When VM is running, host non-PMI NMI causes VM exit, KVM will
> +	 *    call host NMI handler (vmx_vcpu_enter_exit()) first before KVM save
> +	 *    guest PMU context (kvm_pmu_put_guest_context()), as x86_pmu_handle_irq()
> +	 *    clear global_status MSR which has guest status now, then this destroy
> +	 *    guest PMU status.
> +	 * 3. After VM exit, but before KVM save guest PMU context, host non-PMI NMI
> +	 *    could happen, x86_pmu_handle_irq() clear global_status MSR which has
> +	 *    guest status now, then this destroy guest PMU status.
> +	 */

This *might* be useful for a changelog, but even then it's probably overkill.
NMIs can happen at any time, that's the full the story.  Enumerating the exact
edge cases adds a lot of noise and not much value.

