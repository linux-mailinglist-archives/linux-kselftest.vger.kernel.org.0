Return-Path: <linux-kselftest+bounces-19045-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE25C9909CE
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Oct 2024 19:00:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86B3A282C9E
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Oct 2024 17:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDD8C1D9A53;
	Fri,  4 Oct 2024 17:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E4/e1zkf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1526B1C3040;
	Fri,  4 Oct 2024 17:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728061206; cv=none; b=U6aOPUJnLpFufbLwGo0Fq7o8mN01RbIsyXc/GxW+5GR4O2WJTmnccuD3PUETy9w/EXFVP5IenN0R+WEA//yDZbnEvxZoExsbd6ZDRIMDEiIGqGXcEr7cosVmB1wcWosdfalYix8VHD2oXk90ay6gk1eir4Q7G3vZ39v/WGwTyH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728061206; c=relaxed/simple;
	bh=kGMr9XJwmR/6XMbdyM0sz2yO0/poueWM7SpCkZ9rr1E=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=sU295U3c4fX8bO7koIimxwnnObFKFySmLee/6IfNjfFdDOWRN9iMp/+CHeJbynKmetbaF4eyus7q8C8uM351BZzmNY/iJX6iqvhXPTxFtNj53AOdPXRxg1WwcuAWxY1LSlUn7I0ywAg/d/cwCOkN7rXszE8X0mf+RpP4n9LDHv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E4/e1zkf; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728061205; x=1759597205;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=kGMr9XJwmR/6XMbdyM0sz2yO0/poueWM7SpCkZ9rr1E=;
  b=E4/e1zkfcV8/YbYYullDUZHy95C9+/VUkTTxnikeOJuOHF8Vg2B/ynM/
   RZ3TeaM8IUL6E2BZLflJVR/Z1/W/crSLrD1ruTsLAMXXwNTfl5o7c2l44
   gR/1NbeK7kgNfMlMYxDGgqXYBY1eO9ugoCIvHfzqtP3e+uy0e9sB9wDck
   6gsF+ZMq3/vXyQhopeLT/BMsIC+RizWXDmJRsTCq6AG7q52TbR5eIvjJ4
   1aUMySWz3c4DXkHtXspg0rkHxZfQau39lX09HFvDzrcJXOq8lidFRVwZY
   NrhTG4ivVshk7Ky4/vYuZyl2CCi3rh7z8rMbmCbGTBYp91e3013RmhFgC
   w==;
X-CSE-ConnectionGUID: Y9tpcUhzTDCcf1qReMs4ZA==
X-CSE-MsgGUID: wnRrIcKwTnudsTfabq89mQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11215"; a="37895482"
X-IronPort-AV: E=Sophos;i="6.11,178,1725346800"; 
   d="scan'208";a="37895482"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2024 10:00:04 -0700
X-CSE-ConnectionGUID: JcEuj40hRqKVOfr6zgygJg==
X-CSE-MsgGUID: KKBvCfawQvirj++5TeV3Xg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,178,1725346800"; 
   d="scan'208";a="105614661"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.245.166.93])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2024 09:59:56 -0700
Message-ID: <ddf6960c-a48a-48df-b09d-f70797042413@intel.com>
Date: Fri, 4 Oct 2024 19:59:50 +0300
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
 <b2671dab-9efa-4a56-bbe4-9b9140708120@intel.com>
Content-Language: en-US
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <b2671dab-9efa-4a56-bbe4-9b9140708120@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26/09/24 17:05, Adrian Hunter wrote:
> On 6/09/24 16:00, Adrian Hunter wrote:
>> Hi
>>
>> There is a long-standing problem whereby running Intel PT on host and guest
>> in Host/Guest mode, causes VM-Entry failure.
>>
>> The motivation for this patch set is to provide a fix for stable kernels
>> prior to the advent of the "Mediated Passthrough vPMU" patch set:
>>
>> 	https://lore.kernel.org/kvm/20240801045907.4010984-1-mizhang@google.com/
>>
>> which would render a large part of the fix unnecessary but likely not be
>> suitable for backport to stable due to its size and complexity.
>>
>> Ideally, this patch set would be applied before "Mediated Passthrough vPMU"
>>
>> Note that the fix does not conflict with "Mediated Passthrough vPMU", it
>> is just that "Mediated Passthrough vPMU" will make the code to stop and
>> restart Intel PT unnecessary.
> 
> Any comments?

Any comments?

> 
>>
>>
>> Adrian Hunter (3):
>>       KVM: x86: Fix Intel PT IA32_RTIT_CTL MSR validation
>>       KVM: x86: Fix Intel PT Host/Guest mode when host tracing also
>>       KVM: selftests: Add guest Intel PT test
>>
>>  arch/x86/events/intel/pt.c                         | 131 ++++++-
>>  arch/x86/events/intel/pt.h                         |  10 +
>>  arch/x86/include/asm/intel_pt.h                    |   4 +
>>  arch/x86/kvm/vmx/vmx.c                             |  26 +-
>>  arch/x86/kvm/vmx/vmx.h                             |   1 -
>>  tools/testing/selftests/kvm/Makefile               |   1 +
>>  .../selftests/kvm/include/x86_64/processor.h       |   1 +
>>  tools/testing/selftests/kvm/x86_64/intel_pt.c      | 381 +++++++++++++++++++++
>>  8 files changed, 532 insertions(+), 23 deletions(-)
>>  create mode 100644 tools/testing/selftests/kvm/x86_64/intel_pt.c
>>
>> base-commit: d45aab436cf06544abeeffc607110f559a3af3b4
>>
>>
>> Regards
>> Adrian
> 


