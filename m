Return-Path: <linux-kselftest+bounces-18398-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2B18987512
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Sep 2024 16:06:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78D8D1F26FA1
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Sep 2024 14:06:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A64BE84E1C;
	Thu, 26 Sep 2024 14:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IbnP3/KR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B432D1C6B2;
	Thu, 26 Sep 2024 14:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727359570; cv=none; b=oc4fWNnyHybCTNmuk48GjFKjghwQfvzzSzQFjGSEKHW2/jgAWOvLYsPl90+K6a6yi31MsOn6hhBpruR1rMfT9lLzQvU98c1aq7d2lpNw7VEJrBm5msTBFT8wwpJObTgs/kqowsHyAAQbOxcpkABECsVPhpplaF9RxKYNIoN3AL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727359570; c=relaxed/simple;
	bh=0GQOr+LIbUulabpQaa69HJI0LcUX9XLKPsx3EwY06XI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=jpFRjf8mabx3OazR7mXncm0IyUqR6IaVXVOYjou73C1iCtAQbUyYs0r049IoqmVTj4VaTs4GUEm4FHe2GbO0WQ2VD3wVh5dMA6Ebqb/LE7HXnB/OB3+t0DGv6yLMbmvZMSy77KKM2wVAM68FWAduE4D64ErPrvbEnOpgt10Qj/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IbnP3/KR; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727359570; x=1758895570;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=0GQOr+LIbUulabpQaa69HJI0LcUX9XLKPsx3EwY06XI=;
  b=IbnP3/KRg7la3SCA6bAzTkJoQXztjKZ4PiUf0XchH8J1gXZ3L3LMIEV5
   +JC+IYfZxLWr3aCo9yjucBrRPaN9Q1flAgBHZh33sSOSsC3UnsiVkDFWc
   wDxazLhUTv2KRjsj+dFqsjB/BKlbwwXCC1boAPYxwFlkyLOb1U0WH/Hxy
   WUYx3/a+nv3//SttPafP2tT5+Q5ohkfHL6NeGXvxVzlsSxC4zyYY4QUC9
   6PE8CIRTHOFUHNZwdM34a1AXaRWujly172Oh3pWm+XxNOx0fcF4fquBht
   rQ+8maVzD+2T7crZUSbHZ+4m3teQHEnUXS5+lN/0NQ4Pczn7qECuhjD4v
   A==;
X-CSE-ConnectionGUID: CLE4TiOBSN6EdwDwGdboqg==
X-CSE-MsgGUID: vaH6swcMTYye0Fvqt4Ml8Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11207"; a="26593976"
X-IronPort-AV: E=Sophos;i="6.11,155,1725346800"; 
   d="scan'208";a="26593976"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2024 07:05:49 -0700
X-CSE-ConnectionGUID: W9ZCflfUTy+O/y2gjZS+QQ==
X-CSE-MsgGUID: UfRvfteSRPSAaor/1UiUOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,155,1725346800"; 
   d="scan'208";a="76939292"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.245.89.141])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2024 07:05:42 -0700
Message-ID: <b2671dab-9efa-4a56-bbe4-9b9140708120@intel.com>
Date: Thu, 26 Sep 2024 17:05:36 +0300
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] KVM: x86: Fix Intel PT Host/Guest mode when host
 tracing also
From: Adrian Hunter <adrian.hunter@intel.com>
To: Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Zijlstra <peterz@infradead.org>
Cc: Zhenyu Wang <zhenyuw@linux.intel.com>, kvm@vger.kernel.org,
 Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
 Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, H Peter Anvin <hpa@zytor.com>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 Kan Liang <kan.liang@linux.intel.com>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, mizhang@google.com
References: <20240906130026.10705-1-adrian.hunter@intel.com>
Content-Language: en-US
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20240906130026.10705-1-adrian.hunter@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/09/24 16:00, Adrian Hunter wrote:
> Hi
> 
> There is a long-standing problem whereby running Intel PT on host and guest
> in Host/Guest mode, causes VM-Entry failure.
> 
> The motivation for this patch set is to provide a fix for stable kernels
> prior to the advent of the "Mediated Passthrough vPMU" patch set:
> 
> 	https://lore.kernel.org/kvm/20240801045907.4010984-1-mizhang@google.com/
> 
> which would render a large part of the fix unnecessary but likely not be
> suitable for backport to stable due to its size and complexity.
> 
> Ideally, this patch set would be applied before "Mediated Passthrough vPMU"
> 
> Note that the fix does not conflict with "Mediated Passthrough vPMU", it
> is just that "Mediated Passthrough vPMU" will make the code to stop and
> restart Intel PT unnecessary.

Any comments?

> 
> 
> Adrian Hunter (3):
>       KVM: x86: Fix Intel PT IA32_RTIT_CTL MSR validation
>       KVM: x86: Fix Intel PT Host/Guest mode when host tracing also
>       KVM: selftests: Add guest Intel PT test
> 
>  arch/x86/events/intel/pt.c                         | 131 ++++++-
>  arch/x86/events/intel/pt.h                         |  10 +
>  arch/x86/include/asm/intel_pt.h                    |   4 +
>  arch/x86/kvm/vmx/vmx.c                             |  26 +-
>  arch/x86/kvm/vmx/vmx.h                             |   1 -
>  tools/testing/selftests/kvm/Makefile               |   1 +
>  .../selftests/kvm/include/x86_64/processor.h       |   1 +
>  tools/testing/selftests/kvm/x86_64/intel_pt.c      | 381 +++++++++++++++++++++
>  8 files changed, 532 insertions(+), 23 deletions(-)
>  create mode 100644 tools/testing/selftests/kvm/x86_64/intel_pt.c
> 
> base-commit: d45aab436cf06544abeeffc607110f559a3af3b4
> 
> 
> Regards
> Adrian


