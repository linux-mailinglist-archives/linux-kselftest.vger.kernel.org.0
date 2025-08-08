Return-Path: <linux-kselftest+bounces-38569-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ED2F7B1EA5B
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Aug 2025 16:26:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA89B1C259E3
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Aug 2025 14:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EC13274651;
	Fri,  8 Aug 2025 14:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Q9TPlsC+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4882B13C9C4;
	Fri,  8 Aug 2025 14:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754663172; cv=none; b=djaft2FR9EA/yy1uN3S1SY27izI1B0jZD27VHHnFOMWazfbnD6o7Xnl3p4rUDee4H24LdiOpQjBeaFCCo2p2SRyg0zNAPHYqCbIiQgeInIyhaUawvJ7bZ/QSUPjGyysYnc340FD/Nip75HiIGGVJPk1WmyN7AEnDvWSaBw3jjnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754663172; c=relaxed/simple;
	bh=yPFoBGMlkaCLr/CMbEd5c2uQ1Kz0vUPVyy1Ha3juT/4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zvwkp/ePvkeMJOefUHpYaA+8XGIcViYfWkK8xF7z2Ou8//mWZTEDho1IvWwK62BhTe/lzypSZAPakQYSP++N1YbVap50fCQxig23qqq/5l0tL4iGZ+foDVCYBH3LIkLBEjgk3P8PRTc1noxD0FlcmQuM7wr29nvOB/uWz0eJKeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Q9TPlsC+; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5784flYJ012384;
	Fri, 8 Aug 2025 14:25:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=7NG8/+
	w/52idpKiJVVKZI/m2F7CfWPBDXpzCJ/SudBs=; b=Q9TPlsC+gn/lUJHJcpd0Li
	Gap4wvFYnsq6h4AikW/L0SMzezlEgPd5ppqGiXnyOcUmnffY2UeLhplu0ijYcPtc
	tAsVHPc8S20rA7jVwx7XzERjx/iZl/nAN3nFlryRDL4oMCmq72D4w0xlH0HDg6V3
	oHv3jrUnkmu9W2lqibTk7eRUyZdvZGP4N8vmwEwk/xrGu6nEdabJStcmI7O1594N
	YJ5Dqsp5Xc3XriUo+ddsxrWyTBlKUhWFBqf44oqYqSUij85OVjq9/+dxf7s8zyZg
	XS9Rubl/PrPfNIMIeWk/Y9flD7QkqexfpW4oXJhpXSaOxXdmJW6t3gexvuJB3gdA
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48bq640hrd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Aug 2025 14:25:46 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 578E4W3C009844;
	Fri, 8 Aug 2025 14:25:46 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48bq640hra-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Aug 2025 14:25:46 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 578B71AR022687;
	Fri, 8 Aug 2025 14:25:45 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 48bpwqnyxw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Aug 2025 14:25:45 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 578EPi3S24642140
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 8 Aug 2025 14:25:44 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7B0555805D;
	Fri,  8 Aug 2025 14:25:44 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D195158059;
	Fri,  8 Aug 2025 14:25:38 +0000 (GMT)
Received: from [9.109.245.113] (unknown [9.109.245.113])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  8 Aug 2025 14:25:38 +0000 (GMT)
Message-ID: <c237c703-3ed6-4d7d-aaff-bd6291f9220f@linux.ibm.com>
Date: Fri, 8 Aug 2025 19:55:37 +0530
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/7] selftest/mm: Fix ksm_funtional_test failures
To: Wei Yang <richard.weiyang@gmail.com>
Cc: Aboorva Devarajan <aboorvad@linux.ibm.com>, akpm@linux-foundation.org,
        Liam.Howlett@oracle.com, lorenzo.stoakes@oracle.com, shuah@kernel.org,
        pfalcato@suse.de, david@redhat.com, ziy@nvidia.com,
        baolin.wang@linux.alibaba.com, npache@redhat.com, ryan.roberts@arm.com,
        dev.jain@arm.com, baohua@kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        ritesh.list@gmail.com
References: <20250729053403.1071807-1-aboorvad@linux.ibm.com>
 <20250729053403.1071807-4-aboorvad@linux.ibm.com>
 <20250804091141.ifwryfmgjepwrog4@master>
 <20fb853c-7d79-4d26-9c8a-f6ce9367d424@linux.ibm.com>
 <20250805170353.6vlbyg6qn5hv4yzz@master>
 <e9079694-1e30-46b6-97e7-b79be01c65a6@linux.ibm.com>
 <20250806145432.nygrslkiyvzulujn@master>
 <111d2351-3fb7-4011-af07-78b40874d956@linux.ibm.com>
 <20250808025804.b7cv47gcq2yscka7@master>
Content-Language: en-US
From: Donet Tom <donettom@linux.ibm.com>
In-Reply-To: <20250808025804.b7cv47gcq2yscka7@master>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA4MDExMyBTYWx0ZWRfX2pIhAuhRAYIw
 veiyNyiMhbz5xNVYUaMjnYk6lwUYWMlt3GprENzigfyNRCS4HUsfo0xPumZTg5y6+CjWQvt+Oo/
 jwCzFS+K0yzd4kmcmwmmdfy8Ed0IHxGiPE7uJkK2+sELwCloyaDdPv1zYwiKI3MGn8jQUglqmVU
 DjFhcfm/loV3nUJAv8/kou1ID3m+RpN/fSoU1nki9aQ7G1dgGdXLJYwBHGGlvJa21xVtV/sorZh
 7JiSXvSDHWQaryMf4bWBFvoGJZHcN/+PPJ1cKd+1kYDfd2VAX9rm7itbzDp36wKNBdydDITtqWS
 Z7wQmazprLMnSXf64jN27shROygrFnkPEPadM+t+FXd8QAp6+I8sSllgqUlhlcdYOvfB56q5YoQ
 bdFsB2b9fkRKPwX46VubyoIgq8D82l4yeb12vIclFwTXILu6jVXXVmfev0Iubv9G8JATXraj
X-Proofpoint-ORIG-GUID: ajx5j68b4sziG6t_CyVZ2iyhE7AMfkxU
X-Authority-Analysis: v=2.4 cv=LreSymdc c=1 sm=1 tr=0 ts=689608ea cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=1k-Y_4iKrBSBoghwKMkA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: HpiSBDbHRUtx0WfmyQLVjmtXEHVUYkAW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-08_04,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0 spamscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 mlxlogscore=999 bulkscore=0
 malwarescore=0 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2507300000
 definitions=main-2508080113


On 8/8/25 8:28 AM, Wei Yang wrote:
> On Thu, Aug 07, 2025 at 02:56:28PM +0530, Donet Tom wrote:
>> On 8/6/25 8:24 PM, Wei Yang wrote:
>>> On Wed, Aug 06, 2025 at 06:30:37PM +0530, Donet Tom wrote:
>>> [...]
>>>>> Child process inherit the ksm_merging_pages from parent, which is reasonable
>>>>> to me. But I am confused why ksm_unmerge() would just reset ksm_merging_pages
>>>>> for parent and leave ksm_merging_pages in child process unchanged.
>>>>>
>>>>> ksm_unmerge() writes to /sys/kernel/mm/ksm/run, which is a system wide sysfs
>>>>> interface. I expect it applies to both parent and child.
>>>> I am not very familiar with the KSM code, but from what I understand:
>>>>
>>>> The ksm_merging_pages counter is maintained per mm_struct. When
>>>> we write to /sys/kernel/mm/ksm/run, unmerging is triggered, and the
>>>> counters are updated for all mm_structs present in the ksm_mm_slot list.
>>>>
>>>> A mm_struct gets added to this list  when MADV_MERGEABLE is called.
>>>> In the case of the child process, since MADV_MERGEABLE has not been
>>>> invoked yet, its mm_struct is not part of the list. As a result,
>>>> its ksm_merging_pages counter is not reset.
>>>>
>>> Would this flag be inherited during fork? VM_MERGEABLE is saved in related vma
>>> I don't see it would be dropped during fork. Maybe missed.
>>>
>>>>>> value remained unchanged. That’s why get_my_merging_page() in the child was
>>>>>> returning a non-zero value.
>>>>>>
>>>>> I guess you mean the get_my_merging_page() in __mmap_and_merge_range() return
>>>>> a non-zero value. But there is ksm_unmerge() before it. Why this ksm_unmerge()
>>>>> couldn't reset the value, but a ksm_unmerge() in parent could.
>>>>>
>>>>>> Initially, I fixed the issue by calling ksm_unmerge() before the fork(), and
>>>>>> that
>>>>>> resolved the problem. Later, I decided it would be cleaner to move the
>>>>>> ksm_unmerge() call to the test cleanup phase.
>>>>>>
>>>>> Also all the tests before test_prctl_fork(), except test_prctl(), calls
>>>>>
>>>>>      ksft_test_result(!range_maps_duplicates());
>>>>>
>>>>> If the previous tests succeed, it means there is no duplicate pages. This
>>>>> means ksm_merging_pages should be 0 before test_prctl_fork() if other tests
>>>>> pass. And the child process would inherit a 0 ksm_merging_pages. (A quick test
>>>>> proves it.)
>>>> If I understand correctly, all the tests are calling MADV_UNMERGEABLE,
>>>> which internally calls break_ksm() in the kernel. This function replaces the
>>>> KSM page with an exclusive anonymous page. However, the
>>>> ksm_merging_pages counters are not updated at this point.
>>>>
>>>> The function range_maps_duplicates(map, size) checks whether the pages
>>>> have been unmerged. Since break_ksm() does perform the unmerge, this
>>>> function returns false, and the test passes.
>>>>
>>>> The ksm_merging_pages update happens later via the ksm_scan_thread().
>>>> That’s why we observe that ksm_merging_pages values are not reset
>>>> immediately after the test finishes.
>>>>
>>> Not familiar with ksm internal. But the ksm_merging_pages counter still has
>>> non-zero value when all merged pages are unmerged makes me feel odd.
>>>
>>>> If we add a sleep(1) after the MADV_UNMERGEABLE call, we can see that
>>>> the ksm_merging_pages values are reset after the sleep.
>>>>
>>>> Once the test completes successfully, we can call ksm_unmerge(), which
>>>> will immediately reset the ksm_merging_pages value. This way, in the fork
>>>> test, the child process will also see the correct value.
>>>>> So which part of the story I missed?
>>>>>
>>>> So, during the cleanup phase after a successful test, we can call
>>>> ksm_unmerge() to reset the counter. Do you see any issue with
>>>> this approach?
>>>>
>>> It looks there is no issue with an extra ksm_unmerge().
>>>
>>> But one more question. Why an extra ksm_unmerge() could help.
>>>
>>> Here is what we have during test:
>>>
>>>
>>>     test_prot_none()
>>>         !range_maps_duplicates()
>>>         ksm_unmerge()                  1) <--- newly add
>>>     test_prctl_fork()
>>>         >--- in child
>>>         __mmap_and_merge_range()
>>>             ksm_unmerge()              2) <--- already have
>>>
>>> As you mentioned above ksm_unmerge() would immediately reset
>>> ksm_merging_pages, why ksm_unmerge() at 2) still leave ksm_merging_pages
>>> non-zero? And the one at 1) could help.
>>
> >From the debugging, what I understood is:
>> When we perform fork(), MADV_MERGEABLE, or PR_SET_MEMORY_MERGE, the
>> mm_struct of the process gets added to the ksm_mm_slot list. As a
>> result, both the parent and child processes’ mm_struct structures
>> will be present in ksm_mm_slot.
>>
>> When KSM merges the pages, it creates a ksm_rmap_item for each page,
>> and the ksm_merging_pages counter is incremented accordingly.
>>
>> Since the parent process did the merge, its mm_struct is present in
>> ksm_mm_slot, and ksm_rmap_item entries are created for all the merged
>> pages.
>>
>> When a process is forked, the child’s mm_struct is also added to
>> ksm_mm_slot, and it inherits the ksm_merging_pages count. However,
>> no ksm_rmap_item entries are created for the child process because it
>> did not do any merge.
>>
>> When ksm_unmerge() is called, it iterates over all processes in
>> ksm_mm_slot. In our case, both the parent and child are present. It
>> first processes the parent, which has ksm_rmap_item entries, so it
>> unmerges the pages and resets the ksm_merging_pages counter.
>>
>> For the child, since it did not perform any actual merging, it does not
>> have any ksm_rmap_item entries. Therefore, there are no pages to unmerge,
>> and the counter remains unchanged.
>>
> Thanks for the detailed analysis.
>
> So the key is child has no ksm_rmap_item which will not clear ksm_merging_page
> on ksm_unmerge().
>
>> So, only processes that performed KSM merging will have their counters
>> updated during ksm_unmerge(). The child process, having not initiated any
>> merging, retains the inherited counter value without any update.
>>
>> So from a testing point of view, I think it is better to reset the
>> counters as part of the cleanup code to ensure that the next tests do
>> not get incorrect values.
>>
> Hmm... I agree from the test point of view based on current situation.
>
> While maybe this is also a check point for later version.

Are you okay to proceed with the current patch in this series?

>
>> The question I have is: is it correct to keep the inherited
>> |ksm_merging_page|
>> value in the child or Should we reset it to 0 during |ksm_fork()|?
>>
> Very good question. There looks to be something wrong, but I am not sure this
> is the correct way.

ok.

I am going through it and will come up with a fix along with a test for 
this scenario. I will post it as a separate series.


>
>>> Or there is still some timing issue like sleep(1) you did?
>>>

