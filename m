Return-Path: <linux-kselftest+bounces-33150-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A59FAAB939B
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 May 2025 03:26:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 329F2502829
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 May 2025 01:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B52B2221F2E;
	Fri, 16 May 2025 01:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DLTPqJJ8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56FC2221F0F;
	Fri, 16 May 2025 01:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747358773; cv=none; b=dtvJlLIgk/48PU9D+8r9XynZeIrp2znLnOhe3F96GN9j2iGPs7c8UMUa60gZpYFfFDVg3kvHnEfQ+ro8MFTV0GQPc3WUyViK04/JHVJ8tYazxh85IykIT3YmfJ4fj5U8EIKKirrAaC4cjFwRm/J7Bzk/xIeQcuatjJ7mZxWg1gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747358773; c=relaxed/simple;
	bh=+Yy/bPTI3EQIjpf/ldcTwJX8i0K3DwxV94IKrvJpwSI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AUz1EJwVDzymCUNy5lVuEimnppYJAIAI+BhR+LakEi5gwHtTmFZ/FOwoeoOnjpfEpUpkjLdtxdxSwNyr6lm31KRHcC1PPUNY4q9Z+3f+01cW4r+zWJgFoK02cYtbLNH0d2e3uH+q0mZLxWmMk9YW4+wpXFrIt39tex8EOsOLPGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DLTPqJJ8; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747358771; x=1778894771;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=+Yy/bPTI3EQIjpf/ldcTwJX8i0K3DwxV94IKrvJpwSI=;
  b=DLTPqJJ8pL9w1dokE/A+SVyedT0yUpHpNcQzOEaSsmDa0EfjbREkvIaf
   hHgO7a8/HsoXk8/6ywAtWQu0F/R+lNAp5wBiJrf+E435gSTXsnKwgaquB
   tm5X5hqabges2ndazPcBTryVIDt6DdQdvvNeWCyHetHJwYfoDhKBv6zck
   uDovPILn3N1bFIOGC7gS46UxAwvhG6DGw0V4C1VgKtYkNUFq0wd1bhJgC
   um9jChhujkV0XK1nfWcDeZf4uZOLQK51e7FaIPIhfDZ4tNJ61A0mraw96
   sCwHBWlhS3R7hcK3OIrPCpG7fGqgT27JoLGux7ZiIUfG0m8+zWsA1Rgsj
   w==;
X-CSE-ConnectionGUID: NRlGKGjrSgm2oGMQMG4kDg==
X-CSE-MsgGUID: ylRQ7FacT+Kaqd5U2bZOqw==
X-IronPort-AV: E=McAfee;i="6700,10204,11434"; a="53135506"
X-IronPort-AV: E=Sophos;i="6.15,292,1739865600"; 
   d="scan'208";a="53135506"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2025 18:26:09 -0700
X-CSE-ConnectionGUID: kz/cxXuLS/iSDmP7oCWkCQ==
X-CSE-MsgGUID: B4DEs4SeRpS8sRqZl3plIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,292,1739865600"; 
   d="scan'208";a="175672095"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.245.128]) ([10.124.245.128])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2025 18:26:04 -0700
Message-ID: <2d0d274c-6bc0-43c7-a8a8-92aa11872675@linux.intel.com>
Date: Fri, 16 May 2025 09:26:00 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 27/38] KVM: x86/pmu: Handle PMU MSRs interception and
 event filtering
To: Mingwei Zhang <mizhang@google.com>, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, Liang@google.com,
 Kan <kan.liang@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Yongwei Ma <yongwei.ma@intel.com>,
 Xiong Zhang <xiong.y.zhang@linux.intel.com>,
 Jim Mattson <jmattson@google.com>, Sandipan Das <sandipan.das@amd.com>,
 Zide Chen <zide.chen@intel.com>, Eranian Stephane <eranian@google.com>,
 Shukla Manali <Manali.Shukla@amd.com>,
 Nikunj Dadhania <nikunj.dadhania@amd.com>
References: <20250324173121.1275209-1-mizhang@google.com>
 <20250324173121.1275209-28-mizhang@google.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20250324173121.1275209-28-mizhang@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 3/25/2025 1:31 AM, Mingwei Zhang wrote:
> From: Dapeng Mi <dapeng1.mi@linux.intel.com>
>
> Mediated vPMU needs to intercept EVENTSELx and FIXED_CNTR_CTRL MSRs to
> filter out guest malicious perf events. Either writing these MSRs or
> updating event filters would call reprogram_counter() eventually. Thus
> check if the guest event should be filtered out in reprogram_counter().
> If so, clear corresponding EVENTSELx MSR or FIXED_CNTR_CTRL field to
> ensure the guest event won't be really enabled at vm-entry.
>
> Besides, mediated vPMU intercepts the MSRs of these guest not owned
> counters and it just needs simply to read/write from/to pmc->counter.
>
> Suggested-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> Co-developed-by: Mingwei Zhang <mizhang@google.com>
> Signed-off-by: Mingwei Zhang <mizhang@google.com>
> ---
>  arch/x86/kvm/pmu.c | 27 +++++++++++++++++++++++++++
>  arch/x86/kvm/pmu.h |  3 +++
>  2 files changed, 30 insertions(+)
>
> diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
> index 63143eeb5c44..e9100dc49fdc 100644
> --- a/arch/x86/kvm/pmu.c
> +++ b/arch/x86/kvm/pmu.c
> @@ -305,6 +305,11 @@ static void pmc_update_sample_period(struct kvm_pmc *pmc)
>  
>  void pmc_write_counter(struct kvm_pmc *pmc, u64 val)
>  {
> +	if (kvm_mediated_pmu_enabled(pmc->vcpu)) {
> +		pmc->counter = val & pmc_bitmask(pmc);
> +		return;
> +	}
> +
>  	/*
>  	 * Drop any unconsumed accumulated counts, the WRMSR is a write, not a
>  	 * read-modify-write.  Adjust the counter value so that its value is
> @@ -455,6 +460,28 @@ static int reprogram_counter(struct kvm_pmc *pmc)
>  	bool emulate_overflow;
>  	u8 fixed_ctr_ctrl;
>  
> +	if (kvm_mediated_pmu_enabled(pmu_to_vcpu(pmu))) {
> +		bool allowed = check_pmu_event_filter(pmc);
> +
> +		if (pmc_is_gp(pmc)) {
> +			if (allowed)
> +				pmc->eventsel_hw |= pmc->eventsel &
> +						    ARCH_PERFMON_EVENTSEL_ENABLE;
> +			else
> +				pmc->eventsel_hw &= ~ARCH_PERFMON_EVENTSEL_ENABLE;
> +		} else {
> +			int idx = pmc->idx - KVM_FIXED_PMC_BASE_IDX;
> +
> +			if (allowed)
> +				pmu->fixed_ctr_ctrl_hw = pmu->fixed_ctr_ctrl;

Sean, just found there is a potential bug here.  The
"pmu->fixed_ctr_ctrl_hw" should not be assigned to "pmu->fixed_ctr_ctrl"
here, otherwise the other filtered fixed counter (not this allowed fixed
counter) could be enabled accidentally.

diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
index ba9d336f1d1d..f32e5f66f73b 100644
--- a/arch/x86/kvm/pmu.c
+++ b/arch/x86/kvm/pmu.c
@@ -473,7 +473,8 @@ static int reprogram_counter(struct kvm_pmc *pmc)
                        int idx = pmc->idx - KVM_FIXED_PMC_BASE_IDX;

                        if (allowed)
-                               pmu->fixed_ctr_ctrl_hw = pmu->fixed_ctr_ctrl;
+                               pmu->fixed_ctr_ctrl_hw |= pmu->fixed_ctr_ctrl &
+                                              
intel_fixed_bits_by_idx(idx, 0xf);
                        else
                                pmu->fixed_ctr_ctrl_hw &=
                                        ~intel_fixed_bits_by_idx(idx, 0xf);

> +			else
> +				pmu->fixed_ctr_ctrl_hw &=
> +					~intel_fixed_bits_by_idx(idx, 0xf);
> +		}
> +
> +		return 0;
> +	}
> +
>  	emulate_overflow = pmc_pause_counter(pmc);
>  
>  	if (!pmc_event_is_allowed(pmc))
> diff --git a/arch/x86/kvm/pmu.h b/arch/x86/kvm/pmu.h
> index 509c995b7871..6289f523d893 100644
> --- a/arch/x86/kvm/pmu.h
> +++ b/arch/x86/kvm/pmu.h
> @@ -113,6 +113,9 @@ static inline u64 pmc_read_counter(struct kvm_pmc *pmc)
>  {
>  	u64 counter, enabled, running;
>  
> +	if (kvm_mediated_pmu_enabled(pmc->vcpu))
> +		return pmc->counter & pmc_bitmask(pmc);
> +
>  	counter = pmc->counter + pmc->emulated_counter;
>  
>  	if (pmc->perf_event && !pmc->is_paused)

