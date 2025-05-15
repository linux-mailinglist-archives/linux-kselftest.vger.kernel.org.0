Return-Path: <linux-kselftest+bounces-33020-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB873AB7D04
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 07:35:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAA888C43CA
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 05:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B26EC2222AC;
	Thu, 15 May 2025 05:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jPlCQykV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F254B1E71;
	Thu, 15 May 2025 05:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747287298; cv=none; b=La9rJLhftcPcmkBdo8w52ZAR2nxyX6ms4hT2XsJ6sw5otFHBIZvVmrK+qdnSF0OkRK4QrQDOFu8O9DUbLxQBw2JDPb7MuTkp8ib1GFO7QspuHllpc10ZSO3vkAuBbOwbf84GHmZCw58RdkB2UykG/jTg93xAusImAZIbygDoRTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747287298; c=relaxed/simple;
	bh=M2vgp7I9jexpSjOmNO3GYj+dqtyAy1KjTL1WYYh/TrM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EgdYq5JdURUSaHbs+LztASCHi//EMjl50RZiHsdrJbAUt2/swjXvyPkCIR93GKejDyye5RjI8L9NBgJRx96SOM+FU2NKuwWI2VaMI/5h18lgc20UAfF7X6JtRoSnPnSAYgnw+L5d1ZQuAmdXUZyOpbei08FpYidjEpljdrir9ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jPlCQykV; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747287297; x=1778823297;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=M2vgp7I9jexpSjOmNO3GYj+dqtyAy1KjTL1WYYh/TrM=;
  b=jPlCQykV4rTz1llImClqqquAZ9cC061Fhe9D/yptDohnBEELgKTuKA2v
   1t+gXMDNa7BPVzI6exNUrjX1zV35fDTGIddXFwZYV7pk07kFEOvTydu/v
   wFWpgBHKGzhnB+cH9R9sFLU2JfihPoiOzQmSWxh67GXk4cUpjc2A3rG0i
   SOoMhTCR2cFZ3fx4+qLiRO6y3AQUUONYcs/mVYBotDkT7Ln244cDdnbz8
   hvFWMTPs9/vIH/Ooesd4Vb6VoIK2pnn2k2pJtfj9ChOLlidTnHZbt3uEq
   D9mAEknXgj4qDlKvSdw2BNARRFFpqlYBhSRSpYUo45XmKkpFhE+LtVllO
   A==;
X-CSE-ConnectionGUID: H06P1TaQQ6OgfyfO4Zfzag==
X-CSE-MsgGUID: OZtw9Q1YTDaTtyB1pmh+IA==
X-IronPort-AV: E=McAfee;i="6700,10204,11433"; a="49143175"
X-IronPort-AV: E=Sophos;i="6.15,290,1739865600"; 
   d="scan'208";a="49143175"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2025 22:34:56 -0700
X-CSE-ConnectionGUID: XAh8ozvOR2yqwm3TeljeRQ==
X-CSE-MsgGUID: jHSqDxIjSdSCc5T68V0NKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,290,1739865600"; 
   d="scan'208";a="138761559"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.245.128]) ([10.124.245.128])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2025 22:34:50 -0700
Message-ID: <1f35b6b4-58b6-4c7e-b788-3edbb2f807f3@linux.intel.com>
Date: Thu, 15 May 2025 13:34:48 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 26/38] KVM: x86/pmu: Introduce eventsel_hw to prepare
 for pmu event filtering
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
 <20250324173121.1275209-27-mizhang@google.com> <aCU4cHtvjwDordxW@google.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <aCU4cHtvjwDordxW@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 5/15/2025 8:42 AM, Sean Christopherson wrote:
> On Mon, Mar 24, 2025, Mingwei Zhang wrote:
>> -	pmu->fixed_ctr_ctrl = pmu->global_ctrl = pmu->global_status = 0;
>> +	pmu->fixed_ctr_ctrl = pmu->fixed_ctr_ctrl_hw = 0;
>> +	pmu->global_ctrl = pmu->global_status = 0;
> VMCS needs to be updated.

Yes. Thanks.



