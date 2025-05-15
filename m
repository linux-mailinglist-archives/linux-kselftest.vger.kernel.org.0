Return-Path: <linux-kselftest+bounces-33001-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E1F23AB7B01
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 03:35:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F46B4C1084
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 01:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E42A82698BC;
	Thu, 15 May 2025 01:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KDRlsqWZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4842622DA03;
	Thu, 15 May 2025 01:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747272940; cv=none; b=jfeGUUuPdWjZozjQ6HtHjFme+TFsBiA9rAHZ4G513PHJqG4SS8gwZk8B+YpU/G/q9GeYQ7iCpiQvpNrak8cfGSVKCc1iYsBv741Ei9fEuK1LZEqfs2vouJPHPUHEuhawJ0iIgu1V9Si/J+nG4K2yZ08AekE2SJJ4325SUvmrUdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747272940; c=relaxed/simple;
	bh=xCpDmmAYRWAbawXwCWvho2dS6smLcURJoOuFzWX+JY8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PjPvZPoEesoJ3g32dR95ek8fsNFco78AaQapZ1dPmkKw1yAuRtKh2soaxyl0cW8xjbAIFLxmzvpleXoHGSj4uyELnS2PVlW96K7Ri7OV59La449Apia1Tx0EpKwIwBprbLMQBXbFv7Sn1/artaGc8bh91nX2IfryfUv0yZp40VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KDRlsqWZ; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747272940; x=1778808940;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=xCpDmmAYRWAbawXwCWvho2dS6smLcURJoOuFzWX+JY8=;
  b=KDRlsqWZy5DDNjJ4RnYvYzwmqWQzRIijcFmGmiRg4wMh2eAELwsL3444
   3hlkl3XtDzKtr2O0eTWeFBljWkUyN+A9Z1PNuHtRxgrnkYwShpiQki8/q
   4Pii3GTZHwkWA7vnXEiYvSwE00AO8y0pHcKHjtJKzY/3ig4XEwHm5cZ0M
   OYwoFh862FzFAL9finihktWwtVU8Z1JqA2SQnDXuaqkwCXPOZWZjfvHYN
   awyShmMxA7bhWf7NHUXlCLtDrZAiExGX0E6doQQ20g+xX13A25jPPBCYR
   f3dg8XCDg9w6We5K0/S6maj/vNQSY/xxpCQM1vW67xXxUt3pIxl1AtBOT
   w==;
X-CSE-ConnectionGUID: lWnSAbCISoOmSBw3Fs1Q0g==
X-CSE-MsgGUID: WyExNyGqTJ2jWpVQ96CgMQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11433"; a="49176993"
X-IronPort-AV: E=Sophos;i="6.15,289,1739865600"; 
   d="scan'208";a="49176993"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2025 18:35:39 -0700
X-CSE-ConnectionGUID: GQMum0KHRMCqZLlsjNmR2w==
X-CSE-MsgGUID: qbe95BuSSYOtE0ShZLidCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,289,1739865600"; 
   d="scan'208";a="169295432"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.245.128]) ([10.124.245.128])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2025 18:35:32 -0700
Message-ID: <def6a396-b6c0-4b7a-8ccd-6d4a0a8f6aaa@linux.intel.com>
Date: Thu, 15 May 2025 09:35:30 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 04/38] perf: Add a EVENT_GUEST flag
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
 <20250324173121.1275209-5-mizhang@google.com> <aCUeh6KxgjLxd-MK@google.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <aCUeh6KxgjLxd-MK@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 5/15/2025 6:51 AM, Sean Christopherson wrote:
> On Mon, Mar 24, 2025, Mingwei Zhang wrote:
>> +{
>> +	if (event->attr.exclude_guest && __this_cpu_read(perf_in_guest)) {
> My vote is for s/perf_in_guest/guest_ctx_loaded, because "perf in guest" doesn't
> accurately describe just the mediated PMU case.  E.g. perf itself is running in
> KVM guests when using an emulated vPMU, or no vPMU at all.

Agree.


>
> And with a Kconfig to guard the mediated PMU, this check (and others) can be
> elided at compile time for architectures that don't support a mediated PMU (or
> if KVM is disabled).
>
>> +		/*
>> +		 * (now + times[total].offset) - (now + times[guest].offset) :=
>> +		 * times[total].offset - times[guest].offset
>> +		 */
>> +		return READ_ONCE(times[T_TOTAL].offset) - READ_ONCE(times[T_GUEST].offset);
>> +	}
>> +
>> +	return now + READ_ONCE(times[T_TOTAL].offset);
>> +}
>> +

