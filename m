Return-Path: <linux-kselftest+bounces-47726-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B1E7CCEFD8
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Dec 2025 09:33:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 733273071FAA
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Dec 2025 08:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A587129B200;
	Fri, 19 Dec 2025 08:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jWk8hALG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD0B2690EC;
	Fri, 19 Dec 2025 08:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766132952; cv=none; b=PJ/Aet63bPY8hjV66KFaq8/1vm5E7WeGTmkHLtslfD3yAQw5903x7LC+Duf0YxKdMNpdovhfP9C7elRyNdOi7vouFdxF3JoOy6LsmIKU5wy0XZX7ZGq/SltMv7gaQNNt/RY34ZUcjXIJ5mslZ7gObnhTSkoM28bM4/vRboBDVAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766132952; c=relaxed/simple;
	bh=UCFnBOrzhV3jWI43ElU9t2h6igr0WlVvCIX4xGYLDk0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k3flLRX30NKtQEe2+vxws4L4M4g4Z3acOtfIbMn8A2W0wwYTjUVT9ybhxKyLmMOYiSk/DbbO9PuSVafucPg7CuEZqItyxBlbK1F5jfRE1/+lK5Vi7KX/9o0V2CqhkgOPvHLU6m/tZusJA0XcpthgwsKtlGuZ9IJb8fd3qenWT74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jWk8hALG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD61DC116B1;
	Fri, 19 Dec 2025 08:29:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766132952;
	bh=UCFnBOrzhV3jWI43ElU9t2h6igr0WlVvCIX4xGYLDk0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=jWk8hALGXyTDQTBOou4ixavX7CnsUIfth0+Lxjb9cqp3NQS5XoFaSEdUdUUI+f928
	 jty2G8rmU7Gk/BheKCFqD9Y2FzPRO1gtYzRCpdzGkQXIilkAMjttsvH6lJ2zgEypej
	 HaNcmYcLBoIxorXioJAgzgi2cVrlTLBJwzn0SFdSdFWPLklS7V7IbR0R+BxwEnScWT
	 UDDL+O12Zz9/L2S6Pp283WNMS6r2C3wwlFnSfs/Y0hhmBVkNgr6FpGP5Ndo51jWUOd
	 tqdy2GTXFYZr9jJINvQ81sVj6hCr6k9c3uf0AYlxm0bXd/uz0KlJzLGCbhDCkVDr5W
	 WP5UqAVOuYtdw==
Message-ID: <a3ca6293-8f85-4489-a48e-eb8d0d3792c5@kernel.org>
Date: Fri, 19 Dec 2025 09:29:06 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] selftests/mm: fix faulting-in code in pagemap_ioctl
 test
To: Kevin Brodsky <kevin.brodsky@arm.com>, Ryan Roberts
 <ryan.roberts@arm.com>, linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Mark Brown
 <broonie@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Usama Anjum <Usama.Anjum@arm.com>
References: <20251216142633.2401447-1-kevin.brodsky@arm.com>
 <20251216142633.2401447-4-kevin.brodsky@arm.com>
 <37210500-6f6e-46ac-ac2f-ac996308590d@arm.com>
 <6aa47cdb-d2e7-4977-929b-7019b6f991c1@kernel.org>
 <0575bcf6-c1a3-4ebf-a199-3113758fbdc5@arm.com>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <0575bcf6-c1a3-4ebf-a199-3113758fbdc5@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/18/25 14:18, Kevin Brodsky wrote:
> On 18/12/2025 09:05, David Hildenbrand (Red Hat) wrote:
>> On 12/16/25 15:56, Ryan Roberts wrote:
>>> On 16/12/2025 14:26, Kevin Brodsky wrote:
>>>> One of the pagemap_ioctl tests attempts to fault in pages by
>>>> memcpy()'ing them to an unused buffer. This probably worked
>>>> originally, but since commit 46036188ea1f ("selftests/mm: build with
>>>> -O2") the compiler is free to optimise away that unused buffer and
>>>> the memcpy() with it. As a result there might not be any resident
>>>> page in the mapping and the test may fail.
>>>>
>>>> We don't need to copy all that memory anyway. Just fault in every
>>>> page by forcing the compiler to read the first byte.
>>>>
>>>> Cc: Usama Anjum <Usama.Anjum@arm.com>
>>>> Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
>>>> ---
>>>>    tools/testing/selftests/mm/pagemap_ioctl.c | 6 +++---
>>>>    1 file changed, 3 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/tools/testing/selftests/mm/pagemap_ioctl.c
>>>> b/tools/testing/selftests/mm/pagemap_ioctl.c
>>>> index 2cb5441f29c7..67a7a3705604 100644
>>>> --- a/tools/testing/selftests/mm/pagemap_ioctl.c
>>>> +++ b/tools/testing/selftests/mm/pagemap_ioctl.c
>>>> @@ -1056,7 +1056,6 @@ int sanity_tests(void)
>>>>        struct page_region *vec;
>>>>        char *mem, *fmem;
>>>>        struct stat sbuf;
>>>> -    char *tmp_buf;
>>>>          /* 1. wrong operation */
>>>>        mem_size = 10 * page_size;
>>>> @@ -1167,8 +1166,9 @@ int sanity_tests(void)
>>>>        if (fmem == MAP_FAILED)
>>>>            ksft_exit_fail_msg("error nomem %d %s\n", errno,
>>>> strerror(errno));
>>>>    -    tmp_buf = malloc(sbuf.st_size);
>>>> -    memcpy(tmp_buf, fmem, sbuf.st_size);
>>>> +    /* Fault in every page by reading the first byte */
>>>> +    for (i = 0; i < sbuf.st_size; i += page_size)
>>>> +        (void)*(volatile char *)(fmem + i);
>>>
>>> We have FORCE_READ() in vm_util.h for this. Perhaps that would be
>>> better?
>>
>> Agreed, and if we have multiple patterns where we want to force_read a
>> bigger area, maybe we should provide a helper for that?
> 
> I've found just a couple of cases where FORCE_READ() is used for a
> larger area (in hugetlb-madvise.c and split_huge_page_test.c). The step
> size isn't the same in any of these cases though. We could have
> something like fault_area(addr, size, step) but maybe the loops are
> clear enough already?

Note that even for hugtlb we can read page-per-page, no need to 
hugetlb-page-per-hugetlb-page. Not sure if the performance change would 
make any real performance difference in this testing code.

-- 
Cheers

David

