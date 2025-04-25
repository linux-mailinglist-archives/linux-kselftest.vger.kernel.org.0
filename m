Return-Path: <linux-kselftest+bounces-31648-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0AFDA9CAEA
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Apr 2025 15:56:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CA523A54C3
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Apr 2025 13:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CE6E24BD04;
	Fri, 25 Apr 2025 13:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d2JFGerP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C3082459D4;
	Fri, 25 Apr 2025 13:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745589385; cv=none; b=h7Px84cHNUohzlWJiWDrPQC2T+9pVWWLYPsLM+Jda3/FaZ+ZFsGf/JKGR8AkhINLugi0oHIkQfnUbgNS42kMKT+tEX4F1Z4/V3PbHC8ICIh5rF9kq9CW+L1a5uTP2HUaRNkXwTj/gYHhHUr8/vFluuSxjtDNp3GeZT3A0NZ1fJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745589385; c=relaxed/simple;
	bh=YTddCksM45cgoHHNYv8q+OWh8E+7R8mg1AEXjvW90DU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z69TNez8pyaSiOffQ18z90OXMwIEw+Qq8KvPkN/Fw/dhfD+IxctJMhCTYQYJ2jUQVGfR1TuKg7Nv9ZPnqvXSWk3UL1BcuWhJVT+1Y0l/mB0Ml0+38JnYHmjmeLlxE59aZWr1U82krOzh994/Ssu35s3LC/FswS7WYxSuG7Nv5Bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d2JFGerP; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745589383; x=1777125383;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=YTddCksM45cgoHHNYv8q+OWh8E+7R8mg1AEXjvW90DU=;
  b=d2JFGerPgp7UhqTZ3J1LepxVwlS6Ol2H693zUybdS5p3hf5D/hKM1IEA
   enCy8Awjgaix32hGJf4Qfyb6cbo+vh3xf0qwp6wbD/n0uxeDJ70sPaolD
   5IeWHgw/6mnA8BaGxjVXkzGTRp9wnl2aXlbhSS2LP56+tIV83pXOQuV4N
   rBkHivd/miow6H/Yehb+v96uN2Q1ClSDRFQC9HRA8hmKUxwPbDfv+R9j/
   Ca/sbZ8UZwtndGaMiNEoZbZ+1t84wakdMfmdqcbxCKUgAuUZKKrKvWu0Y
   vO/0epdV4Jw9GDx/64hJ+/6t9OjygSAO0hPfv32mbX7vKLDr3OA/Lc+0a
   g==;
X-CSE-ConnectionGUID: YLk967teTvqEjzxzDCsnMQ==
X-CSE-MsgGUID: E1w2JK9fQHaFe3GyBFq+Xg==
X-IronPort-AV: E=McAfee;i="6700,10204,11414"; a="47163291"
X-IronPort-AV: E=Sophos;i="6.15,238,1739865600"; 
   d="scan'208";a="47163291"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2025 06:56:23 -0700
X-CSE-ConnectionGUID: 0C/TsEehTiOd20iYZ2SJ6Q==
X-CSE-MsgGUID: ArfhGeCUTl+u7Hph6IbiWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,238,1739865600"; 
   d="scan'208";a="133222259"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2025 06:56:21 -0700
Received: from [10.246.136.14] (kliang2-mobl1.ccr.corp.intel.com [10.246.136.14])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id DF61E20B5736;
	Fri, 25 Apr 2025 06:56:17 -0700 (PDT)
Message-ID: <dacd4a8e-5104-4043-b647-63e2df6d6a94@linux.intel.com>
Date: Fri, 25 Apr 2025 09:56:16 -0400
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 10/38] perf/x86: Support switch_guest_ctx interface
To: Peter Zijlstra <peterz@infradead.org>
Cc: Mingwei Zhang <mizhang@google.com>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
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
 <e2f3b1d5-ed91-47a1-aead-28675bcca2c8@linux.intel.com>
 <20250425134323.GA35881@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20250425134323.GA35881@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2025-04-25 9:43 a.m., Peter Zijlstra wrote:
> On Fri, Apr 25, 2025 at 09:06:26AM -0400, Liang, Kan wrote:
>>
>>
>> On 2025-04-25 7:15 a.m., Peter Zijlstra wrote:
>>> On Mon, Mar 24, 2025 at 05:30:50PM +0000, Mingwei Zhang wrote:
>>>> From: Kan Liang <kan.liang@linux.intel.com>
>>>>
>>>> Implement switch_guest_ctx interface for x86 PMU, switch PMI to dedicated
>>>> KVM_GUEST_PMI_VECTOR at perf guest enter, and switch PMI back to
>>>> NMI at perf guest exit.
>>>>
>>>> Signed-off-by: Xiong Zhang <xiong.y.zhang@linux.intel.com>
>>>> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
>>>> Tested-by: Yongwei Ma <yongwei.ma@intel.com>
>>>> Signed-off-by: Mingwei Zhang <mizhang@google.com>
>>>> ---
>>>>  arch/x86/events/core.c | 12 ++++++++++++
>>>>  1 file changed, 12 insertions(+)
>>>>
>>>> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
>>>> index 8f218ac0d445..28161d6ff26d 100644
>>>> --- a/arch/x86/events/core.c
>>>> +++ b/arch/x86/events/core.c
>>>> @@ -2677,6 +2677,16 @@ static bool x86_pmu_filter(struct pmu *pmu, int cpu)
>>>>  	return ret;
>>>>  }
>>>>  
>>>> +static void x86_pmu_switch_guest_ctx(bool enter, void *data)
>>>> +{
>>>> +	u32 guest_lvtpc = *(u32 *)data;
>>>> +
>>>> +	if (enter)
>>>> +		apic_write(APIC_LVTPC, guest_lvtpc);
>>>> +	else
>>>> +		apic_write(APIC_LVTPC, APIC_DM_NMI);
>>>> +}
>>>
>>> This, why can't it use x86_pmu.guest_lvtpc here and call it a day? Why
>>> is that argument passed around through the generic code only to get back
>>> here?
>>
>> The vector has to be from the KVM. However, the current interfaces only
>> support KVM read perf variables, e.g., perf_get_x86_pmu_capability and
>> perf_get_hw_event_config.
>> We need to add an new interface to allow the KVM write a perf variable,
>> e.g., perf_set_guest_lvtpc.
> 
> But all that should remain in x86, there is no reason what so ever to
> leak this into generic code.
> 

Sure. I will change it in the V5.

Thanks,
Kan

