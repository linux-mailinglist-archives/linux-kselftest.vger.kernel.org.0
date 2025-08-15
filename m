Return-Path: <linux-kselftest+bounces-39031-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F467B27638
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Aug 2025 04:43:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F532AA7A30
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Aug 2025 02:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68DCB28507F;
	Fri, 15 Aug 2025 02:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZfHpTwv4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F9E9270548;
	Fri, 15 Aug 2025 02:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755225481; cv=none; b=LF/R2bXz/SBjhU4/MHoOsDo2oiXwF0BCWjqy2fw7/QTjtAcZ+sb6NoF+k29jYa+Vk/iYberXINielkYpbUf7CvJiALqaOywU4qyeyfPK2nZiAwVuTPjpO5mCLosKZGMchUXWUxSFx5zGsgYASa0D1BN57XxcZzinD/V/aueIlGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755225481; c=relaxed/simple;
	bh=FfTNkVdLO1qS8IkMGnyPkwWSzl0av/r3zlncnz1w3uo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Op9S9/oT6/x8uxDFLoH+7YtMrCgD6NzV+1Xq8pWVvACAREUiJt/E+GpoHLZrg4+cX4RCNbiNyu1cAykK8PlDm3dBpCFROM9VPh0FwZFW4CyNIZblFeSFOSbaOgCAM1nK5OZWUOfPz/801Mp4vkrjkVE/fjvG5A2WSMsAgScoXGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZfHpTwv4; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755225479; x=1786761479;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=FfTNkVdLO1qS8IkMGnyPkwWSzl0av/r3zlncnz1w3uo=;
  b=ZfHpTwv4ob4MRpimb7pv7nizvHkdyOm+/92NXWyClV+49YwG1Hp6JRZm
   yFeiuAOQBn0X8LDcOZ2Li5Z4gnr9Cw2ffQ8QSs2Y4qqQUxyd3OPhWIumB
   LSPTCloc9xzzSwT4MzBebV33T4HWBisvdaLt8CD/NaHTIY81QOsFXfF3f
   fALz/DN1GzN53aJsDbWUF8tybxzvgo/4Yqw1ODKaWMDtPDOSqQSbNjKYB
   QdO6U5jmWvPCFvps0U6l2ft93ISjKmrIFzhu4w7MuOVncmceo8TIIZak3
   As1DYpVFKLoTMKnoLGCWJVpxgu+8UpM0k6IHx+quUHRZH4Z+KPOWvWGTL
   w==;
X-CSE-ConnectionGUID: iYvE9cbQRy+iWsUdgDfDwQ==
X-CSE-MsgGUID: vKhwuhHQR5+cALFwfx2vTg==
X-IronPort-AV: E=McAfee;i="6800,10657,11522"; a="60179374"
X-IronPort-AV: E=Sophos;i="6.17,290,1747724400"; 
   d="scan'208";a="60179374"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2025 19:37:59 -0700
X-CSE-ConnectionGUID: oE8u1vFbRdiHKSXqZH6kZQ==
X-CSE-MsgGUID: OS+LmJWIQoCU4f8NhnjwSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,290,1747724400"; 
   d="scan'208";a="166129711"
Received: from unknown (HELO [10.238.0.107]) ([10.238.0.107])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2025 19:37:54 -0700
Message-ID: <d69b2da1-efc4-47da-a74d-c18d0b50db74@linux.intel.com>
Date: Fri, 15 Aug 2025 10:37:51 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 23/30] KVM: selftests: Add functions to allow mapping
 as shared
To: Sagi Shahar <sagis@google.com>
Cc: linux-kselftest@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 Shuah Khan <shuah@kernel.org>, Sean Christopherson <seanjc@google.com>,
 Ackerley Tng <ackerleytng@google.com>, Ryan Afranji <afranji@google.com>,
 Andrew Jones <ajones@ventanamicro.com>,
 Isaku Yamahata <isaku.yamahata@intel.com>,
 Erdem Aktas <erdemaktas@google.com>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Roger Wang <runanwang@google.com>, Oliver Upton <oliver.upton@linux.dev>,
 "Pratik R. Sampat" <pratikrajesh.sampat@amd.com>,
 Reinette Chatre <reinette.chatre@intel.com>, Ira Weiny
 <ira.weiny@intel.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
References: <20250807201628.1185915-1-sagis@google.com>
 <20250807201628.1185915-24-sagis@google.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20250807201628.1185915-24-sagis@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/8/2025 4:16 AM, Sagi Shahar wrote:
> From: Ackerley Tng <ackerleytng@google.com>
>
> virt_map() enforces a private mapping for private memory. Introduce
> virt_map_shared() that creates a shared mapping for private as
> well as shared memory. This way, the TD does not have to remap its
> page tables at runtime.
>
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> Signed-off-by: Sagi Shahar <sagis@google.com>
> ---
>   .../testing/selftests/kvm/include/kvm_util.h  | 23 +++++++++++++
>   tools/testing/selftests/kvm/lib/kvm_util.c    | 34 +++++++++++++++++++
>   .../testing/selftests/kvm/lib/x86/processor.c | 15 ++++++--
>   3 files changed, 70 insertions(+), 2 deletions(-)
>
[...]
>   
> -void __virt_pg_map(struct kvm_vm *vm, uint64_t vaddr, uint64_t paddr, int level)
> +static void ___virt_pg_map(struct kvm_vm *vm, uint64_t vaddr, uint64_t paddr,
> +			   int level, bool protected)
>   {
>   	const uint64_t pg_size = PG_LEVEL_SIZE(level);
>   	uint64_t *pml4e, *pdpe, *pde;
> @@ -231,17 +232,27 @@ void __virt_pg_map(struct kvm_vm *vm, uint64_t vaddr, uint64_t paddr, int level)
>   	 * Neither SEV nor TDX supports shared page tables, so only the final
>   	 * leaf PTE needs manually set the C/S-bit.
>   	 */
> -	if (vm_is_gpa_protected(vm, paddr))

Since the original code has already create shared/private mapping based on the
paddr, why not just use virt_map() and shared GPA as paddr, then no need to
duplicate the code?

> +	if (protected)
>   		*pte |= vm->arch.c_bit;
>   	else
>   		*pte |= vm->arch.s_bit;
>   }
>   
> +void __virt_pg_map(struct kvm_vm *vm, uint64_t vaddr, uint64_t paddr, int level)
> +{
> +	___virt_pg_map(vm, vaddr, paddr, level, vm_is_gpa_protected(vm, paddr));
> +}
> +
>   void virt_arch_pg_map(struct kvm_vm *vm, uint64_t vaddr, uint64_t paddr)
>   {
>   	__virt_pg_map(vm, vaddr, paddr, PG_LEVEL_4K);
>   }
>   
> +void virt_arch_pg_map_shared(struct kvm_vm *vm, uint64_t vaddr, uint64_t paddr)
> +{
> +	___virt_pg_map(vm, vaddr, paddr, PG_LEVEL_4K, false);
> +}
> +
>   void virt_map_level(struct kvm_vm *vm, uint64_t vaddr, uint64_t paddr,
>   		    uint64_t nr_bytes, int level)
>   {


