Return-Path: <linux-kselftest+bounces-33491-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E09E5AC01C6
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 May 2025 03:37:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93595166C63
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 May 2025 01:37:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6DA82A1BB;
	Thu, 22 May 2025 01:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j9qKkD0E"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A8C2F3E;
	Thu, 22 May 2025 01:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747877828; cv=none; b=F1oJsqntpgLhZbMBhTI8EW1zmI9UHET0gaqGnF7cBmA3mzn/G4J5sOmEOHxLGWHIkq9Jhe0YKf/OLKUz+6MvYbZHCuwIMx+RTEvDqi2I8InMcCayWAZOOFOov79gcIsuM13/DP464I3sTWVjVOrRiX9wZIzmoBlxC7ZRxeenmRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747877828; c=relaxed/simple;
	bh=il8bkfvjDGki95nEhszu8/+jTMJsPVEjXY92QWq+E2c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xd5Ct/jm1Z66hl+8zGLPGxPTyBYPHd6YxIQ0/1Yq29hGEHYEQxnDjB0qZMfn0bwajiekbUzyj45KRrExHFr+/7UkOcevvG5sweyY7jRHBAJvQrR2tbefMVYgU3xLTtfWcu8M9w3QFpcRbYbrw8IaW9ObWX9mQ94QmmSlyUSrsx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j9qKkD0E; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747877827; x=1779413827;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=il8bkfvjDGki95nEhszu8/+jTMJsPVEjXY92QWq+E2c=;
  b=j9qKkD0ER66xklUP046L6dHQfR4INVuZRsaVPNOjGu+UvQSt+yi+Suhw
   CvG9ptfw2rUt0BwpfgNKkgpqzqLGl8UpkeU6RlDfW3q34W3VmYPYOVNng
   GOAE4okyFj5LWCXI3p3brKMyD6iSgzy4G9ljOszOUvzBOkeS9t97qF/IT
   n+8RKCFVBhuKQDgTYPo+NYTbKwp7b4zGFOMSBztieZM15aGgd9YYpp4Jw
   /UEfWibICIQ/HNMD/lnOs284TKvHTbWanzieb64Vr6EzzPXu4ucy1TK+y
   dZYV/1hPy82z2TPPNkW8yRsk3LjxS1eYZ37j4/LjOhk5pyfoA3w2X4UCb
   w==;
X-CSE-ConnectionGUID: ZUTzSXpeTgaAA69GWi6Zrw==
X-CSE-MsgGUID: Y3/PJWctQpaIb1QxOh8Yzg==
X-IronPort-AV: E=McAfee;i="6700,10204,11440"; a="60932147"
X-IronPort-AV: E=Sophos;i="6.15,304,1739865600"; 
   d="scan'208";a="60932147"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2025 18:37:06 -0700
X-CSE-ConnectionGUID: hTO/8/4JRweAIlDGpCaZKw==
X-CSE-MsgGUID: OndiVDn1RQyRZW1/vkilgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,304,1739865600"; 
   d="scan'208";a="171331916"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.245.128]) ([10.124.245.128])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2025 18:36:58 -0700
Message-ID: <2e227e09-b8aa-4f94-abd3-8c31d46f7e3e@linux.intel.com>
Date: Thu, 22 May 2025 09:36:55 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 14/38] KVM: x86/pmu: Introduce enable_mediated_pmu
 global parameter
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
 <20250324173121.1275209-15-mizhang@google.com> <aCUwvXPKD0ANKFb7@google.com>
 <1d024d71-0b02-4481-a0d4-f1786313c1e7@linux.intel.com>
 <aC4ezRH8msD6yUhC@google.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <aC4ezRH8msD6yUhC@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 5/22/2025 2:43 AM, Sean Christopherson wrote:
> On Thu, May 15, 2025, Dapeng Mi wrote:
>> On 5/15/2025 8:09 AM, Sean Christopherson wrote:
>>> On Mon, Mar 24, 2025, Mingwei Zhang wrote:
>>>> +	return vcpu->kvm->arch.enable_pmu &&
>>> This is superfluous, pmu->version should never be non-zero without the PMU being
>>> enabled at the VM level.
>> Strictly speaking, "arch.enable_pmu" and pmu->version doesn't indicates
>> fully same thing.  "arch.enable_pmu" indicates whether PMU function is
>> enabled in KVM, but the "pmu->version" comes from user space configuration.
>> In theory user space could configure a "0"  PMU version just like
>> pmu_counters_test does. Currently I'm not sure if the check for
>> "pmu->version" can be removed, let me have a double check.
> Gah, sorry, my comment was vague and confusing.  What I was trying to say is that
> the vcpu->kvm->arch.enable_pmu check is superfluous and can be dropped.

Hmm, yes.  "pmu->version > 0" implies that arch.enable_pmu must be true
(kvm_pmu_refresh() checks if arch.enable_pmu is true before setting
pmu->verison).


>
>>>> +	kvm->arch.enable_pmu = enable_pmu && !enable_mediated_pmu;
>>> So I tried to run a QEMU with this and it failed, because QEMU expected the PMU
>>> to be enabled and tried to write to PMU MSRs.  I haven't dug through the QEMU
>>> code, but I assume that QEMU rightly expects that passing in PMU in CPUID when
>>> KVM_GET_SUPPORTED_CPUID says its supported will result in the VM having a PMU.
>> As long as the module parameter "enable_mediated_pmu" is enabled, qemu
>> needs below extra code to enable mediated vPMU, otherwise PMU is disabled
>> in KVM.
>>
>> https://lore.kernel.org/all/20250324123712.34096-1-dapeng1.mi@linux.intel.com/
>>
>>> I.e. by trying to get cute with backwards compatibility, I think we broke backwards
>>> compatiblity.  At this point, I'm leaning toward making the module param off-by-default,
>>> but otherwise not messing with the behavior of kvm->arch.enable_pmu.  Not sure if
>>> that has implications for KVM_PMU_CAP_DISABLE though.
>> I'm not sure if it's a kind of break for backwards compatibility.  As long
>> as "enable_mediated_pmu" is not enabled, the qemu doesn't need any changes,
>> the legacy vPMU can still be enabled by old qemu version. But if user want
>> to enable mediated vPMU, so they should use the new version qemu which has
>> the capability to enable mediated vPMU, it sounds reasonable for me.
> I agree it's reasonable to require a userspace update to take advantage of new
> features, what I don't like is what happens if userspace _hasn't_ been updated.
> I also don't love that forcing a userspace update in this case is more than a bit
> contrived.  It's very doable to let existing userspace utilize the mediated PMU,
> forcing KVM_CAP_PMU_CAPABILITY is essentially KVM punting a problem to userspace.
>
> And the complications with the mediated PMU don't really have anything to do with
> the VMM, they're more about all the other tasks and daemons running on the system,
> e.g. that might be using perf.
>
> Thinking more about this, the problem isn't so much that enabling mediated PMUs
> by default is undesirable, it's that giving userspace a binary choise doesn't
> provide enough flexibility.  E.g. for single-user QEMU-based use cases (including
> my use of QEMU), requiring a new QEMU is painful and annoying, and so having an
> on-by-default option would be nice.
>
> But for use cases that already utilize KVM_CAP_PMU_CAPABILITY, e.g. to explicitly
> disable PMUs for a subset of VMs, on-by-default is very undesirable, e.g. would
> require KVM to support KVM_PMU_CAP_DISABLE, and would generate unnecessary noise
> and contention in perf.
>
> So, what if we simply make enable_mediated_pmu a tri-state of sorts?
>
>   0   == disabled
>   > 0 == enabled for all VMs (no opt-in or opt-out supported)
>   < 0 == enabled, but off by default (requires opt-in)
>
> Then use cases like my personal usage of QEMU can run with enable_mediated_pmu=1,
> while use cases like Google Cloud can run with enable_mediated_pmu=-1, and everyone
> is happy (hopefully), without too much added complexity in KVM.

Hmm, I agree. a tri-state "enable_mediated_pmu" is much flexible, but we
need to a good document to describe it, maybe like this.

enable_mediated_pmu

0       ==  globally disabled for all VMs

> 0    ==  globally enabled for all VMs

< 0    ==  VM-scoped disabled, need VMM explicitly enables by
KVM_CAP_PMU_CAPABILITY ioctl.




