Return-Path: <linux-kselftest+bounces-38038-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 457B4B146E1
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Jul 2025 05:29:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C49D541768
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Jul 2025 03:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A693921FF4B;
	Tue, 29 Jul 2025 03:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HKki5wkZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B0502045B6;
	Tue, 29 Jul 2025 03:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753759765; cv=none; b=uxtMbjDzUxFi2S729uHfxCDxS5UouiG3gpfn+X6UPqNi7qjxOgV1ycxX4I/GLrCK00Clfxclg8dZ89NOw2NSmwb7xK35yVpCcHcbsZpH2XEjIdIvat2WL40A+al0RAgVJvfHA0DlBHLvY7FZhyCt538aXzo2Pxml7EQc2KQGkkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753759765; c=relaxed/simple;
	bh=ANZkbK817MFJd1tmvTvtQznG5aURBb6fkvguPdy8/Rk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FHqfvUIrE98eRPAoCS18VhhxiuE7YPCTnlrFKxnZTNoOCDrjSpnrpFKZORm7o0sso0lcJX1VohJyV70lIyqn4u/RQ82uxE8tLdr9/0qiHZ1T6JAJ8pcv1n2SgB9azeYJrOBix0UPkWknDlMLEVObbRXe0D+GFRmPIh6rJM3u3NI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HKki5wkZ; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753759764; x=1785295764;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ANZkbK817MFJd1tmvTvtQznG5aURBb6fkvguPdy8/Rk=;
  b=HKki5wkZU9EjhOGwr9/HgpdZ9L8MEyWhhIWXGhqj/0uDR+VjMTogN45k
   KV2Wsqz0YHM8zAkNBzvqE2xvysg8PZItlaTfCGgJdl9+R/f/IErv6a7AB
   tE3Aeq3vKYTbE2YYY/UY4nTDuuHbrDM3IyOsyb4BO2ZWKqaXVQXqsKhfN
   4lbKtRNvD4HnGJABsvHheUgaQqfUUwddgUdjwvu+B3UPDoRkehuzFj7IM
   mr/8F5dMfWkwuQFxzDDh0YAp7cr9wLxoFfLKExp1qGRpE2UvvH4sGJzu7
   mz3/t8rw/tXflDcak56in5UA+kB7SPYLzQcbzvweDx1i7OAjYUvR4ByQT
   Q==;
X-CSE-ConnectionGUID: k7lGRyVnShKiR6+RJvZB3Q==
X-CSE-MsgGUID: A6i+33SaSriJtrQH7aVXVQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11505"; a="66291914"
X-IronPort-AV: E=Sophos;i="6.16,348,1744095600"; 
   d="scan'208";a="66291914"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2025 20:29:23 -0700
X-CSE-ConnectionGUID: dmmLKCIFQpqYNDG5hHfwEw==
X-CSE-MsgGUID: 2RK1eSy1Q3a6Klp6VpNCRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,348,1744095600"; 
   d="scan'208";a="193570153"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.240.106]) ([10.124.240.106])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2025 20:29:17 -0700
Message-ID: <7dc97db7-5eea-4b65-aed3-4fc2846e13a6@linux.intel.com>
Date: Tue, 29 Jul 2025 11:29:14 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 20/38] KVM: x86/pmu: Check if mediated vPMU can
 intercept rdpmc
To: Sean Christopherson <seanjc@google.com>,
 Sandipan Das <sandipan.das@amd.com>
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
 Jim Mattson <jmattson@google.com>, Zide Chen <zide.chen@intel.com>,
 Eranian Stephane <eranian@google.com>, Shukla Manali
 <Manali.Shukla@amd.com>, Nikunj Dadhania <nikunj.dadhania@amd.com>
References: <20250324173121.1275209-1-mizhang@google.com>
 <20250324173121.1275209-21-mizhang@google.com>
 <a700ab4c-0e8d-499d-be71-f24c4a6439cf@amd.com> <aG6QeTXrd7Can8PK@google.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <aG6QeTXrd7Can8PK@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 7/9/2025 11:53 PM, Sean Christopherson wrote:
> On Mon, May 26, 2025, Sandipan Das wrote:
>>> @@ -212,6 +212,18 @@ static void amd_pmu_refresh(struct kvm_vcpu *vcpu)
>>>  	bitmap_set(pmu->all_valid_pmc_idx, 0, pmu->nr_arch_gp_counters);
>>>  }
>>>  
>>> +static void amd_pmu_refresh(struct kvm_vcpu *vcpu)
>>> +{
>>> +	struct vcpu_svm *svm = to_svm(vcpu);
>>> +
>>> +	__amd_pmu_refresh(vcpu);
>>> +
>>> +	if (kvm_rdpmc_in_guest(vcpu))
>>> +		svm_clr_intercept(svm, INTERCEPT_RDPMC);
>>> +	else
>>> +		svm_set_intercept(svm, INTERCEPT_RDPMC);
>>> +}
>>> +
>> After putting kprobes on kvm_pmu_rdpmc(), I noticed that RDPMC instructions were
>> getting intercepted for the secondary vCPUs. This happens because when secondary
>> vCPUs come up, kvm_vcpu_reset() gets called after guest CPUID has been updated.
>> While RDPMC interception is initially disabled in the kvm_pmu_refresh() path, it
>> gets re-enabled in the kvm_vcpu_reset() path as svm_vcpu_reset() calls init_vmcb().
>> We should consider adding the following change to avoid that.
> Revisiting this code after the MSR interception rework, I think we should go for
> a more complete, big-hammer solution.  Rather than manipulate intercepts during
> kvm_pmu_refresh(), do the updates as part of the "common" recalc intercepts flow.
> And then to trigger recalc on PERF_CAPABILITIES writes, turn KVM_REQ_MSR_FILTER_CHANGED
> into a generic KVM_REQ_RECALC_INTERCEPTS.
>
> That way there's one path for calculating dynamic intercepts, which should make it
> much more difficult for us to screw up things like reacting to MSR filter changes.
> And providing a single path avoids needing to have a series of back-and-forth calls
> between common x86 code, PMU code, and vendor code.

Sounds good to me.

BTW, Sean, may I know your plan about the mediated vPMU v5 patch set? Thanks.



