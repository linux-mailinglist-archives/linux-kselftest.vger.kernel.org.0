Return-Path: <linux-kselftest+bounces-36452-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BE3EDAF78F6
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jul 2025 16:56:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44A9C1CA22E7
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jul 2025 14:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 759742EFD80;
	Thu,  3 Jul 2025 14:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="E6euIqWd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F6E2EE978;
	Thu,  3 Jul 2025 14:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751554368; cv=none; b=O/cM2Vj+p6EgV4Tk+QUo6u/jsWZ1GTnK5xtSNDcEgfErtRwKKVKklBYlzjmSc7+xPxl+22G2zgXRqZMSgAgJFznHm77n+1BDpm9DESktZXRgoX0hzcgTcy/WSrvJ+NTYE11D/bPmWf5nl01oHmyTD5G/1+omEjDWLjT3Lyc3msc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751554368; c=relaxed/simple;
	bh=4uiQOKq9+dOU2EcBfhGx9y6ZSanJJ4mEnzeEmB9WfUI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MbtNx3pG7tx3NxH7vgXyi0vyuLXg8xv0dYrRs7U05l12DsNNgNYE9fuI0UI3iOqM5LtpDfVAf7gMojSqoXp9LS1/oRHoYaHl2FzAVvUbGO3CIHDbn7+hUYyPf3KGgHfD/8AQef+QE20KkxQ6HvohksWDvMTXV+GCgOpo5kopaNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=E6euIqWd; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 563CP5oV024412;
	Thu, 3 Jul 2025 14:52:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=mY6ftB
	pphXMErXOxTNW++Rpsp6EmBFPcZptcpuH9lvw=; b=E6euIqWdMY08dmWJoF5HaJ
	3m7B0anHbdKsqL9tlZvrAP7nXEvYL18V502kjwqHE9C7vckTDj6yJHIVv0uoC0nV
	9RCy6DSo16yO8776TtDdf3XLes+/UCz1kNdjCj7tfH4TplKmDx5RsH5PJt/9ce9A
	1I5VCfBg5o4NYLrr8ZagT7vWIp4ls0l6VzRkE4s6kgQv3WIHBzWdWg5Vp/z84rUn
	CuGvM/CLbxsdL/6ajXqHJm3797r+wiVbfZjpRPmybTfY2deATmCy91DjC/Zh+SB3
	KPiklGXZT3qesVBaWBmLSa47MyYMc9P4L/QTNFWql6lzPLK/4hWeJgy0a8elowYQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47j82g41gy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Jul 2025 14:52:33 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 563Edv0S029184;
	Thu, 3 Jul 2025 14:52:32 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47j82g41gt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Jul 2025 14:52:32 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 563D6pGe021109;
	Thu, 3 Jul 2025 14:52:32 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 47jtqunm17-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Jul 2025 14:52:31 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 563EqV2a57409824
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 3 Jul 2025 14:52:31 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EC4BD5805D;
	Thu,  3 Jul 2025 14:52:30 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AB7CC5805E;
	Thu,  3 Jul 2025 14:52:25 +0000 (GMT)
Received: from [9.109.245.113] (unknown [9.109.245.113])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  3 Jul 2025 14:52:25 +0000 (GMT)
Message-ID: <5bc95d56-0b2e-404a-9740-cd68facf7f55@linux.ibm.com>
Date: Thu, 3 Jul 2025 20:22:24 +0530
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/7] mm/selftests: Fix split_huge_page_test failure on
 systems with 64KB page size
To: Zi Yan <ziy@nvidia.com>, Aboorva Devarajan <aboorvad@linux.ibm.com>
Cc: akpm@linux-foundation.org, Liam.Howlett@oracle.com,
        lorenzo.stoakes@oracle.com, shuah@kernel.org, pfalcato@suse.de,
        david@redhat.com, baolin.wang@linux.alibaba.com, npache@redhat.com,
        ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, ritesh.list@gmail.com
References: <20250703060656.54345-1-aboorvad@linux.ibm.com>
 <20250703060656.54345-5-aboorvad@linux.ibm.com>
 <9440CBF1-AE4E-4C9F-ABC6-EBCB74316CF8@nvidia.com>
Content-Language: en-US
From: Donet Tom <donettom@linux.ibm.com>
In-Reply-To: <9440CBF1-AE4E-4C9F-ABC6-EBCB74316CF8@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: d0MVYya5BfnavZQNhVrX68n-pB7xF2_V
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAzMDEyNSBTYWx0ZWRfX2KpBx84o+vm3 o7HdbLkpVFllA85JI4orbVlwW+5vNaZA2Tc0KRFiA1K/PmHJyvfQ0/vgitNLDBjvK0w+FkWNxTp 1lPNqU7kOczbJZnvT6OsqQ+z0pA5ZtrEkWRK72PIAy42X4SlmFTy2EQ7JuoGJkXcfv5jqr5OZ8f
 yAt9YiRuryQbFm8ItvRyF75KeTxzhjZqhFGzQpcb03+BGCw7n67du2grUgMLYRXH1q49y1X/f1a vhzJOf7TP8g/KLpOFauWICjqyMUTdVNynAyDIujG87ZGWyObkBvFGJf4RQgEVwr7Ix/fXaoirDV 8GTLO9ugq2gA9gV/KgZ5u5kOrzKGdADx8cY9JYe7sL/+iBpXK7+CYDwrMq6Z7radsxZJgiGm22v
 eawR+gztivcwiVyaBdKKFJ4Xx0ykUHrRGmFfP8vGTt4BXqjCyPDYtHW+cr/3rtO0/eR9xBFg
X-Authority-Analysis: v=2.4 cv=LpeSymdc c=1 sm=1 tr=0 ts=68669931 cx=c_pps a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VnNF1IyMAAAA:8 a=Ikd4Dj_1AAAA:8 a=g9tEA885WHVDQ8z4Vf4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: d_E1IoYl_87F0af97llEgVPfKcNbJ4DN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-03_04,2025-07-02_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015
 impostorscore=0 mlxscore=0 mlxlogscore=999 phishscore=0 suspectscore=0
 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507030125


On 7/3/25 8:00 PM, Zi Yan wrote:
> On 3 Jul 2025, at 2:06, Aboorva Devarajan wrote:
>
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
>> to split huge pages beyond their actual order (5) causes the test to fail.
>>
>> In this patch, we calculate the huge page order based on the system's base
>> page size. With this change, the tests now run successfully on both 64KB
>> and 4KB page size systems.
>>
>> Fixes: fa6c02315f745 ("mm: huge_memory: a new debugfs interface for splitting THP tests")
>> Signed-off-by: Donet Tom <donettom@linux.ibm.com>
>> Signed-off-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
>> ---
>>   .../selftests/mm/split_huge_page_test.c       | 23 ++++++++++++++-----
>>   1 file changed, 17 insertions(+), 6 deletions(-)
>>
>> diff --git a/tools/testing/selftests/mm/split_huge_page_test.c b/tools/testing/selftests/mm/split_huge_page_test.c
>> index aa7400ed0e99..38296a758330 100644
>> --- a/tools/testing/selftests/mm/split_huge_page_test.c
>> +++ b/tools/testing/selftests/mm/split_huge_page_test.c
>> @@ -514,6 +514,15 @@ void split_thp_in_pagecache_to_order_at(size_t fd_size, const char *fs_loc,
>>   	}
>>   }
>>
>> +static unsigned int get_order(unsigned int pages)
>> +{
>> +	unsigned int order = 0;
>> +
>> +	while ((1U << order) < pages)
>> +		order++;
>> +	return order;
>> +}
>> +
>>   int main(int argc, char **argv)
>>   {
>>   	int i;
>> @@ -523,6 +532,7 @@ int main(int argc, char **argv)
>>   	const char *fs_loc;
>>   	bool created_tmp;
>>   	int offset;
>> +	unsigned int max_order;
>>
>>   	ksft_print_header();
>>
>> @@ -534,32 +544,33 @@ int main(int argc, char **argv)
>>   	if (argc > 1)
>>   		optional_xfs_path = argv[1];
>>
>> -	ksft_set_plan(1+8+1+9+9+8*4+2);
>> -
>>   	pagesize = getpagesize();
>>   	pageshift = ffs(pagesize) - 1;
>>   	pmd_pagesize = read_pmd_pagesize();
>>   	if (!pmd_pagesize)
>>   		ksft_exit_fail_msg("Reading PMD pagesize failed\n");
>>
>> +	max_order = get_order(pmd_pagesize/pagesize);
> pmd_pagesize/pagesize is reused below, a tmp variable would be good.


Thank you. I will add it in next version.


>
>> +	ksft_set_plan(1+(max_order-1)+1+max_order+max_order+(max_order-1)*4+2);
>> +
>>   	fd_size = 2 * pmd_pagesize;
>>
>>   	split_pmd_zero_pages();
>>
>> -	for (i = 0; i < 9; i++)
>> +	for (i = 0; i < max_order; i++)
>>   		if (i != 1)
>>   			split_pmd_thp_to_order(i);
>>
>>   	split_pte_mapped_thp();
>> -	for (i = 0; i < 9; i++)
>> +	for (i = 0; i < max_order; i++)
>>   		split_file_backed_thp(i);
>>
>>   	created_tmp = prepare_thp_fs(optional_xfs_path, fs_loc_template,
>>   			&fs_loc);
>> -	for (i = 8; i >= 0; i--)
>> +	for (i = (max_order-1); i >= 0; i--)
>>   		split_thp_in_pagecache_to_order_at(fd_size, fs_loc, i, -1);
>>
>> -	for (i = 0; i < 9; i++)
>> +	for (i = 0; i < max_order; i++)
>>   		for (offset = 0;
>>   		     offset < pmd_pagesize / pagesize;
>>   		     offset += MAX(pmd_pagesize / pagesize / 4, 1 << i))
> With the change to get_order() proposed by David and ksft_set_plan()
> simplification, Reviewed-by: Zi Yan <ziy@nvidia.com>
>
> Best Regards,
> Yan, Zi

