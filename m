Return-Path: <linux-kselftest+bounces-20417-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB7189AB6DB
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Oct 2024 21:33:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04B8F1C23394
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Oct 2024 19:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 699141CBE8D;
	Tue, 22 Oct 2024 19:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SW6jM7Ol"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D5BF19EED0;
	Tue, 22 Oct 2024 19:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729625482; cv=none; b=tBKHg1gT0xsmcyHNpDOW8bEioNXyAdrO3JCRaXeDG9JYx6WG3HVM6/OrXCqAdFjKvZgWmMYHkPGdUFU/IZOyNsAgVUXWkClSCyxnb05j1m1SyB4XrzwDRkv995DOf8c0/BFMcqpDMf76ygdXGnPtBG8w7CjVHBiUgEmCTCEiGaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729625482; c=relaxed/simple;
	bh=1dT2jJaCjhu9+xr53oY4OlmfMB8jPqfWipDC5gxKAtI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dd7jebuJqUPfHKLKSLjicsMd/VvH5htluJ+4cjLtjkbgIiI4w5H76RD7Sl5wPgVBLY3HaHGHSC8Du6MGcSukbYcjCcLyWWu7sQYAYo0vBHpKa91vqyFzilCFqCSeqr7aiwT4De20ePoVaQ9FHEEiKDvE+F0InI5GpQKQFydF7yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SW6jM7Ol; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729625481; x=1761161481;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=1dT2jJaCjhu9+xr53oY4OlmfMB8jPqfWipDC5gxKAtI=;
  b=SW6jM7Ol0cbPyX5pleBFFI8MVeodSXVb2Cx6JY9msG1LHuUfAn+sFjQv
   RDah+32KJb88grEphEIZY+AiZeOAJXvN2NALpcNA/cSdZt+Enb8in6bHu
   oxkqs3pwNhqT+7EGl1wahcF0phYaUlSu7U8LLQ63Zy0MN8aXHdhTKE5ge
   9uRQct+DTngtdLLHtgP26esp8mO8kK2LwoohfcCalEFcbyg7ZBT1RsVkw
   SlHfKhY9f3H/uQsiiclnwelXzKqk/LdAu1JAYCTysWSXyFCTqogIAONHx
   WEGoew7isWA+hhayZdhLVSwvfUu7tWcsbfgtUan0QlElT5DD6LmSnQ1cb
   w==;
X-CSE-ConnectionGUID: i8qiTTMWRaOSpQuR8WaKlA==
X-CSE-MsgGUID: mbyOPUQsSHOPt9LGeBxZyQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="40307870"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="40307870"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2024 12:31:18 -0700
X-CSE-ConnectionGUID: gJ2/MQknTLC8VZHvb2HBYg==
X-CSE-MsgGUID: AvRxGY7XQAqoUWQ6JunKCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,223,1725346800"; 
   d="scan'208";a="80148851"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.246.16.81])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2024 12:31:07 -0700
Message-ID: <2a8e6f2c-4284-4218-9b91-af6a4d65e982@intel.com>
Date: Tue, 22 Oct 2024 22:31:02 +0300
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V13 03/14] KVM: x86: Fix Intel PT Host/Guest mode when
 host tracing also
To: Sean Christopherson <seanjc@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Paolo Bonzini
 <pbonzini@redhat.com>, Ingo Molnar <mingo@redhat.com>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Heiko Carstens <hca@linux.ibm.com>, Thomas Richter <tmricht@linux.ibm.com>,
 Hendrik Brueckner <brueckner@linux.ibm.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach
 <mike.leach@linaro.org>, James Clark <james.clark@arm.com>,
 coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
 Yicong Yang <yangyicong@hisilicon.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>, Will Deacon
 <will@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Ian Rogers <irogers@google.com>, Andi Kleen <ak@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 H Peter Anvin <hpa@zytor.com>, Kan Liang <kan.liang@linux.intel.com>,
 Zhenyu Wang <zhenyuw@linux.intel.com>, mizhang@google.com,
 kvm@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org
References: <20241014105124.24473-1-adrian.hunter@intel.com>
 <20241014105124.24473-4-adrian.hunter@intel.com>
 <Zw1iCMNSI4Lc0mSG@google.com>
 <b29e8ba4-5893-4ca0-b2cc-55d95f2fc968@intel.com>
 <ZxfTOQzcXTBEiXMG@google.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <ZxfTOQzcXTBEiXMG@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22/10/24 19:30, Sean Christopherson wrote:
> On Tue, Oct 22, 2024, Adrian Hunter wrote:
>> On 14/10/24 21:25, Sean Christopherson wrote:
>>>> Fixes: 2ef444f1600b ("KVM: x86: Add Intel PT context switch for each vcpu")
>>>> Cc: stable@vger.kernel.org
>>>
>>> This is way, way too big for stable@.  Given that host/guest mode is disabled by
>>> default and that no one has complained about this, I think it's safe to say that
>>> unless we can provide a minimal patch, fixing this in LTS kernels isn't a priority.
>>>
>>> Alternatively, I'm tempted to simply drop support for host/guest mode.  It clearly
>>> hasn't been well tested, and given the lack of bug reports, likely doesn't have
>>> many, if any, users.  And I'm guessing the overhead needed to context switch all
>>> the RTIT MSRs makes tracing in the guest relatively useless.
>>
>> As a control flow trace, it is not affected by context switch overhead.
> 
> Out of curiosity, how much is Intel PT used purely for control flow tracing, i.e.
> without caring _at all_ about perceived execution time?

It can be used to try to understand how code went wrong.

But timestamps would still indicate what was happening on different VCPUs
at about the same time.

> 
>> Intel PT timestamps are also not affected by that.
> 
> Timestamps are affected because the guest will see inexplicable jumps in time.

Tracing a task on the host sees jumps in time for scheduler
context switches anyway.

> Those gaps are unavoidable to some degree, but context switching on every entry
> and exit is 
> 
>> This patch reduces the MSR switching.
> 
> To be clear, I'm not objecting to any of the ideas in this patch, I'm "objecting"
> to trying to put band-aids on KVM's existing implementation, which is clearly
> buggy and, like far too many PMU-ish features in KVM, was probably developed
> without any thought as to how it would affect use cases beyond the host admin
> and the VM owner being a single person.  And I'm also objecting, vehemently, to
> sending anything of this magnitude and complexity to LTS kernels.

That's your call for sure.

> 
>>> /me fiddles around
>>>
>>> LOL, yeah, this needs to be burned with fire.  It's wildly broken.  So for stable@,
>>
>> It doesn't seem wildly broken.  Just the VMM passing invalid CPUID
>> and KVM not validating it.
> 
> Heh, I agree with "just", but unfortunately "just ... not validating" a large
> swath of userspace inputs is pretty widly broken.  More importantly, it's not
> easy to fix.  E.g. KVM could require the inputs to exactly match hardware, but
> that creates an ABI that I'm not entirely sure is desirable in the long term.

Although the CPUID ABI does not really change.  KVM does not support
emulating Intel PT, so accepting CPUID that the hardware cannot support
seems like a bit of a lie.  Aren't there other features that KVM does not
support if the hardware support is not there?

To some degree, a testing and debugging feature does not have to be
available in 100% of cases because it can still be useful when it is
available.

> 
>>> I'll post a patch to hide the module param if CONFIG_BROKEN=n (and will omit
>>> stable@ for the previous patch).
>>>
>>> Going forward, if someone actually cares about virtualizing PT enough to want to
>>> fix KVM's mess, then they can put in the effort to fix all the bugs, write all
>>> the tests, and in general clean up the implementation to meet KVM's current
>>> standards.  E.g. KVM usage of intel_pt_validate_cap() instead of KVM's guest CPUID
>>> and capabilities infrastructure needs to go.
>>
>> The problem below seems to be caused by not validating against the *host*
>> CPUID.  KVM's CPUID information seems to be invalid.
> 
> Yes.
> 
>>> My vote is to queue the current code for removal, and revisit support after the
>>> mediated PMU has landed.  Because I don't see any point in supporting Intel PT
>>> without a mediated PMU, as host/guest mode really only makes sense if the entire
>>> PMU is being handed over to the guest.
>>
>> Why?
> 
> To simplify the implementation, and because I don't see how virtualizing Intel PT
> without also enabling the mediated PMU makes any sense.
> 
> Conceptually, KVM's PT implementation is very, very similar to the mediated PMU.
> They both effectively give the guest control of hardware when the vCPU starts
> running, and take back control when the vCPU stops running.
> 
> If KVM allows Intel PT without the mediated PMU, then KVM and perf have to support
> two separate implementations for the same model.  If virtualizing Intel PT is
> allowed if and only if the mediated PMU is enabled, then .handle_intel_pt_intr()
> goes away.  And on the flip side, it becomes super obvious that host usage of
> Intel PT needs to be mutually exclusive with the mediated PMU.

And forgo being able to trace mediated passthough with Intel PT ;-)

> 
>> Intel PT PMU is programmed separately from the x86 PMU.
> 
> Except for the minor detail that Intel PT generates PMIs, and that PEBS can log
> to PT buffers.  Oh, and giving the guest control of the PMU means host usage of
> Intel PT will break the host *and* guest.  The host won't get PMIs, while the
> guest will see spurious PMIs.

Yes the PMI is in conflict if it is not also a VM-Exit

Note that Intel PT does have a snapshot mode that doesn't use a PMI.
Trace data continuously overwrites the ring buffer until the user asks
for a snapshot.

> 
> So I don't see any reason to try to separate the two.

OK

> 
>>> [ 1458.686107] ------------[ cut here ]------------
>>> [ 1458.690766] Invalid MSR 588, please adapt vmx_possible_passthrough_msrs[]
>>
>> VMM is trying to set a non-existent MSR.  Looks like it has
>> decided there are more PT address filter MSRs that are architecturally
>> possible.
>>
>> I had no idea QEMU was so broken.  
> 
> It's not QEMU that's broken, it's KVM that's broken.  
> 
>> I always just use -cpu host.
> 
> Yes, and that's exactly the problem.  The only people that have ever touched this
> likely only ever use `-cpu host`, and so KVM's flaws have gone unnoticed.
> 
>> What were you setting?
> 
> I tweaked your selftest to feed KVM garbage.


