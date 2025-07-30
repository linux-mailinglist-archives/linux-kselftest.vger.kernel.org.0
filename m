Return-Path: <linux-kselftest+bounces-38077-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DF7BB1578C
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Jul 2025 04:25:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4833543126
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Jul 2025 02:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B40CD17AE11;
	Wed, 30 Jul 2025 02:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RfAHvX8O"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8822C120;
	Wed, 30 Jul 2025 02:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753842335; cv=none; b=JOoTzJiUHKaf6Pw21CjMNw502KmBUOmjiio7ZbX1D8XdmSD6LITdHVXZ5ViErv7qVx6E4rOKmXFKpCftS7DeMEqiYHJj8sDJdcvM+EmmsjHJuQv+eHZCYWMPdkTYmK0XxEzAujs/XyEfL6scHiKpjorZzpo8Ae4NNoyal8I1T54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753842335; c=relaxed/simple;
	bh=T4saVRHW+Rd63tVciyPmElzG+gdHjLlabZNZEPM8ex8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qOalwWTyDKx/3pW0CCPa65TYeUoL4BckZx45tz3qrSJQruNC74tknhXbuio+e88jX0xbzsUUuNV7wEoVoThvlQZldBxInNe3WGGvdMiCx1YBiIPhyJSKrcmhk7pn++OmM+Fs/fCLn011V2q0MuzylH1INaBHLM91RwdK5fr0gug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RfAHvX8O; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753842335; x=1785378335;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=T4saVRHW+Rd63tVciyPmElzG+gdHjLlabZNZEPM8ex8=;
  b=RfAHvX8OKm0s/f7DbLmRXzDl11ujiKwp0O53yKmRCmF2rRbkE1DRC+9O
   QUZ7hiHUnnUM+5XHVGBgRY1Ytfh2oi7A9fGOB1jeHm0nubOWU6ympyHzJ
   JJ5OvdckcSTS9Gppwcp5qYDaVHDz/XuJDTEhxyB+m5ycwQahZA8cr//8o
   LF7wYXM/6nCKt02UbEXEXQqfgO6rpffhBmmTTXfNozG2FVmtTwk66rq3V
   ZlxplbOGxqjG9O/cI2zxiF7tcx5CKjRq9XgWDIcXRaO0+9DGsNhjVdSDe
   gx4wV3p1ObTmCyHSSdX45Im4jBsjKaDjCQFHfhfaZUwzeL/UCDSKLUn6k
   g==;
X-CSE-ConnectionGUID: VmZbeM+pQBWp7OwjYTXMHw==
X-CSE-MsgGUID: in0meqfvTyOzX3wCvgJE8Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11506"; a="56282155"
X-IronPort-AV: E=Sophos;i="6.16,350,1744095600"; 
   d="scan'208";a="56282155"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2025 19:25:34 -0700
X-CSE-ConnectionGUID: hHqyItXXSpm1ytaGDKTDDQ==
X-CSE-MsgGUID: 3erQg/wtQD2bbgelYdnCfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,350,1744095600"; 
   d="scan'208";a="162888983"
Received: from jiguojix-mobl.ccr.corp.intel.com (HELO [10.238.0.249]) ([10.238.0.249])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2025 19:25:28 -0700
Message-ID: <7de2b6ed-af39-4434-9ead-5b06ed4761c5@linux.intel.com>
Date: Wed, 30 Jul 2025 10:25:24 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 20/38] KVM: x86/pmu: Check if mediated vPMU can
 intercept rdpmc
To: Sean Christopherson <seanjc@google.com>
Cc: Sandipan Das <sandipan.das@amd.com>, Mingwei Zhang <mizhang@google.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
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
 Jim Mattson <jmattson@google.com>, Zide Chen <zide.chen@intel.com>,
 Eranian Stephane <eranian@google.com>, Shukla Manali
 <Manali.Shukla@amd.com>, Nikunj Dadhania <nikunj.dadhania@amd.com>
References: <20250324173121.1275209-1-mizhang@google.com>
 <20250324173121.1275209-21-mizhang@google.com>
 <a700ab4c-0e8d-499d-be71-f24c4a6439cf@amd.com> <aG6QeTXrd7Can8PK@google.com>
 <7dc97db7-5eea-4b65-aed3-4fc2846e13a6@linux.intel.com>
 <aIlpaL-yEU_0kgrD@google.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <aIlpaL-yEU_0kgrD@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 7/30/2025 8:38 AM, Sean Christopherson wrote:
> On Tue, Jul 29, 2025, Dapeng Mi wrote:
>> BTW, Sean, may I know your plan about the mediated vPMU v5 patch set? Thanks.
> I'll get it out this week (hopefully tomorrow).

Thumbs up! Thanks.


>

