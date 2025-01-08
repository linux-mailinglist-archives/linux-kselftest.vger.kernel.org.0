Return-Path: <linux-kselftest+bounces-24078-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 351D1A06582
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Jan 2025 20:42:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09BAE7A1FEA
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Jan 2025 19:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19CA720103D;
	Wed,  8 Jan 2025 19:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n3JR1924"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E971F708D
	for <linux-kselftest@vger.kernel.org>; Wed,  8 Jan 2025 19:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736365367; cv=none; b=XKIWfPb7g28PxV8J44xfkLR8spCUnBZUKTUA6TJia95Fa0qoKXT1D+V4xdkrlKMc4dEZ/yJQd3GK2zTGt4LuNMgxDRD9mFTL/YEHKELRa/bJCTarqiszKa+M8OgGo2rHLTNkfwV2sSGZ6zs5bFw2879Dk9z+/E7CT6pluoJdTiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736365367; c=relaxed/simple;
	bh=rI9lTDj/3xxLUWxNoP3YMHHFvTPK0kaPZCUPe7dFjSo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YJq5K/1yegGO4dP2l7+DtjR7e3Uh6TKPo+1rjznlS5318U9KYc6Oh9zt/HCP06SO8zw4AOPHNIT5rtiUMHSkFIrIKT0CqGaETfe8ctmcMy0glJJzBjz8sPtUB6uUTTcXiUHM6kLXH08/l43D4CEbbrBCAM9RlQT+DpA9JV9b3hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=n3JR1924; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-216405eea1fso1520135ad.0
        for <linux-kselftest@vger.kernel.org>; Wed, 08 Jan 2025 11:42:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736365365; x=1736970165; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=OcqngNRH0rXYoEBfqi4ViOp0zgRPrk+QzEEBCgGh8d4=;
        b=n3JR1924KPqo57ghqKcmieNP7c7568cZlnNS81AfssFPtz6iXEq9Dd+b7az/E+nUwq
         9vXvMeSTnsg6Lnox8dzEs3a+udSgxQYUipFPMAo6IH/wRuZ1+Di/ftpnGjqIN3xOdbXo
         0i9F8kOeSQ19QZDRwb77jOmQqu0jnRbNdpqcrwxU/eGTCOb8HUl7zW6w2UiLm2xUarb7
         l7KGnjJFKQvyQfzo6jmvNj1Nacn7OsTN+VKAckuZl8JD9Q49oYZZi4ffpZG0Z/8xyePB
         xXJGa40u3TpZWsQfHysbYi5c31wQ2VvlA1BSu+T9rzKFGXG5nzxp0fgSnZc6E9GznoYH
         yk3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736365365; x=1736970165;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OcqngNRH0rXYoEBfqi4ViOp0zgRPrk+QzEEBCgGh8d4=;
        b=vjDUsqJ1qz9jTG02Dur5GiklIHhkB/4xS99E3aGN0z8xG+dQdV63NiFThgo+drXkg2
         6fB2qe2eA6eOBUflhaeyJ5F7F3cJ/AoSqdf6bevhf3XZC5YSbQ2j7JzhyT1Hu3K8GQGH
         3ec4O392bIQ2fU/Yul3wRGhAOyZ2kOfWJS2Jopem0ovDVrUsNltePXut7Al3ugSZrWvs
         nHFU8cssci3kOsREgT3RdEXj6NSsSFnh060s582ZDWwEHrCx42UhFbSGTgI8GYvqGOc9
         vMHW6G93gYh/os3kJ6A8bR8FSZnpPW2VV8JwsUf+2a0bgiNOzgvc5WVTNH4LbGyEA9Nv
         80vg==
X-Forwarded-Encrypted: i=1; AJvYcCWcOohMySZ+UFqVyc3P6FBiU2bXbtfLYcdWV+lAJ5acNTkHfzxj7aUzCNehuc7BWtGks2l2/BkAHkGE/gyJKrI=@vger.kernel.org
X-Gm-Message-State: AOJu0YycHdTxQYPPhE86awZ0uYDknOv/cP8LIrpye3I8XyppFQp40TXS
	SkaQ++agD0EEYw3Ccp26IpF3GwCC61bLb1ZSc/nmn8q23dxg5JjFXqIlBzp7NnP1y30bZfeeMZ7
	bng==
X-Google-Smtp-Source: AGHT+IGNfKCZ8Q2VCeggXdXbou0bzD5z1DgxcTPhkKTSHTkFCJPodqXfpK8DgQ73ma5DxN7hfHcC0Lc1R+c=
X-Received: from pfbf7.prod.google.com ([2002:a05:6a00:ad87:b0:725:c96b:b1db])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:d81a:b0:1e3:e6f3:6372
 with SMTP id adf61e73a8af0-1e88d132ef8mr6644654637.27.1736365365004; Wed, 08
 Jan 2025 11:42:45 -0800 (PST)
Date: Wed, 8 Jan 2025 11:42:43 -0800
In-Reply-To: <20240918205319.3517569-7-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240918205319.3517569-1-coltonlewis@google.com> <20240918205319.3517569-7-coltonlewis@google.com>
Message-ID: <Z37VMzbCZEKkDOmP@google.com>
Subject: Re: [PATCH v2 6/6] KVM: x86: selftests: Test PerfMonV2
From: Sean Christopherson <seanjc@google.com>
To: Colton Lewis <coltonlewis@google.com>
Cc: kvm@vger.kernel.org, Mingwei Zhang <mizhang@google.com>, 
	Jinrong Liang <ljr.kernel@gmail.com>, Jim Mattson <jmattson@google.com>, 
	Aaron Lewis <aaronlewis@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Wed, Sep 18, 2024, Colton Lewis wrote:
> Test PerfMonV2, which defines global registers to enable multiple
> performance counters with a single MSR write, in its own function.
> 
> If the feature is available, ensure the global control register has
> the ability to start and stop the performance counters and the global
> status register correctly flags an overflow by the associated counter.
> 
> Signed-off-by: Colton Lewis <coltonlewis@google.com>
> ---
>  .../selftests/kvm/x86_64/pmu_counters_test.c  | 53 +++++++++++++++++++
>  1 file changed, 53 insertions(+)
> 
> diff --git a/tools/testing/selftests/kvm/x86_64/pmu_counters_test.c b/tools/testing/selftests/kvm/x86_64/pmu_counters_test.c
> index cf2941cc7c4c..a90df8b67a19 100644
> --- a/tools/testing/selftests/kvm/x86_64/pmu_counters_test.c
> +++ b/tools/testing/selftests/kvm/x86_64/pmu_counters_test.c
> @@ -763,10 +763,63 @@ static void guest_test_core_events(void)
>  	}
>  }
>  
> +static void guest_test_perfmon_v2(void)
> +{
> +	uint64_t i;
> +	uint64_t eventsel = ARCH_PERFMON_EVENTSEL_OS |
> +		ARCH_PERFMON_EVENTSEL_ENABLE |
> +		AMD_ZEN_CORE_CYCLES;

Hmm.  I like the extra coverage, but I think the guts of this test belong is
common code, because the core logic is the same across Intel and AMD (I think),
only the MSRs are different.

Maybe a library helper that takes in the MSRs as parameters?  Not sure.

I suspect it'll take some back and forth to figure out how best to validate these
more "advanced" behaviors, so maybe skip this patch for the next version?  I.e.
land basic AMD coverage and then we can figure out how to test global control and
status.

> +	bool core_ext = this_cpu_has(X86_FEATURE_PERF_CTR_EXT_CORE);
> +	uint64_t sel_msr_base = core_ext ? MSR_F15H_PERF_CTL : MSR_K7_EVNTSEL0;
> +	uint64_t cnt_msr_base = core_ext ? MSR_F15H_PERF_CTR : MSR_K7_PERFCTR0;
> +	uint64_t msr_step = core_ext ? 2 : 1;
> +	uint8_t nr_counters = guest_nr_core_counters();
> +	bool perfmon_v2 = this_cpu_has(X86_FEATURE_PERFMON_V2);

Zero reason to capture this in a local variable.

> +	uint64_t sel_msr;
> +	uint64_t cnt_msr;
> +
> +	if (!perfmon_v2)
> +		return;
> +
> +	for (i = 0; i < nr_counters; i++) {
> +		sel_msr = sel_msr_base + msr_step * i;
> +		cnt_msr = cnt_msr_base + msr_step * i;
> +
> +		/* Ensure count stays 0 when global register disables counter. */
> +		wrmsr(MSR_AMD64_PERF_CNTR_GLOBAL_CTL, 0);
> +		wrmsr(sel_msr, eventsel);
> +		wrmsr(cnt_msr, 0);
> +		__asm__ __volatile__("loop ." : "+c"((int){NUM_LOOPS}));
> +		GUEST_ASSERT(!_rdpmc(i));
> +
> +		/* Ensure counter is >0 when global register enables counter. */
> +		wrmsr(MSR_AMD64_PERF_CNTR_GLOBAL_CTL, BIT_ULL(i));
> +		__asm__ __volatile__("loop ." : "+c"((int){NUM_LOOPS}));
> +		wrmsr(MSR_AMD64_PERF_CNTR_GLOBAL_CTL, 0);
> +		GUEST_ASSERT(_rdpmc(i));
> +
> +		/* Ensure global status register flags a counter overflow. */
> +		wrmsr(cnt_msr, -1);
> +		wrmsr(MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_CLR, 0xff);
> +		wrmsr(MSR_AMD64_PERF_CNTR_GLOBAL_CTL, BIT_ULL(i));
> +		__asm__ __volatile__("loop ." : "+c"((int){NUM_LOOPS}));
> +		wrmsr(MSR_AMD64_PERF_CNTR_GLOBAL_CTL, 0);
> +		GUEST_ASSERT(rdmsr(MSR_AMD64_PERF_CNTR_GLOBAL_STATUS) &
> +			     BIT_ULL(i));
> +
> +		/* Ensure global status register flag is cleared correctly. */
> +		wrmsr(MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_CLR, BIT_ULL(i));
> +		GUEST_ASSERT(!(rdmsr(MSR_AMD64_PERF_CNTR_GLOBAL_STATUS) &
> +			     BIT_ULL(i)));
> +	}
> +}
> +
> +
>  static void guest_test_core_counters(void)
>  {
>  	guest_test_rdwr_core_counters();
>  	guest_test_core_events();
> +	guest_test_perfmon_v2();
>  	GUEST_DONE();
>  }
>  
> -- 
> 2.46.0.662.g92d0881bb0-goog
> 

