Return-Path: <linux-kselftest+bounces-7881-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AF6F18A387F
	for <lists+linux-kselftest@lfdr.de>; Sat, 13 Apr 2024 00:17:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3AC30B226AD
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Apr 2024 22:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F273215218F;
	Fri, 12 Apr 2024 22:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ETzIjfwQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3691F1514F8
	for <linux-kselftest@vger.kernel.org>; Fri, 12 Apr 2024 22:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712960217; cv=none; b=FpTc23XBtzwZhc1Hm1lmgDqjK2pnGGdyeiHX+X1hUmyqt/c09gilxnyhhS3IFLLWqEE2TEkAOdJaoVp9VEdtmoSRBTinjRy2AuOrWBUkNorgcQafRR1dhsjklO7hlJiwUQeuk9W+32RgxqO8RQ9uWFfr4tDZIn1MCdOohwdOd74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712960217; c=relaxed/simple;
	bh=A+WlCPvFO2agCoXWz9wEmlRDX2foLb2Z/uZuvNEIuVk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CHx6M6F2gyj8doOQTg27+Z2jWYLokirM50HwqNYvDTmyZvAK/BFTvNkLHmeTvbt9eDQN6GyMVT1MTSsTjMeZ0HnaLwC/jFb/4Ro7hud/qY5TVXGN06KdKmAhkKrb8EJnPClNGrGooQviaq1OLKC03x7f654jGpBFn/Oj4GUZl9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ETzIjfwQ; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712960217; x=1744496217;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=A+WlCPvFO2agCoXWz9wEmlRDX2foLb2Z/uZuvNEIuVk=;
  b=ETzIjfwQ9kxya8Qp/nZ4Kk8z1V41EGPH0nyZTm2j6RVh5KoVKU4uMiQf
   V7KWaG/ilLnIs7Qt8SCb19hl/s7cQmQutrSshGAHtZZKO9Gjhn8UskDVT
   y6iijhF9gAMbGaYvsylZoRQyaekewScRnJvgpUPIdblZ0o/HxIqxk2NuY
   6vkGKHngKT2qof6lLT2IbnzSErNv4lYsmnth7D3nXdgcj9Bb3fNhqS+6r
   6XHX9O1sHwZ0T6+sxzh7QZrVT9pTwfwxbbtuLXRRLN/VAnlc0oNevrl44
   mLGayqGF8aaAG8xB5K5DnmOWgFwq/S3QzAjAFHlKw1E9USLNOq8hkoZ48
   w==;
X-CSE-ConnectionGUID: VFzY1l7QRjayJShXpom1IA==
X-CSE-MsgGUID: LCa7c6ocRq69fPFDomSRBQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11042"; a="18993104"
X-IronPort-AV: E=Sophos;i="6.07,197,1708416000"; 
   d="scan'208";a="18993104"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2024 15:16:56 -0700
X-CSE-ConnectionGUID: dTlWiR63S4ylB0MpcSEH0g==
X-CSE-MsgGUID: Rn+CM6onTgSGNssJLeiLOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,197,1708416000"; 
   d="scan'208";a="26044734"
Received: from soc-cp83kr3.jf.intel.com (HELO [10.24.10.40]) ([10.24.10.40])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2024 15:16:56 -0700
Message-ID: <3d5b3dd0-82ed-4437-a452-a67cd9b6c283@intel.com>
Date: Fri, 12 Apr 2024 15:16:56 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/rseq: take large C-state exit latency into
 consideration
To: Sean Christopherson <seanjc@google.com>
Cc: linux-kselftest@vger.kernel.org, pbonzini@redhat.com
References: <20240322163351.150673-1-zide.chen@intel.com>
 <ZhCCub4ajIvpvrBk@google.com>
 <0d366f20-e332-45a9-8545-4513fdce6e21@intel.com>
 <ZhmC3PbYQlChDg-t@google.com>
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <ZhmC3PbYQlChDg-t@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/12/2024 11:52 AM, Sean Christopherson wrote:
> On Fri, Apr 12, 2024, Zide Chen wrote:
>> On 4/5/2024 4:01 PM, Sean Christopherson wrote:
>>> On Fri, Mar 22, 2024, Zide Chen wrote:
>>>> Currently, the migration worker delays 1-10 us, assuming that one
>>>> KVM_RUN iteration only takes a few microseconds.  But if C-state exit
>>>> latencies are large enough, for example, hundreds or even thousands
>>>> of microseconds on server CPUs, it may happen that it's not able to
>>>> bring the target CPU out of C-state before the migration worker starts
>>>> to migrate it to the next CPU.
>>>>
>>>> If the system workload is light, most CPUs could be at a certain level
>>>> of C-state, and the vCPU thread may waste milliseconds before it can
>>>> actually migrate to a new CPU.
>>>
>>> Well fudge.  That's definitely not on my bingo sheet.
>>>
>>>> Thus, the tests may be inefficient in such systems, and in some cases
>>>> it may fail the migration/KVM_RUN ratio sanity check.
>>>>
>>>> Since we are not able to turn off the cpuidle sub-system in run time,
>>>> this patch creates an idle thread on every CPU to prevent them from
>>>> entering C-states.
>>>
>>> First off, huge thanks for debugging this!  That must have been quite the task
>>> (no pun intended).
>>>
>>> While spinning up threads on every CPU is a clever way to ensure they don't go
>>> into a deep sleep state, I'm not exactly excited about the idea of putting every
>>> reachable CPU into a busy loop.  And while this doesn't add _that_ much complexity,
>>> I'm not sure the benefit (preserving the assert for all systems) is worth it.  I
>>> also don't want to arbitrarily prevent idle task (as in, the kernel's idle task)
>>> interactions.  E.g. it's highly (highly) unlikely, but not impossible for there
>>> to be a bug that's unique to idle tasks, or C-states, or other edge case.
>>>
>>> Are there any metrics/stats that can be (easily) checked to grant an exception
>>> to the sanity check?  That's a very hand-wavy question, as I'm not even sure what
>>> type of stat we'd want to look at.  Actual runtime of a task, maybe?
>>>
>>> If that's not easy, what if we add an off-by-default command line option to skip
>>> the sanity check?  I was resistant to simply deleting the assert in the past, but
>>> that was mainly because I didn't want to delete it without understanding what was
>>> causing problems.  That would allow CI environments to opt-out as needed, while
>>> still keeping the sanity check alive for enough systems to make it useful.
>>
>> Sorry for not replying earlier. I overlooked your email from my inbox. :)
>>
>> Alternative to the busy loop, how about using the /dev/cpu_dma_latency
>> interface to disable c-states (I wish I had learned this before writing
>> the initial patch)? The good thing is it can do automatic cleanup when
>> it closes the fd.
> 
> It's probably not practical to touch /dev/cpu_dma_latency in code, e.g. on my
> system it's fully root-only.  And forcing rseq_test to run as root, or be bookended
> with script commands to toggle /dev/cpu_dma_latency, is not a net positive.
> Lastly, fiddling with a system-wide knob in a KVM selftests is opening a can of
> worms I don't want to open.
> 
> However, we could have the failing TEST_ASSERT() explicitly call out
> /dev/cpu_dma_latency as a knob to try changing if the assert is failing.  If we
> do that *and* add a command line option to skip the sanity check, that seems like
> it would give users sufficient flexibility to avoid false positives, while still
> maintaining good coverage.

Make sense, will do it in V2.

