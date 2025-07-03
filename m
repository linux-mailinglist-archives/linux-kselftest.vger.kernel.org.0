Return-Path: <linux-kselftest+bounces-36442-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65C10AF778C
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jul 2025 16:32:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 383D816CD34
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jul 2025 14:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BED322EAD1D;
	Thu,  3 Jul 2025 14:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Ur72R8wC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E71322E7BBE;
	Thu,  3 Jul 2025 14:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751553076; cv=none; b=DaGBt8P8R1lfLk8DHQAcL1Tg9VxR/BSsUGrMUFj3jBJs4HD9UEqkhq+kS0kx0r5QE22SwmOMfAktmCttc8BP308jb10QIA3Ui9MG61v0FYZ4TsDgXp6vLS1YWq+995YpiyLXhapRPYWHKYRqBbO+o2gNbsUc9iL1MHwyOIzOflg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751553076; c=relaxed/simple;
	bh=GnCoweuCKp9HC+T/ENx4+SI74o6NhtIK+KFhR059MkY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BRc+kRP29KoUDvVxkpRz5KfGI4CrbjkSYdyTEqYRghXpJ+kUVBvMeEtpOzibKGVrbU8P/yozUuB5SyQUY3qyQHlIZcG6HKpheF9bOUX9UrqumKhangfNlwQFsGmfDqLH6PnJI/kybWLML/ow3Lj9Vb3Nkynl3LjS0GJJ5MHpR38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Ur72R8wC; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 563Al4IE003964;
	Thu, 3 Jul 2025 14:30:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=+EGCIe
	ZiE7Wm38ioKk6/mF6bfmXlUNhVkOvOXOYRiRM=; b=Ur72R8wCUTr5+C9Zjnj2Yd
	xqKegshoVR8xXba7/QwcgVFPZvI05k99ast2x8XYbcKPG3MIfHra7ex2DH+ln8SM
	WNE78+M5h5uLFFdrunootYewIGLX/JGEPctIJO0GCcCTWt0h4TEUY7RIMIdPjwKa
	nnzPyiSRIc7n3b+JHBM0CgdX8BlOrALNga2FOyWv4IgPPKOkQSXyGOB+PIfO1IwW
	Ztu87xErIFG/2U8mvoNvzb2s/NaID6EHuEKKjgNky9aOjMhm0sfc8pD1jPcvK2t1
	FzCqB95npOy7hwh0M3yVUAIMaXEQBjozrL7iGk/jsNE3n70TCrffURH6YLLBt0QQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47j5ttmamm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Jul 2025 14:30:56 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 563ETsZA012790;
	Thu, 3 Jul 2025 14:30:55 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47j5ttmamh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Jul 2025 14:30:55 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 563BZBGq021354;
	Thu, 3 Jul 2025 14:30:54 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 47jwe3n242-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Jul 2025 14:30:54 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 563EUrU847448530
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 3 Jul 2025 14:30:54 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ABE3E58059;
	Thu,  3 Jul 2025 14:30:53 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2A05358043;
	Thu,  3 Jul 2025 14:30:48 +0000 (GMT)
Received: from [9.109.245.113] (unknown [9.109.245.113])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  3 Jul 2025 14:30:47 +0000 (GMT)
Message-ID: <3a99961c-6eda-434a-8721-58eaf8b989db@linux.ibm.com>
Date: Thu, 3 Jul 2025 20:00:46 +0530
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/7] mm/selftests: Fix split_huge_page_test failure on
 systems with 64KB page size
To: Zi Yan <ziy@nvidia.com>
Cc: David Hildenbrand <david@redhat.com>,
        Aboorva Devarajan <aboorvad@linux.ibm.com>, akpm@linux-foundation.org,
        Liam.Howlett@oracle.com, lorenzo.stoakes@oracle.com, shuah@kernel.org,
        pfalcato@suse.de, baolin.wang@linux.alibaba.com, npache@redhat.com,
        ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, ritesh.list@gmail.com
References: <20250703060656.54345-1-aboorvad@linux.ibm.com>
 <20250703060656.54345-5-aboorvad@linux.ibm.com>
 <d73f0591-e407-4350-9ddd-dc05ff571a8d@redhat.com>
 <0e099baa-0a36-4ffd-821f-a7a4856fd52f@linux.ibm.com>
 <788EBC0F-67CB-4EE2-883F-A55CD394EE21@nvidia.com>
Content-Language: en-US
From: Donet Tom <donettom@linux.ibm.com>
In-Reply-To: <788EBC0F-67CB-4EE2-883F-A55CD394EE21@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: D03t7_6MGrbGXyfRp8-xBxLsF9Hy2eMx
X-Authority-Analysis: v=2.4 cv=UtNjN/wB c=1 sm=1 tr=0 ts=68669420 cx=c_pps a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VnNF1IyMAAAA:8 a=21Bkwq0YnMq5brnyCR8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: tx_YuQD7yBpKDIN9Awfn9GQgTG13oirr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAzMDEyMCBTYWx0ZWRfX4LOloxo/QbpE m9fQ2n14dHw8TGAcX+ZIf1i/sgX35PqrUrt7u+lSA5Z2F+wL47PrqM3z2lCChz27O1ZmdB18RlT UgV9mEwPbYk1sGRwyVGZGUFlvEDF09CTCeqYaAdnM2niNeFOqLEGqRNkjfbVyxP79OLTtO9cjCl
 c8hR5xdYlVCLoREElt8CFyeu7C73qv5Y4ZZLh7lHZHY37CfK4ozNkJuW3tUSknXDk3ingpa6NR9 S+woPxVVnWeCG2cpSAuYy6HMqALQ/xUEtvjtSLnGe0dBtjzsTeWiTPyzkhNJ/g1WqtYcESmVeFj x/rSm+E/1vhvA2kqOdc3G0+BKxz/a/jE4wxZBRLsFBFaB5cd4/jxslLo56XXG3+zqdSujlbj2se
 y5BDwcghSqI55qCbaUjHwzMLJFkbfYFOwHQnJbd4PU6CWBd6j64mP2nROOe4t59jee+YzAsC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-03_04,2025-07-02_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 phishscore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 adultscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0 impostorscore=0
 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507030120


On 7/3/25 7:51 PM, Zi Yan wrote:
> On 3 Jul 2025, at 4:58, Donet Tom wrote:
>
>> On 7/3/25 1:52 PM, David Hildenbrand wrote:
>>> On 03.07.25 08:06, Aboorva Devarajan wrote:
>>>> From: Donet Tom <donettom@linux.ibm.com>
>>>>
>>>> The split_huge_page_test fails on systems with a 64KB base page size.
>>>> This is because the order of a 2MB huge page is different:
>>>>
>>>> On 64KB systems, the order is 5.
>>>>
>>>> On 4KB systems, it's 9.
>>>>
>>>> The test currently assumes a maximum huge page order of 9, which is only
>>>> valid for 4KB base page systems. On systems with 64KB pages, attempting
>>>> to split huge pages beyond their actual order (5) causes the test to fail.
>>>>
>>>> In this patch, we calculate the huge page order based on the system's base
>>>> page size. With this change, the tests now run successfully on both 64KB
>>>> and 4KB page size systems.
>>>>
>>>> Fixes: fa6c02315f745 ("mm: huge_memory: a new debugfs interface for splitting THP tests")
>>>> Signed-off-by: Donet Tom <donettom@linux.ibm.com>
>>>> Signed-off-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
>>>> ---
>>>>    .../selftests/mm/split_huge_page_test.c       | 23 ++++++++++++++-----
>>>>    1 file changed, 17 insertions(+), 6 deletions(-)
>>>>
>>>> diff --git a/tools/testing/selftests/mm/split_huge_page_test.c b/tools/testing/selftests/mm/split_huge_page_test.c
>>>> index aa7400ed0e99..38296a758330 100644
>>>> --- a/tools/testing/selftests/mm/split_huge_page_test.c
>>>> +++ b/tools/testing/selftests/mm/split_huge_page_test.c
>>>> @@ -514,6 +514,15 @@ void split_thp_in_pagecache_to_order_at(size_t fd_size, const char *fs_loc,
>>>>        }
>>>>    }
>>>>    +static unsigned int get_order(unsigned int pages)
>>>> +{
>>>> +    unsigned int order = 0;
>>>> +
>>>> +    while ((1U << order) < pages)
>>>> +        order++;
>>>> +    return order;
>>>> +}
>>> I think this can simply be
>>>
>>> return 32 - __builtin_clz(pages - 1);
>>>
>>> That mimics what get_order() in the kernel does for BITS_PER_LONG == 32
>>>
>>> or simpler
>>>
>>> return 31 - __builtin_clz(pages);
>>>
>>> E.g., if pages=512, you get 31-22=9
>>
>> Sure David, We will  change it.
>>
>>
>>>> +
>>>>    int main(int argc, char **argv)
>>>>    {
>>>>        int i;
>>>> @@ -523,6 +532,7 @@ int main(int argc, char **argv)
>>>>        const char *fs_loc;
>>>>        bool created_tmp;
>>>>        int offset;
>>>> +    unsigned int max_order;
>>>>          ksft_print_header();
>>>>    @@ -534,32 +544,33 @@ int main(int argc, char **argv)
>>>>        if (argc > 1)
>>>>            optional_xfs_path = argv[1];
>>>>    -    ksft_set_plan(1+8+1+9+9+8*4+2);
>>>> -
>>>>        pagesize = getpagesize();
>>>>        pageshift = ffs(pagesize) - 1;
>>>>        pmd_pagesize = read_pmd_pagesize();
>>>>        if (!pmd_pagesize)
>>>>            ksft_exit_fail_msg("Reading PMD pagesize failed\n");
>>>>    +    max_order = get_order(pmd_pagesize/pagesize);
>>>> + ksft_set_plan(1+(max_order-1)+1+max_order+max_order+(max_order-1)*4+2);
>>> Wow. Can we simplify that in any sane way?
>>
>> It is counting test by test. Let me try to simplify it and send the next version.
> Yeah, I did that (ksft_set_plan(1+8+1+9+9+8*4+2);) to count different tests
> separately and in the same order as the following tests, so that I could
> get ksft_set_plan number right when adding or removing tests. Maybe it is
> fine to just sum them up now.


Sure. Thank you


>
> Best Regards,
> Yan, Zi
>

