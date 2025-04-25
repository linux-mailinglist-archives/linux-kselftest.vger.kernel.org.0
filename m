Return-Path: <linux-kselftest+bounces-31643-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A53CA9C9D1
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Apr 2025 15:07:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A68F81889BA3
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Apr 2025 13:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 855B221638E;
	Fri, 25 Apr 2025 13:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i14zaZMC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A7771E52D;
	Fri, 25 Apr 2025 13:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745586393; cv=none; b=kerkrPh0rpMgPdieP/RRn8014q9nIsL55NAkc7reTTbqQWJcU+BXwpwu77gevAYQeOysJT21GUrCyNK18fqFn8+SOoybEl+VTvgYCfZdxzfIdBUlQR4wCCJxCTnPoPnj6/CuRgApaqxMqf+S1mFnyW4cjHo2WzaiSggF6i9wGZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745586393; c=relaxed/simple;
	bh=nHVKliqcZKK43pbKthlxPZ/VSVNDT4wpMwBBL4ep/AI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UjUbw+/wQRIfYt3oDSD3XeuQ5taHOgkfFhn+gsW8k4ZC+/Be3YMhDq1AslAUMwoTT86N8Ud+9B6XJDvgOtXRwJriya/Wr0B59NIJnxA7JPkelrNSPgdCEJpCFjAVF2i6bNkRWPGTCCet1vgF6bqNfW9IduIPxRf7eHzVMINkNb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i14zaZMC; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745586392; x=1777122392;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=nHVKliqcZKK43pbKthlxPZ/VSVNDT4wpMwBBL4ep/AI=;
  b=i14zaZMCzLIUSXNcemG7M2KJDudI20tX8F1PjeNeIzQoMWKOVoZBvFqg
   NBnO0xO5Z4zFZQoqyG4lWL4P6U//TilxO1LKYpt+30F5T+TKiQYZR7sCg
   JRPO1CZCxDrqUL8QV5g9GQ6wRBaaVP6QYMRwUvlt0vxNzMURdJu0gtPfH
   tY6usRAjWxHWlkdVfTkqy1azZJVT/4N2gXnRXwo54iu/NSB9JbGt5Hy8t
   9E1z3a57ex3KxWv5XBwC9FSMwae8wlge09mhnPxCWBgnxfy48esN9PsyK
   KLrW5xqEI7qIwD9rEdOEj7SHBKYo3i4E0iXOsLGAMYg4c5qYd1v01Kn73
   Q==;
X-CSE-ConnectionGUID: 3sDZKTC7S8yIyA18bWdXkQ==
X-CSE-MsgGUID: 5GfjXpEJSNSjDFlCp+qkKw==
X-IronPort-AV: E=McAfee;i="6700,10204,11414"; a="47383639"
X-IronPort-AV: E=Sophos;i="6.15,238,1739865600"; 
   d="scan'208";a="47383639"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2025 06:06:31 -0700
X-CSE-ConnectionGUID: W6G5gNm1QUy5Lr0fy17H/g==
X-CSE-MsgGUID: SORRBAR/T8K5jv5J/TKpuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,238,1739865600"; 
   d="scan'208";a="137892402"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2025 06:06:30 -0700
Received: from [10.246.136.14] (kliang2-mobl1.ccr.corp.intel.com [10.246.136.14])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 6C61620B5736;
	Fri, 25 Apr 2025 06:06:27 -0700 (PDT)
Message-ID: <e2f3b1d5-ed91-47a1-aead-28675bcca2c8@linux.intel.com>
Date: Fri, 25 Apr 2025 09:06:26 -0400
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 10/38] perf/x86: Support switch_guest_ctx interface
To: Peter Zijlstra <peterz@infradead.org>, Mingwei Zhang <mizhang@google.com>
Cc: Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo
 <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Sean Christopherson <seanjc@google.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, Liang@google.com,
 "H. Peter Anvin" <hpa@zytor.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Yongwei Ma <yongwei.ma@intel.com>,
 Xiong Zhang <xiong.y.zhang@linux.intel.com>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>, Jim Mattson <jmattson@google.com>,
 Sandipan Das <sandipan.das@amd.com>, Zide Chen <zide.chen@intel.com>,
 Eranian Stephane <eranian@google.com>, Shukla Manali
 <Manali.Shukla@amd.com>, Nikunj Dadhania <nikunj.dadhania@amd.com>
References: <20250324173121.1275209-1-mizhang@google.com>
 <20250324173121.1275209-11-mizhang@google.com>
 <20250425111531.GG1166@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20250425111531.GG1166@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2025-04-25 7:15 a.m., Peter Zijlstra wrote:
> On Mon, Mar 24, 2025 at 05:30:50PM +0000, Mingwei Zhang wrote:
>> From: Kan Liang <kan.liang@linux.intel.com>
>>
>> Implement switch_guest_ctx interface for x86 PMU, switch PMI to dedicated
>> KVM_GUEST_PMI_VECTOR at perf guest enter, and switch PMI back to
>> NMI at perf guest exit.
>>
>> Signed-off-by: Xiong Zhang <xiong.y.zhang@linux.intel.com>
>> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
>> Tested-by: Yongwei Ma <yongwei.ma@intel.com>
>> Signed-off-by: Mingwei Zhang <mizhang@google.com>
>> ---
>>  arch/x86/events/core.c | 12 ++++++++++++
>>  1 file changed, 12 insertions(+)
>>
>> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
>> index 8f218ac0d445..28161d6ff26d 100644
>> --- a/arch/x86/events/core.c
>> +++ b/arch/x86/events/core.c
>> @@ -2677,6 +2677,16 @@ static bool x86_pmu_filter(struct pmu *pmu, int cpu)
>>  	return ret;
>>  }
>>  
>> +static void x86_pmu_switch_guest_ctx(bool enter, void *data)
>> +{
>> +	u32 guest_lvtpc = *(u32 *)data;
>> +
>> +	if (enter)
>> +		apic_write(APIC_LVTPC, guest_lvtpc);
>> +	else
>> +		apic_write(APIC_LVTPC, APIC_DM_NMI);
>> +}
> 
> This, why can't it use x86_pmu.guest_lvtpc here and call it a day? Why
> is that argument passed around through the generic code only to get back
> here?

The vector has to be from the KVM. However, the current interfaces only
support KVM read perf variables, e.g., perf_get_x86_pmu_capability and
perf_get_hw_event_config.
We need to add an new interface to allow the KVM write a perf variable,
e.g., perf_set_guest_lvtpc.

Thanks,
Kan

