Return-Path: <linux-kselftest+bounces-36413-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 607B8AF6DFD
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jul 2025 10:59:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EBD51C20227
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jul 2025 08:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 442CE2D3A75;
	Thu,  3 Jul 2025 08:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="HTJP139q"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A4E2D12F4;
	Thu,  3 Jul 2025 08:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751533169; cv=none; b=LseM4fBndVPA3PPU0IMGWyKVj9bwtI7+TJPS16MIRn0M1+x6wjX33X8cFUCkydpDYa+YRsr2/FzPIbjtPgx9VgN5LHc7V/oG8DZpAaztDOh76mAqVWibBeZjkq67d9Zi5m86ZYE+nflcS4gvLOJuw0F1PVqkUyHpU3D6lsxEbOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751533169; c=relaxed/simple;
	bh=2A0GUpNDDtKGvM6AmD6jTgjZnfl30T8wFKIqfw/Y2Ys=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aAnJ67mu6K236D59W3Ax5fRjmxgTyz/Jt55cLSghTF5qIRgSH6ELgS+kJl+zvku0pb5n0fwwL9iZmcFnGZ+DJlrUoRpeGG0Yp48+kPjzlBbgZcAkh0fXGgtfXkmHBOhrheq4ca0K6EpnVT95LIGlF4aQWaQLCBwjOkJT0+2dKTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=HTJP139q; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5630lqfm001087;
	Thu, 3 Jul 2025 08:59:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ijgdEy
	p9oBh3emRjFv1X4HIGEpnqZYi0vcjkbkMBVns=; b=HTJP139qyHfv/hGUOLcaeK
	ZZ3Ju4ayGfiuISIyBly4q0SR0qDVHgZCeVZY/1vOMhQbLvl00Kcw1JGhMwbsKvd5
	usc7kgW70K1vJvcnG0OTYJahQQ7scEUZkyixRpKkQh4d9gyF8SMQM1zn4ffHo110
	GDzfnMHlDdbU1CtkwTzV6+tCGlMNPn51qE20VJwxcEp9dMM+7iWxrF7Q9Fv9K16V
	XGCDbnuAYTFB9ctYbULN3NrQfqal7mKGhKJQ8NP3qjnW1Kb+LW3P6yh+CiN6m/ne
	9b88rnKR6kU1BErVtTwMaRBeqag9NPGvS+d5IxTvdkmvDB5kpGjIdrdxs+4T2jrA
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47j84djkda-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Jul 2025 08:59:09 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 5638x8LE023111;
	Thu, 3 Jul 2025 08:59:08 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47j84djkd3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Jul 2025 08:59:08 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5636oGCJ011803;
	Thu, 3 Jul 2025 08:59:07 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47jv7n3uux-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Jul 2025 08:59:07 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5638x6T919530424
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 3 Jul 2025 08:59:06 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 43CF35805E;
	Thu,  3 Jul 2025 08:59:06 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BFFF158055;
	Thu,  3 Jul 2025 08:59:00 +0000 (GMT)
Received: from [9.109.245.113] (unknown [9.109.245.113])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  3 Jul 2025 08:59:00 +0000 (GMT)
Message-ID: <0e099baa-0a36-4ffd-821f-a7a4856fd52f@linux.ibm.com>
Date: Thu, 3 Jul 2025 14:28:59 +0530
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/7] mm/selftests: Fix split_huge_page_test failure on
 systems with 64KB page size
To: David Hildenbrand <david@redhat.com>,
        Aboorva Devarajan <aboorvad@linux.ibm.com>, akpm@linux-foundation.org,
        Liam.Howlett@oracle.com, lorenzo.stoakes@oracle.com, shuah@kernel.org,
        pfalcato@suse.de, ziy@nvidia.com, baolin.wang@linux.alibaba.com,
        npache@redhat.com, ryan.roberts@arm.com, dev.jain@arm.com,
        baohua@kernel.org
Cc: linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, ritesh.list@gmail.com
References: <20250703060656.54345-1-aboorvad@linux.ibm.com>
 <20250703060656.54345-5-aboorvad@linux.ibm.com>
 <d73f0591-e407-4350-9ddd-dc05ff571a8d@redhat.com>
Content-Language: en-US
From: Donet Tom <donettom@linux.ibm.com>
In-Reply-To: <d73f0591-e407-4350-9ddd-dc05ff571a8d@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: LPheNdXG_tUaEuOhX85dEf3eZPoepz7X
X-Proofpoint-GUID: yNNsKARGwUDr6NdDQvgDzez_yiDBzCMR
X-Authority-Analysis: v=2.4 cv=Ib6HWXqa c=1 sm=1 tr=0 ts=6866465d cx=c_pps a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VnNF1IyMAAAA:8 a=HZMDwHG8fRVm9kfh3eUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAzMDA3MSBTYWx0ZWRfX9r5CEUJSHzAF F5/c/4q3wTH5zdjl1t/7nw7NP3Ts9RLeQcxebvS41SQU1BaYsl7Vlyku06mmN9Qr9m18YzlYiT7 Rz++529kJpM7Fs0/ZnTt0+MBeTizcpls50hloqvsyX+XTIU8Swp14fJ43XLuksr0tjbpPkxeAUv
 o9l2IALjwXLCCKKOYbivu8i1BM6SuploWkMounpHdzUWRhecJRfeB+owhMNzmevNI4dZhjyT/vN 3ei3BhfhP9jN5VSYsrf7c7Z0LIORoHMJK72NT7ASDMn0ONpam3smmkRklDtwl0fI124h7fnEU1U WpZqxwTd3yjzNEeq9UPc2PFcw7xELB+260WqIw2NB02Qlmue0JCASxAJuqTfF+63Xiau966NSab
 IA7fBpKiZEGMHL0nCwPE1uwDJ1YDvnfn7kmyb8bjGMFU9SgVD9sJ/VVzsMdhgs5bp+2QxFiD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-03_02,2025-07-02_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 suspectscore=0
 clxscore=1015 mlxlogscore=999 lowpriorityscore=0 impostorscore=0
 mlxscore=0 malwarescore=0 spamscore=0 priorityscore=1501 adultscore=0
 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507030071


On 7/3/25 1:52 PM, David Hildenbrand wrote:
> On 03.07.25 08:06, Aboorva Devarajan wrote:
>> From: Donet Tom <donettom@linux.ibm.com>
>>
>> The split_huge_page_test fails on systems with a 64KB base page size.
>> This is because the order of a 2MB huge page is different:
>>
>> On 64KB systems, the order is 5.
>>
>> On 4KB systems, it's 9.
>>
>> The test currently assumes a maximum huge page order of 9, which is only
>> valid for 4KB base page systems. On systems with 64KB pages, attempting
>> to split huge pages beyond their actual order (5) causes the test to 
>> fail.
>>
>> In this patch, we calculate the huge page order based on the system's 
>> base
>> page size. With this change, the tests now run successfully on both 64KB
>> and 4KB page size systems.
>>
>> Fixes: fa6c02315f745 ("mm: huge_memory: a new debugfs interface for 
>> splitting THP tests")
>> Signed-off-by: Donet Tom <donettom@linux.ibm.com>
>> Signed-off-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
>> ---
>>   .../selftests/mm/split_huge_page_test.c       | 23 ++++++++++++++-----
>>   1 file changed, 17 insertions(+), 6 deletions(-)
>>
>> diff --git a/tools/testing/selftests/mm/split_huge_page_test.c 
>> b/tools/testing/selftests/mm/split_huge_page_test.c
>> index aa7400ed0e99..38296a758330 100644
>> --- a/tools/testing/selftests/mm/split_huge_page_test.c
>> +++ b/tools/testing/selftests/mm/split_huge_page_test.c
>> @@ -514,6 +514,15 @@ void split_thp_in_pagecache_to_order_at(size_t 
>> fd_size, const char *fs_loc,
>>       }
>>   }
>>   +static unsigned int get_order(unsigned int pages)
>> +{
>> +    unsigned int order = 0;
>> +
>> +    while ((1U << order) < pages)
>> +        order++;
>> +    return order;
>> +}
>
> I think this can simply be
>
> return 32 - __builtin_clz(pages - 1);
>
> That mimics what get_order() in the kernel does for BITS_PER_LONG == 32
>
> or simpler
>
> return 31 - __builtin_clz(pages);
>
> E.g., if pages=512, you get 31-22=9


Sure David, We will  change it.


>
>> +
>>   int main(int argc, char **argv)
>>   {
>>       int i;
>> @@ -523,6 +532,7 @@ int main(int argc, char **argv)
>>       const char *fs_loc;
>>       bool created_tmp;
>>       int offset;
>> +    unsigned int max_order;
>>         ksft_print_header();
>>   @@ -534,32 +544,33 @@ int main(int argc, char **argv)
>>       if (argc > 1)
>>           optional_xfs_path = argv[1];
>>   -    ksft_set_plan(1+8+1+9+9+8*4+2);
>> -
>>       pagesize = getpagesize();
>>       pageshift = ffs(pagesize) - 1;
>>       pmd_pagesize = read_pmd_pagesize();
>>       if (!pmd_pagesize)
>>           ksft_exit_fail_msg("Reading PMD pagesize failed\n");
>>   +    max_order = get_order(pmd_pagesize/pagesize);
>> + 
>> ksft_set_plan(1+(max_order-1)+1+max_order+max_order+(max_order-1)*4+2);
>
> Wow. Can we simplify that in any sane way?


It is counting test by test. Let me try to simplify it and send the next 
version.


>
>> +
>>       fd_size = 2 * pmd_pagesize;
>>         split_pmd_zero_pages();
>>   -    for (i = 0; i < 9; i++)
>> +    for (i = 0; i < max_order; i++)
>>           if (i != 1)
>>               split_pmd_thp_to_order(i);
>>         split_pte_mapped_thp();
>> -    for (i = 0; i < 9; i++)
>> +    for (i = 0; i < max_order; i++)
>>           split_file_backed_thp(i);
>>         created_tmp = prepare_thp_fs(optional_xfs_path, fs_loc_template,
>>               &fs_loc);
>> -    for (i = 8; i >= 0; i--)
>> +    for (i = (max_order-1); i >= 0; i--)
>
> "i = max_order - 1"


I will change it.


>
>> split_thp_in_pagecache_to_order_at(fd_size, fs_loc, i, -1);
>>   -    for (i = 0; i < 9; i++)
>> +    for (i = 0; i < max_order; i++)
>>           for (offset = 0;
>>                offset < pmd_pagesize / pagesize;
>>                offset += MAX(pmd_pagesize / pagesize / 4, 1 << i))
>
>

