Return-Path: <linux-kselftest+bounces-39418-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 452BEB2EA69
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 03:19:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E4535A303E
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 01:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EB901E493C;
	Thu, 21 Aug 2025 01:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="wlZnw6kv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0333636CE02;
	Thu, 21 Aug 2025 01:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755739038; cv=none; b=W2TaNZr5ZZgH1ZvBqUqcAARdq21G9fKxAPLPhvPuR5aTHz3nR69KMMI0du0a7HfoKGiM/U9n5w25yvrIWRndYhUQNPvkzh0rA56a0yrVDMOD9YCHgHO37BdHCHBt+jY/OzZjMIWTapX4AssdDs+l+X+2S/123g79D08RHP90nM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755739038; c=relaxed/simple;
	bh=w/mhTWUbr6/K3ZpBOw6iFBOZ7tUKFPr+Fy1MPDtZFyY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ut72dnrZ4FcY/0Id5LCkncZyJCxTrWv6AOzdsB1x7n8Nl2Zt30hD/Q3/W8adiqAxK+4zDdoRlYJysXgUvwivRJM8Q+t22yIDY0KPSbpIL4+losRhT7B2jQnTjPNpP2x7Ht+umol0O0p70TVR2suCb5nYI0pF7qpRaHvVBDd+UTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=wlZnw6kv; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1755739027; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=Kcy4kiDvfXjZXkr3p+YJ3IZARRcGWf8p3DtdKNM7Prw=;
	b=wlZnw6kv3L93IuGWKFpgFpZrvNt6crSxCtPi/QEu8b3ZHojHqNCD0Gh+jWq2Q0WDFPVw4wEHL0ooB0rLKL74LibaRUWTtODZ0K7kUZ31h2cFb2aSQT7x86F14zvhOT/lOtokuLcx9NAZFY7bOIDaJCOUUKkpz3tBL5tdmDzUIYQ=
Received: from 30.74.144.114(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WmE-6ch_1755738705 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 21 Aug 2025 09:11:46 +0800
Message-ID: <816d77f1-aa8f-4580-b1cd-b8c81f929fdd@linux.alibaba.com>
Date: Thu, 21 Aug 2025 09:11:45 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/5] selftests/mm: add check_after_split_folio_orders()
 helper.
To: Zi Yan <ziy@nvidia.com>
Cc: Wei Yang <richard.weiyang@gmail.com>, wang lian <lianux.mm@gmail.com>,
 David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
 Andrew Morton <akpm@linux-foundation.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Shuah Khan <shuah@kernel.org>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20250818184622.1521620-1-ziy@nvidia.com>
 <20250818184622.1521620-5-ziy@nvidia.com>
 <a81b7fd3-c466-45c9-9374-361b780ce09b@linux.alibaba.com>
 <A5A3C9E5-7E90-4EB4-878F-D5143FE0F349@nvidia.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <A5A3C9E5-7E90-4EB4-878F-D5143FE0F349@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/8/20 21:49, Zi Yan wrote:
> On 20 Aug 2025, at 5:22, Baolin Wang wrote:
> 
>> On 2025/8/19 02:46, Zi Yan wrote:
>>> The helper gathers a folio order statistics of folios within a virtual
>>> address range and checks it against a given order list. It aims to provide
>>> a more precise folio order check instead of just checking the existence of
>>> PMD folios.
>>>
>>> The helper will be used the upcoming commit.
>>>
>>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>>> ---
>>
>> I tested this patch, and it works for me.
>> Tested-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> 
> Thanks.
> 
>>
>> By the way, I moved gather_after_split_folio_orders() to the vm_util.c file as a helper for mTHP collapse checks in my patchset[1]. I'm not sure whether you need to move gather_after_split_folio_orders() to vm_util.c in this patch, or if I should move it in my patchset.
> 
> Feel free to move it in your patchset. My initial version has it in vm_util.c, but
> I realized that its implementation is very limited to folio split check and moved
> it to split_huge_page_test.c. If you find it suitable for your test cases, feel
> free to move it. Just note that the code does not handle memremapped THP, since
> it only checks page flags without checking the PFN. So when a vaddr range is mapped
> to a THP/mTHP head page and some other THP/mTHP tail pages, the code just treats
> the whole vaddr range as if it is mapped to a single THP/mTHP and gets a wrong
> order. After-split folios do not have this concern, so
> gather_after_split_folio_orders() is simplified to not handle such cases.

Thanks for the information. khugepaged also does not have this case, so 
it works well for me.

