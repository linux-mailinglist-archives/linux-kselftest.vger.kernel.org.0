Return-Path: <linux-kselftest+bounces-34810-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB351AD6F53
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Jun 2025 13:46:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 996E516C8CC
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Jun 2025 11:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77C4B1442F4;
	Thu, 12 Jun 2025 11:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SNAHWRfE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B82492F432D
	for <linux-kselftest@vger.kernel.org>; Thu, 12 Jun 2025 11:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749728763; cv=none; b=hKW1KzwzyztIZfX/ZmAs6NS1dEiWPH1/tl3qYbwT0MTU3d70NIVJb+ICA4uX0U2o1hs2i1KB0BnYEZbK1zl3l/lFUztB8ThzXZlNgiayr1Qqj94qF8FBcu/duFAeOluZCFe6PV3/XI4L3x3kThyaz7aDe7eJtOCXGv61Su53xuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749728763; c=relaxed/simple;
	bh=NxzUkoX4YGmqxvw5PZtT0t3w5UUtTn07IM8Xo5Tt8fg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=carctj75E0z/b3j8V+h/gTa7xwsy4wUSEqk/TL7mRqThPp6Xx475ZMJHvaFIL3ms+x/6O+jxbTfk/F9uepbna7MD6iuPRcHGYEPY4Dz8RegQEOnqnQA/RuPXquLw3P9AuOj+GUOOk1hHcaE84k2xURDLFgpZ8dg07JWIY8RPv8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SNAHWRfE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749728760;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=NUBrU3Jg/CUyUUQEu0p/rtlfQN+OSb9bogSo5pDhUjs=;
	b=SNAHWRfEvhfoqP4ZtZabDXWQ1ysgwLBuCWqcd4TDKbKcbAd2w3+ncbTOtWCej5dNlmUSWq
	pC+01A3208m8CxkfSinp8bdUCegfcnHiu2OpTxufPJ+3PWBvqBx7VocS10ZdcsAI18/Mfu
	EuDXI4ltXUlP3qNcB3/Lz7pf+4fxCE0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-80-zgplklxKPB-P5rQW3V7u3g-1; Thu, 12 Jun 2025 07:45:59 -0400
X-MC-Unique: zgplklxKPB-P5rQW3V7u3g-1
X-Mimecast-MFC-AGG-ID: zgplklxKPB-P5rQW3V7u3g_1749728758
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3a4f6ff23ccso531850f8f.2
        for <linux-kselftest@vger.kernel.org>; Thu, 12 Jun 2025 04:45:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749728758; x=1750333558;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NUBrU3Jg/CUyUUQEu0p/rtlfQN+OSb9bogSo5pDhUjs=;
        b=e4Jb/n/Y5fQ8dVL7ZYXOexyqaCdy/4fm1Hg28fYCl7lSaHEF47QdqAASUOE51309bX
         e/ZaEJyTG220wypm23JsdWHUdxAcFS/sPj6Q2qAM0T79jQJ6FYWJCxCSnBe6DyISloh+
         uhz/DzYIzJXV0E1ydeDWrCBpJkGOBTb9GYeLKLNH59XL4juFHD0YcxM7OzhsqJpd/wQ0
         iO3aeeYACo9xWmbLAksR6j/bAQxTXzvLs+mPAEGUaCl4ppaecvMuj3hFPTCbQXZOBgm/
         +R7NaCqfvp9EoLbxRvDdyvavGPdBZm8abedzB5lCZ7a8OrTTreJxFyddEq9FU5TscRvr
         8lig==
X-Forwarded-Encrypted: i=1; AJvYcCXQe4osObMJoypgoZ5H7YfZwh5XmrGm0tO1wGejse7SeeyLDAWpaA+yjEmZQ9SsG7n6OsGlteL3sQqeB5ZCrOc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz88c9zuvm9br5t2YvBRwqyor/pH2CnBa0s2nax6lVAgixLrONN
	/5jfA/ZoSCwfPHXIYKJhdG2SthycYHs8ni2KUAxT5sCLrZxhwe/4yB5cYlMOxT2iuqSD6pBlD06
	MQOArCKtloCmIrFtRQYUtqph+MUI70NhjfO75dOJshOePPXLdqAa8oAAi2D+2DFXjZR6PZA==
X-Gm-Gg: ASbGncusmbJh9xRBRM0EuoEVzt1ZfooQ2cGl5ek5L0isArsJUGG0Nyp6e449HKfD8rB
	QdbfAv+UVcQ7BiTZSv8wCX24uKBOA8auofxWwqe7LC6dGKOIRk3H2fm5LukzBxetk5VFZBxn0sR
	A3nXQ2Pi0doaB3ivATeQFRWzNKxQjG4SxBdghMKeWhFgAYofgAutEsTyt1tY4D4sB9C12jJVwYN
	Oc73jLN2/HPNInQy3DJO9b+v5QE8869tLrPW85f6hNt43bsbrWuCR9wSQoC3aPOs1t5duU9TXTU
	/WtNPhGs3GXPqrSaa7xM9pTU/Xji836dzl2hepZp3NGFuVHucWNVPg==
X-Received: by 2002:a05:6000:26c5:b0:3a4:d0fe:428a with SMTP id ffacd0b85a97d-3a558a27540mr6070611f8f.28.1749728758304;
        Thu, 12 Jun 2025 04:45:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGqazLFzdFqusR3OLSoTLzy3FePbxbU+q7iXp0Vbp++hFW1qVgR9Y3DMj1guKzAU7taGVv88w==
X-Received: by 2002:a05:6000:26c5:b0:3a4:d0fe:428a with SMTP id ffacd0b85a97d-3a558a27540mr6070581f8f.28.1749728757938;
        Thu, 12 Jun 2025 04:45:57 -0700 (PDT)
Received: from [192.168.3.141] (p4fe0f8a8.dip0.t-ipconnect.de. [79.224.248.168])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a56199aa52sm1772249f8f.36.2025.06.12.04.45.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Jun 2025 04:45:57 -0700 (PDT)
Message-ID: <6ceb38ce-c16d-48f2-baca-fef79f8fc058@redhat.com>
Date: Thu, 12 Jun 2025 13:45:56 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] selftests: khugepaged: fix the shmem collapse failure
To: Baolin Wang <baolin.wang@linux.alibaba.com>, akpm@linux-foundation.org
Cc: lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, npache@redhat.com,
 ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org, shuah@kernel.org,
 ziy@nvidia.com, linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <c16d1d452aa876b449324d12df6465677158a711.1749697399.git.baolin.wang@linux.alibaba.com>
 <e06530f6-5c2e-4b6f-b175-c7aaab79aa4e@redhat.com>
 <42b76dbc-d1a1-4d00-b139-c50e0abf8b0c@linux.alibaba.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <42b76dbc-d1a1-4d00-b139-c50e0abf8b0c@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12.06.25 13:37, Baolin Wang wrote:
> 
> 
> On 2025/6/12 18:08, David Hildenbrand wrote:
>> On 12.06.25 05:54, Baolin Wang wrote:
>>> When running the khugepaged selftest for shmem (./khugepaged all:shmem),
>>
>> Hmm, this combination is not run automatically through run_tests.sh,
>> right? IIUC, it only runs "./khugepaged" which tests anon only ...
>>
>> Should we add it there? Then I would probably have noticed that myself
>> earlier :)
> 
> Yes, see patch 2.

Yes, was pleasantly surprised when I found that :)

> 
>>> I encountered the following test failures:
>>> "
>>> Run test: collapse_full (khugepaged:shmem)
>>> Collapse multiple fully populated PTE table.... Fail
>>> ...
>>> Run test: collapse_single_pte_entry (khugepaged:shmem)
>>> Collapse PTE table with single PTE entry present.... Fail
>>> ...
>>> Run test: collapse_full_of_compound (khugepaged:shmem)
>>> Allocate huge page... OK
>>> Split huge page leaving single PTE page table full of compound
>>> pages... OK
>>> Collapse PTE table full of compound pages.... Fail
>>> "
>>>
>>> The reason for the failure is that, it will set MADV_NOHUGEPAGE to
>>> prevent
>>> khugepaged from continuing to scan shmem VMA after khugepaged finishes
>>> scanning in the wait_for_scan() function. Moreover, shmem requires a
>>> refault
>>> to establish PMD mappings.
>>>
>>> However, after commit 2b0f922323cc, PMD mappings are prevented if the
>>> VMA is
>>> set with MADV_NOHUGEPAGE flag, so shmem cannot establish PMD mappings
>>> during
>>> refault.
>>
>> Right. It's always problematic when we have some contradicting
>> information in the VMA vs. pagecache.
>>
>>>
>>> To fix this issue, we can set the MADV_NOHUGEPAGE flag after the shmem
>>> refault.
>>> With this fix, the shmem test case passes.
>>>
>>> Fixes: 2b0f922323cc ("mm: don't install PMD mappings when THPs are
>>> disabled by the hw/process/vma")
>>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>>> ---
>>>    tools/testing/selftests/mm/khugepaged.c | 3 +--
>>>    1 file changed, 1 insertion(+), 2 deletions(-)
>>>
>>> diff --git a/tools/testing/selftests/mm/khugepaged.c
>>> b/tools/testing/selftests/mm/khugepaged.c
>>> index 8a4d34cce36b..d462f62d8116 100644
>>> --- a/tools/testing/selftests/mm/khugepaged.c
>>> +++ b/tools/testing/selftests/mm/khugepaged.c
>>> @@ -561,8 +561,6 @@ static bool wait_for_scan(const char *msg, char
>>> *p, int nr_hpages,
>>>            usleep(TICK);
>>>        }
>>> -    madvise(p, nr_hpages * hpage_pmd_size, MADV_NOHUGEPAGE);
>>> -
>>>        return timeout == -1;
>>>    }
>>> @@ -585,6 +583,7 @@ static void khugepaged_collapse(const char *msg,
>>> char *p, int nr_hpages,
>>>        if (ops != &__anon_ops)
>>>            ops->fault(p, 0, nr_hpages * hpage_pmd_size);
>>> +    madvise(p, nr_hpages * hpage_pmd_size, MADV_NOHUGEPAGE);
>>>        if (ops->check_huge(p, expect ? nr_hpages : 0))
>>>            success("OK");
>>>        else
>>
>> It's a shame we have this weird interface: there is no way we can clear
>> VM_HUGEPAGE without setting VM_NOHUGEPAGE :(
> 
> Right.
> 
>> But, do we even care about setting MADV_NOHUGEPAGE at all? IIUC, we'll
>> almost immediately later call cleanup_area() where we munmap(), right?
> 
> I tested removing the MADV_NOHUGEPAGE setting, and the khugepaged test
> cases all passed.
> 
> However, a potential impact of removing MADV_NOHUGEPAGE is that,
> khugepaged might report 'timeout', but check_huge() would still report
> 'success' (assuming khugepaged tries to scan the VMA and successfully
> collapses it after the timeout). Such test result could be confusing.

If we run into the timeout, we return "true" from wait_for_scan(), and 
in khugepaged_collapse() returns immediately.

So we wouldn't issue another check_huge() call in khugepaged_collapse().

Did I miss something?


-- 
Cheers,

David / dhildenb


