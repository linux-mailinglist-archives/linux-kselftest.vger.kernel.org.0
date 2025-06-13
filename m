Return-Path: <linux-kselftest+bounces-34854-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D20A9AD8074
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Jun 2025 03:46:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 518313A426C
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Jun 2025 01:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C814C1A314F;
	Fri, 13 Jun 2025 01:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="jz70MgVY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out199-7.us.a.mail.aliyun.com (out199-7.us.a.mail.aliyun.com [47.90.199.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C24EB72636;
	Fri, 13 Jun 2025 01:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.199.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749779214; cv=none; b=deMp2DVSMwQEGH69VNlElWPICMzb7q3Uu+Z1ruTXSsNuT7poRmB+NwVh/lNx2mw9O+ReC9MnVTbphJtiPm+JeUBf1vd7+iSRuU1Fcvr6FQ+IaqOpemFpFvVsKDTEQlaHOPjUvaF8kikZUvQAs/qZGsVIiaYesnR/RMouNICpJoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749779214; c=relaxed/simple;
	bh=E0r94BR3E6A0HCGt3cREJiiePlVg/qmmZSqcR0FneOU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N5p/hRAIpzHFx4pOJ28geZzok4/Dnpx8YqaCXyDArmeewGtlx6WVZvEhe5B94tTqYr6gCNtuxJwjSkduyYIOgWwdP1H12AcAw0Bm601sP/38kZsAsb+ndIxOnxMucA8+RO0+c6t8dzj2beDavhOEkJnvp1CO5RNvfa6iaURSDak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=jz70MgVY; arc=none smtp.client-ip=47.90.199.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1749779194; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=CSzFqjAOdYOhtCVpEGFFODIRgXuSQjCJncahjlXIPOY=;
	b=jz70MgVYyiYpxaOzwt7VFlXT7nxkmfp9DoJJDiMH0KyCQUZ9cOd98j5lByJS3/OkXg7lnhx6Zis1NgZmPSxLjAl5ww5W49GT4vqJB1T51XyZsiFgKWgPUqpFy78l5MnyCzgk+Iq/9dmN4xn+fNYJzFuniOMWRPKMfoFVuG5rruM=
Received: from 30.74.144.147(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0Wdic67h_1749778874 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 13 Jun 2025 09:41:15 +0800
Message-ID: <28221305-14de-4e46-a9f4-8bf90c7b32c0@linux.alibaba.com>
Date: Fri, 13 Jun 2025 09:41:14 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] selftests: khugepaged: fix the shmem collapse failure
To: Zi Yan <ziy@nvidia.com>
Cc: akpm@linux-foundation.org, david@redhat.com, lorenzo.stoakes@oracle.com,
 Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com,
 dev.jain@arm.com, baohua@kernel.org, shuah@kernel.org, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <c16d1d452aa876b449324d12df6465677158a711.1749697399.git.baolin.wang@linux.alibaba.com>
 <AFC17CA1-DF5A-48F0-8E63-E139005F5880@nvidia.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <AFC17CA1-DF5A-48F0-8E63-E139005F5880@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/6/12 23:46, Zi Yan wrote:
> On 11 Jun 2025, at 23:54, Baolin Wang wrote:
> 
>> When running the khugepaged selftest for shmem (./khugepaged all:shmem),
>> I encountered the following test failures:
>> "
>> Run test: collapse_full (khugepaged:shmem)
>> Collapse multiple fully populated PTE table.... Fail
>> ...
>> Run test: collapse_single_pte_entry (khugepaged:shmem)
>> Collapse PTE table with single PTE entry present.... Fail
>> ...
>> Run test: collapse_full_of_compound (khugepaged:shmem)
>> Allocate huge page... OK
>> Split huge page leaving single PTE page table full of compound pages... OK
>> Collapse PTE table full of compound pages.... Fail
>> "
>>
>> The reason for the failure is that, it will set MADV_NOHUGEPAGE to prevent
>> khugepaged from continuing to scan shmem VMA after khugepaged finishes
>> scanning in the wait_for_scan() function. Moreover, shmem requires a refault
>> to establish PMD mappings.
>>
>> However, after commit 2b0f922323cc, PMD mappings are prevented if the VMA is
> 
> Can you add the title of the commit? It is easier to understand the context.
> 
> 2b0f922323cc ("mm: don't install PMD mappings when THPs are disabled by the hw/process/vma")

Sure.

> 
>> set with MADV_NOHUGEPAGE flag, so shmem cannot establish PMD mappings during
>> refault.
>>
>> To fix this issue, we can set the MADV_NOHUGEPAGE flag after the shmem refault.
>> With this fix, the shmem test case passes.
>>
>> Fixes: 2b0f922323cc ("mm: don't install PMD mappings when THPs are disabled by the hw/process/vma")
>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>> ---
>>   tools/testing/selftests/mm/khugepaged.c | 3 +--
>>   1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/tools/testing/selftests/mm/khugepaged.c b/tools/testing/selftests/mm/khugepaged.c
>> index 8a4d34cce36b..d462f62d8116 100644
>> --- a/tools/testing/selftests/mm/khugepaged.c
>> +++ b/tools/testing/selftests/mm/khugepaged.c
>> @@ -561,8 +561,6 @@ static bool wait_for_scan(const char *msg, char *p, int nr_hpages,
>>   		usleep(TICK);
>>   	}
>>
>> -	madvise(p, nr_hpages * hpage_pmd_size, MADV_NOHUGEPAGE);
>> -
>>   	return timeout == -1;
>>   }
>>
> I assume you are going to just remove this madvise based on your discussion
> with David. With that, feel free to add Reviewed-by: Zi Yan <ziy@nvidia.com>

Thanks.

