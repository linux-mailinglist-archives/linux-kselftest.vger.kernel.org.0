Return-Path: <linux-kselftest+bounces-38927-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 058B4B2599A
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Aug 2025 04:49:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 980236240F0
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Aug 2025 02:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 873771F5838;
	Thu, 14 Aug 2025 02:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YaOz01j6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B24F2FF64F;
	Thu, 14 Aug 2025 02:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755139755; cv=none; b=u6sPlL4DtHYBbz0ZJ27/2esaaISd28RfEtg0sX+ZIVutO+1acg9Wbi830pCI3CX0bcKJVi9PK/oXquCugv9F0A78LGCTqUhOwyiL3cWUSPIi5eTVQ0mBSjNratw048mgLCQfvZnLAcf1sFlGkt7kLCgs7MQ/duGIB3FaIBAFUb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755139755; c=relaxed/simple;
	bh=NpHssSYhn2CrKHZjneLbrsKgTdd7DLyCmHtf4o7Q5rQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LIR3xfAGhtiGT70TyAJeNwRra1mqoxJPWDsk4YHeZM5sKwZkQyJBmvU5/Pxn9LlxCZYC5ja7mxxTBTbaCZyMz3OMkK3yqYVFb2CUvX52VB4zjoNm1OK6Dir1JAtmzNTo5BDmJBlPROQIPk3YYuDt3CnT23EZp/as0+fW4nLFRCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YaOz01j6; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755139754; x=1786675754;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=NpHssSYhn2CrKHZjneLbrsKgTdd7DLyCmHtf4o7Q5rQ=;
  b=YaOz01j6kGHY6x2+z/eQSu+fg12T1L2PissdDkuIAR9TnXWTZMhv8UT5
   kWXkBvbEpesNoQCQVugb7flFrARMH/Ndqk2P0Tw8TCqSni9vg2AuYspZA
   HdTD0Q/UrEjinVrruslV0KLrUWErx2FsWV4yW40ceWdTDVjD95Iv7vCvp
   gKT6pu4tCTOb3vchl5U0B45wov5ao9nhPHWUTzwOaMXcu6149PDSQ6Gyq
   HLI9uITCvlgGJ/WE5hMuwVbRbXKv12IdpvezosrLTCYHhbscRdQ0kpZHx
   Xi72nUQsVfjeQM4mV2oMINrkFr/fzU6bCN1JvyTpQ2RR0IfYp/vKJ/Dy5
   w==;
X-CSE-ConnectionGUID: BCWlbJRsTweg9FAWXitocw==
X-CSE-MsgGUID: yMHyqI4eQTWBxHJJWTbgKQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11520"; a="61067348"
X-IronPort-AV: E=Sophos;i="6.17,287,1747724400"; 
   d="scan'208";a="61067348"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2025 19:49:11 -0700
X-CSE-ConnectionGUID: PvsRFcA1Qz+YhDZhaV9yIw==
X-CSE-MsgGUID: K+dR4kxIQvyOIl0PurNKPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,287,1747724400"; 
   d="scan'208";a="171977867"
Received: from unknown (HELO [10.238.0.107]) ([10.238.0.107])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2025 19:49:07 -0700
Message-ID: <4b7e7099-79da-4178-8f16-6780d8137ae1@linux.intel.com>
Date: Thu, 14 Aug 2025 10:49:04 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 08/30] KVM: selftests: TDX: Update
 load_td_memory_region() for VM memory backed by guest memfd
To: Reinette Chatre <reinette.chatre@intel.com>,
 Sean Christopherson <seanjc@google.com>, Sagi Shahar <sagis@google.com>
Cc: linux-kselftest@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 Shuah Khan <shuah@kernel.org>, Ackerley Tng <ackerleytng@google.com>,
 Ryan Afranji <afranji@google.com>, Andrew Jones <ajones@ventanamicro.com>,
 Isaku Yamahata <isaku.yamahata@intel.com>,
 Erdem Aktas <erdemaktas@google.com>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Roger Wang <runanwang@google.com>, Oliver Upton <oliver.upton@linux.dev>,
 "Pratik R. Sampat" <pratikrajesh.sampat@amd.com>,
 Ira Weiny <ira.weiny@intel.com>, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org
References: <20250807201628.1185915-1-sagis@google.com>
 <20250807201628.1185915-9-sagis@google.com> <aJpTMVV-F0z8iyb4@google.com>
 <4b938a0a-a4ef-42c9-aef5-c931f2ad8aa0@linux.intel.com>
 <bec79c4a-499d-4f82-bfea-05746d4085e9@intel.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <bec79c4a-499d-4f82-bfea-05746d4085e9@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 8/13/2025 10:42 PM, Reinette Chatre wrote:
> Hi Binbin,
>
> On 8/13/25 2:23 AM, Binbin Wu wrote:
>>
>> On 8/12/2025 4:31 AM, Sean Christopherson wrote:
>>> On Thu, Aug 07, 2025, Sagi Shahar wrote:
>> [...]
>>>> +
>>>>    /*
>>>>     * TD creation/setup/finalization
>>>>     */
>>>> @@ -459,28 +474,35 @@ static void load_td_memory_region(struct kvm_vm *vm,
>>>>        if (!sparsebit_any_set(pages))
>>>>            return;
>>>>    +    if (region->region.guest_memfd != -1)
>>>> +        register_encrypted_memory_region(vm, region);
>>>> +
>>>>        sparsebit_for_each_set_range(pages, i, j) {
>>>>            const uint64_t size_to_load = (j - i + 1) * vm->page_size;
>>>>            const uint64_t offset =
>>>>                (i - lowest_page_in_region) * vm->page_size;
>>>>            const uint64_t hva = hva_base + offset;
>>>>            const uint64_t gpa = gpa_base + offset;
>>>> -        void *source_addr;
>>>> +        void *source_addr = (void *)hva;
>>>>              /*
>>>>             * KVM_TDX_INIT_MEM_REGION ioctl cannot encrypt memory in place.
>>>>             * Make a copy if there's only one backing memory source.
>>>>             */
>>>> -        source_addr = mmap(NULL, size_to_load, PROT_READ | PROT_WRITE,
>>>> -                   MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
>>>> -        TEST_ASSERT(source_addr,
>>>> -                "Could not allocate memory for loading memory region");
>>>> -
>>>> -        memcpy(source_addr, (void *)hva, size_to_load);
>>>> +        if (region->region.guest_memfd == -1) {
>>> Oh, here's the "if".
>> Is it still possible for "region->region.guest_memfd == -1" case?
>> KVM_TDX_INIT_MEM_REGION can only work with guest memfd, right?
>>
> This is still used and supports test "KVM: selftests: TDX: Test
> LOG_DIRTY_PAGES flag to a non-GUEST_MEMFD memslot" found in patch #30 that
> was created to support the issue encountered when QEMU attaches an emulated
> VGA device to a TD. More details available in the fix:
> fbb4adadea55 ("KVM: x86: Make cpu_dirty_log_size a per-VM value")

I think load_td_memory_region() should return directly for non-guest_memfd
region.
In current upstream version, KVM_TDX_INIT_MEM_REGION doesn't support
non-guest_memfd region.

The mmap/memcpy/munmap sequence should be removed because it does nothing but
zero out the original content.



>
> Reinette


