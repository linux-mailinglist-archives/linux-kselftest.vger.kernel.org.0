Return-Path: <linux-kselftest+bounces-33000-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF6DFAB7AF6
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 03:31:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B75023A1138
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 01:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B663226161;
	Thu, 15 May 2025 01:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bUUEGTIr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ECC7F9D6;
	Thu, 15 May 2025 01:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747272673; cv=none; b=OtshoInVJ/wPy29vApTLEaQBcZkcVsOQD8ekNgjlXIZsw8K9X6mEAU1J4JNEFq+7T1cO0IFAMtNjQDwp9AwdZiXVVFZvKOpdxbH3hR0gcFmALqZcYmmzgo9XK/HLNZoV7NrxZMaiv8XEX4/OjRkutOqrBwBNSaVibcpNxQ7M3i0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747272673; c=relaxed/simple;
	bh=NCeIslnruzRitSm7BSgkBHpLCL5CTK0c5HqsqD1ej3U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XpkyBv144dsZprxxes6/tyb5i5q+8DzHPv2XBaj6KHdpKPFhpt2iB/5zyQ953edQBFs+DmGV4qavz8Vc8hppsVFV9ZNyei/0ru9nireMQEZ7/YBH4TKKju+btl7xMdkSkdqg2W2mr5kNKs/89T4BVzah810lFD91tOqhiLcFs8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bUUEGTIr; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747272672; x=1778808672;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=NCeIslnruzRitSm7BSgkBHpLCL5CTK0c5HqsqD1ej3U=;
  b=bUUEGTIrhKMl5CrE0XxFnp1jzrlpoP6CrlNFZIuxBqGYcCf/+eN2r3jQ
   D+Nzo6z6UGMSD6OOJEATmv5pQmM5dY6nynbm04284ScMysOuQcXDpbJHS
   TrXdV4NJK0fQas1x6HXqGzDt6n/bUZMOrcb/Hn4EcVFPZS0pAI0naT2so
   YmziCVQCut2/ughJpjYa6fGU6ie1cUM7swSKJCAj9rIzQf+nJVQkxN6QT
   XrQLlFFCk22s62b3127b1CXQHiHWUJI6RhM2GNnrSPEn81DzyfZWGJJ13
   OmjzU22EmNNKgFsu7GW6NYfTJdRCgcrYExlQ+xEjangr3MVl8owmdl2mL
   A==;
X-CSE-ConnectionGUID: BEXEKepuQYypwcRr3Bv8EA==
X-CSE-MsgGUID: Au76MdiIQl69/YFEwM0/Kw==
X-IronPort-AV: E=McAfee;i="6700,10204,11433"; a="60203284"
X-IronPort-AV: E=Sophos;i="6.15,289,1739865600"; 
   d="scan'208";a="60203284"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2025 18:31:10 -0700
X-CSE-ConnectionGUID: mAW4HLuBTZCVGylJMSMRRg==
X-CSE-MsgGUID: HWTGOs0DQrekd2cBL6qCoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,289,1739865600"; 
   d="scan'208";a="142973694"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.245.128]) ([10.124.245.128])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2025 18:31:04 -0700
Message-ID: <60ca046d-b706-47ff-bbdb-9e6646af5250@linux.intel.com>
Date: Thu, 15 May 2025 09:31:01 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/38] perf: Support get/put mediated PMU interfaces
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
 <20250324173121.1275209-2-mizhang@google.com> <aCUdvaM4xkLzRF8J@google.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <aCUdvaM4xkLzRF8J@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 5/15/2025 6:48 AM, Sean Christopherson wrote:
> On Mon, Mar 24, 2025, Mingwei Zhang wrote:
>> +/*
>> + * Currently invoked at VM creation to
>> + * - Check whether there are existing !exclude_guest events of PMU with
>> + *   PERF_PMU_CAP_MEDIATED_VPMU
>> + * - Set nr_mediated_pmu_vms to prevent !exclude_guest event creation on
>> + *   PMUs with PERF_PMU_CAP_MEDIATED_VPMU
>> + *
>> + * No impact for the PMU without PERF_PMU_CAP_MEDIATED_VPMU. The perf
>> + * still owns all the PMU resources.
>> + */
>> +int perf_get_mediated_pmu(void)
>> +{
>> +	guard(mutex)(&perf_mediated_pmu_mutex);
>> +	if (atomic_inc_not_zero(&nr_mediated_pmu_vms))
>> +		return 0;
>> +
>> +	if (atomic_read(&nr_include_guest_events))
>> +		return -EBUSY;
>> +
>> +	atomic_inc(&nr_mediated_pmu_vms);
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(perf_get_mediated_pmu);
> IMO, all of the mediated PMU logic should be guarded with a Kconfig.  I strongly
> suspect KVM x86 will be the only user for the foreseeable, e.g. arm64 is trending
> toward a partioned PMU approach, and subjecting other architectures to the (minor)
> overhead associated with e.g. nr_mediated_pmu_vms seems pointless.  The other
> nicety is that it helps encapsulate the mediated PMU code, which for those of us
> that haven't been living and breathing this for the last few months, is immensely
> helpful.

I'm fine with this.


>
>> +void perf_put_mediated_pmu(void)
> To avoid confusion with perf_put_guest_context() in future patches, I think it
> makes sense to go with something like perf_{create,release}_mediated_pmu().  I
> actually like the get/put terminology in isolation, but they look weird side-by-side.

Agree.



