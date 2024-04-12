Return-Path: <linux-kselftest+bounces-7820-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D6D9D8A3405
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Apr 2024 18:47:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E7E51C21528
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Apr 2024 16:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E46F8148313;
	Fri, 12 Apr 2024 16:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KehtsQ3f"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF44C14A639
	for <linux-kselftest@vger.kernel.org>; Fri, 12 Apr 2024 16:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712940434; cv=none; b=bLZDAIaqEcG8lowIm0aKWZ2PSrPVHY4uTW+pMANmkP7lL23/o6JJL4e8StXjISVi+vj+wgh1/xi6mR9AMFRnnwG3YMaESXH++3MnwQp2ykJT4ZI9WqQuFAMLZAdI/d2ocTCU4gJWlebvA9O4Vs3KUN11yWuADFL1lhnBvtrs7g8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712940434; c=relaxed/simple;
	bh=723TyUM84tFd/tNvuYS/SabsJNTtPpFWjxVSgSpvVNc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u4sGDo35K/dlLSeZyYKjIDyWU/NJ/m5VEjBpktMsHD4n5lQ+3BmJf7AlsYEV0gecXIcnFtAhHlAmLZyevuU7c39u4aF1kZTzrZq/SgpuSMDO1KeFUOMql4soVvNvenPWE18eYzwWG6tLGd1QvJXhXeVWXM54q4rSRX9zEJMS3Lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KehtsQ3f; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712940433; x=1744476433;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=723TyUM84tFd/tNvuYS/SabsJNTtPpFWjxVSgSpvVNc=;
  b=KehtsQ3fBxKd7ipGr8EizLilC5CjJgCaGj2u2n6Vnoy2xvZ2tKIWcxqy
   Bp7OLOCamV6ZvotpQGK54i6ZRCnAeTfUavXDoLrT+9TfwEKrlRYo7HVNm
   RY60pkbd2lH7rbbXMklOIZNFQd1O2jG8wfGaySnaUoARYiHnB1gMCAV4F
   /xmrp95J9Gtda0u4uZk0BGaTmr8NzP78DaKW0O0xARICBT6/4uH7pz8Vt
   cjy6U/NRO5s0/M7psF800NScRCJXBky8UhT5WbjWgnSq0qJGZ+/v6lnOC
   dTu2pQJaBRXOzjXNlBxupKBcJti0uqOITllDywJ4h/n37jtgPNSzq0T9G
   Q==;
X-CSE-ConnectionGUID: FTy8B/dRTIaiZE4zhGuppA==
X-CSE-MsgGUID: HhwdqmDnRUyK1DsH6WQbQQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11042"; a="25917094"
X-IronPort-AV: E=Sophos;i="6.07,196,1708416000"; 
   d="scan'208";a="25917094"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2024 09:47:12 -0700
X-CSE-ConnectionGUID: 7yd/4pDaQ4C+y4gF/pL9zA==
X-CSE-MsgGUID: eLGOAeRyQAaD7zcJ8ydvAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,196,1708416000"; 
   d="scan'208";a="25928693"
Received: from soc-cp83kr3.jf.intel.com (HELO [10.24.10.40]) ([10.24.10.40])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2024 09:47:12 -0700
Message-ID: <0d366f20-e332-45a9-8545-4513fdce6e21@intel.com>
Date: Fri, 12 Apr 2024 09:47:12 -0700
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
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <ZhCCub4ajIvpvrBk@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/5/2024 4:01 PM, Sean Christopherson wrote:
> On Fri, Mar 22, 2024, Zide Chen wrote:
>> Currently, the migration worker delays 1-10 us, assuming that one
>> KVM_RUN iteration only takes a few microseconds.  But if C-state exit
>> latencies are large enough, for example, hundreds or even thousands
>> of microseconds on server CPUs, it may happen that it's not able to
>> bring the target CPU out of C-state before the migration worker starts
>> to migrate it to the next CPU.
>>
>> If the system workload is light, most CPUs could be at a certain level
>> of C-state, and the vCPU thread may waste milliseconds before it can
>> actually migrate to a new CPU.
> 
> Well fudge.  That's definitely not on my bingo sheet.
> 
>> Thus, the tests may be inefficient in such systems, and in some cases
>> it may fail the migration/KVM_RUN ratio sanity check.
>>
>> Since we are not able to turn off the cpuidle sub-system in run time,
>> this patch creates an idle thread on every CPU to prevent them from
>> entering C-states.
> 
> First off, huge thanks for debugging this!  That must have been quite the task
> (no pun intended).
> 
> While spinning up threads on every CPU is a clever way to ensure they don't go
> into a deep sleep state, I'm not exactly excited about the idea of putting every
> reachable CPU into a busy loop.  And while this doesn't add _that_ much complexity,
> I'm not sure the benefit (preserving the assert for all systems) is worth it.  I
> also don't want to arbitrarily prevent idle task (as in, the kernel's idle task)
> interactions.  E.g. it's highly (highly) unlikely, but not impossible for there
> to be a bug that's unique to idle tasks, or C-states, or other edge case.
> 
> Are there any metrics/stats that can be (easily) checked to grant an exception
> to the sanity check?  That's a very hand-wavy question, as I'm not even sure what
> type of stat we'd want to look at.  Actual runtime of a task, maybe?
> 
> If that's not easy, what if we add an off-by-default command line option to skip
> the sanity check?  I was resistant to simply deleting the assert in the past, but
> that was mainly because I didn't want to delete it without understanding what was
> causing problems.  That would allow CI environments to opt-out as needed, while
> still keeping the sanity check alive for enough systems to make it useful.

Sorry for not replying earlier. I overlooked your email from my inbox. :)

Alternative to the busy loop, how about using the /dev/cpu_dma_latency
interface to disable c-states (I wish I had learned this before writing
the initial patch)? The good thing is it can do automatic cleanup when
it closes the fd.

The reason why I still think of disabling c-states is, even in the low
c-states exit latency setup, it can still increase the chances of
successful migration.

Otherwise, I can implement a command line option to skip the sanity
check, as I was not able to find out a metrics/stats that is easy and
reliable to indicate that the scheduler is not able to wake up the
target CPU before the task is scheduled to another CPU.

