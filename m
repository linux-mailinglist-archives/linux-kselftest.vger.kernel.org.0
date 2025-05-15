Return-Path: <linux-kselftest+bounces-33003-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0996BAB7B0C
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 03:41:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94AEC4C2A70
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 01:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 978A8279909;
	Thu, 15 May 2025 01:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FIEWLPTj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4CB52798EA;
	Thu, 15 May 2025 01:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747273258; cv=none; b=OYWcGdCyoyxGoS77tUKV6Ew7zpEiUbpUr6e/yiXh+j6FsRp+Rkdg4wxC4mfQMMr+6QQukRFHstwh3gjSKhUs4ZB6b9JUS5bg9jLk3Dux08oyI+404JHspB8XqzYFPoSSWsZ+QeCTeojqy5BrKuRzIMS6ANZANMZ9SUfy6Jhc00A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747273258; c=relaxed/simple;
	bh=1ihtGtHpTM6gYPrx8yeOkrO0mE1WK1KqAeqrzwHP8to=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WiGErs59VKMDoV3q4zIhPeMZ/9tjCGfNULw1xZ1NX/h4D7Ceeamg4mZMW6DnhqbR58s1v2r/DBE+lKPzECXzkctJcI2jR2Hj9EMxUz6cQaquKg5oJrKrMyTk3z7iKcwcgXRJoS5qJ3JIEG6t4ftD+wtzoNl1KZEn+7P3cme/PlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FIEWLPTj; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747273257; x=1778809257;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=1ihtGtHpTM6gYPrx8yeOkrO0mE1WK1KqAeqrzwHP8to=;
  b=FIEWLPTjHy6WQhy+Y6JD0pZY5HbeUB2FteWjRhm0HKA5GVn7KxjmvZE6
   iS/G4mMhZB2mxqDKg9lVpAh6nG3BhM6TLS5YLU6TjT3rx0iONTj6I19Hk
   BGiyyoOUfUCECBpkOT7YfpXntkaRqkiHAd1HSrWdkmWnyAOqQnyt6UpRO
   D1+MLXE7vDl0BWJ8cVlRYyZOrBjmN12xmsXWUCKOBFRXQqkt3efU8kCA3
   rmJJMB80TqDXnkosz7OV6TpHwywcfhzJNhJium0k+Hk6HE/s2Pf6e8Cr5
   AqkB98a52BQAG8HrifzuQKmVeHJH4kU2ndRC5k1jGHLs6xx8LR5RaCSFj
   A==;
X-CSE-ConnectionGUID: gnyYzFRvQMGFnkYmtyYSGQ==
X-CSE-MsgGUID: pIU57DDCQoCXIj+BFa43cg==
X-IronPort-AV: E=McAfee;i="6700,10204,11433"; a="36814739"
X-IronPort-AV: E=Sophos;i="6.15,289,1739865600"; 
   d="scan'208";a="36814739"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2025 18:40:56 -0700
X-CSE-ConnectionGUID: kKkn4OnxR+6SQ+bZFGWRDw==
X-CSE-MsgGUID: uO0QduhKREGse4orvz/lbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,289,1739865600"; 
   d="scan'208";a="143090670"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.245.128]) ([10.124.245.128])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2025 18:40:50 -0700
Message-ID: <e8e8ed55-7614-49be-9a1e-069738dbb2ef@linux.intel.com>
Date: Thu, 15 May 2025 09:40:47 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 07/38] perf: core/x86: Register a new vector for KVM
 GUEST PMI
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
 <20250324173121.1275209-8-mizhang@google.com> <aCUmGC45Pg6qC6FR@google.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <aCUmGC45Pg6qC6FR@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 5/15/2025 7:24 AM, Sean Christopherson wrote:
> On Mon, Mar 24, 2025, Mingwei Zhang wrote:
>> diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
>> index ad5c68f0509d..b0cb3220e1bb 100644
>> --- a/arch/x86/include/asm/idtentry.h
>> +++ b/arch/x86/include/asm/idtentry.h
>> @@ -745,6 +745,7 @@ DECLARE_IDTENTRY_SYSVEC(IRQ_WORK_VECTOR,		sysvec_irq_work);
>>  DECLARE_IDTENTRY_SYSVEC(POSTED_INTR_VECTOR,		sysvec_kvm_posted_intr_ipi);
>>  DECLARE_IDTENTRY_SYSVEC(POSTED_INTR_WAKEUP_VECTOR,	sysvec_kvm_posted_intr_wakeup_ipi);
>>  DECLARE_IDTENTRY_SYSVEC(POSTED_INTR_NESTED_VECTOR,	sysvec_kvm_posted_intr_nested_ipi);
>> +DECLARE_IDTENTRY_SYSVEC(KVM_GUEST_PMI_VECTOR,	        sysvec_kvm_guest_pmi_handler);
> I would prefer to keep KVM out of the name, and as mentioned in the previous patch,
> route this through perf.

Sure.


>
>>  #else
>>  # define fred_sysvec_kvm_posted_intr_ipi		NULL
>>  # define fred_sysvec_kvm_posted_intr_wakeup_ipi		NULL
> Y'all forgot to wire up the FRED handling.  I.e. the mediated PMI IRQs would get
> treated as spurious when running with FRED.

Oh, yes. we missed that. we would look at it. Thanks for reminding.


>
>> diff --git a/arch/x86/include/asm/irq_vectors.h b/arch/x86/include/asm/irq_vectors.h
>> index 47051871b436..250cdab11306 100644
>> --- a/arch/x86/include/asm/irq_vectors.h
>> +++ b/arch/x86/include/asm/irq_vectors.h
>> @@ -77,7 +77,10 @@
>>   */
>>  #define IRQ_WORK_VECTOR			0xf6
>>  
>> -/* 0xf5 - unused, was UV_BAU_MESSAGE */
>> +#if IS_ENABLED(CONFIG_KVM)
>> +#define KVM_GUEST_PMI_VECTOR		0xf5
>> +#endif
> Conditionally defining the vector sounds good on paper, but its problematic, e.g.
> for connecting the handler to FRED's array, and doesn't really add much value.
>
>>  #define DEFERRED_ERROR_VECTOR		0xf4
>>  
>>  /* Vector on which hypervisor callbacks will be delivered */
>> diff --git a/arch/x86/kernel/idt.c b/arch/x86/kernel/idt.c
>> index f445bec516a0..0bec4c7e2308 100644
>> --- a/arch/x86/kernel/idt.c
>> +++ b/arch/x86/kernel/idt.c
>> @@ -157,6 +157,7 @@ static const __initconst struct idt_data apic_idts[] = {
>>  	INTG(POSTED_INTR_VECTOR,		asm_sysvec_kvm_posted_intr_ipi),
>>  	INTG(POSTED_INTR_WAKEUP_VECTOR,		asm_sysvec_kvm_posted_intr_wakeup_ipi),
>>  	INTG(POSTED_INTR_NESTED_VECTOR,		asm_sysvec_kvm_posted_intr_nested_ipi),

