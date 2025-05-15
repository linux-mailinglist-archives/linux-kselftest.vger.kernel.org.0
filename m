Return-Path: <linux-kselftest+bounces-33004-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FA3FAB7B1F
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 03:46:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1A931BA7795
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 01:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2665D286880;
	Thu, 15 May 2025 01:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O0LABGRf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AEDE286424;
	Thu, 15 May 2025 01:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747273559; cv=none; b=GQR5W5skFfwnyeeOusBtSp6aIJAKSge05rMKH/baY+lfoGxvRVKUruIfJOKoK0NZ9KHD99keHBXvmcIpkJonf9vrq1jxHa0sg7pdhT3T27Pa3023xfUaAmZfFvIKJ8sWwMT2W2+rVZST/h2vNed+ENBaHGSDNNix/24hz4zv5fE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747273559; c=relaxed/simple;
	bh=liCH3ST2rSNtb6kq11X873N09bmPyJxZKgearEG0g8M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uy43w3cf5gQoXvS2O0+oPKobxedlkw7AvafRtjLMJtgRzJ49VxiWr1hRws++iWvJ5wMsdiSqJ4+dllqmR1ZGlqKviG2Z+hNWNWH3OtxYru308mvGY4rLAkKd+o1xKJ9kVJIZ/EuLTzemR6sgyMbRRTTv16eIkn5QN8paQs3ePS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O0LABGRf; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747273558; x=1778809558;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=liCH3ST2rSNtb6kq11X873N09bmPyJxZKgearEG0g8M=;
  b=O0LABGRfhRA7Rns61UlzYRqds3qV8btfdZHsjCqU21Pd8nuQ1YxQ3Hru
   3TjJ1b2s/vROCMpe1LXbWslmLZo7jNbwTnibYi4xyBo9Wy73QsAjouZxO
   BDToqTUkh2IvMf6IKY0DLaUo+mZjxAA79hUYvoHWLrYviQTiwGiVD5CEA
   Ebdy545P7L1Ri5o9V2eyLE9/947tnXeOZDQPGf49OfJd8agLNkKjQ6CG4
   5YhthoBXCYs/iyDHGNoZpfmkDBuQu3bdrmp9EzAsgex9PMRSUWIb7m0O1
   WYh6oMDxJqBj4k8FmT32B/hxhKPe5OM84L8sKkm9cwzj0w/0RjdDMfofn
   g==;
X-CSE-ConnectionGUID: EB3ddolgTkelvoORcAm11g==
X-CSE-MsgGUID: TwP1XFQOTD6AysaVALzB/w==
X-IronPort-AV: E=McAfee;i="6700,10204,11433"; a="52998986"
X-IronPort-AV: E=Sophos;i="6.15,289,1739865600"; 
   d="scan'208";a="52998986"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2025 18:45:57 -0700
X-CSE-ConnectionGUID: eB/Db9DSS7GZY7p8XF0YIw==
X-CSE-MsgGUID: f9eHd5xKRDyloNKLzvnxAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,289,1739865600"; 
   d="scan'208";a="161500287"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.245.128]) ([10.124.245.128])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2025 18:45:50 -0700
Message-ID: <0355f4e5-e458-457e-ad74-d4dc26331671@linux.intel.com>
Date: Thu, 15 May 2025 09:45:48 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 09/38] perf: Add switch_guest_ctx() interface
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
 <20250324173121.1275209-10-mizhang@google.com> <aCUnq4M33yTj_t1F@google.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <aCUnq4M33yTj_t1F@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 5/15/2025 7:30 AM, Sean Christopherson wrote:
> On Mon, Mar 24, 2025, Mingwei Zhang wrote:
>> From: Kan Liang <kan.liang@linux.intel.com>
>>
>> When entering/exiting a guest, some contexts for a guest have to be
>> switched. For examples, there is a dedicated interrupt vector for
>> guests on Intel platforms.
>>
>> When PMI switch into a new guest vector, guest_lvtpc value need to be
>> reflected onto HW, e,g., guest clear PMI mask bit, the HW PMI mask
>> bit should be cleared also, then PMI can be generated continuously
>> for guest. So guest_lvtpc parameter is added into perf_guest_enter()
>> and switch_guest_ctx().
>>
>> Add a dedicated list to track all the pmus with the PASSTHROUGH cap, which
>> may require switching the guest context. It can avoid going through the
>> huge pmus list.
>>
>> Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
>> Signed-off-by: Mingwei Zhang <mizhang@google.com>
>> ---
>>  include/linux/perf_event.h | 17 +++++++++++--
>>  kernel/events/core.c       | 51 +++++++++++++++++++++++++++++++++++++-
>>  2 files changed, 65 insertions(+), 3 deletions(-)
>>
>> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
>> index 37187ee8e226..58c1cf6939bf 100644
>> --- a/include/linux/perf_event.h
>> +++ b/include/linux/perf_event.h
>> @@ -584,6 +584,11 @@ struct pmu {
>>  	 * Check period value for PERF_EVENT_IOC_PERIOD ioctl.
>>  	 */
>>  	int (*check_period)		(struct perf_event *event, u64 value); /* optional */
>> +
>> +	/*
>> +	 * Switch guest context when a guest enter/exit, e.g., interrupt vectors.
>> +	 */
>> +	void (*switch_guest_ctx)	(bool enter, void *data); /* optional */
> IMO, putting this in "struct pmu" is unnecessarily convoluted and complex, and a
> poor fit for what needs to be done.  The only usage of the hook is for the CPU to
> swap the LVTPC, and the @data payload communicates exactly that.  I.e. this has
> one user, and can't reasonably be extended to other users without some ugliness.
>
> And if by some miracle there's no CPU pmu in perf, KVM's mediated PMU still needs
> to swap to its PMI IRQ.  So rather than per-PMU hook along with a list and a
> spinlock, just make this an arch hook.  And if all of the mediated PMU code is
> guarded by a Kconfig, then perf doesn't even needs __weak stubs.

Sounds good for me.


>

