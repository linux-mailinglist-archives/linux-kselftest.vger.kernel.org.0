Return-Path: <linux-kselftest+bounces-33148-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA0FEAB9363
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 May 2025 03:04:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E8261701EC
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 May 2025 01:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B23E214217;
	Fri, 16 May 2025 01:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G2/wySll"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EDFA1D5ACE;
	Fri, 16 May 2025 01:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747357449; cv=none; b=kExtQpMzS6emNGq7MjANjKGsuDgdn1gyloUd9Dcjk5brpI72v1j1XjYhiNQ0g8trC4EYtW3EBl62mryhRQr3jFIEflhEFQEsrCUfZBb/CagNR4dO/kNdKg5qAYiErJp1ecYApJbiHj0yNezidL/pUpoCJOE/lfDfpsmGWdggE10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747357449; c=relaxed/simple;
	bh=ZuBYgHalJA7vgVtaMnY0GX4nolPhUZ/aynlvRMgWhTA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eqR2s6l6xHTTmYLJ/bRqyUlcJboiEZIZtMP89/fRWISM44qPPu0OQh3hiH/CehKOapplzcK8rzeS0jobFyq1acld7jFvkvrE4MO6gnWOr1jMw5J1Iv4T8Acoeu7XCiAAh/ajhQ272GVsdxjxQ84Ef1bCMcMP+de/X0UTBS3KGHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G2/wySll; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747357447; x=1778893447;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ZuBYgHalJA7vgVtaMnY0GX4nolPhUZ/aynlvRMgWhTA=;
  b=G2/wySll1qp2iyZWB+Fzn+J6eiIL2A6e9uvHwmNgeOHR6ZyA2ugdu19C
   /ztgDYi9Zp7q7CEJ02nHkETOjNOpiErEASQelogcvq7psjzdvqsA56t40
   yqOYmYSaf80WcoFO2xa+GicLologjC0WrNmkKJjwFarIfHPgX0+4EYE36
   HrV9S43oavra905Ucqgi0HYNgJPcVX+l6xT6Le3mkLCYLrBLdFv5O1bjz
   Of+oqj5EcG1kYIWdTgniD6uj5pztZVV1kbGRbX4HvGNo2ZxPvKPXdBVOx
   pG49Zm2MnzwvklFbIf9SjexyYPyPLSH18rNJZA+Qrp4jKMTZveYyEAcV0
   g==;
X-CSE-ConnectionGUID: eKst717PTIqPItaduyGeWA==
X-CSE-MsgGUID: pQi5Cs4wSeqVGjKEbIpRKg==
X-IronPort-AV: E=McAfee;i="6700,10204,11434"; a="49248658"
X-IronPort-AV: E=Sophos;i="6.15,292,1739865600"; 
   d="scan'208";a="49248658"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2025 18:04:06 -0700
X-CSE-ConnectionGUID: PmszdaHmRoKfhyYPLEmDgQ==
X-CSE-MsgGUID: QmRwKshtTQ6Dk4yiBAfg5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,292,1739865600"; 
   d="scan'208";a="138933023"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.245.128]) ([10.124.245.128])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2025 18:04:00 -0700
Message-ID: <474892bc-8c70-4b3d-8835-473f2323496c@linux.intel.com>
Date: Fri, 16 May 2025 09:03:57 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 22/38] KVM: x86/pmu: Optimize intel/amd_pmu_refresh()
 helpers
To: Sean Christopherson <seanjc@google.com>
Cc: Mingwei Zhang <mizhang@google.com>, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Mark Rutland <mark.rutland@arm.com>,
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
 <20250324173121.1275209-23-mizhang@google.com> <aCU3Ri0iz0aDBDup@google.com>
 <41821a66-8db1-42f1-85d6-fde67a8c072e@linux.intel.com>
 <aCY--A8SY7GQuq4F@google.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <aCY--A8SY7GQuq4F@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 5/16/2025 3:22 AM, Sean Christopherson wrote:
> On Thu, May 15, 2025, Dapeng Mi wrote:
>> On 5/15/2025 8:37 AM, Sean Christopherson wrote:
>>>> diff --git a/arch/x86/kvm/svm/pmu.c b/arch/x86/kvm/svm/pmu.c
>>>> index 153972e944eb..eba086ef5eca 100644
>>>> --- a/arch/x86/kvm/svm/pmu.c
>>>> +++ b/arch/x86/kvm/svm/pmu.c
>>>> @@ -198,12 +198,20 @@ static void __amd_pmu_refresh(struct kvm_vcpu *vcpu)
>>>>  	pmu->nr_arch_gp_counters = min_t(unsigned int, pmu->nr_arch_gp_counters,
>>>>  					 kvm_pmu_cap.num_counters_gp);
>>>>  
>>>> -	if (pmu->version > 1) {
>>>> -		pmu->global_ctrl_rsvd = ~((1ull << pmu->nr_arch_gp_counters) - 1);
>>>> +	if (kvm_pmu_cap.version > 1) {
> ARGH!!!!!  I saw the pmu->version => kvm_pmu_cap.version change when going through
> this patch, but assumed it was simply a refactoring bug and ignored it.
>
> Nope, 100% intentional, as I discovered after spending the better part of an hour
> debugging.  Stuffing pmu->global_ctrl when it doesn't exist is necessary when the
> mediated PMU is enabled, because pmu->global_ctrl will always be loaded in hardware.
> And so loading '0' means the PMU is effectively disabled, because KVM disallows the
> guest from writing the MSR.
>
> _That_ is the type of thing that absolutely needs a comment and a lengthy explanation
> in the changelog.

Yes, this change is intended.  As long as HW supports Global_CTRL MSR, KVM
should write available value into it at vm-entry regardless of if guest PMU
has GLOBAL_CTRL (pmu version < 2), otherwise guest counters won't be really
enabled on HW.

yeah, it's indeed easily confused and should put a comment here. My fault ...


>
> Intel also needs the same treatment for PMU v1.  And since there's no hackery that
> I can see, that suggests PMU v1 guests haven't been tested with the mediated PMU
> on Intel.
>
> I guess congratulations are in order, because this patch just became my new goto
> example of why I'm so strict about on the "one thing per patch" rule.

Embarrassing ....


>
>>> It's not just global_ctrl.  PEBS and the fixed counters also depend on v2+ (the
>>> SDM contradicts itself; KVM's ABI is that they're v2+).
>>>
>>>> +		/*
>>>> +		 * At RESET, AMD CPUs set all enable bits for general purpose counters in
>>>> +		 * IA32_PERF_GLOBAL_CTRL (so that software that was written for v1 PMUs
>>>> +		 * don't unknowingly leave GP counters disabled in the global controls).
>>>> +		 * Emulate that behavior when refreshing the PMU so that userspace doesn't
>>>> +		 * need to manually set PERF_GLOBAL_CTRL.
>>>> +		 */
>>>> +		pmu->global_ctrl = BIT_ULL(pmu->nr_arch_gp_counters) - 1;
>>>> +		pmu->global_ctrl_rsvd = ~pmu->global_ctrl;
>>>>  		pmu->global_status_rsvd = pmu->global_ctrl_rsvd;
>>>>  	}

