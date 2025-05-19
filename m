Return-Path: <linux-kselftest+bounces-33305-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D2E9ABB44D
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 May 2025 07:07:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C95127A8FD0
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 May 2025 05:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7AAC1EF393;
	Mon, 19 May 2025 05:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dhzcRnil"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E9B1C5F13;
	Mon, 19 May 2025 05:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747631251; cv=none; b=BlKDHO4tZpKWyqCq396NazDiTaqBO32z1cO7jx7jGHi/RYqrh3bv233UdC1FbdR22G5/ED1dzKZg/5oUMQjjwu+IoxdmWxUvtkjeDPVJ3/020c7r6qh4TIRgVq3RfkJMkINOyqOH4rc0+2jOTP5pl3yQh29J7U8ZDbLaTsd4CSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747631251; c=relaxed/simple;
	bh=S5ZNbdsg4wDUCuKqxM5YRSWGM9yiZiVQDInfyPth+p8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XJu0RflkA+0RCtmy/N4EIQEkxiCbKbr/rqnTR/p9Eqk7HgxTI6kHAgQ9d85F35j/3UUMKoNYjnVEE0GTJS7hXJbVdP0EwomgqpklaEUL2x2P/5OEkByFKSgvORjI+IMsUc2r4qLT4vjnutSOh7FzHCt76KQAE8e3qHNfUITTgPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dhzcRnil; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747631250; x=1779167250;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=S5ZNbdsg4wDUCuKqxM5YRSWGM9yiZiVQDInfyPth+p8=;
  b=dhzcRnilgMS8V9kw1KCKyahJJjGgbO1kPLRSBCl6tF2GzEa+JZu0DeZl
   1tWK5BrC8dRgN9e0FmRJuAr6Q9l3pdf3olEqpXkejw7bJGG1b4ArkIw8D
   kOip0TzBoxaQNnfZJrWMTAOxw2n6HNjR3DZYqrfasw9pOBdBoe/3g5a/k
   N+v1YJG/aV8UTnP96Zfg5XP1Cjc7f+eJ+VqoqY69jYfM8G1nPNWIqZ57P
   8vcC67JCH3tKSVpZj5VdpGxC2ODBbpEH/4NWoeA8hI+SiAWDbCzBmPB//
   oOwO5YpitbN7Jf2DRJTcUNsKur0ZZTEKYWdfEhQtjvjnmw0qRbn71pC6g
   A==;
X-CSE-ConnectionGUID: UJe2NOuYTK+lpTojavpkfA==
X-CSE-MsgGUID: l5CgHdScRRGWErYWJAgqBw==
X-IronPort-AV: E=McAfee;i="6700,10204,11437"; a="74917057"
X-IronPort-AV: E=Sophos;i="6.15,300,1739865600"; 
   d="scan'208";a="74917057"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2025 22:07:29 -0700
X-CSE-ConnectionGUID: +L7rLQChRQy2cqMJacaboQ==
X-CSE-MsgGUID: uN+tIhaBQPCdLB/rMn2vPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,300,1739865600"; 
   d="scan'208";a="139100836"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.245.128]) ([10.124.245.128])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2025 22:07:21 -0700
Message-ID: <b1cf61c7-956b-4614-82b2-78d964e20b55@linux.intel.com>
Date: Mon, 19 May 2025 13:07:19 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 29/38] KVM: x86/pmu: Switch host/guest PMU context at
 vm-exit/vm-entry
To: Sean Christopherson <seanjc@google.com>,
 Mingwei Zhang <mizhang@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
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
 <20250324173121.1275209-30-mizhang@google.com> <aCc9CKw3DGXXQbbe@google.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <aCc9CKw3DGXXQbbe@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 5/16/2025 9:26 PM, Sean Christopherson wrote:
> On Mon, Mar 24, 2025, Mingwei Zhang wrote:
>> +	/*
>> +	 * Clear hardware selector MSR content and its counter to avoid
>> +	 * leakage and also avoid this guest GP counter get accidentally
>> +	 * enabled during host running when host enable global ctrl.
>> +	 */
>> +	for (i = 0; i < pmu->nr_arch_gp_counters; i++) {
>> +		pmc = &pmu->gp_counters[i];
>> +		eventsel_msr = pmc_msr_addr(pmu, pmu->gp_eventsel_base, i);
>> +		counter_msr = pmc_msr_addr(pmu, pmu->gp_counter_base, i);
>> +
>> +		rdpmcl(i, pmc->counter);
>> +		rdmsrl(eventsel_msr, pmc->eventsel_hw);
> As pointed out by Dapeng offlist, this RDMSR is unnecessary since event selector
> MSRs are always intercepted.
>
>> +		if (pmc->counter)
>> +			wrmsrl(counter_msr, 0);
>> +		if (pmc->eventsel_hw)
>> +			wrmsrl(eventsel_msr, 0);
>> +	}
>> +
>> +	for (i = 0; i < pmu->nr_arch_fixed_counters; i++) {
>> +		pmc = &pmu->fixed_counters[i];
>> +		counter_msr = pmc_msr_addr(pmu, pmu->fixed_base, i);
>> +
>> +		rdpmcl(INTEL_PMC_FIXED_RDPMC_BASE | i, pmc->counter);
>> +		if (pmc->counter)
>> +			wrmsrl(counter_msr, 0);
>> +	}
>> +
>> +}
>> +static void intel_put_guest_context(struct kvm_vcpu *vcpu)
>> +{
>> +	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
>> +
>> +	/* Global ctrl register is already saved at VM-exit. */
>> +	rdmsrl(MSR_CORE_PERF_GLOBAL_STATUS, pmu->global_status);
>> +
>> +	/* Clear hardware MSR_CORE_PERF_GLOBAL_STATUS MSR, if non-zero. */
>> +	if (pmu->global_status)
>> +		wrmsrl(MSR_CORE_PERF_GLOBAL_OVF_CTRL, pmu->global_status);
>> +
>> +	rdmsrl(MSR_CORE_PERF_FIXED_CTR_CTRL, pmu->fixed_ctr_ctrl_hw);
> And same thing here.  Though I'm confused as to why KVM always intercept
> FIXED_CTR_CTRL.
>
> /me rummages around the SDM
>
> Ahh, because there are Any Thread bits in there.  That absolutely needs to be
> called out, probably in the interception logic in pmu_intel.c.  I'll add a comment.

Another reason is event filter. User may select to filter out some but not
all fixed counters, so PERF_FIXED_CTR_CTRL has to be intercepted.


>

