Return-Path: <linux-kselftest+bounces-32548-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4EF6AAD265
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 May 2025 02:46:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCF203B05E7
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 May 2025 00:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2C7820330;
	Wed,  7 May 2025 00:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fcQnjx4K"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1310ABA34;
	Wed,  7 May 2025 00:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746578794; cv=none; b=UJrWIdWiMwc53Fzv9KbhA2lVKoeXEgU96jQyM/uclhus8K/5yfOUfb6ys50iZaJuEes8/cpuY1o9Ov4Zh+niIwyDr2rVGe8Nm3DyncXpaqWSIyYtSOzi886bmXxp7IhuKYCKJ33uk/z7rh6l/bKnVJgPwcTy7t6U+Nw4HPoEAzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746578794; c=relaxed/simple;
	bh=+A5NJ5+jxCm9l0AgQ7gorxymnsY8EJzbQp8wownW+dc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sceNDLIMM5LK+Wn5iWDReXUrO3T8//qbJKNqM2tQAi+erPTXjAjY2TjmfYEDg6I+VTyIgFlJ4kOkK1LIeLpmoD+HiVaEXSt38pb4Ww/gGoBaLkTBhgC/qmxZbXDMXEI/KXAJdcUsIQ7d2oFybKZqRzRCZzT7zfw3JBohs09epbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fcQnjx4K; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746578793; x=1778114793;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=+A5NJ5+jxCm9l0AgQ7gorxymnsY8EJzbQp8wownW+dc=;
  b=fcQnjx4KEQNvH4+v5rvCkCODezS14upNzyGV4QEqx5tVCusqkJj6Z3ke
   pI2P8tQuegBBp/j9T6VyzeaXQAeqPY+puY6pD3QQHfuvf16ZV2fQlA1Ye
   w+Yy6yFJYw37eC+AEIhJCC1IZE6yM14FP2aJnlRi2Ik5kBaKq2hwALVaS
   df8qFEewHlXKv0aJPqt5kEQ7ASvvEOgB7Qg/mGzvrI3BE9OPCOea0hrwo
   W/XaRTdCWzwabRf0qmRMx1T6hKm9S0n45bUnv2yo6JmUEPEmfhSJO+WCV
   O64uz1PbTbOgGSB16bWXPa7nQSBXWSSRLOj2t2sr3+XSY+K8ZlORGc03q
   A==;
X-CSE-ConnectionGUID: xwwEusAMRFOa8zInuDacdw==
X-CSE-MsgGUID: 0nnmH39fQSy03iGF2yNfyg==
X-IronPort-AV: E=McAfee;i="6700,10204,11425"; a="51932183"
X-IronPort-AV: E=Sophos;i="6.15,267,1739865600"; 
   d="scan'208";a="51932183"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2025 17:46:33 -0700
X-CSE-ConnectionGUID: E4wGvNi4Tl+mgOx7GOxyag==
X-CSE-MsgGUID: mTwCQj6CSNiurqeHblQLPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,267,1739865600"; 
   d="scan'208";a="136305613"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.245.128]) ([10.124.245.128])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2025 17:46:26 -0700
Message-ID: <faacb266-4b2a-4b96-b324-9b6aa3379830@linux.intel.com>
Date: Wed, 7 May 2025 08:46:22 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/38] Mediated vPMU 4.0 for x86
To: Sean Christopherson <seanjc@google.com>
Cc: Mingwei Zhang <mizhang@google.com>, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
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
 <827cc30b-35e0-4a63-a993-484d4616091d@linux.intel.com>
 <aBpmycjTn4Xo4Hc4@google.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <aBpmycjTn4Xo4Hc4@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 5/7/2025 3:45 AM, Sean Christopherson wrote:
> On Tue, May 06, 2025, Dapeng Mi wrote:
>> Hi Sean,
>>
>> Not sure if you have bandwidth to review this mediated vPMU v4 patchset?
> I'm getting there.  I wanted to get through all the stuff I thought would likely
> be ready for 6.16 as-is before moving onto the larger series.

Got it. Thanks.


>

