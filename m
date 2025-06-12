Return-Path: <linux-kselftest+bounces-34790-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B02FDAD6732
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Jun 2025 07:18:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6CA5188F116
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Jun 2025 05:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55EF619F121;
	Thu, 12 Jun 2025 05:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="s8sUfbk6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B72A08F40;
	Thu, 12 Jun 2025 05:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749705526; cv=none; b=ApJe1ILgKxH+UMibFtAU0vfyXpJnMzivbt+jlAvFbkMawC121lXY86g3mjs1lwVUTpqDPC8zLKIexm7DzzG7Q7bVrgEx4/X4v3FWTsY0Klp8aviw0l93NV3s1QVf0m/Et4aJyb0n0MXq2xjZLG5ug6jji0rAatDYiTXM4MZVUJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749705526; c=relaxed/simple;
	bh=E5YlB2u7S0ZqY9qOmnfCFjhkpjNfWKCju/M+dvlFXx8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XfmkyBi7WXGPkxK4IYualZ7oWFTAznYi3JbArOvrIZwdUgj0TWp2PZd1W+TYHKze8C8h5f0rBeyyr7fKCcL3yDzI+YIne1u9ON9O8fHAlKsYCnGwMB2XsbI0IAeNOCqCS1kKwNSDX/pkHG5K/bkFXyUzvIKn97aSEbu3W64hyys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=s8sUfbk6; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1749705519; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=qsxOidY6ikXbFJ667HOPRMq7JTZQwc/Y4evKhZPM3uo=;
	b=s8sUfbk6TJ3f729grIOhCt11cNwEDWMZFSkjK7vK4OI19KQOq881Px+jx0nE/oJ4nwmTrK1MG1qYERgjN3sw8ki7LT19ffIpZ4v0kc4fZVP5Sut1ieglntdzOyKRGRb3wvMqdBdYPw+4Lam6PfovtT/DTY5M914dBhpWq+0YsMI=
Received: from 30.74.144.123(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0Wdfbpu1_1749705518 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 12 Jun 2025 13:18:38 +0800
Message-ID: <f920fdfe-fa0f-446c-b1cd-08956ec161c3@linux.alibaba.com>
Date: Thu, 12 Jun 2025 13:18:37 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] selftests: khugepaged: fix the shmem collapse failure
To: Dev Jain <dev.jain@arm.com>, akpm@linux-foundation.org, david@redhat.com
Cc: lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, npache@redhat.com,
 ryan.roberts@arm.com, baohua@kernel.org, shuah@kernel.org, ziy@nvidia.com,
 linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <c16d1d452aa876b449324d12df6465677158a711.1749697399.git.baolin.wang@linux.alibaba.com>
 <80218cc2-de6f-49dc-bdee-4b2560c619b5@arm.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <80218cc2-de6f-49dc-bdee-4b2560c619b5@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2025/6/12 13:10, Dev Jain wrote:
> 
> On 12/06/25 9:24 am, Baolin Wang wrote:
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
>> Split huge page leaving single PTE page table full of compound 
>> pages... OK
>> Collapse PTE table full of compound pages.... Fail
>> "
>>
>> The reason for the failure is that, it will set MADV_NOHUGEPAGE to 
>> prevent
>> khugepaged from continuing to scan shmem VMA after khugepaged finishes
>> scanning in the wait_for_scan() function. Moreover, shmem requires a 
>> refault
>> to establish PMD mappings.
>>
>> However, after commit 2b0f922323cc, PMD mappings are prevented if the 
>> VMA is
>> set with MADV_NOHUGEPAGE flag, so shmem cannot establish PMD mappings 
>> during
>> refault.
>>
>> To fix this issue, we can set the MADV_NOHUGEPAGE flag after the shmem 
>> refault.
>> With this fix, the shmem test case passes.
>>
>> Fixes: 2b0f922323cc ("mm: don't install PMD mappings when THPs are 
>> disabled by the hw/process/vma")
>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>> ---
>>   tools/testing/selftests/mm/khugepaged.c | 3 +--
>>   1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/tools/testing/selftests/mm/khugepaged.c 
>> b/tools/testing/selftests/mm/khugepaged.c
>> index 8a4d34cce36b..d462f62d8116 100644
>> --- a/tools/testing/selftests/mm/khugepaged.c
>> +++ b/tools/testing/selftests/mm/khugepaged.c
>> @@ -561,8 +561,6 @@ static bool wait_for_scan(const char *msg, char 
>> *p, int nr_hpages,
>>           usleep(TICK);
>>       }
>> -    madvise(p, nr_hpages * hpage_pmd_size, MADV_NOHUGEPAGE);
>> -
>>       return timeout == -1;
>>   }
>> @@ -585,6 +583,7 @@ static void khugepaged_collapse(const char *msg, 
>> char *p, int nr_hpages,
>>       if (ops != &__anon_ops)
>>           ops->fault(p, 0, nr_hpages * hpage_pmd_size);
>> +    madvise(p, nr_hpages * hpage_pmd_size, MADV_NOHUGEPAGE);
>>       if (ops->check_huge(p, expect ? nr_hpages : 0))
>>           success("OK");
>>       else
> 
> The idea looks sane to me, but do we need to add the madvise call to
> madvise_retracted_page_tables() too, since that also calls wait_for_scan()?

Yes, I also realized this after sending the patches:) Thanks.

To keep the original logic:

diff --git a/tools/testing/selftests/mm/khugepaged.c 
b/tools/testing/selftests/mm/khugepaged.c
index d462f62d8116..3452763e2fe3 100644
--- a/tools/testing/selftests/mm/khugepaged.c
+++ b/tools/testing/selftests/mm/khugepaged.c
@@ -1074,6 +1074,7 @@ static void madvise_retracted_page_tables(struct 
collapse_context *c,
                 return;
         }
         success("OK");
+       madvise(p, nr_hpages * hpage_pmd_size, MADV_NOHUGEPAGE);
         c->collapse("Install huge PMD from page cache", p, nr_hpages, ops,
                     true);
         validate_memory(p, 0, size);

