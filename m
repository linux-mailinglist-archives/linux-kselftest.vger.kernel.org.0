Return-Path: <linux-kselftest+bounces-47613-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 537EDCC4275
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Dec 2025 17:12:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E27353118D67
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Dec 2025 16:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37283352FA5;
	Tue, 16 Dec 2025 15:12:06 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4368E352F96;
	Tue, 16 Dec 2025 15:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765897926; cv=none; b=OAB1X+GLxN18MvUN9kYssMxynnz5uhJ5402+c1xLfRfoecOhT0gOlqLmp5PQ56+RXi3JnKfwijogEidOaM2MQWXoSiEmo755KXFk7cLLU9PW+QatkdcDA70XAbkh+jm+x67MsdDtY9x94b7lLVkwLfFBaD+zywEVuIlbpL6Y8Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765897926; c=relaxed/simple;
	bh=sORyT94VtnbOCzIRMMMSdubqBYiWNGJgEe2qZPVcIkA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HW+3nAY9rRkd8KbbQ0ogrOMPCoDkXg0kuWNWTLgwTPTM7jSnGeJnaRRkGni8pcz7HQLV6ct2NPTzJSDnhLgFbyJG3D3hB2eZq9/fhzxHWKS4PZlIUFvIJWXdbGnWpalvRJL6fP05M55Lxg5EftrSGtG88+MLwB/sSzni7pz5DHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7F93D1516;
	Tue, 16 Dec 2025 07:11:56 -0800 (PST)
Received: from [10.44.160.64] (e126510-lin.lund.arm.com [10.44.160.64])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A6DDC3F73B;
	Tue, 16 Dec 2025 07:12:01 -0800 (PST)
Message-ID: <fbf8e6ce-c058-4e87-b023-1544dac857be@arm.com>
Date: Tue, 16 Dec 2025 16:11:58 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] selftests/mm: fix faulting-in code in pagemap_ioctl
 test
To: Ryan Roberts <ryan.roberts@arm.com>, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Mark Brown
 <broonie@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Usama Anjum <Usama.Anjum@arm.com>
References: <20251216142633.2401447-1-kevin.brodsky@arm.com>
 <20251216142633.2401447-4-kevin.brodsky@arm.com>
 <37210500-6f6e-46ac-ac2f-ac996308590d@arm.com>
From: Kevin Brodsky <kevin.brodsky@arm.com>
Content-Language: en-GB
In-Reply-To: <37210500-6f6e-46ac-ac2f-ac996308590d@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 16/12/2025 15:56, Ryan Roberts wrote:
> On 16/12/2025 14:26, Kevin Brodsky wrote:
>> One of the pagemap_ioctl tests attempts to fault in pages by
>> memcpy()'ing them to an unused buffer. This probably worked
>> originally, but since commit 46036188ea1f ("selftests/mm: build with
>> -O2") the compiler is free to optimise away that unused buffer and
>> the memcpy() with it. As a result there might not be any resident
>> page in the mapping and the test may fail.
>>
>> We don't need to copy all that memory anyway. Just fault in every
>> page by forcing the compiler to read the first byte.
>>
>> Cc: Usama Anjum <Usama.Anjum@arm.com>
>> Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
>> ---
>>  tools/testing/selftests/mm/pagemap_ioctl.c | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/tools/testing/selftests/mm/pagemap_ioctl.c b/tools/testing/selftests/mm/pagemap_ioctl.c
>> index 2cb5441f29c7..67a7a3705604 100644
>> --- a/tools/testing/selftests/mm/pagemap_ioctl.c
>> +++ b/tools/testing/selftests/mm/pagemap_ioctl.c
>> @@ -1056,7 +1056,6 @@ int sanity_tests(void)
>>  	struct page_region *vec;
>>  	char *mem, *fmem;
>>  	struct stat sbuf;
>> -	char *tmp_buf;
>>  
>>  	/* 1. wrong operation */
>>  	mem_size = 10 * page_size;
>> @@ -1167,8 +1166,9 @@ int sanity_tests(void)
>>  	if (fmem == MAP_FAILED)
>>  		ksft_exit_fail_msg("error nomem %d %s\n", errno, strerror(errno));
>>  
>> -	tmp_buf = malloc(sbuf.st_size);
>> -	memcpy(tmp_buf, fmem, sbuf.st_size);
>> +	/* Fault in every page by reading the first byte */
>> +	for (i = 0; i < sbuf.st_size; i += page_size)
>> +		(void)*(volatile char *)(fmem + i);
> We have FORCE_READ() in vm_util.h for this. Perhaps that would be better?

It would, thanks! I wanted to use READ_ONCE() from
tools/include/linux/compiler.h but for some reason we don't add
tools/include to the include path in the mm kselftests Makefile and I
didn't want to dive into that rabbit hole.

- Kevin

