Return-Path: <linux-kselftest+bounces-36278-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9378AF0E05
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 10:30:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5B2A1C262AD
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 08:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A364D23957D;
	Wed,  2 Jul 2025 08:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QardYkIL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C53A239086
	for <linux-kselftest@vger.kernel.org>; Wed,  2 Jul 2025 08:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751444941; cv=none; b=oft84CSjHo927a7CONxWO9Mdmh0ghWJTu9J9gieEvWGBZLols9u0MM+rq02j6zW04jVjMS61aWKhn2TLypeAwiIAe0aXasyr44K1aTBiOoupOaKGyZcxF5gxlJmh/n1uV72tq5eFA2EV2QrTbnuAfNP9Sv3LDM/VDdQdIao3mxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751444941; c=relaxed/simple;
	bh=TpUiGwitXPaVtboFPC1JiMhrIkd+/KdYZg8MhTrKKlM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jDvC3zkgHGX0DSRZh+P38AQSVRgoZL4MxoCf2kdy12z45LO+Ncr4vQUcWss2W+tU347rJWlkbOyfVuhyOvWW6ImZcHpE5Xqmbg2bmG6J7SaOm8k0gBwzi0VRRSipYBnpdWQV83kbzApjZpgAVZYtP/FKOxwyugXCotKlB/rt0+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QardYkIL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751444938;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=HzbQFqLIkZ4mMZ8AYNo+jHz+PQn+lq0iEDVgmGYyPOM=;
	b=QardYkILCV6a8OE0Xy5Ej6buEgM3AMoekuKD2uJrFPlIDpqOidOMm3YGklM/+a7eqAxa+Z
	1aUUGpPxfnuxatMhg+V24TncxeRhOsJMywtIxb/JwP1qs6bPuGOBB5GgC1sgNRTWiyJMzR
	RCvvuJMHgjsF6Gz9rcwco7zmIgw/+C4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-573-8eLOjEJIOr6NmSrApbRVdQ-1; Wed, 02 Jul 2025 04:28:54 -0400
X-MC-Unique: 8eLOjEJIOr6NmSrApbRVdQ-1
X-Mimecast-MFC-AGG-ID: 8eLOjEJIOr6NmSrApbRVdQ_1751444934
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3a4f8192e2cso2593074f8f.3
        for <linux-kselftest@vger.kernel.org>; Wed, 02 Jul 2025 01:28:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751444934; x=1752049734;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HzbQFqLIkZ4mMZ8AYNo+jHz+PQn+lq0iEDVgmGYyPOM=;
        b=p8nGO8dy9zfR5ytd+wYXZmTi+vWF8H9He5DBYj3E43BezWXC7Yk+MjX1Op46GaCJu9
         6imASH4OOtMqxcmmGEAwDFMMsPgG786B7l2fdqhTRzrPVPEdOBXiSH4OOf/YPM1G22KP
         6tbG04QwW04L/QOO3X66aij3P89Lqt4Kte5bi8yLYDFJgafpoRSpOpKvqSVSHT3UXTFx
         T8/7buaCza4PGMMO8SWyJIGxehTZ0iQi5rrYyPwDz6fNP6HuVHfwa4QBnraS1LrI4CtX
         KkWTXGJEtHuEMw7tBc6jVynByEMETB4/A1hdMmvQRxWTu+4ixnAzzMjTAZyiZSDGBwgh
         NWYw==
X-Forwarded-Encrypted: i=1; AJvYcCUuUhM30LH7fjGyJ3rtUKZydn1HiulVOlCerSbcWv61ZduV8+zt6S0COEVssJWwf6/4zxGOvq6pmHVEc4cPehg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtVlXWiAfqfI0hVVArwul3YuQ22s5KJONUlIHCqCCl+WpfHCoB
	HnH0xD+PfSEf9Jl7IHmrUgUC0kt2z416CQ0j8ln1s71CO+uBLL4YCNUfJPZe6O5vzhgn0+DnWuQ
	6CbfLwe64F1wjF2GEJnpXBqQeS0g6C5gu1edcI9dON1dU8PwdHhkA3PguJnoHBUVX1TWH0g==
X-Gm-Gg: ASbGncs5zIuzuEah/ZyjjRXCjvFPDa6WTnrzQOML02hkNxGuXetZV3Kw+8mZS53x/Sz
	gbP5TjhY9bmjafoQhoGk7WGVdB8olkJnVN7xlrCGJmZ9I+uljiV482+zPXxKvs5I89n+wLvY4e4
	b1Z33Z38YcxFRn06+sUysPwQw51K3rJAjobQcEeJXYDB9qxqja4AZl/qm+BdWl2vqP668eP/48E
	/tN05R76Y8gxLw8kQnJZlt7SgqNCp6cdmBCwa8Yz4bSnODbXD97kvCnkcSgkGatdsVwhkZGgkBA
	CL/g55eGVWLMAiljdTc3ujNPqyedIkMvKYIkbhie9M/w51nPbIWcMKs=
X-Received: by 2002:a05:6000:703:b0:3a4:f6ba:51c8 with SMTP id ffacd0b85a97d-3b1fe5c082fmr1259456f8f.14.1751444933503;
        Wed, 02 Jul 2025 01:28:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHU4GPCoUJnaI5KrpPRxbohExSM4p/V+1hC5zWtpV0MmAymkrtexckqli/iTlrYjgsiXsuFcw==
X-Received: by 2002:a05:6000:703:b0:3a4:f6ba:51c8 with SMTP id ffacd0b85a97d-3b1fe5c082fmr1259424f8f.14.1751444932931;
        Wed, 02 Jul 2025 01:28:52 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4538234b382sm222400965e9.9.2025.07.02.01.28.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Jul 2025 01:28:52 -0700 (PDT)
Message-ID: <f474ef7b-71f3-4169-ba30-74f4afbaeee6@redhat.com>
Date: Wed, 2 Jul 2025 10:28:51 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/mm: pagemap_scan ioctl: add PFN ZERO test cases
To: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>
Cc: kernel@collabora.com, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250630102443.137809-1-usama.anjum@collabora.com>
 <20027e0c-f43b-4d10-a4d6-41dcc38145bd@redhat.com>
 <6846faf7-20b5-4f08-a8f0-9946f993b0e9@collabora.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <6846faf7-20b5-4f08-a8f0-9946f993b0e9@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 02.07.25 09:39, Muhammad Usama Anjum wrote:
> On 7/1/25 7:51 PM, David Hildenbrand wrote:
>> On 30.06.25 12:24, Muhammad Usama Anjum wrote:
>>> Add test cases to test the correctness of PFN ZERO flag of pagemap_scan
>>> ioctl. Test with normal pages backed memory and huge pages backed
>>> memory.
>>
>> Just to verify: would this trigger on kernels before my fix?
> Yes, it does trigger the bug without the fix.
> 
>>
>>>
>>> Cc: David Hildenbrand <david@redhat.com>
>>> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
>>> ---
>>> The bug has been fixed [1].
>>>
>>> [1] https://lore.kernel.org/all/20250617143532.2375383-1-david@redhat.com
>>> ---
>>>    tools/testing/selftests/mm/pagemap_ioctl.c | 57 +++++++++++++++++++++-
>>>    1 file changed, 56 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/tools/testing/selftests/mm/pagemap_ioctl.c b/tools/
>>> testing/selftests/mm/pagemap_ioctl.c
>>> index 57b4bba2b45f3..6138de0087edf 100644
>>> --- a/tools/testing/selftests/mm/pagemap_ioctl.c
>>> +++ b/tools/testing/selftests/mm/pagemap_ioctl.c
>>> @@ -1,4 +1,5 @@
>>>    // SPDX-License-Identifier: GPL-2.0
>>> +
>>>    #define _GNU_SOURCE
>>>    #include <stdio.h>
>>>    #include <fcntl.h>
>>> @@ -1480,6 +1481,57 @@ static void transact_test(int page_size)
>>>                      extra_thread_faults);
>>>    }
>>>    +void zeropfn_tests(void)
>>> +{
>>> +    unsigned long long mem_size;
>>> +    struct page_region vec;
>>> +    int i, ret;
>>> +    char *mem;
>>> +
>>> +    /* Test with page backed memory */
>>
>> What is "page backed memory" ? :)
> I mean, normal memory which isn't huge page backed. I've renamed it to
> Test with normal memory.
> 
>>
>>> +    mem_size = 10 * page_size;
>>> +    mem = mmap(NULL, mem_size, PROT_READ, MAP_PRIVATE | MAP_ANON, -1,
>>> 0);
>>> +    if (mem == MAP_FAILED)
>>> +        ksft_exit_fail_msg("error nomem\n");
>>> +
>>> +    /* Touch each page to ensure it's mapped */
>>> +    for (i = 0; i < mem_size; i += page_size)
>>> +        (void)((volatile char *)mem)[i];
>>> +
>>> +    ret = pagemap_ioctl(mem, mem_size, &vec, 1, 0,
>>> +                (mem_size / page_size), PAGE_IS_PFNZERO, 0, 0,
>>> PAGE_IS_PFNZERO);
>>> +    if (ret < 0)
>>> +        ksft_exit_fail_msg("error %d %d %s\n", ret, errno,
>>> strerror(errno));
>>> +
>>> +    ksft_test_result(ret == 1 && LEN(vec) == (mem_size / page_size),
>>> +             "%s all pages must have PFNZERO set\n", __func__);
>>> +
>>> +    munmap(mem, mem_size);
>>> +
>>> +    /* Test with huge page */
>>> +    mem_size = 10 * hpage_size;
>>> +    mem = memalign(hpage_size, mem_size);
>>> +    if (!mem)
>>> +        ksft_exit_fail_msg("error nomem\n");
>>> +
>>> +    ret = madvise(mem, mem_size, MADV_HUGEPAGE);
>>> +    if (ret)
>>> +        ksft_exit_fail_msg("madvise failed %d %s\n", errno,
>>> strerror(errno));
>>
>> Might fail on older kernels, so we usually treat this as a skip.
> I'll skip it in next version.
> 
>>
>>> +
>>> +    for (i = 0; i < mem_size; i += hpage_size)
>>> +        (void)((volatile char *)mem)[i];
>>> +
>>> +    ret = pagemap_ioctl(mem, mem_size, &vec, 1, 0,
>>> +                (mem_size / page_size), PAGE_IS_PFNZERO, 0, 0,
>>> PAGE_IS_PFNZERO);
>>> +    if (ret < 0)
>>> +        ksft_exit_fail_msg("error %d %d %s\n", ret, errno,
>>> strerror(errno));
>>> +
>>> +    ksft_test_result(ret == 1 && LEN(vec) == (mem_size / page_size),
>>> +             "%s all huge pages must have PFNZERO set\n", __func__);
>>
>> Wouldn't this be able to fail if /sys/kernel/mm/transparent_hugepage/
>> use_zero_page is set to false,
> I wasn't aware of it. I'll check user_zero_page first as initial condition.
> 
>> or if mmap() gave us a suboptimally-
>> aligned range?
> mem = memalign(hpage_size, mem_size) is being used to allocate this. So
> aligment should be correct.
> 
>>
>> You'd have to read each and every page to get the ordinary shared
>> zeropage in these configs instead without making the test too complicated.
> In the above for loop, we are reading each new page already. Let's
> resolve this and then I'll post the v2 which is ready.
> 
>>
>>> +
>>> +    free(mem);
>>
>>
>> Shouldn't this be an munmap() ?
> free() is being used to free memory allocated by memalign().

Oh, I missed that detail.

I'm afraid memalign+free that might not be what you want: there is no 
guarantee that what you are getting hasn't been used before and is not 
already filled with other pages?

-- 
Cheers,

David / dhildenb


