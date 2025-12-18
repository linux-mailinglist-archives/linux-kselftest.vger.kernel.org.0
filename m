Return-Path: <linux-kselftest+bounces-47685-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A270CCAC46
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Dec 2025 09:05:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F046F30232B8
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Dec 2025 08:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C58E42E8B66;
	Thu, 18 Dec 2025 08:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ly158k2o"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D37C2459ED;
	Thu, 18 Dec 2025 08:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766045131; cv=none; b=NoLgiuHdpkDmGs91VRdX+x7EdzNnu0jP5t/7Oqjx0zZdc/bWbAlEoE4jNgD5jnJAxuUVXGNT0CTnkqtKwVmwke4KPBJ3kisQKhrnRy3JNm2LXHl/OU/RQItKHlxO8hGchAH0zXStY8DiwG4JUqrBIB3qCYKNi9BET1X1sraC/68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766045131; c=relaxed/simple;
	bh=OzSTS8I7zeGFfn+9aQoFwN8O+cmLb6QBvAXAvMo9Ucs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rZQk/x2rwdk0bK0cs6Sgj114zMDm/0fKwDczCllkkzANUoIUCf+3VHhfBctSJgxIOBdV2OfcItOkf+ygfc3FoR22j6dRJFPeTFi/ujUFWQn7D+MHKe5Eny03vmmLQBxQiCYHl8OL6sCAGXRU/n/qcGxYZyUotwUPsiVGF6Gn34M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ly158k2o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15EA0C4CEFB;
	Thu, 18 Dec 2025 08:05:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766045131;
	bh=OzSTS8I7zeGFfn+9aQoFwN8O+cmLb6QBvAXAvMo9Ucs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Ly158k2otsUXsxGvg+hMLHK6XdetqPckQe980NBs5BY+zeog2Ysm0rMLTxUR1xmmq
	 Lgyrf96RU2TY79qsWp9dH7QjNC+lyBGTOYaVFGbidHlB0ci74xRtDrO0u43ioFqhVG
	 umLnwu9NFs/nq84gi2yBVjR0ps7YmTwFcXykBRNR/aoFwFr3mdejAucpCJchzNAOOH
	 cpoLvN5RU4E7HrGGT1myxrSe4A++/WmufZPPel1aYw9e1PQAuhyhWfFli3n7hMNXMP
	 KMnhCPxrQsuW7BO1/19blQi8ghAKjBfISLuFefKKWc7R+OoAZGnot2H0pGULjyN9fy
	 IY/gLIGP8D3lg==
Message-ID: <6aa47cdb-d2e7-4977-929b-7019b6f991c1@kernel.org>
Date: Thu, 18 Dec 2025 09:05:27 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] selftests/mm: fix faulting-in code in pagemap_ioctl
 test
To: Ryan Roberts <ryan.roberts@arm.com>, Kevin Brodsky
 <kevin.brodsky@arm.com>, linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Mark Brown
 <broonie@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Usama Anjum <Usama.Anjum@arm.com>
References: <20251216142633.2401447-1-kevin.brodsky@arm.com>
 <20251216142633.2401447-4-kevin.brodsky@arm.com>
 <37210500-6f6e-46ac-ac2f-ac996308590d@arm.com>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <37210500-6f6e-46ac-ac2f-ac996308590d@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/16/25 15:56, Ryan Roberts wrote:
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
>>   tools/testing/selftests/mm/pagemap_ioctl.c | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/tools/testing/selftests/mm/pagemap_ioctl.c b/tools/testing/selftests/mm/pagemap_ioctl.c
>> index 2cb5441f29c7..67a7a3705604 100644
>> --- a/tools/testing/selftests/mm/pagemap_ioctl.c
>> +++ b/tools/testing/selftests/mm/pagemap_ioctl.c
>> @@ -1056,7 +1056,6 @@ int sanity_tests(void)
>>   	struct page_region *vec;
>>   	char *mem, *fmem;
>>   	struct stat sbuf;
>> -	char *tmp_buf;
>>   
>>   	/* 1. wrong operation */
>>   	mem_size = 10 * page_size;
>> @@ -1167,8 +1166,9 @@ int sanity_tests(void)
>>   	if (fmem == MAP_FAILED)
>>   		ksft_exit_fail_msg("error nomem %d %s\n", errno, strerror(errno));
>>   
>> -	tmp_buf = malloc(sbuf.st_size);
>> -	memcpy(tmp_buf, fmem, sbuf.st_size);
>> +	/* Fault in every page by reading the first byte */
>> +	for (i = 0; i < sbuf.st_size; i += page_size)
>> +		(void)*(volatile char *)(fmem + i);
> 
> We have FORCE_READ() in vm_util.h for this. Perhaps that would be better?

Agreed, and if we have multiple patterns where we want to force_read a 
bigger area, maybe we should provide a helper for that?

-- 
Cheers

David

