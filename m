Return-Path: <linux-kselftest+bounces-38829-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FE11B242F4
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Aug 2025 09:42:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EAAD11B62BC1
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Aug 2025 07:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0DDC2D3236;
	Wed, 13 Aug 2025 07:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LMVjau4J"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF9B1D5CD4;
	Wed, 13 Aug 2025 07:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755070929; cv=none; b=gce2k2D/Vo2GYgQqeslgT2eSZBk1VR/hzU2dy6FpRiwIid4D5EHf9NR8Qcj70BIR0/kHDSgMOIIz1vTxL9BB8gYCBBWIcU8f2V7HENfgI56RP/qXrvkh/Ug17bCeGsZKIve/Li4vFtNzvdqXphditUFAWAfgnfJ1BUnVseNVkHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755070929; c=relaxed/simple;
	bh=Pl2Iufjhn6TyKymAyspu0j4XsMb2q8F63c5yODSEHts=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mny7Y/uxvt5KJTbCI0KmvzFf6kmOTiyKJjAVdAjmZCnrBd4n4EBAqAcOpvqpJkLBjx46PwjkPNMCdu1UoVokOx8IorSabW4fyraWhoMnHinN7lLXDhAcdqruhM+9OjWPomO/WgKpZMb6H6Dn5BUrjTw5oJmzUAtzzbR/iTf1PFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LMVjau4J; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755070929; x=1786606929;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Pl2Iufjhn6TyKymAyspu0j4XsMb2q8F63c5yODSEHts=;
  b=LMVjau4JWU+Onep3zJBWtIJX/VtdVVTPItaUP3M5jr0Kgl+Od46xWkO6
   jiz9Uyn3vah1CWn7NZbeyiXSzsDBZvbMZF/EKR7vcPYJVLWxFtLnMJwSN
   0r9zBwo9Q6wCF2Mg5k8WUmMFxXKgIwFbPIbjCGagl0DGTtnpOWQ18JXdU
   nmfgRUOC+9YysGyIJ1OB49cx9h2UTgSH5AuiIr+zsac0kD4kTfVOozq39
   LnplmwUbIHhcZ2XEZOyLcNa5pigACb6aVs5EUQlTPZGvSWu0SjhCQOmBw
   f9yr6LmhUFIR3fTPjP3OIiAlJIXLjNB7WtWBaSnD/esKw/9mqwETDB2EV
   Q==;
X-CSE-ConnectionGUID: 5IP7jq/HTT2DcB0lA3ON5g==
X-CSE-MsgGUID: sEUKkwchQg2W7kN3OzlZ9w==
X-IronPort-AV: E=McAfee;i="6800,10657,11520"; a="57223914"
X-IronPort-AV: E=Sophos;i="6.17,285,1747724400"; 
   d="scan'208";a="57223914"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2025 00:42:07 -0700
X-CSE-ConnectionGUID: bREfrc+3RqGcKFxyAT7YNw==
X-CSE-MsgGUID: 3uCK9oXDQoedGW7Lgm1QHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,285,1747724400"; 
   d="scan'208";a="170854106"
Received: from unknown (HELO [10.238.11.25]) ([10.238.11.25])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2025 00:42:02 -0700
Message-ID: <2217214c-c4ec-43b5-9940-01139a0eba81@linux.intel.com>
Date: Wed, 13 Aug 2025 15:41:59 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 06/30] KVM: selftests: Add helper functions to create
 TDX VMs
To: Sean Christopherson <seanjc@google.com>, Sagi Shahar <sagis@google.com>
Cc: linux-kselftest@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 Shuah Khan <shuah@kernel.org>, Ackerley Tng <ackerleytng@google.com>,
 Ryan Afranji <afranji@google.com>, Andrew Jones <ajones@ventanamicro.com>,
 Isaku Yamahata <isaku.yamahata@intel.com>,
 Erdem Aktas <erdemaktas@google.com>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Roger Wang <runanwang@google.com>, Oliver Upton <oliver.upton@linux.dev>,
 "Pratik R. Sampat" <pratikrajesh.sampat@amd.com>,
 Reinette Chatre <reinette.chatre@intel.com>, Ira Weiny
 <ira.weiny@intel.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
References: <20250807201628.1185915-1-sagis@google.com>
 <20250807201628.1185915-7-sagis@google.com> <aJpO_zN3buvaQoAW@google.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <aJpO_zN3buvaQoAW@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/12/2025 4:13 AM, Sean Christopherson wrote:
[...]
>> +void __tdx_mask_cpuid_features(struct kvm_cpuid_entry2 *entry)
>> +{
>> +	/*
>> +	 * Only entries with sub-leaf zero need to be masked, but some of these
>> +	 * leaves have other sub-leaves defined. Bail on any non-zero sub-leaf,
>> +	 * so they don't get unintentionally modified.
>> +	 */
>> +	if (entry->index)
>> +		return;
>> +
>> +	switch (entry->function) {
>> +	case 0x1:
>> +		entry->ecx &= ~(CPUID_EXT_VMX | CPUID_EXT_SMX);
>> +		entry->edx &= ~CPUID_PSE36;
> vcpu_clear_cpuid_feature()
>
>> +		break;
>> +	case 0x7:
>> +		entry->ebx &= ~(CPUID_7_0_EBX_TSC_ADJUST | CPUID_7_0_EBX_SGX);
>> +		entry->ebx &= ~CPUID_7_0_EBX_INTEL_PT;
>> +		entry->ecx &= ~CPUID_7_0_ECX_SGX_LC;
>> +		break;
>> +	case 0x40000001:
>> +		entry->eax &= TDX_SUPPORTED_KVM_FEATURES;
>> +		break;
>> +	case 0x80000007:
>> +		entry->edx |= CPUID_APM_INVTSC;
> Quite obviously isn't "masking" anything".

Beside that, I guess this is handling fixed1 bit. But why only this bit is
treated specially?


