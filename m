Return-Path: <linux-kselftest+bounces-33421-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CF78ABE32C
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 May 2025 20:50:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E438F4C36D4
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 May 2025 18:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9A7E26C3AD;
	Tue, 20 May 2025 18:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bwhZZdYD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A7DB248F75;
	Tue, 20 May 2025 18:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747767034; cv=none; b=b1KnUfPnWToR8z3/xo+bHuGXm+UKPITi/rIHXdYIgmMouojM45AsW0N5uCsAIEy9cAfz4ouZCe6gmHFnxmNtuZxXM8OLroIep9Q8Of9nvePWywGc7IBB0UkQMlsrmdm9ITT5k/AwYHhmDdPmQTgzrp1p21n6XEdwE655IjVG1i4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747767034; c=relaxed/simple;
	bh=4Xz+qUHB2YCNCR2CV7QYNfulgNvPj70zCp9v+dNVwig=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BV8TOVabC5hRixJw6XHN6OQyS0IiQnnjadXWbFM/nAPlbd0U5mgHBG0NsZh2BL140pyWoN7gFQNqC7NqMRKQx/AMP6Z9SbcyhiuRa1SpO8rtXjmlKw18zgF3LZ3iajCihlJat8BOcD8T+LrG/cpkCZ07wRXfPDrITwevw4NKaAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bwhZZdYD; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747767033; x=1779303033;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=4Xz+qUHB2YCNCR2CV7QYNfulgNvPj70zCp9v+dNVwig=;
  b=bwhZZdYDBnBQONXGGBqd/VT6CtxKDbiDXMGoBF/xOOUQRl6WvOVbSDUb
   oKU5Ap77UR1myCMBLuKo2gQNVwNNJZ4lQsSaL9xJEEbVDrKMFCsJR5u5Z
   2zWNGdq2WmKDDe1XyCcaBBNYVlrQjdNVe1wvVLCU/Vklmj4Rds83A7sN1
   67agHcTk3eiAGeRWXBgBwDDmPdxDbATTXmiEai8v0T+kX+6no8FLajPLl
   yD6ShZByd518WBgyQFAckYKBNXpSc1tlu9bpbvygaWsjGDpxcPyLYVG9n
   7R3vHaGVC20HDg7lJ2ot8pCAJXiYGBH9+ub3vrBJW1gtgiXiVHZHSJis4
   Q==;
X-CSE-ConnectionGUID: TjO85QopSf+tZLHcHj/WKA==
X-CSE-MsgGUID: 6BEDDGCeTuCbUJGoSeW7PA==
X-IronPort-AV: E=McAfee;i="6700,10204,11439"; a="59946398"
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="59946398"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2025 11:50:31 -0700
X-CSE-ConnectionGUID: XEW4GmabSG2u9P81egzzEw==
X-CSE-MsgGUID: 9Lv+wtraReqXT+hvIqH6Hw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="140708012"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2025 11:50:31 -0700
Received: from [10.246.136.52] (kliang2-mobl1.ccr.corp.intel.com [10.246.136.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id CAD4A20B5736;
	Tue, 20 May 2025 11:50:28 -0700 (PDT)
Message-ID: <800f99f6-a1bf-41f3-bc65-67fbe4c61368@linux.intel.com>
Date: Tue, 20 May 2025 14:50:27 -0400
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 04/38] perf: Add a EVENT_GUEST flag
To: Namhyung Kim <namhyung@kernel.org>
Cc: Mingwei Zhang <mizhang@google.com>, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
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
 <20250324173121.1275209-5-mizhang@google.com> <aCrWqhaID9-b_jmr@google.com>
 <09ed8cb5-707d-4b13-b230-cff4fab02b72@linux.intel.com>
 <aCzBDaHdELjiKHfc@google.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <aCzBDaHdELjiKHfc@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2025-05-20 1:51 p.m., Namhyung Kim wrote:
>>>> @@ -1089,6 +1094,7 @@ struct bpf_perf_event_data_kern {
>>>>   */
>>>>  struct perf_cgroup_info {
>>>>  	struct perf_time_ctx		time;
>>>> +	struct perf_time_ctx		timeguest;
>>>>  	int				active;
>>>>  };
>>>>  
>>>> diff --git a/kernel/events/core.c b/kernel/events/core.c
>>>> index e38c8b5e8086..7a2115b2c5c1 100644
>>>> --- a/kernel/events/core.c
>>>> +++ b/kernel/events/core.c
>>>> @@ -163,7 +163,8 @@ enum event_type_t {
>>>>  	/* see ctx_resched() for details */
>>>>  	EVENT_CPU	= 0x10,
>>>>  	EVENT_CGROUP	= 0x20,
>>>> -	EVENT_FLAGS	= EVENT_CGROUP,
>>>> +	EVENT_GUEST	= 0x40,
>>> It's not clear to me if this flag is for events to include guests or
>>> exclude them.  Can you please add a comment?
>>>
>> /*
>>  * There are guest events. The for_each_epc() iteration can
>>  * skip those PMUs which doesn't support guest events via the
>>  * MEDIATED_VPMU. It is also used to indicate the start/end of
>>  * guest events to calculate the guest running time.
>>  */
> Thanks for the explanation.  So it's for events with !exclude_guest on
> host 

The above "guest events" means that the events in a guest. The KVM
should only invokes the interface when a guest requires PMU.

For the host, for now, only the event with exclude_guest is supported.
The !exclude_guest event on host must be failed to be created if there
is a running VM.

and to do some operation only for host-only events on mediated
> vPMUs.

Yes.

Update the comments as below.

/*
 * There are events in a guest enabled with MEDIATED_VPMU.
 * The flag can be used in two places.
 * - The for_each_epc() iteration can skip those PMUs which
 *   doesn't support the events in a guest via the MEDIATED_VPMU.
 * - Indicate the start/end point of the events in a guest.
 *   The guest running time can be deducted for the
 *   host-only (exclude_guest) events.
 */

Thanks,
Kan

