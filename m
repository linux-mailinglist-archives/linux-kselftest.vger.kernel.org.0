Return-Path: <linux-kselftest+bounces-44176-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F196C146E6
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Oct 2025 12:44:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8B981AA4542
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Oct 2025 11:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01BE830AD0B;
	Tue, 28 Oct 2025 11:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A/U0TorO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F095D30AAC4
	for <linux-kselftest@vger.kernel.org>; Tue, 28 Oct 2025 11:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761651852; cv=none; b=Syq9YCpOM8ZxCIQh/luyQVQ5aAsL/s2agmGCjoctbMtr4WuJP41KrBpt5ZkL0qpKpjQrrB9dyCrZiXPHToTPrP37ADVSzusnitNFFxSiitHmdKt/gtFzOt1NaBP8UnOH4vQ1Qe0yL17UnwVB0mgNHbmFqSNcuQDhFZA8qgyr7Wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761651852; c=relaxed/simple;
	bh=poij8wlwwOv2xQkmm5yAYpdmtg97F2oQvtny01XIVT8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=spQ5YI6as9wQJ/j2JhubcWpxBpSvGL1yHV/ihgEat/zvhjjBjlmt4dj2EQXsxSxVVysH7C1HbFujTTMYkuaueXO8gFp5bBNY4Tknin8JQB4AcDuhK+orz29WNLWfupY1ol4iiuVahJP63b0AgBUJJOrotQvhaIK2IJuIsTUpTKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A/U0TorO; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-427060bc0f5so3212117f8f.3
        for <linux-kselftest@vger.kernel.org>; Tue, 28 Oct 2025 04:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761651848; x=1762256648; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PWcMpUbr5EvoYwg6OCCvCq3zKJMQIWwwgnasyRi2T/U=;
        b=A/U0TorO7PrsxQeinvfhEFb9UyHeKrRVY7hk2S62o4940PtjH6EZmpImgQ/4lD0pJK
         iX1BwBOyBQEzZzyxMPAO7N9WJo72WyOlsrdnFMU1ACnVNTD6wfLy0fLFAXOA9BV51STc
         8EkB+WH6CT5YKbxiho6HUEC0dSgpHvtDrFt4XWaNd3AYtkPTgR4pueUNj0vTu0dCZJ/A
         9v8jdMjzDB10a5IEP7YwpoZI/lYQIDf3CXVbAjn3ZIcGIrgsr4jOrYwsqvkNfPojH3Jk
         2mrLDyJAowyX2piNDhaGRF2hCz8+nwee1dFvuZqxZMVIyCoTWWJVRc4WXaQq9CF72jZJ
         Oqfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761651848; x=1762256648;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PWcMpUbr5EvoYwg6OCCvCq3zKJMQIWwwgnasyRi2T/U=;
        b=NWbxCHgesFtac+OPSqDCXbcPGYneZylVlD1DnsHEebaRZzn6Iy/iW0k1YokO+Tb6+t
         4VXrNkMvTFvCm60OHyp3wDuAkf7O8BcZ4YrOdg/G4oxG2aqBnqDVkRrwoi4PxHmqyu7o
         F2O6t3olHDon1ipYJ7WMMYL18C9DeBOgrZUJFSRjxkm7CvoK98kieYs//MyuW9gp6R95
         XdaPZyebFdNjdjX138N8IuRu7K/WYaWQq3ngwu8LVKx1LdvwaEvp18bkA32sqhWQRKMc
         LR7wWMmnlm5aoMH7rGk0QaHAl7S9S8FIhn0WmRmptjdHOw9ECvoLMQQR/ENAfcWqEAvi
         LIZg==
X-Forwarded-Encrypted: i=1; AJvYcCWKDIXgEcO5C2TEol0U3sb+F6IHf21lasimbNK+deYhbPXtmf712kPKjFyW3hS3MS2WwEkWwSct14gwpeK0Oa4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBdHLmmDWYbFIYeuFSzgpepD8XCMt1pBeXHk5ZRPp+4F9VhSdn
	GR/7B5P/ZmptDew66/ZgbvsQPfLD6ZypE8qEUdGwACcSCSakCPqPEVRC
X-Gm-Gg: ASbGnct3NEkixIVBLzbTNy0F0fDQctTAETG/fyRxJC+Ds0Hh42Lrf1Qz3fd/Rm8oqUg
	y6chuk20+hbF6vGIOBIlPo03kCzaKF0AndW1F5dk0t7U7WDbOpU9q33aKHfsaOSQ2VqvJkm9blb
	VqZJeLbAZuLucqa0ckFoZxakE7qiBSW05TZC9qYKXykQ1gAbSWUaJcwk2yzyrm1XPFvB5FEeztn
	Z4WogaqoXA4JD5U+8cekNyZi+30sTJOt5oVZGbJs2SBXw8cE2UssDPS+3KlZwbZpFKOCiG0buZW
	7Efnwn/Eo01wPsqnxAV0XV13pDJ5FfrqKR66hBS7HaVlAxe4BLm7Mx0+xgaNCimieJpAgYNF2xD
	4AqePxioSA8jcUx0Uhn1aRvixDVf9wmcGxYaO2/pZy7uTcLmMMrVKKTOPHrsZ5k9pDRZ4hVOtcz
	5rppIYWeUdMy6NTUnJtRAk
X-Google-Smtp-Source: AGHT+IGWKlgpP2z1QhsSUQHXl7C4b+OW6D0eUSaDQiNKqIYxyLK5t9gJfLBx15l4AM6BkXPesoBDGw==
X-Received: by 2002:a05:6000:3103:b0:429:8cda:dd4e with SMTP id ffacd0b85a97d-429a7e732bdmr2556153f8f.32.1761651847905;
        Tue, 28 Oct 2025 04:44:07 -0700 (PDT)
Received: from [10.24.67.204] ([15.248.3.88])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952b7b43sm20301815f8f.6.2025.10.28.04.44.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Oct 2025 04:44:07 -0700 (PDT)
Message-ID: <c52db7bf-494f-49a8-9829-3805db6dda7c@gmail.com>
Date: Tue, 28 Oct 2025 11:44:06 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] KVM: selftests: Fix unaligned mmap allocations
Content-Language: en-GB
To: Sean Christopherson <seanjc@google.com>
Cc: maz@kernel.org, oliver.upton@linux.dev, pbonzini@redhat.com,
 joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com,
 catalin.marinas@arm.com, will@kernel.org, shuah@kernel.org,
 linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 isaku.yamahata@intel.com, roypat@amazon.co.uk, kalyazin@amazon.co.uk,
 jackabt@amazon.com
References: <20251013151502.6679-1-jackabt.amazon@gmail.com>
 <20251013151502.6679-3-jackabt.amazon@gmail.com>
 <aPpi1c-8EpWuo87B@google.com>
From: "Thomson, Jack" <jackabt.amazon@gmail.com>
In-Reply-To: <aPpi1c-8EpWuo87B@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 23/10/2025 6:16 pm, Sean Christopherson wrote:
> On Mon, Oct 13, 2025, Jack Thomson wrote:
>> From: Jack Thomson <jackabt@amazon.com>
>>
>> When creating a VM using mmap with huge pages, and the memory amount does
>> not align with the underlying page size. The stored mmap_size value does
>> not account for the fact that mmap will automatically align the length
>> to a multiple of the underlying page size. During the teardown of the
>> test, munmap is used. However, munmap requires the length to be a
>> multiple of the underlying page size.
> 
> What happens when selftests use the wrong map_size?  E.g. is munmap() silently
> failing?  If so, then I should probably take this particular patch through
> kvm-x86/gmem, otherwise it means we'll start getting asserts due to:
> 
>    3223560c93eb ("KVM: selftests: Define wrappers for common syscalls to assert success")
> 
> If munmap() isn't failing, then that begs the question of what this patch is
> actually doing :-)
> 

Hi Sean, sorry I completely missed your reply.

Yeah currently with a misaligned map_size it causes munmap() to fail, I
noticed when tested with different backings.

>> Update the vm_mem_add method to ensure the mmap_size is aligned to the
>> underlying page size.
>>
>> Signed-off-by: Jack Thomson <jackabt@amazon.com>
>> ---
>>   tools/testing/selftests/kvm/lib/kvm_util.c | 12 +++++-------
>>   1 file changed, 5 insertions(+), 7 deletions(-)
>>
>> diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
>> index c3f5142b0a54..b106fbed999c 100644
>> --- a/tools/testing/selftests/kvm/lib/kvm_util.c
>> +++ b/tools/testing/selftests/kvm/lib/kvm_util.c
>> @@ -1051,7 +1051,6 @@ void vm_mem_add(struct kvm_vm *vm, enum vm_mem_backing_src_type src_type,
>>   	/* Allocate and initialize new mem region structure. */
>>   	region = calloc(1, sizeof(*region));
>>   	TEST_ASSERT(region != NULL, "Insufficient Memory");
>> -	region->mmap_size = mem_size;
>>   
>>   #ifdef __s390x__
>>   	/* On s390x, the host address must be aligned to 1M (due to PGSTEs) */
>> @@ -1060,6 +1059,11 @@ void vm_mem_add(struct kvm_vm *vm, enum vm_mem_backing_src_type src_type,
>>   	alignment = 1;
>>   #endif
>>   
>> +	alignment = max(backing_src_pagesz, alignment);
>> +	region->mmap_size = align_up(mem_size, alignment);
>> +
>> +	TEST_ASSERT_EQ(guest_paddr, align_up(guest_paddr, backing_src_pagesz));
>> +
>>   	/*
>>   	 * When using THP mmap is not guaranteed to returned a hugepage aligned
>>   	 * address so we have to pad the mmap. Padding is not needed for HugeTLB
>> @@ -1067,12 +1071,6 @@ void vm_mem_add(struct kvm_vm *vm, enum vm_mem_backing_src_type src_type,
>>   	 * page size.
>>   	 */
>>   	if (src_type == VM_MEM_SRC_ANONYMOUS_THP)
>> -		alignment = max(backing_src_pagesz, alignment);
>> -
>> -	TEST_ASSERT_EQ(guest_paddr, align_up(guest_paddr, backing_src_pagesz));
>> -
>> -	/* Add enough memory to align up if necessary */
>> -	if (alignment > 1)
>>   		region->mmap_size += alignment;
>>   
>>   	region->fd = -1;
>> -- 
>> 2.43.0
>>

-- 
Thanks,
Jack

