Return-Path: <linux-kselftest+bounces-33304-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F873ABB3E0
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 May 2025 06:16:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A921170230
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 May 2025 04:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 182F91E7C27;
	Mon, 19 May 2025 04:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dWfSYr5r"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 252C93595D;
	Mon, 19 May 2025 04:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747628194; cv=none; b=I7QrKYQKzClIB0dBuC21KJVIG19E7CO85pvY32O2h9Voe6L7qKOFrzaC9CimdAkWZvIwGPfxdU8oI0u4Ug4AD4kdfcF/DBT+oCrXYv9g/TQD+GZMfhv+USiVWdlxtoDGl5KSqTRYk4B50Hk02bRRS+dns1C4yiza95aQQYgY/VU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747628194; c=relaxed/simple;
	bh=GkMzPKhO1OJ4iGbuKLJGKxX4Kn//36QU7IIlwR3PDeI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cUin/EA43/CWqifeqb87/s9hhcjKne1aPYaSFViZ821+fYf/xw3dKxyhspnTBS3+ZINO9Ui7iVYXkEd27iUWDFqt18wd/zjw17m648rIn1WfgWd1OM1xvrS36zH7hHiy+UhlQpXTjKA+kKZYaFGdA7oefEaVwRXjqXQxBSMIJdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dWfSYr5r; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747628193; x=1779164193;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=GkMzPKhO1OJ4iGbuKLJGKxX4Kn//36QU7IIlwR3PDeI=;
  b=dWfSYr5r3sghRmbIjtol93SMAZxOb8H83IbRkARgqquB+5yJWdfjJMxv
   8MkgaUvwuPBcUV9Iv/Hcgtzc5lOL+OwdtEUVonOC20mAF4GFxulzbDI9u
   GQoGrQab3sPTzKMgADw5a45xdE7CyrfC6PmtCjJi4rk+ocOzR7TcJVS3i
   VpQcTvlgwMv5tiB62TSENmf5l2TyrcXyeAAP7369iwrn3tz1kvBBckIhE
   gC+C3pa2bbwYvnF+tMjxYxnRslQJCPIKdHvowNWoLxFlnzhAiRO+vKrpD
   A7wDfKyr3LOKZjP3oaqx+/NYndzVXJX5GHkl7Z3HzdSjjfxVX6bc5P+k+
   Q==;
X-CSE-ConnectionGUID: oOPmePK1TTang6PdHFgEPw==
X-CSE-MsgGUID: NvZaNoCfReCGKddB8G+Piw==
X-IronPort-AV: E=McAfee;i="6700,10204,11437"; a="49211699"
X-IronPort-AV: E=Sophos;i="6.15,300,1739865600"; 
   d="scan'208";a="49211699"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2025 21:16:32 -0700
X-CSE-ConnectionGUID: wqfTlkbITeSgE7GYYrO7Ag==
X-CSE-MsgGUID: S9+KVYSwQNi4o9/a+DoLFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,300,1739865600"; 
   d="scan'208";a="139162322"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.245.128]) ([10.124.245.128])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2025 21:16:21 -0700
Message-ID: <b29fc40d-4c05-44db-975f-b40d3c188c88@linux.intel.com>
Date: Mon, 19 May 2025 12:16:17 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 27/38] KVM: x86/pmu: Handle PMU MSRs interception and
 event filtering
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
 <20250324173121.1275209-28-mizhang@google.com>
 <2d0d274c-6bc0-43c7-a8a8-92aa11872675@linux.intel.com>
 <aCemClX6rKnVFqLt@google.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <aCemClX6rKnVFqLt@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 5/17/2025 4:54 AM, Sean Christopherson wrote:
> On Fri, May 16, 2025, Dapeng Mi wrote:
>> On 3/25/2025 1:31 AM, Mingwei Zhang wrote:
>>> +	if (kvm_mediated_pmu_enabled(pmu_to_vcpu(pmu))) {
>>> +		bool allowed = check_pmu_event_filter(pmc);
>>> +
>>> +		if (pmc_is_gp(pmc)) {
>>> +			if (allowed)
>>> +				pmc->eventsel_hw |= pmc->eventsel &
>>> +						    ARCH_PERFMON_EVENTSEL_ENABLE;
>>> +			else
>>> +				pmc->eventsel_hw &= ~ARCH_PERFMON_EVENTSEL_ENABLE;
>>> +		} else {
>>> +			int idx = pmc->idx - KVM_FIXED_PMC_BASE_IDX;
>>> +
>>> +			if (allowed)
>>> +				pmu->fixed_ctr_ctrl_hw = pmu->fixed_ctr_ctrl;
>> Sean, just found there is a potential bug here.  The
>> "pmu->fixed_ctr_ctrl_hw" should not be assigned to "pmu->fixed_ctr_ctrl"
>> here, otherwise the other filtered fixed counter (not this allowed fixed
>> counter) could be enabled accidentally.
>>
>> diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
>> index ba9d336f1d1d..f32e5f66f73b 100644
>> --- a/arch/x86/kvm/pmu.c
>> +++ b/arch/x86/kvm/pmu.c
>> @@ -473,7 +473,8 @@ static int reprogram_counter(struct kvm_pmc *pmc)
>>                         int idx = pmc->idx - KVM_FIXED_PMC_BASE_IDX;
>>
>>                         if (allowed)
>> -                               pmu->fixed_ctr_ctrl_hw = pmu->fixed_ctr_ctrl;
>> +                               pmu->fixed_ctr_ctrl_hw |= pmu->fixed_ctr_ctrl &
>> +                                              
>> intel_fixed_bits_by_idx(idx, 0xf);
> Hmm, I think that's fine, since pmu->fixed_ctr_ctrl should have changed?  But I'd

Not exactly. Assume guest enables the fixed counter 0 and 1, then
pmu->fixed_ctr_ctrl would be 0xbb. At the first time, user disables the
fixed counter 0 by KVM event filter, then pmu->fixed_ctr_ctrl_hw would be
0xb0, secondly user disables the fixed counter 1 as well, so
pmu->fixed_ctr_ctrl_hw is 0x0. At the third time, user re-enables fixed
counter 1, so pmu->fixed_ctr_ctrl_hw is expected to be 0xb0, but it's not
actually. Although the 1st calling (for fixed counter 0) to
reprogram_counter() would disable it, but the 2nd calling (for fixed
counter 1) to reprogram_counter() accidentally enables it
(pmu->fixed_ctr_ctrl_hw becomes 0xbb eventually). This is incorrect.


> rather play it safe and do (completely untested):
>
> 	if (pmc_is_gp(pmc)) {
> 		pmc->eventsel_hw &= ~ARCH_PERFMON_EVENTSEL_ENABLE;
> 		if (allowed)
> 			pmc->eventsel_hw |= pmc->eventsel &
> 					    ARCH_PERFMON_EVENTSEL_ENABLE;
> 	} else {
> 		u64 mask = intel_fixed_bits_by_idx(pmc->idx - KVM_FIXED_PMC_BASE_IDX, 0xf);
>
> 		pmu->fixed_ctr_ctrl_hw &= ~mask;
> 		if (allowed)
> 			pmu->fixed_ctr_ctrl_hw |= pmu->fixed_ctr_ctrl & mask;
> 	}

The code looks good.



