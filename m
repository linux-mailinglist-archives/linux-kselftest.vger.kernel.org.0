Return-Path: <linux-kselftest+bounces-33009-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BA5FFAB7BFD
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 05:04:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82BF71BA7B3D
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 03:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 614BC2920A5;
	Thu, 15 May 2025 03:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DAv8BWta"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F6E296713;
	Thu, 15 May 2025 03:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747278268; cv=none; b=INMfgKXFb3FiC4MYiO8JqIdNwenNw+Nw3JN4VwSEFb4TxphFe4tspPDE3DvmPzvrp7whbCte4J3rj00fxI0d4fi4AzhG208Qitce2LLsYgMXL5h3Zh+Hx4hZ2K30QCeOQWrbriCGs584Y7XHHtFUtDAke/RFoxuNTr+V0FGQsNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747278268; c=relaxed/simple;
	bh=8P2jZb2CWXydChMb3W1NmTVmRyeqjqJTPkqq5Cz6u4M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u46hnZ9/nRGnUz393rnp0ZzPLtxK9h3w/szsDix18A89wPNZ8OnkkugjmWEjgUjLzd+2c1cONf03Pot8/LkDJxBnzNZgcRPcj3cF9BthtA4CbFa2av9EBKLsBwRdnQRxW9NrUsc4bAm4oKB3thzOjezWVnD3mbt73MymOEfXANQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DAv8BWta; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747278267; x=1778814267;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=8P2jZb2CWXydChMb3W1NmTVmRyeqjqJTPkqq5Cz6u4M=;
  b=DAv8BWtaA+t1rqd+bOcZ2Q2/N1VZq/S74VH55aNHWUZvJKwVta6p0ioe
   a1zHBSJHnA9fIi+drn9+W7EuIVbJJa/z5P1qhFHcsuhplCrphlpGEVXE2
   ckd+7kgIuVkgHjigDOqr3nM2l5Wv2LgAfPRJGneFocF4Tqnyvfij1wZvO
   UWJ16KMX6WuoDKidzq2U2Px4q0sGmzr3PxesKb9KgAAmnRD9jb6a+SEgl
   791wA6HLbEmHxhfF87D6wrwsvhNiYtCLQUElsgIvRJnqIJ04CXsWuF0/x
   OiWl6pY23c7hXgTqrdkLoxDC80EDQ73hG+dByHMEa6ikedbcVuYS1+Cth
   g==;
X-CSE-ConnectionGUID: oOM+4TMIRWWv0p8t8b+Tiw==
X-CSE-MsgGUID: qivU6XoeQKafrbnXwSpmCw==
X-IronPort-AV: E=McAfee;i="6700,10204,11433"; a="49363122"
X-IronPort-AV: E=Sophos;i="6.15,290,1739865600"; 
   d="scan'208";a="49363122"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2025 20:04:26 -0700
X-CSE-ConnectionGUID: Xvyt4aJ6SJ2a+ZdqKs61IA==
X-CSE-MsgGUID: EQqKXdXYSWybfeMZ8HCHFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,290,1739865600"; 
   d="scan'208";a="142990091"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.245.128]) ([10.124.245.128])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2025 20:04:19 -0700
Message-ID: <e0974937-c4b8-4fbd-935d-335f7472a235@linux.intel.com>
Date: Thu, 15 May 2025 11:04:17 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 17/38] KVM: x86/pmu: Add perf_capabilities field in
 struct kvm_host_values{}
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
 <20250324173121.1275209-18-mizhang@google.com> <aCUxc3c6Tt6yVmqi@google.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <aCUxc3c6Tt6yVmqi@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 5/15/2025 8:12 AM, Sean Christopherson wrote:
> On Mon, Mar 24, 2025, Mingwei Zhang wrote:
>> From: Dapeng Mi <dapeng1.mi@linux.intel.com>
>>
>> Add perf_capabilities in kvm_host_values{} structure to record host perf
>> capabilities. KVM needs to know if host supports some PMU capabilities
>> and then decide if passthrough or intercept some PMU MSRs or instruction
>> like rdpmc, e.g. If host supports PERF_METRICES, but guest is configured
>> not to support it, then rdpmc instruction needs to be intercepted.
> This is wrong (spoiler alert).  This patch can be dropped.

Sean, why? I don't get your point here. Could you please give more
information? Thanks.



