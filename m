Return-Path: <linux-kselftest+bounces-33026-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD066AB7D27
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 07:46:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA61B3A158C
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 05:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F393295506;
	Thu, 15 May 2025 05:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RS4CGm7y"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC5FE2951DF;
	Thu, 15 May 2025 05:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747287966; cv=none; b=PMPljOXf7B8GDS9FJ0yxJMhuZc6A5mKfn95wkZZ9SHL613JSqD2+CrbmPHocdsfwX9/5kEi6pI1TlWZQGPOq2mVlM1Cq6Dt9IyMroLtsaBjhoz4nDn2xMlfoo/0d6RTgvzqWOFUH8N8eWCJnseCHFwcsxbV0qrfVvm0kLKiomyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747287966; c=relaxed/simple;
	bh=nWgDAOIXKZ2IPfTE1uaEbLd4e6rx6r6ee9joklJj4pA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IG+RLlUWvB3QoN/ZpERPcuQTn7YWukOVS4l989tQlPm8KKlWrn3ohlM9fHr/+9Z469VmafTff4wFNWuv4ecWdk6XQv1Yeata60pADvHOh2mbvYvypVOIj+LLeyeiLaa5TaEKBN+owCfkwWZbJzn8SZrVKU6+MQOj0pc7KzVZzds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RS4CGm7y; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747287965; x=1778823965;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=nWgDAOIXKZ2IPfTE1uaEbLd4e6rx6r6ee9joklJj4pA=;
  b=RS4CGm7ybfxHSxrN1a0FhnuVvHZ64DsKQWDsJrZM7lmYnYlCGeiZxjk9
   gZpFvONXRzBq+ADcq+MqnAlYTtYImTNTHj1IGapR1/GQF9xze02Cvre25
   bBq2YGg1/KA7ekVwnJ0vCXZbh8Og1kWbidrkXFB6MYIKtRyo97atfhfZ2
   s/adVLSqlr0BfAMP+hA8U3zM2FqgM3aja5GQYjE9ILx898sYaBKhGPwGt
   BVmG4VH/W78OppGbyQd1R0sPgZQ/j902VIFd28iSe94UL5glQtL49SqfE
   PMD9hFWW4fCWUEA4JXe5rNLl6L5zc6OZbo3dd/upcxfqRSvd8sofAvTtY
   Q==;
X-CSE-ConnectionGUID: 0EgnPkabSpqyQ6okkDmOpw==
X-CSE-MsgGUID: l9pySCPtQhKhXF5/lfpgsQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11433"; a="49144083"
X-IronPort-AV: E=Sophos;i="6.15,290,1739865600"; 
   d="scan'208";a="49144083"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2025 22:46:04 -0700
X-CSE-ConnectionGUID: i+/fNnEKQk+uwN3n571WJw==
X-CSE-MsgGUID: 6Ys/it48SaGfY9gtAnoUMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,290,1739865600"; 
   d="scan'208";a="138763941"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.245.128]) ([10.124.245.128])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2025 22:45:58 -0700
Message-ID: <ed365c1a-259c-43b4-b08b-9364986968d9@linux.intel.com>
Date: Thu, 15 May 2025 13:45:56 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/38] Mediated vPMU 4.0 for x86
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
 <aCU6EjbXzPct9v7B@google.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <aCU6EjbXzPct9v7B@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 5/15/2025 8:49 AM, Sean Christopherson wrote:
> On Mon, Mar 24, 2025, Mingwei Zhang wrote:
>> Dapeng Mi (18):
>>   KVM: x86/pmu: Introduce enable_mediated_pmu global parameter
>>   KVM: x86/pmu: Check PMU cpuid configuration from user space
>>   KVM: x86: Rename vmx_vmentry/vmexit_ctrl() helpers
>>   KVM: x86/pmu: Add perf_capabilities field in struct kvm_host_values{}
>>   KVM: x86/pmu: Move PMU_CAP_{FW_WRITES,LBR_FMT} into msr-index.h header
>>   KVM: VMX: Add macros to wrap around
>>     {secondary,tertiary}_exec_controls_changebit()
>>   KVM: x86/pmu: Check if mediated vPMU can intercept rdpmc
>>   KVM: x86/pmu/vmx: Save/load guest IA32_PERF_GLOBAL_CTRL with
>>     vm_exit/entry_ctrl
>>   KVM: x86/pmu: Optimize intel/amd_pmu_refresh() helpers
>>   KVM: x86/pmu: Setup PMU MSRs' interception mode
>>   KVM: x86/pmu: Handle PMU MSRs interception and event filtering
>>   KVM: x86/pmu: Switch host/guest PMU context at vm-exit/vm-entry
>>   KVM: x86/pmu: Handle emulated instruction for mediated vPMU
>>   KVM: nVMX: Add macros to simplify nested MSR interception setting
>>   KVM: selftests: Add mediated vPMU supported for pmu tests
>>   KVM: Selftests: Support mediated vPMU for vmx_pmu_caps_test
>>   KVM: Selftests: Fix pmu_counters_test error for mediated vPMU
>>   KVM: x86/pmu: Expose enable_mediated_pmu parameter to user space
>>
>> Kan Liang (8):
>>   perf: Support get/put mediated PMU interfaces
>>   perf: Skip pmu_ctx based on event_type
>>   perf: Clean up perf ctx time
>>   perf: Add a EVENT_GUEST flag
>>   perf: Add generic exclude_guest support
>>   perf: Add switch_guest_ctx() interface
>>   perf/x86: Support switch_guest_ctx interface
>>   perf/x86/intel: Support PERF_PMU_CAP_MEDIATED_VPMU
>>
>> Mingwei Zhang (5):
>>   perf/x86: Forbid PMI handler when guest own PMU
>>   perf/x86/core: Plumb mediated PMU capability from x86_pmu to
>>     x86_pmu_cap
>>   KVM: x86/pmu: Exclude PMU MSRs in vmx_get_passthrough_msr_slot()
>>   KVM: x86/pmu: introduce eventsel_hw to prepare for pmu event filtering
>>   KVM: nVMX: Add nested virtualization support for mediated PMU
>>
>> Sandipan Das (4):
>>   perf/x86/core: Do not set bit width for unavailable counters
>>   KVM: x86/pmu: Add AMD PMU registers to direct access list
>>   KVM: x86/pmu/svm: Set GuestOnly bit and clear HostOnly bit when guest
>>     write to event selectors
>>   perf/x86/amd: Support PERF_PMU_CAP_MEDIATED_VPMU for AMD host
>>
>> Xiong Zhang (3):
>>   x86/irq: Factor out common code for installing kvm irq handler
>>   perf: core/x86: Register a new vector for KVM GUEST PMI
>>   KVM: x86/pmu: Register KVM_GUEST_PMI_VECTOR handler
> I ran out of time today and didn't get emails send for all patches.  I'm planning
> on getting that done tomorrow.
>
> I already have most of the proposed changes implemented:
>
>   https://github.com/sean-jc/linux.git x86/mediated_pmu
>
> It compiles and doesn't explode, but it's not fully functional (PMU tests fail).
> I'll poke at it over the next few days, but if someone is itching to figure out
> what I broke, then by all means.
>
> Given that I've already made many modifications (I have a hard time reviewing a
> series this big without editing as I go), unless someone objects, I'll post v5
> (and v6+ as needed), though that'll like be days/weeks as I need to get it working,
> and want to do more passes over the code, shortlogs, and changelogs. 

Sean, thank you very much for reviewing and refactoring the patchset. I
would look at the code and check it locally in next several days as well.



