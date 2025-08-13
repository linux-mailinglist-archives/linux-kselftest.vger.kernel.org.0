Return-Path: <linux-kselftest+bounces-38844-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14807B24549
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Aug 2025 11:23:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 126D25618A9
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Aug 2025 09:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E32312F0C54;
	Wed, 13 Aug 2025 09:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UuzeoWTG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 552ED27280E;
	Wed, 13 Aug 2025 09:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755077005; cv=none; b=JDqO7fJGPINCxGhbIbS8gUH5UOlUskAnE6EtDZLtoatbLBh0G2mu86jYS7ha0VNL57wodKbVdg76egR15O6uw0r07O6n3bAECytgPVuf9GY+aqqeXzMg1PAesNRKTXURkpIUlWsn/bSVb0mi1hN1L+5Mwvt59Am2CKLhbk/pPrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755077005; c=relaxed/simple;
	bh=esTtWUfim1V9kKbOWRWUoxZeiZSbRevTwHozfIIqhwI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CUnJ3ID3ci0gNYIJqm9AopSArONj2VGDEqOYdBz5udqVYRBs0qBEEAsCbOP+ufLgVaCLy/orYOlwmyLqYCKGn/qv4lBR0DACF4qP5MrYlm1+vsv+Wbks1YRgvHRl7qIi4B7mV3CbHRRDLindQHD3A4Dh/mQyx/dMs8ly8kOn45o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UuzeoWTG; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755077005; x=1786613005;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=esTtWUfim1V9kKbOWRWUoxZeiZSbRevTwHozfIIqhwI=;
  b=UuzeoWTGEKYZqMoyuI/fDO9cmbd03cCjFiwEoEeGIhYJYilWzm/+9NzX
   tS0F2S5JWzjrXmv5QMMtbEHt6taOkZ2vYSrLdfPhznnhRY5WaQlopa/AD
   Hb7McTUmh9sf/Pux8G3nKq/+Ec5PXqdw82+3rdvusP30ZUV4PheBwuScR
   tNsBD5RNZDSY0szhlkcN9c/MQ4GaHCflX4T2JWnNcOCLm0++Od0WFwN3F
   3OSCMmYpJKFCWnd/JOM5qk4wFaVzzHkIai3bh/KbxECkoplNE0MdHeMuk
   isOc4rB4zwTQMqzTeKgXx+YOAMKZQv0qGBKBGn9vWj7o12N8kBhcN+W99
   A==;
X-CSE-ConnectionGUID: HmWCfrLST+SUGAnADUX5Sg==
X-CSE-MsgGUID: 1UjYmBckT7iJIzPcTK90Mg==
X-IronPort-AV: E=McAfee;i="6800,10657,11520"; a="60985708"
X-IronPort-AV: E=Sophos;i="6.17,285,1747724400"; 
   d="scan'208";a="60985708"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2025 02:23:24 -0700
X-CSE-ConnectionGUID: 1ioZn/w8Rda6gbaZ70wojw==
X-CSE-MsgGUID: srXmkal5Ru+3MmngE+WQGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,285,1747724400"; 
   d="scan'208";a="203602660"
Received: from unknown (HELO [10.238.11.25]) ([10.238.11.25])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2025 02:23:20 -0700
Message-ID: <4b938a0a-a4ef-42c9-aef5-c931f2ad8aa0@linux.intel.com>
Date: Wed, 13 Aug 2025 17:23:17 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 08/30] KVM: selftests: TDX: Update
 load_td_memory_region() for VM memory backed by guest memfd
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
 <20250807201628.1185915-9-sagis@google.com> <aJpTMVV-F0z8iyb4@google.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <aJpTMVV-F0z8iyb4@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/12/2025 4:31 AM, Sean Christopherson wrote:
> On Thu, Aug 07, 2025, Sagi Shahar wrote:
[...]
>> +
>>   /*
>>    * TD creation/setup/finalization
>>    */
>> @@ -459,28 +474,35 @@ static void load_td_memory_region(struct kvm_vm *vm,
>>   	if (!sparsebit_any_set(pages))
>>   		return;
>>   
>> +	if (region->region.guest_memfd != -1)
>> +		register_encrypted_memory_region(vm, region);
>> +
>>   	sparsebit_for_each_set_range(pages, i, j) {
>>   		const uint64_t size_to_load = (j - i + 1) * vm->page_size;
>>   		const uint64_t offset =
>>   			(i - lowest_page_in_region) * vm->page_size;
>>   		const uint64_t hva = hva_base + offset;
>>   		const uint64_t gpa = gpa_base + offset;
>> -		void *source_addr;
>> +		void *source_addr = (void *)hva;
>>   
>>   		/*
>>   		 * KVM_TDX_INIT_MEM_REGION ioctl cannot encrypt memory in place.
>>   		 * Make a copy if there's only one backing memory source.
>>   		 */
>> -		source_addr = mmap(NULL, size_to_load, PROT_READ | PROT_WRITE,
>> -				   MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
>> -		TEST_ASSERT(source_addr,
>> -			    "Could not allocate memory for loading memory region");
>> -
>> -		memcpy(source_addr, (void *)hva, size_to_load);
>> +		if (region->region.guest_memfd == -1) {
> Oh, here's the "if".

Is it still possible for "region->region.guest_memfd == -1" case?
KVM_TDX_INIT_MEM_REGION can only work with guest memfd, right?



>
>> +			source_addr = mmap(NULL, size_to_load, PROT_READ | PROT_WRITE,
>> +					   MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
>> +			TEST_ASSERT(source_addr,
>> +				    "Could not allocate memory for loading memory region");
>> +
>> +			memcpy(source_addr, (void *)hva, size_to_load);
>> +			memset((void *)hva, 0, size_to_load);
>> +		}
>>   
>>   		tdx_init_mem_region(vm, source_addr, gpa, size_to_load);
>>   
>> -		munmap(source_addr, size_to_load);
>> +		if (region->region.guest_memfd == -1)
>> +			munmap(source_addr, size_to_load);
>>   	}
>>   }
>>   
>> -- 
>> 2.51.0.rc0.155.g4a0f42376b-goog
>>


