Return-Path: <linux-kselftest+bounces-33008-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C5C1AB7BDE
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 05:00:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB0254A7138
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 03:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B87C27A476;
	Thu, 15 May 2025 03:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gfxKF8eE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A539C25B1CE;
	Thu, 15 May 2025 03:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747278037; cv=none; b=CKw+zJVBI64svjbf6WI/Ti7TqWihOYsNbxFjSINns3H7Z0SSN7TrcnoJbvFGzosm2bjlklgR9kxs8hugdyuEsI/FU/icVWnS96ZzuIyhj3p6gvNfDzilqhXVBpe6ZOuP8bbW361adge6QHKHO6GFlIH/J1lJEaZvNr79hnq9DLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747278037; c=relaxed/simple;
	bh=MX4LNaKBrDVEZrUWYZWvWYqe2KgUgHh6Z3+4zis1hDA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dqaSuNnIe2VYgHRuFfJS9yA31JuMWpiceGlCusrR5x7I5+KipU8goseGu+13DtnZDwWvwZvM9OAl5KyzBcpdL4ZkNp6ho3GPzSeWOHzYR8f5EhoiwfZ5KT6Z4Msk7bzuunM1pSVNzWNV5eaFni7txrySazwReIEUinjndSnQ0h4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gfxKF8eE; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747278036; x=1778814036;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=MX4LNaKBrDVEZrUWYZWvWYqe2KgUgHh6Z3+4zis1hDA=;
  b=gfxKF8eESD20QffFxtoU9TxNHBdJUIVA0tD/dkhNkeUhSvlZTUiS5X1k
   D15g3pqXoeQbYAg7JkVZwGnmLSamUEdBDRoxYdvlPRg62G79BAFcU19kV
   q1pwuESuA3rElO6uRN7WaqAIgj5idHTo5eAsBIKtZbwDFdv5989d6O8u9
   xz0CJJ3KypoWrU2RaCuMVUE/rFfQCv6Egh2oTQk5868IhYBGT1GXow52m
   Qhig7DuzA+DqBfkj5b2PdSwqCNBpw4ZukHsw+MbODqrk+RuQ0aXWPe/gW
   RbCSnxN5YCmbTPIzSpH2AdFbBVAM42W8MvYYbsLTCfOGqCPmjlUTHgtLK
   Q==;
X-CSE-ConnectionGUID: nDFmRNNBRoyUdvOEuoKnYg==
X-CSE-MsgGUID: VURWxAVOQ/+f4XbK5ktUqw==
X-IronPort-AV: E=McAfee;i="6700,10204,11433"; a="74599230"
X-IronPort-AV: E=Sophos;i="6.15,289,1739865600"; 
   d="scan'208";a="74599230"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2025 20:00:31 -0700
X-CSE-ConnectionGUID: 7HvFv9suQwiX+fgYU+tW8A==
X-CSE-MsgGUID: X03XOVC2TAK4/mNQzvjD3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,289,1739865600"; 
   d="scan'208";a="138753225"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.245.128]) ([10.124.245.128])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2025 20:00:19 -0700
Message-ID: <d54e8654-d761-47aa-b9f7-10d8c44a07ec@linux.intel.com>
Date: Thu, 15 May 2025 11:00:16 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 15/38] KVM: x86/pmu: Check PMU cpuid configuration from
 user space
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
 <20250324173121.1275209-16-mizhang@google.com> <aCUxWDaNKezTzJTV@google.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <aCUxWDaNKezTzJTV@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 5/15/2025 8:12 AM, Sean Christopherson wrote:
> On Mon, Mar 24, 2025, Mingwei Zhang wrote:
>> From: Dapeng Mi <dapeng1.mi@linux.intel.com>
>>
>> Check user space's PMU cpuid configuration and filter the invalid
>> configuration.
>>
>> Either legacy perf-based vPMU or mediated vPMU needs kernel to support
>> local APIC, otherwise PMI has no way to be injected into guest. If
>> kernel doesn't support local APIC, reject user space to enable PMU
>> cpuid.
>>
>> User space configured PMU version must be no larger than KVM supported
>> maximum pmu version for mediated vPMU, otherwise guest may manipulate
>> some unsupported or unallowed PMU MSRs, this is dangerous and harmful.
>>
>> If the pmu version is larger than 1 but smaller than 5, CPUID.AH.ECX
>> must be 0 as well which is required by SDM.
>>
>> Suggested-by: Zide Chen <zide.chen@intel.com>
>> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
>> Signed-off-by: Mingwei Zhang <mizhang@google.com>
>> ---
>>  arch/x86/kvm/cpuid.c | 15 +++++++++++++++
>>  arch/x86/kvm/pmu.c   |  7 +++++--
>>  arch/x86/kvm/pmu.h   |  1 +
>>  3 files changed, 21 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
>> index 8eb3a88707f2..f849ced9deba 100644
>> --- a/arch/x86/kvm/cpuid.c
>> +++ b/arch/x86/kvm/cpuid.c
>> @@ -179,6 +179,21 @@ static int kvm_check_cpuid(struct kvm_vcpu *vcpu)
>>  			return -EINVAL;
>>  	}
>>  
>> +	best = kvm_find_cpuid_entry(vcpu, 0xa);
>> +	if (vcpu->kvm->arch.enable_pmu && best) {
>> +		union cpuid10_eax eax;
>> +
>> +		eax.full = best->eax;
>> +		if (enable_mediated_pmu &&
>> +		    eax.split.version_id > kvm_pmu_cap.version)
>> +			return -EINVAL;
>> +		if (eax.split.version_id > 0 && !vcpu_pmu_can_enable(vcpu))
>> +			return -EINVAL;
>> +		if (eax.split.version_id > 1 && eax.split.version_id < 5 &&
>> +		    best->ecx != 0)
>> +			return -EINVAL;
> NAK, unless there is a really, *really* strong need for this.  I do not want to
> get in the business of vetting the vCPU model presented to the guest.  If KVM
> needs to constrain things for its own safety, then by all means, but AFAICT these
> are nothing more than sanity checks on userspace.

Ok.


>
>> +	}
>> +
>>  	/*
>>  	 * Exposing dynamic xfeatures to the guest requires additional
>>  	 * enabling in the FPU, e.g. to expand the guest XSAVE state size.
>> diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
>> index 4f455afe4009..92c742ead663 100644
>> --- a/arch/x86/kvm/pmu.c
>> +++ b/arch/x86/kvm/pmu.c
>> @@ -743,6 +743,10 @@ static void kvm_pmu_reset(struct kvm_vcpu *vcpu)
>>  	kvm_pmu_call(reset)(vcpu);
>>  }
>>  
>> +inline bool vcpu_pmu_can_enable(struct kvm_vcpu *vcpu)
>> +{
>> +	return vcpu->kvm->arch.enable_pmu && lapic_in_kernel(vcpu);
> Again, the APIC check belongs in the VM enablement path, not here.  Hmm, that
> may require more thought with respect to enabling the PMU by default.

Sure.



