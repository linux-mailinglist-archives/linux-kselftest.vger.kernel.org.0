Return-Path: <linux-kselftest+bounces-33021-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45E1EAB7D0B
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 07:38:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF8B18C61B4
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 05:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C620D293B6F;
	Thu, 15 May 2025 05:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TVIK7mEr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 137304B1E71;
	Thu, 15 May 2025 05:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747287479; cv=none; b=YEzG/d6vPMitshzaoBguNjdtnRnlg11gzZVbtpjgTbE2Q+0r8CDEHhoFWJSQJH0B6B/f72BqLg1sRLrV/CzyAVHeL+KLwLJkq2ydjmVffgAEMbL4DykEAJ2rntmYSC64EZ5/zCgGmsNPMX5DrA17PeRu4lzlB4J6x+egGUqqmjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747287479; c=relaxed/simple;
	bh=xLlmQORNl2yGCmXe0IMxm/678rmJHgDejJHZphvssXE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V+Uuk8kAU2+oMXw8et35XRuLBLT/PGUchSxfA5owDDpG2ZbvkkOT+MgyAGLn7LhDAxmhOnSDZWF5no6bc46bm/I2AE7b5PLs6L/BM2ydpozoXAhyxfE8VWIUVKIAJohGPyQnULU5rwQr+XA/f0Ql7KadvOO5VXpCTXcS4YQ8chQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TVIK7mEr; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747287478; x=1778823478;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=xLlmQORNl2yGCmXe0IMxm/678rmJHgDejJHZphvssXE=;
  b=TVIK7mErNuK6VokogK9Km+jWv+xVSwqDUoUXawDGHzKYPqenlGhOKqxb
   VrWQIYBCYz7zf1wwK3rmetC4bd5TDFpKTPUP0Lj4yKni8OsiAe9/2cxm1
   McppnSL8NSWaYFjzq7RjMBYq5vy4YV8CWT9DiR4tqIrpMH6eo2YFIxU7b
   A95QS10ZNXMjfKQ1UwYqB5o6iTbqW+Cm5O9GKojhXBAWm6Jwz0ESGlOhw
   3dyto01Ats3xKVsW+QR6cIfgxyBvxJ1EvdP9QGX+PPtXv1NYn0njFa5VF
   LuYJg+lpCyrf9xiz6/RNe0UHAu8k5dOdfhjq7tZfr9FGO/i3PXdiIbiFo
   Q==;
X-CSE-ConnectionGUID: 7jFZLurTTvmXzd1dnNveHQ==
X-CSE-MsgGUID: 3aycLS5PQUumlUVQPbXrgg==
X-IronPort-AV: E=McAfee;i="6700,10204,11433"; a="71717818"
X-IronPort-AV: E=Sophos;i="6.15,290,1739865600"; 
   d="scan'208";a="71717818"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2025 22:37:58 -0700
X-CSE-ConnectionGUID: 22anqOZvToCOExIJT0BGWg==
X-CSE-MsgGUID: hmfxcQ46QYG1wU7dAWPwQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,290,1739865600"; 
   d="scan'208";a="138129187"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.245.128]) ([10.124.245.128])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2025 22:37:52 -0700
Message-ID: <bac13842-9d15-4664-a20d-4916abcdc3e7@linux.intel.com>
Date: Thu, 15 May 2025 13:37:49 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 23/38] KVM: x86/pmu: Configure the interception of PMU
 MSRs
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
 <20250324173121.1275209-24-mizhang@google.com> <aCU4Uuhzo_ovR7r8@google.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <aCU4Uuhzo_ovR7r8@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 5/15/2025 8:41 AM, Sean Christopherson wrote:
> Again, use more precise language.  "Configure interceptions" is akin to "do work".
> It gives readers a vague idea of what's going on, but this
>
>   KVM: x86/pmu: Disable interception of select PMU MSRs for mediated vPMUs
>
> is just as concise, and more descriptive.

Yes, absolutely. Thanks.


>
>> +	/*
>> +	 * In mediated vPMU, intercept global PMU MSRs when guest PMU only owns
>> +	 * a subset of counters provided in HW or its version is less than 2.
>> +	 */
>> +	if (kvm_mediated_pmu_enabled(vcpu) && kvm_pmu_has_perf_global_ctrl(pmu) &&
>> +	    pmu->nr_arch_gp_counters == kvm_pmu_cap.num_counters_gp)
> This logic belongs in common code.  Just because AMD doesn't have fixed counters
> doesn't mean KVM can't have a superfluous "0 == 0" check.

Yes.


>
>> +	if (kvm_mediated_pmu_enabled(vcpu) && kvm_pmu_has_perf_global_ctrl(pmu) &&
> Just require the guest to have PERF_GLOBAL_CTRL, I don't see any reason to support
> v1 PMUs.  It adds complexity and weirdness, and I can't imagine there's a use case.

Ok.


