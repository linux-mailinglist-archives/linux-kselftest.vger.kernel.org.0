Return-Path: <linux-kselftest+bounces-47987-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9570FCE6987
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Dec 2025 12:49:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 997C730038FC
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Dec 2025 11:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C0182C0273;
	Mon, 29 Dec 2025 11:46:55 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84A922BEC41;
	Mon, 29 Dec 2025 11:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767008815; cv=none; b=Ab57ler7g7pgj+e0D+DHnFx26WWFeYqoaMz8DWIAVm/nS/08p8mrW59+kCcA8wzZYwkqW8bATFXZyLII/oNNp/cVJp1iGFEVnmpA7ztjor6dAVg3dY8WzciTGVc8644ZVwknflrIYXUnB7SK3Tsl6uDKO+1U2ASsKbHYy6H/C/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767008815; c=relaxed/simple;
	bh=55HigBlQHbzxhusODOnJSc5MeYRZFy/kHhQUkZrIBNE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s3BZPFmpzFEM+nSTXXWj4S3tJmYEZ4GoISx1pLRSjtrivy+HFV/02MSsmDRm2EGdfhjtO0n6quH6pSlD6u+LmYmRjBxKxO4HbdZ5/6+odB+uOIsM2qylF4F7IDrZEbfb6/GkoRP1lyqtmoQP2IqOZsWd3ECe8d81ql0wGdRFMjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C4A93339;
	Mon, 29 Dec 2025 03:46:42 -0800 (PST)
Received: from [10.57.45.222] (unknown [10.57.45.222])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9303B3F5A1;
	Mon, 29 Dec 2025 03:46:47 -0800 (PST)
Message-ID: <7f0ac47d-1eff-4b79-b260-7812bf3ebc80@arm.com>
Date: Mon, 29 Dec 2025 12:46:45 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] selftests/mm: fix faulting-in code in pagemap_ioctl
 test
To: "David Hildenbrand (Red Hat)" <david@kernel.org>,
 Ryan Roberts <ryan.roberts@arm.com>, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Mark Brown
 <broonie@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Usama Anjum <Usama.Anjum@arm.com>
References: <20251216142633.2401447-1-kevin.brodsky@arm.com>
 <20251216142633.2401447-4-kevin.brodsky@arm.com>
 <37210500-6f6e-46ac-ac2f-ac996308590d@arm.com>
 <6aa47cdb-d2e7-4977-929b-7019b6f991c1@kernel.org>
 <0575bcf6-c1a3-4ebf-a199-3113758fbdc5@arm.com>
 <a3ca6293-8f85-4489-a48e-eb8d0d3792c5@kernel.org>
From: Kevin Brodsky <kevin.brodsky@arm.com>
Content-Language: en-GB
In-Reply-To: <a3ca6293-8f85-4489-a48e-eb8d0d3792c5@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 19/12/2025 09:29, David Hildenbrand (Red Hat) wrote:
> On 12/18/25 14:18, Kevin Brodsky wrote:
>> On 18/12/2025 09:05, David Hildenbrand (Red Hat) wrote:
>>> On 12/16/25 15:56, Ryan Roberts wrote:
>>>> On 16/12/2025 14:26, Kevin Brodsky wrote:
>>>>> One of the pagemap_ioctl tests attempts to fault in pages by
>>>>> memcpy()'ing them to an unused buffer. This probably worked
>>>>> originally, but since commit 46036188ea1f ("selftests/mm: build with
>>>>> -O2") the compiler is free to optimise away that unused buffer and
>>>>> the memcpy() with it. As a result there might not be any resident
>>>>> page in the mapping and the test may fail.
>>>>>
>>>>> We don't need to copy all that memory anyway. Just fault in every
>>>>> page by forcing the compiler to read the first byte.
>>>>>
>>>>> Cc: Usama Anjum <Usama.Anjum@arm.com>
>>>>> Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
>>>>> ---
>>>>>    tools/testing/selftests/mm/pagemap_ioctl.c | 6 +++---
>>>>>    1 file changed, 3 insertions(+), 3 deletions(-)
>>>>>
>>>>> diff --git a/tools/testing/selftests/mm/pagemap_ioctl.c
>>>>> b/tools/testing/selftests/mm/pagemap_ioctl.c
>>>>> index 2cb5441f29c7..67a7a3705604 100644
>>>>> --- a/tools/testing/selftests/mm/pagemap_ioctl.c
>>>>> +++ b/tools/testing/selftests/mm/pagemap_ioctl.c
>>>>> @@ -1056,7 +1056,6 @@ int sanity_tests(void)
>>>>>        struct page_region *vec;
>>>>>        char *mem, *fmem;
>>>>>        struct stat sbuf;
>>>>> -    char *tmp_buf;
>>>>>          /* 1. wrong operation */
>>>>>        mem_size = 10 * page_size;
>>>>> @@ -1167,8 +1166,9 @@ int sanity_tests(void)
>>>>>        if (fmem == MAP_FAILED)
>>>>>            ksft_exit_fail_msg("error nomem %d %s\n", errno,
>>>>> strerror(errno));
>>>>>    -    tmp_buf = malloc(sbuf.st_size);
>>>>> -    memcpy(tmp_buf, fmem, sbuf.st_size);
>>>>> +    /* Fault in every page by reading the first byte */
>>>>> +    for (i = 0; i < sbuf.st_size; i += page_size)
>>>>> +        (void)*(volatile char *)(fmem + i);
>>>>
>>>> We have FORCE_READ() in vm_util.h for this. Perhaps that would be
>>>> better?
>>>
>>> Agreed, and if we have multiple patterns where we want to force_read a
>>> bigger area, maybe we should provide a helper for that?
>>
>> I've found just a couple of cases where FORCE_READ() is used for a
>> larger area (in hugetlb-madvise.c and split_huge_page_test.c). The step
>> size isn't the same in any of these cases though. We could have
>> something like fault_area(addr, size, step) but maybe the loops are
>> clear enough already?
>
> Note that even for hugtlb we can read page-per-page, no need to
> hugetlb-page-per-hugetlb-page. Not sure if the performance change
> would make any real performance difference in this testing code.

Fair point. In fact in split_huge_page_test.c we're reading every byte
but that's unnecessary. I'll add a helper that reads page-by-page and
use that in all 3 cases.

- Kevin

